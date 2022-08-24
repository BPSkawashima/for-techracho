/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import Foundation

class Article: NSObject, NSCoding, Identifiable {
    let title: String?
    let summary: String?
    let authors: [String]
    let links: [URL]
    let thumbnailImageURL: URL?
    let categories: [String]
    let updated: Date?

    init(
        title: String?,
        summary: String?,
        authors: [String],
        links: [URL],
        thumbnailImageURL: URL?,
        categories: [String],
        updated: Date
    ) {
        self.title = title
        self.summary = summary
        self.authors = authors
        self.links = links
        self.thumbnailImageURL = thumbnailImageURL
        self.categories = categories
        self.updated = updated
    }

    required init(coder decoder: NSCoder) {
        title = decoder.decodeObject(forKey: "title") as? String
        summary = decoder.decodeObject(forKey: "summary") as? String
        authors = decoder.decodeObject(forKey: "authors") as? [String] ?? []
        links = decoder.decodeObject(forKey: "links") as? [URL] ?? []
        thumbnailImageURL = decoder.decodeObject(forKey: "thumbnailImageURL") as? URL
        categories = decoder.decodeObject(forKey: "categories") as? [String] ?? []
        updated = decoder.decodeObject(forKey: "updated") as? Date
    }

    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(summary, forKey: "summary")
        coder.encode(authors, forKey: "authors")
        coder.encode(links, forKey: "links")
        coder.encode(thumbnailImageURL, forKey: "thumbnailImageURL")
        coder.encode(categories, forKey: "categories")
        coder.encode(updated, forKey: "updated")
    }
}
