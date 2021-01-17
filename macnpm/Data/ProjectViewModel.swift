//
//  ProjectViewModel.swift
//  macnpm
//
//  Created by Foysal Ahamed on 16/01/2021.
//

import Foundation
import SwiftUI


class ProjectViewModel {
    var entry: Project;
    var id: UUID
    var name: String
    var path: String
    var addedAt: Date
    var packageInfo: PackageJSON

    init(entry: Project) {
        self.entry = entry;
        id = UUID()
        name = "None"
        addedAt = entry.addedAt ?? Date()
        path = entry.path ?? "/Users/foysal"

        let packageReader = PackageReader(projectPath: path);
        packageInfo = packageReader.readPackageJSON()
    }
}

class ProjectListViewModel: ObservableObject {
    var context: NSManagedObjectContext
    @FetchRequest(
        entity: Project.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Project.addedAt, ascending: false)]
    ) var coreDataProjects: FetchedResults<Project>

    var projects = [ProjectViewModel]()

    func fetchEntries() {
        projects = coreDataProjects.map { ProjectViewModel.init(entry: $0) }
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveContext() {
        debugPrint(self.context.hasChanges)
        if self.context.hasChanges {
            do {
                try self.context.save()
                debugPrint(coreDataProjects)
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteProject(project: Project) -> Void {
        self.context.delete(project)
        saveContext()
    }
    
    func addProject(name: String, path: String) {
        let newProject = Project(context: self.context)

        newProject.id = UUID()
        newProject.name = name
        newProject.path = path
        newProject.addedAt = Date()
        
        debugPrint(newProject)
        saveContext()
        fetchEntries()
    }
    
    
}
