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
    private var frequencyAnalysisOperations = [Int: BlockOperation]()

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

    private func loadChart(_ section: Int) {
        let fetchAnalysisOperation = FetchAnalysisOperation(fileStatsDataString: fileStatsList[section].dataString)

        let setFileStatsListOperation = BlockOperation {
                DispatchQueue.main.async {
                    self.fileStatsList[section].ligatures1Character = fetchAnalysisOperation.ligatures1Character
                    self.fileStatsList[section].ligatures2Character = fetchAnalysisOperation.ligatures2Character
                    self.fileStatsList[section].ligatures3Character = fetchAnalysisOperation.ligatures3Character
                    self.fileStatsList[section].chartState = .isFinished
                    self.fileStatsList[section].timeToAnalyze = fetchAnalysisOperation.timeToAnalyze
                    self.tableView.reloadSections([section], with: .automatic)
                }
        }

        setFileStatsListOperation.addDependency(fetchAnalysisOperation)

        frequencyAnalysisQueue.addOperations([fetchAnalysisOperation], waitUntilFinished: false)
        OperationQueue.main.addOperation(setFileStatsListOperation)
        frequencyAnalysisOperations[section] = setFileStatsListOperation
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
            let fileStats = FileStats(index: fileStatsList.count,url: url, dataString: dataString, name: String(name))
            DispatchQueue.main.async {
                fileStats.chartState = .isExecuting
                self.fileStatsList.append(fileStats)
                self.loadChart(self.fileStatsList.count - 1)
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

        return cell
    }

}

extension FetchTextViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let fileStats = fileStatsList[indexPath.section]

        if fileStats.chartState == .isExecuting {
            // error with canceling Process
            let cancelProcessAlertController = UIAlertController(title: "Stop Processing", message: fileStats.name, preferredStyle: .alert)

            cancelProcessAlertController.addAction(UIAlertAction(title: "Stop", style: .destructive) { [weak self] _ in
                guard let self = self else { return }
                // stop process
                if let frequencyAnalysisOperation = self.frequencyAnalysisOperations[fileStats.index] {
                    frequencyAnalysisOperation.cancel()
                    DispatchQueue.main.async {
                        fileStats.chartState = .isCancelled
                        self.tableView.reloadSections([indexPath.section], with: .automatic)
                    }
                }

            })

            cancelProcessAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(cancelProcessAlertController, animated: true)

        } else if fileStats.chartState == .isExecuting {

        }else if fileStats.chartState == .isFinished {
            let swiftUIView = ChartsSwiftUIView(fileStats: fileStats)
            let viewController = UIHostingController(rootView: swiftUIView)
            present(viewController, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let section = fileStatsList[indexPath.section].index
            fileStatsList.remove(at: indexPath.section)
            frequencyAnalysisOperations[section]?.cancel()
            frequencyAnalysisOperations.removeValue(forKey: section)
            self.tableView.reloadData()

        }
    }
}

