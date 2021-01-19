//
//  HomeView.swift
//  macnpm
//
//  Created by Foysal Ahamed on 16/01/2021.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @ObservedObject var projectList: ProjectListViewModel
    @State var selectedProjectIndex: Int = 0

    var body: some View {
        if (projectList.projects.isEmpty) {
            Text("No project found").font(.title)
        } else {
            HStack{
                ProjectListView(projectList: projectList, selectedProjectIndex: self.$selectedProjectIndex)
                if (selectedProjectIndex >= 0) {
                    ProjectDetailsView(project: projectList.projects[selectedProjectIndex], projectList: projectList)
                }
            }
        }
    }
}
