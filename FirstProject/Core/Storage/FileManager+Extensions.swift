//
//  FileManager+Extensions.swift
//  FirstProject
//
//  Created by Fenominall on 11/17/21.
//

import Foundation

extension FileManager {
    
    // function gets URL path to documents directory
    // Filemanager.getdocumentsDirectory() // typeMethod
    static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
//    static func pathToDocumentsDirectory(with fileName: String) -> URL {
//        let fileManager  = FileManager.default
//        let url = fileManager.urls(for: .documentDirectory,
//                                      in: .userDomainMask).first!
//        return url.appendingPathComponent(fileName)
//            .appendingPathExtension("json")
//    }
    
}
