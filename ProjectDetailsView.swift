//
//  ProjectDetailsView.swift
//  macnpm
//
//  Created by Foysal Ahamed on 18/01/2021.
//

import SwiftUI

struct ProjectDetailsView: View {
    var project: Project
    var projectList: ProjectListViewModel;
    @State private var showingDeleteConfirm = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    Text(project.name ?? "None").font(.title2)
                    Spacer()
                    Button(action: {
                        self.showingDeleteConfirm = true;
                    }) {
                        Image(systemName: "trash")
                            .font(Font.system(size: 14, weight: .light))
                        Text("Remove")
                    }
                    .foregroundColor(.red)
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
                }.padding(.trailing, 20).padding(.bottom, 15).padding(.top, 15)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Dependencies").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        List {
                            ForEach(project.packageInfo.dependencies!.sorted(by: >), id: \.key) { key, value in
                                Link(destination: URL(string: "https://npmjs.com/package/\(key)")!) {
                                    Text("\(key)")
                                    Text("\(value)")
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Scripts").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        List {
                            ForEach(project.packageInfo.scripts!.sorted(by: >), id: \.key) { key, value in
                                HStack{
                                    Text("\(key)")
                                    Spacer()
                                    Button(action: {
                                        let runner = project.isYarn ? "yarn" : "npm run"
                                        let command = "cd \(project.path!) && \(runner) \(key)"
                                        debugPrint(command)
                                        debugPrint(shell(command))
                                    }) {
                                        Text("Run")
                                    }
                                }
                            }
                        }
                    }
                }
            }.frame(minWidth: geometry.size.width * 0.7)
        }
    }
}
