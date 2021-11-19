//
//  testSwiftUIView.swift
//  MapKitTests
//
//  Created by Стас Жингель on 19.11.2021.
//

import SwiftUI

struct TestSwiftUIView: View {
    @State var string: String  = ""
    var body: some View {
        HStack {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                TextField("add text", text: $string)
            }
            Spacer()
        }
        .padding()
    }
}

struct testSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TestSwiftUIView()
    }
}
