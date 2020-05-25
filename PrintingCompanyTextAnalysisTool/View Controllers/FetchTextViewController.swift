//
//  FetchTextViewController.swift
//  PrintingCompanyTextAnalysisTool
//
//  Created by Hector S. Villasano on 5/24/20.
//  Copyright © 2020 Hector Steven  Villasano. All rights reserved.
//

import UIKit

class FetchTextViewController: UIViewController {

    @IBOutlet weak var newInputButtonFileButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    private var fileController = FileControrller()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }

    private func configureViews() {
        newInputButtonFileButton.layer.cornerRadius = 17

    }

    @IBAction func newInputButtonFileButtonPressed(_ sender: Any) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false

        present(documentPicker, animated: true, completion: nil)
    }
}

extension FetchTextViewController: UIDocumentPickerDelegate, UINavigationControllerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true)
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {

        guard let url = urls.first else { return }
        print(url)
        do {
            let data = try Data(contentsOf: url)
            if let dataString = String(data: data, encoding: .utf8),
                let name = url.absoluteString.split(separator: "/").last {

                let fileStats = FileStats(url: url, dataString: dataString, name: String(name))
                self.fileController.addFile(fileStats)

                self.tableView.reloadData()
            }else {
                let alertController = UIAlertController(title: "Error: File is not UTF-8 Compatible", message: nil, preferredStyle: .actionSheet)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated:  true)

            }

        } catch {
            NSLog("$@", error.localizedDescription)
        }

    }
}

extension FetchTextViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        //check  frequency analysis, if still progress cancel

    }
}

extension FetchTextViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return fileController.fileStatsList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fileController.fileStatsList[section].name
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell", for: indexPath)

        let currentFile = fileController.fileStatsList[indexPath.row]
        cell.textLabel?.text = "..."
        cell.detailTextLabel?.text = "Time: \(currentFile.timeToAnalyze ?? 0)"
        return cell
    }

}
