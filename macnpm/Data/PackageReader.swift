//
//  PackageReader.swift
//  macnpm
//
//  Created by Foysal Ahamed on 16/01/2021.
//

import Foundation

struct PackageJSON: Decodable {
    var name: String
    var version: String
    var scripts: [String: String]
    var dependencies: [String: String]
    var devDependencies: [String: String]
}

struct PackageReader {
    var projectPath: String;
    
    func readPackageJSON() -> PackageJSON {
        do {
            let path = URL(fileURLWithPath: projectPath).appendingPathComponent("package").appendingPathExtension("json")
            let data = try Data(contentsOf: path, options: .mappedIfSafe)
            return try JSONDecoder().decode(PackageJSON.self, from: data)
        } catch {
            print(error)
            return PackageJSON(
                name: "None",
                version: "none",
                scripts: ["test": "one"],
                dependencies: ["test": "two"],
                devDependencies: ["test": "three"]
            )
        }
    }
}
