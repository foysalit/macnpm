//
//  ContentView.swift
//  macnpm
//
//  Created by Foysal Ahamed on 15/01/2021.
//

import SwiftUI
import Foundation

struct PackageJSON: Decodable {
    let name: String?
    let version: String?
    let scripts: [String: String]
}


func shell(_ command: String) -> String {
    let task = Process()
    let pipe = Pipe()
    
    task.standardOutput = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/zsh"
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    
    return output
}

struct ContentView: View {
    @State var output: String = "";
    @State var project: String = "";
    @State var packageInfo: PackageJSON = PackageJSON(name: nil, version: nil, scripts: ["test": "None"]);
    
    func readPackageJSON() -> Void {
        do {
            let path = URL(fileURLWithPath: self.project).appendingPathComponent("package").appendingPathExtension("json")
            let data = try Data(contentsOf: path, options: .mappedIfSafe)
            self.packageInfo = try JSONDecoder().decode(PackageJSON.self, from: data)
        } catch {
            print(error)
        }
    }
    
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
                self.project = result!.path
                self.readPackageJSON();
            }
        } else {
            // User clicked on "Cancel"
            return
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
        VStack {
            Spacer()
            Button(action: {
                self.openProjectPicker();
            }) {
                Text("Add Project")
            }
            if (!project.isEmpty) {
                Text(project);
            }
            
            if (!output.isEmpty) {
                Text(output);
            }
            
            List{
                ForEach(packageInfo.scripts.keys.sorted(), id: \.self) { key in
                    Button(action: {
                        var cmd = "cd ";
                        cmd += self.project;
                        cmd += " && ";
                        cmd += packageInfo.scripts[key]!;
                        self.output = cmd;
                        //self.output = shell(cmd);
                    }) {
                        Text("\(key)")
                    }
                    Text(packageInfo.scripts[key]!)
                }
            }
            Spacer()
        }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
