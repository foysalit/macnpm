//
//  HomeView.swift
//  macnpm
//
//  Created by Foysal Ahamed on 16/01/2021.
//

import SwiftUI
import CoreData

struct HomeView: View {
    var projectList: ProjectListViewModel
    
    var body: some View {
        ProjectListView(projectList: projectList)
    }
}
