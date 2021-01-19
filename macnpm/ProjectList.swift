//
//  ProjectList.swift
//  macnpm
//
//  Created by Foysal Ahamed on 16/01/2021.
//

import SwiftUI

struct ProjectListView: View {
    var projectList: ProjectListViewModel
    @Binding var selectedProjectIndex: Int
    @Environment (\.colorScheme) var colorScheme:ColorScheme

    var body: some View {
        List {
            ForEach(projectList.projects.indices, id: \.self) { id in
                Button(action: {
                    selectedProjectIndex = id
                }) {
                    ProjectItemView(project: projectList.projects[id])
                }.padding(15).overlay(
                    Rectangle()
                        .frame(width: 3, height: nil, alignment: .leading)
                        .foregroundColor(selectedProjectIndex == id ? Color.red : Color.blue),
                    alignment: .leading
                ).background(colorScheme == .dark ? Color.black.opacity(0.7) : Color.white.opacity(0.7))
                .cornerRadius(5.0).buttonStyle(PlainButtonStyle())
            }
        }.onAppear{
            projectList.fetchProjects()
        }
    }
}
