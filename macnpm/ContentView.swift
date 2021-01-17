//
//  ContentView.swift
//  macnpm
//
//  Created by Foysal Ahamed on 15/01/2021.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State var selectedItem: String? = "Home";
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        SidebarView(selectedItem: $selectedItem, projectList: ProjectListViewModel(context: managedObjectContext))
            .environment(\.managedObjectContext, managedObjectContext)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
