//
//  ProjectViewModel.swift
//  macnpm
//
//  Created by Foysal Ahamed on 16/01/2021.
//

import Foundation
import SwiftUI

extension Project {
    static var getAllFetchRequest: NSFetchRequest<Project> {
        let request: NSFetchRequest<Project> = Project.fetchRequest()
        // request.predicate = NSPredicate(format: "dueDate < %@", Date.nextWeek() as CVarArg)
        request.sortDescriptors = [NSSortDescriptor(key: "addedAt", ascending: true)]

        return request
    }

    var packageInfo: PackageJSON {
        let packageReader = PackageReader(projectPath: self.path ?? "/dev/null");
        return packageReader.readPackageJSON()
    }
}

class ProjectListViewModel: NSObject, ObservableObject {
    var managedContext: NSManagedObjectContext;
    @Published var projects: [Project] = []
    private let controller: NSFetchedResultsController<Project>
    
    init(context: NSManagedObjectContext) {
        managedContext = context;
        controller = NSFetchedResultsController(
            fetchRequest: Project.getAllFetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        super.init()
        
        fetchProjects()
    }
    
    func fetchProjects() {
        do {
          try controller.performFetch()
          projects = controller.fetchedObjects ?? []
        } catch {
          print("failed to fetch projects!")
        }
    }
    
    func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteProject(project: Project) -> Void {
        managedContext.delete(project)
        saveContext()
        fetchProjects()
    }
    
    func addProject(name: String, path: String) {
        let newProject = Project(context: managedContext)

        newProject.id = UUID()
        newProject.name = name
        newProject.path = path
        newProject.addedAt = Date()
        
        saveContext()
        fetchProjects()
    }
    
    
}
