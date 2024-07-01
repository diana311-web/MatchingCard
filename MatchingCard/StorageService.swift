//
//  StorageService.swift
//  MatchingCard
//
//  Created by Elena Diana Morosanu on 29.06.2024.
//

import Foundation

public class StorageService
{
    private let storageKey: String
    
    public init(storageKey: String) {
        self.storageKey = storageKey
    }
    
    private var storage = UserDefaults.standard
    
    public func load<T>(_ type: T.Type) -> T? where T : Decodable {
        if let data = storage.data(forKey: storageKey), !data.isEmpty {
            return try! JSONDecoder().decode(T.self, from: data)
        }
        return nil
    }
    
    public func loadArray<T>(_ type: T.Type) -> [T] where T : Decodable {
        if let data = storage.data(forKey: storageKey), !data.isEmpty {
            return try! JSONDecoder().decode([T].self, from: data)
        }
        return []
    }
    
    public func save<T>(_ state: T) where T : Codable {
        if let data = try? JSONEncoder().encode(state) {
            storage.set(data, forKey: storageKey)
        }
    }
    
    public func append<T>(_ state: T) where T : Codable {
        var results = loadArray(T.self)
        results.append(state)
        if let data = try? JSONEncoder().encode(results) {
            storage.set(data, forKey: storageKey)
        }
    }
    
    public func saveArray<T>(_ states: [T]) where T : Codable {
        if let data = try? JSONEncoder().encode(states) {
            storage.set(data, forKey: storageKey)
        }
    }
    
    public func appendArray<T>(_ states: [T]) where T : Codable {
        var results = loadArray(T.self)
        results.append(contentsOf: states)
        if let data = try? JSONEncoder().encode(results) {
            storage.set(data, forKey: storageKey)
        }
    }
}
