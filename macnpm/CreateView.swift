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
    @ObservedObject var projectList: ProjectListViewModel

    func openProjectPicker() -> Void {
        let dialog = NSOpenPanel();

        dialog.title                   = "Choose a directory with package.json in it";
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
    
    func handleSaveAction () {
        let packageInfo = PackageReader(projectPath: path).readPackageJSON()
        if (packageInfo.version?.isEmpty == nil) {
            return
        }
        
        projectList.addProject(name: title, path: path)
        title = ""
        path = ""
    }
    
    var body: some View {
        HStack{
            Text("Add new project").font(.title)
            Spacer()
        }.padding(.leading, 15)
        Section{
            Form{
                Text("Project title")
                TextField("Name of your project", text: $title).padding(.bottom, 10)
                Text("Select project from your disk")
                Button(action: {
                    self.openProjectPicker();
                }) {
                    Text(path.isEmpty ? "Project Location" : path)
                }.padding(.bottom, 10)
                
                HStack {
                    Spacer()
                    Button(action: self.handleSaveAction) {
                        HStack {
                            Image(systemName: "checkmark")
                                .font(Font.system(size: 14, weight: .light))
                            Text("Save Project")
                        }
                    }.disabled(path.isEmpty || title.isEmpty)
                }
            }
        }.padding(15)
        Spacer()
    }
}


struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView(projectList: ProjectListViewModel(context: PersistenceController.preview.container.viewContext))
    }
}
