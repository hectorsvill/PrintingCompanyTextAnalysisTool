//
//  FetchTextViewController.swift
//  PrintingCompanyTextAnalysisTool
//
//  Created by Hector S. Villasano on 5/24/20.
//  Copyright © 2020 Hector Steven  Villasano. All rights reserved.
//

import UIKit
import SwiftUI

class FetchTextViewController: UIViewController {
    @IBOutlet weak var newInputButtonFileButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    private var fileStatsList = [FileStats]()

    private let frequencyAnalysisQueue = OperationQueue()
    private var frequencyAnalysisOperations = [Int: FetchAnalysisOperation]()
    private let cache = Cache<Int, FileStats>()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }

    private func configureViews() {
        frequencyAnalysisQueue.name = "com.hectorstevenvillasano.PrintingCompanyTextAnalysisTool.frequencyAnalysisOperation"
        newInputButtonFileButton.layer.cornerRadius = 17
    }

    @IBAction func newInputButtonFileButtonPressed(_ sender: Any) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }

    private func loadChart(with cell: UITableViewCell, indexPath: IndexPath) {
        if let fileStats = cache.value(for: indexPath.section), fileStats.analysisComplete {
            self.fileStatsList[indexPath.section] = fileStats
            return
        }

        let fetchAnalysisOperation = FetchAnalysisOperation(fileStats: fileStatsList[indexPath.section])

        let storeFileStatsInCache = BlockOperation {
            self.cache.cache(value: fetchAnalysisOperation.fileStats, for: indexPath.section)
        }

        let checkForReusedCell = BlockOperation {
            if self.tableView.indexPath(for: cell) == indexPath {
                DispatchQueue.main.async {
                    self.fileStatsList[indexPath.section] = fetchAnalysisOperation.fileStats
                    self.tableView.reloadData()
                }
            }
        }

        storeFileStatsInCache.addDependency(fetchAnalysisOperation)
        checkForReusedCell.addDependency(fetchAnalysisOperation)

        frequencyAnalysisQueue.addOperations([fetchAnalysisOperation, storeFileStatsInCache], waitUntilFinished: false)
        OperationQueue.main.addOperation(checkForReusedCell)
        frequencyAnalysisOperations[indexPath.section] = fetchAnalysisOperation
    }
}

extension FetchTextViewController: UIDocumentPickerDelegate, UINavigationControllerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true)
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }

        do {
            let dataString = try String(contentsOf: url, encoding: .utf8)
            let name = url.absoluteString.split(separator: "/").last!
            let fileStats = FileStats(url: url, dataString: dataString, name: String(name))
            DispatchQueue.main.async {
                self.fileStatsList.append(fileStats)
                self.tableView.reloadData()
            }

        } catch {
            let alertController = UIAlertController(title: "Error: File is not UTF-8 Compatible", message: nil, preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            DispatchQueue.main.async {
                self.present(alertController, animated:  true)
            }
        }
    }
}

extension FetchTextViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fileStatsList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fileStatsList[section].name
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell", for: indexPath) as? FileStatsTableViewCell else { return UITableViewCell()}

        let fileStats = fileStatsList[indexPath.section]
        cell.fileStats = fileStats
        self.loadChart(with: cell, indexPath: indexPath)
        return cell
    }

}

extension FetchTextViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let fileStats = fileStatsList[indexPath.section]
        if !fileStats.analysisComplete {
            let cancelProcessAlertController = UIAlertController(title: "Stop Processing", message: fileStats.name, preferredStyle: .alert)

            cancelProcessAlertController.addAction(UIAlertAction(title: "Stop", style: .destructive) { [weak self] _ in
                guard let self = self else { return }
                // stop process
                self.frequencyAnalysisOperations[indexPath.section]!.cancel()
                self.frequencyAnalysisOperations.removeValue(forKey: indexPath.section)
                self.fileStatsList.remove(at: indexPath.section)

                DispatchQueue.main.async {
                    self.tableView.reloadSections([indexPath.section], with: .automatic)
                }
            })

            cancelProcessAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(cancelProcessAlertController, animated: true)

        } else {
            let swiftUIView = ChartsSwiftUIView(fileStats: fileStats)
            let viewController = UIHostingController(rootView: swiftUIView)
            present(viewController, animated: true)
        }
    }
}

