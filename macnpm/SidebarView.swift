//
//  SidebarView.swift
//  macnpm
//
//  Created by Foysal Ahamed on 16/01/2021.
//

import SwiftUI

struct SidebarMenuItemView: View {
    var icon: String;
    var title: String;
    
    var body: some View {
        Image(systemName: icon)
            .font(Font.system(size: 14, weight: .light))
        Text(title).font(.headline)
    }
}

struct SidebarView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Binding var selectedItem: String?
    var pageList = ["Home", "Settings", "Add Project"]
    var projectList: ProjectListViewModel

    var body: some View {
        NavigationView {
            List(selection: $selectedItem) {
                NavigationLink(
                    destination: HomeView(projectList: projectList).environment(\.managedObjectContext, self.managedObjectContext),
                    tag: pageList[0],
                    selection: $selectedItem
                ) {
                    SidebarMenuItemView(icon: "house", title: pageList[0])
                }
                NavigationLink(
                    destination: CreateView(
                        projectList: projectList,
                        onCreateComplete: {
                            self.selectedItem = "Home"
                    })
                        .environment(\.managedObjectContext, self.managedObjectContext),
                    tag: pageList[2],
                    selection: $selectedItem
                ) {
                    SidebarMenuItemView(icon: "plus", title: pageList[2])
                }
            }
        }.listStyle(SidebarListStyle())
    }
}
