//
//  main.swift
//  karen
//
//  Created by Anthony Li on 1/8/22.
//

import Foundation
import ArgumentParser

struct Karen: ParsableCommand {
    @Argument() var path: String
    
    func run() throws {
        let task = Process()
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = nil
        // task.arguments = ["-d", "--entitlements", "-", "--xml", path]
        task.arguments = ["-d", "--entitlements", "-", path]
        task.executableURL = URL(string: "file:///usr/bin/codesign")!
        try task.run()
        
        let data = try pipe.fileHandleForReading.readToEnd()
        
        let decoder = PropertyListDecoder()
        // let entitlements = try decoder.decode([String: Any].self, from: data!)
        // print(entitlements)
        
        print(String(data: data!, encoding: .utf8)!)
    }
}

Karen.main()
