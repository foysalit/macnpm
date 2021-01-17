//
//  ProjectItem.swift
//  macnpm
//
//  Created by Foysal Ahamed on 16/01/2021.
//

import SwiftUI

struct ProjectItemView: View {
    var project: ProjectViewModel;
    var projectList: ProjectListViewModel;
    
    var body: some View {
        HStack {
            Text(project.name)
            Text(project.packageInfo.version)
            Button(action: {
                projectList.deleteProject(project: project.entry)
            }) {
                Image(systemName: "trash")
                    .font(Font.system(size: 14, weight: .light))
            }
        }
    }
}
