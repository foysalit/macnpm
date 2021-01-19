//
//  CreateView.swift
//  macnpm
//
//  Created by Foysal Ahamed on 16/01/2021.
//

import SwiftUI

struct CreateView: View {
    @State private var path: String = ""
    @State private var title: String = ""
    @State private var errorAlertMessage: String = ""
    @State private var showErrorAlert: Bool = false
    @ObservedObject var projectList: ProjectListViewModel
    var onCreateComplete: () -> Void;

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
                let packageInfo = PackageReader(projectPath: result!.path).readPackageJSON()
                if (packageInfo.name.isEmpty) {
                    self.showErrorAlert = true;
                    self.errorAlertMessage = "package.json file does not have a name"
                    return
                }
                
                if (!packageInfo.name.isEmpty && self.title.isEmpty) {
                    self.title = packageInfo.name;
                }
                
                self.path = result!.path
            }
        } else {
            return
        }
    }
    
    func handleSaveAction () {
        projectList.addProject(name: title, path: path)
        title = ""
        path = ""
        onCreateComplete()
    }
    
    var body: some View {
        GeometryReader {geometry in
            VStack {
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
                        }.padding(.bottom, 10).alert(isPresented:$showErrorAlert) {
                            Alert(
                                title: Text("Something's not right"),
                                message: Text(self.errorAlertMessage)
                            )
                        }
                        
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
            }.frame(minWidth: geometry.size.width * 0.5)
        }
    }
}


struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView(
            projectList: ProjectListViewModel(context: PersistenceController.preview.container.viewContext),
            onCreateComplete: {}
        )
    }
}
