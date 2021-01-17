//
//  Dependency+CoreDataProperties.swift
//  macnpm
//
//  Created by Foysal Ahamed on 16/01/2021.
//
//

import Foundation
import CoreData


extension Dependency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dependency> {
        return NSFetchRequest<Dependency>(entityName: "Dependency")
    }

    @NSManaged public var name: String?
    @NSManaged public var version: String?
    @NSManaged public var dev: Bool
    @NSManaged public var project: Project?

}

extension Dependency : Identifiable {

}
