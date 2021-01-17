//
//  Project+CoreDataProperties.swift
//  macnpm
//
//  Created by Foysal Ahamed on 17/01/2021.
//
//

import Foundation
import CoreData


extension Project {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: "Project")
    }

    @NSManaged public var name: String?
    @NSManaged public var path: String?
    @NSManaged public var id: UUID?
    @NSManaged public var addedAt: Date?

}

extension Project : Identifiable {

}
