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
    @State var characterPickerSelectedItem = 0
    let maxWidth: CGFloat = 230
    let height: CGFloat = 10

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("A Frequency Analysis.").font(.system(size: 14)).fontWeight(.thin).multilineTextAlignment(.center)
                    Picker(selection: $characterPickerSelectedItem, label: Text("")) {
                        Text("1 Character").tag(0)
                        Text("2 Character").tag(1)
                        Text("3 Character").tag(2)
                    }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal, 16)

                    VStack (spacing: 8) {
                        ForEach(0..<fileStats.ligatures1Character.count) {
                            BarView(characters: self.fileStats.ligatures1Character[$0].0,
                                    count: self.fileStats.ligatures1Character[$0].1,
                                    widthValue: self.getwidthValue($0)
                            )
                        }
                    }
                }

            }
            .navigationBarTitle(fileStats.name)
        }
    }

    private func getwidthValue(_ index: Int) -> CGFloat {
        let ligaturesCharacter = self.fileStats.ligatures1Character[index]
        let ligaturesCharacterCount = ligaturesCharacter.1

        let widthValue = Float(ligaturesCharacterCount) * Float(Float(230) / Float(self.fileStats.ligatures1Character[0].1))
        return CGFloat(widthValue)
    }
}

struct BarView: View {
    let maxWidth: CGFloat = 230
    let height: CGFloat = 10
    var characters: String
    var count: Int
    var widthValue: CGFloat

    var body: some View {
        HStack {
            Text(characters)
            ZStack (alignment: .leading) {
                Capsule().frame(width: maxWidth, height: height).foregroundColor(Color.init(.systemGray5))
                Capsule().frame(width: widthValue , height: height).foregroundColor(Color.init(.systemGreen))
            }
            Text("\(Int(count))")
        }
    }
}

struct ChartsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsSwiftUIView(fileStats: FileStats(url: URL(string: "url.com")!, dataString: "String", name: "textfile1.txt"))
    }
}
