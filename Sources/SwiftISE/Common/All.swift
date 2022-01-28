//
//  File.swift
//  
//
//  Created by Christoffer Cappelen on 28/01/2022.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let all = try All(json)

//
// To read values from URLs:
//
//   let task = URLSession.shared.allTask(with: url) { all, response, error in
//     if let all = all {
//       ...
//     }
//   }
//   task.resume()

// MARK: - All
struct All: Codable {
    let searchResult: SearchResult

    enum CodingKeys: String, CodingKey {
        case searchResult = "SearchResult"
    }
}

// MARK: All convenience initializers and mutators

extension All {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(All.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        searchResult: SearchResult? = nil
    ) -> All {
        return All(
            searchResult: searchResult ?? self.searchResult
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.searchResultTask(with: url) { searchResult, response, error in
//     if let searchResult = searchResult {
//       ...
//     }
//   }
//   task.resume()

// MARK: - SearchResult
struct SearchResult: Codable {
    let total: Int
    let resources: [Resource]
}

// MARK: SearchResult convenience initializers and mutators

extension SearchResult {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SearchResult.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        total: Int? = nil,
        resources: [Resource]? = nil
    ) -> SearchResult {
        return SearchResult(
            total: total ?? self.total,
            resources: resources ?? self.resources
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.resourceTask(with: url) { resource, response, error in
//     if let resource = resource {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Resource
struct Resource: Codable {
    let id, name: String
    let link: Link
}

// MARK: Resource convenience initializers and mutators

extension Resource {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Resource.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String? = nil,
        name: String? = nil,
        link: Link? = nil
    ) -> Resource {
        return Resource(
            id: id ?? self.id,
            name: name ?? self.name,
            link: link ?? self.link
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.linkTask(with: url) { link, response, error in
//     if let link = link {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Link
struct Link: Codable {
    let rel: String
    let href: String
    let type: String
}

// MARK: Link convenience initializers and mutators

extension Link {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Link.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        rel: String? = nil,
        href: String? = nil,
        type: String? = nil
    ) -> Link {
        return Link(
            rel: rel ?? self.rel,
            href: href ?? self.href,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func allTask(with url: URL, completionHandler: @escaping (All?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
