//
//  GallerySearch.swift
//  CatsGalleryApp
//
//  Created by Fernando del Rio on 09/04/20.
//  Copyright © 2020 Fernando del Rio. All rights reserved.
//

import Foundation

public struct GallerySearch: Decodable {
    private enum CodingKeys: String, CodingKey {
        case data
    }

    private struct GallerySearchData: Decodable {
        let images: [GallerySearchImage]?
    }

    private struct GallerySearchImage: Decodable {
        let link: String
    }

    public let urls: [String]

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let searchData = try values.decode([GallerySearchData].self, forKey: .data)

        urls = searchData
            .flatMap { $0.images ?? [] }
            .map {
                // Get a smaller image
                // reducing mobile data usage
                $0.link.replacingOccurrences(
                    of: "(.*)(\\..*)$",
                    with: "$1l$2",
                    options: .regularExpression
                )
            }
    }
}
