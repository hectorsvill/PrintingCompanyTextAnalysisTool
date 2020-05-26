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

    let maxWidth: CGFloat = 230
    let height: CGFloat = 10
    @State private var characterPickerSelectedItem = 0
    @State private var chartPickerSelectedItem = 0

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("A Frequency Analysis of \(fileStats.name).\nPick a Character count.").font(.system(size: 14)).fontWeight(.thin).multilineTextAlignment(.center)
                    Picker(selection: $characterPickerSelectedItem, label: Text("")) {
                        Text("1 Character").tag(0)
                        Text("2 Character").tag(0)
                        Text("3 Character").tag(0)
                    }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal, 16)

                    Text("Analysing the top-20 most common consecutive one-character, two-character, and three-character patterns. .").font(.system(size: 14)).fontWeight(.thin).multilineTextAlignment(.center)
                    Picker(selection: $chartPickerSelectedItem, label: Text("")) {
                        Text("Top 5").tag(0)
                        Text("6 - 10").tag(1)
                        Text("11 - 15").tag(2)
                        Text("16 - 20").tag(3)
                    }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal, 16)

                    VStack (spacing: 8) {
                        BarView(value: 20)
                        BarView(value: 50)
                    }


                }

            }
            .navigationBarTitle(fileStats.name)
        }
    }
}

struct BarView: View {
    let maxWidth: CGFloat = 230
    let height: CGFloat = 10

    var value: CGFloat

    var body: some View {
        HStack {
            Text("e")
            ZStack (alignment: .leading) {
                Capsule().frame(width: maxWidth, height: height).foregroundColor(Color.init(.systemGray5))
                Capsule().frame(width: 30, height: height).foregroundColor(Color.init(.systemGreen))
            }
            Text("23")
        }

    }

}

struct ChartsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {

        ChartsSwiftUIView(fileStats: FileStats(url: URL(string: "url.com")!, dataString: "String", name: "textfile1.txt"))
    }
}
