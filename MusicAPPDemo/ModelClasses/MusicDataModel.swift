//
//  MusicDataModel.swift
//  MusicAPPDemo
//
//  Created by Mahesh babu on 22/12/23.
//

import Foundation

struct MusicDataModel: Codable {
    let categoryName, categoryID: String?
    let data: [DataResult]

    enum CodingKeys: String, CodingKey {
        case categoryName = "category-name"
        case categoryID = "category-id"
        case data
    }
}

// MARK: - Data inside result
struct DataResult: Codable {
    let subcategoryID, subcategoryName: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case subcategoryID = "subcategory-id"
        case subcategoryName = "subcategory-name"
        case url
    }
}

