//
//  ProjectList.swift
//  macnpm
//
//  Created by Foysal Ahamed on 16/01/2021.
//

import SwiftUI

struct ProjectListView: View {
    var projectList: ProjectListViewModel;

    var body: some View {
        List {
            ForEach(projectList.projects.indices, id: \.self) { id in
                ProjectItemView(project: projectList.projects[id], projectList: projectList)
            }
        }.onAppear{
            projectList.fetchProjects()
        }
    }
}
