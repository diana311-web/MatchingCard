//
//  NetworkMonitor.swift
//  MatchingCard
//
//  Created by Elena Diana Morosanu on 30.06.2024.
//

import Foundation
import Network

public class NetworkMonitor {
    public static let shared = NetworkMonitor()
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue(label: "NetworkMonitor")
    
    public var isConnected: Bool = true
    
    private init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
