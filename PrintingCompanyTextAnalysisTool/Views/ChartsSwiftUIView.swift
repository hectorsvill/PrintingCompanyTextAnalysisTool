//
//  ChartsSwiftUIView.swift
//  PrintingCompanyTextAnalysisTool
//
//  Created by Hector S. Villasano on 5/25/20.
//  Copyright © 2020 Hector Steven  Villasano. All rights reserved.
//

import SwiftUI

struct ChartsSwiftUIView: View {
    @ObservedObject var fileStats: FileStats

    var body: some View {
        Text("This: \(fileStats.name)")
    }
}

struct ChartsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {

        ChartsSwiftUIView(fileStats: FileStats(url: URL(string: "url.com")!, dataString: "String", name: "textfile1.txt"))
    }
}
