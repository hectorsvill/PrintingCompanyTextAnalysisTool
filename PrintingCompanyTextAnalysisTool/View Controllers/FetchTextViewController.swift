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

    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }

    private func configureViews() {
        newInputButtonFileButton.layer.cornerRadius = 17

    }

    @IBAction func newInputButtonFileButtonPressed(_ sender: Any) {
//        let types = ["kUTTypePDF", "kUTTypeText", "kUTTypeRTF", "kUTTypeSpreadsheet"]
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
            print(data)
            if let dataString = String(data: data, encoding: .utf8) {
                print(dataString)
                let alertController = UIAlertController(title: "Error: File is not UTF-8 Compatible", message: nil, preferredStyle: .actionSheet)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated:  true)
            }

        } catch {
            NSLog("$@", error.localizedDescription)
        }

    }
}

extension FetchTextViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "header \(section)"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell", for: indexPath)
        cell.textLabel?.text = "text label"
        cell.detailTextLabel?.text = "Detail Label"
        return cell
    }

}
