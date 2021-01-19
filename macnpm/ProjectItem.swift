//
//  ProjectItem.swift
//  macnpm
//
//  Created by Foysal Ahamed on 16/01/2021.
//

import SwiftUI

struct ProjectItemView: View {
    var project: Project;

    var body: some View {
        HStack {
            VStack (alignment: .leading){
                Text(project.name ?? "None").font(.title2)
                Text(project.path ?? "None").font(.title3)
                Text(project.packageInfo.version ?? "0.0")
            }.padding(.leading, 15)
        }
    }
}
