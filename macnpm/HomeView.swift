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
    
    var body: some View {
        if (projectList.projects.isEmpty) {
            Text("No project found").font(.title)
        } else {
            ProjectListView(projectList: projectList)
        }
    }
}
