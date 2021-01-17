//
//  CreateView.swift
//  macnpm
//
//  Created by Foysal Ahamed on 16/01/2021.
//

import SwiftUI

struct CreateView: View {
    @State private var title: String = "";
    @State private var path: String = "";
    var projectList: ProjectListViewModel

    func openProjectPicker() -> Void {
        let dialog = NSOpenPanel();

        dialog.title                   = "Choose single directory | Our Code World";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseFiles = false;
        dialog.canChooseDirectories = true;

        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            let result = dialog.url

            if (result != nil) {
                self.path = result!.path
            }
        } else {
            // User clicked on "Cancel"
            return
        }
    }
    
    var body: some View {
        Form{
            Text("Project title")
            TextField("Project Title", text: $title)
            Button(action: {
                self.openProjectPicker();
            }) {
                Text(path.isEmpty ? "Project Location" : path)
            }
            Button(action: {
                projectList.addProject(name: title, path: path)
            }) {
                HStack {
                    Image(systemName: "checkmark")
                        .font(Font.system(size: 14, weight: .light))
                    Text("Save Project")
                }
            }
        }.padding(10)
    }
}

