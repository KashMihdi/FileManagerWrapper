//
//  Extension + FileManager.swift
//  FileManagerWrapper
//
//  Created by Kasharin Mikhail on 29.10.2023.
//

import Foundation
extension FileManager {
    static func documentPath(key: String) -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appending(component: "\(key).txt")
    }
}
