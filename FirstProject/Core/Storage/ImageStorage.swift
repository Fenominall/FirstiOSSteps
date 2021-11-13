//
//  ImageStorage.swift
//  FirstProject
//
//  Created by Fenominall on 11/12/21.
//

import Foundation
import UIKit


// MARK: - ImageStorage for storing User`s image
public class ImageStorage {
    
    public enum ImageStorageType {
        case userDefaults
        case fileSystem
    }
    
    // MARK: - Storing Image
    // Store an image either in userDefaults or fileSystem
    public func storeImage(image: UIImage,
                           forKey key: String,
                           withStorageType storageType: ImageStorageType) {
        if let pngRepresentation = image.pngData() {
            switch storageType {
            case .fileSystem:
                // Save image to a disk
                if let filePath = filePath(forKey: key) {
                    do {
                        try pngRepresentation.write(to: filePath,
                                                    options: .atomic)
                    } catch let error {
                        print("Saving file resulted in error: ", error)
                    }
                }
            case .userDefaults:
                // Save Image to UserDefaults
                UserDefaults.standard.set(pngRepresentation, forKey: key)
            }
        }
    }
    
    // MARK: - Retrieving Image
    public func retrieveImage(forKey key: String,
                              inStorageType storageType: ImageStorageType) -> UIImage? {
        switch storageType {
        case .fileSystem:
            // Retrieve from a disk
            if let filePath = self.filePath(forKey: key),
               let fileData = FileManager.default.contents(atPath: filePath.path),
               let image = UIImage(data: fileData) {
                return image
            }
        case .userDefaults:
            // Retrieve from UserDefaults
            if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
               let image = UIImage(data: imageData) {
                return image
            }
        }
        return nil
    }
    
    // MARK: - Deleting Image
    public func removeImage(forKey key: String,
                            inStorageType storageType: ImageStorageType) {
        switch storageType {
        case .fileSystem:
            guard let filePath = filePath(forKey: key) else { return }
            if FileManager.default.fileExists(atPath: filePath.path) {
                print("test")
                do {
                    try FileManager.default.removeItem(at: filePath)
                } catch let error {
                    print(error)
                }
            }
        case .userDefaults:
            print("Test")
        }
    }
    
    // Creating filepath
    public func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                    in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        return documentURL.appendingPathComponent(key + ".png")
    }
    
}
