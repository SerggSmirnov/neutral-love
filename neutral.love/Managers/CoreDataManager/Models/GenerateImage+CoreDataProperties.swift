//
//  GenerateImage+CoreDataProperties.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 16.12.2023.
//
//

import Foundation
import CoreData

extension GenerateImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenerateImage> {
        return NSFetchRequest<GenerateImage>(entityName: "GenerateImage")
    }

    @NSManaged public var caption: String?
    @NSManaged public var preview: Data?
    @NSManaged public var full: Data?

}

extension GenerateImage: Identifiable {}
