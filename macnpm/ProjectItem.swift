//
//  ProjectItem.swift
//  macnpm
//
//  Created by Foysal Ahamed on 16/01/2021.
//

import SwiftUI

struct ProjectItemView: View {
    var project: Project;
    var projectList: ProjectListViewModel;
    @State private var showingDeleteConfirm = false

    var body: some View {
        HStack {
            Text(project.name ?? "None")
            Text(project.packageInfo.version ?? "0.0")
            Button(action: {
                self.showingDeleteConfirm = true;
            }) {
                Image(systemName: "trash")
                    .font(Font.system(size: 14, weight: .light))
            }
            .alert(isPresented:$showingDeleteConfirm) {
                Alert(
                    title: Text("Are you sure you want to delete this project?"),
                    message: Text("This will not remove the project from disk, it will only stop showing up in macnpm."),
                    primaryButton: .destructive(Text("Delete")) {
                        projectList.deleteProject(project: project)
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}
