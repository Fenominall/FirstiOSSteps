//
//  NetworkMonitor.swift
//  FirstProject
//
//  Created by Fenominall on 1/30/22.
//

import Foundation
import Network

final class NetworkMonitor {
    
    // MARK: - Properties
    static let shared = NetworkMonitor()

    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor

    public private(set) var isConnected: Bool = false
    
    // The value is optional because from the start when app is launched we don`t know if user has internet connection or not
    public private(set) var connectionType: ConnectionType = .unknown
    
    enum ConnectionType {
        case wifi
        case cellular
        case wiredEthernet
        case unknown
    }

    // MARK: - Lifecycle
    private init() {
        monitor = NWPathMonitor()
    }
    
    // MARK: - Helpers
    
    public func startMonitoring() {
        // Start monitoring in the global queue
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            // The handler will be called each time internet connection changes to check if it`s status is satisfied
            self?.isConnected = path.status != .unsatisfied
            self?.getConnectionType(path)
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .wiredEthernet
        } else {
            connectionType = .unknown
        }
    }
}
