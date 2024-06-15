//
//  ExamplesViewModel.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 11/04/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import Combine

class ExamplesViewModel {
    
    private(set) var examples = PassthroughSubject<MockExample, Error>()
    
    init() {}
    
    @MainActor
    func readJSONFile(forName name: String) async {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"), let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let result = try JSONDecoder().decode(MockExample.self, from: jsonData)
                examples.send(result)
            }
        } catch {
            print(error)
        }
    }
    
    
}

public struct MockExample: Codable {
    var sections: [Section]
}

public struct Section: Codable {
    var title: String
    var examples: [SectionExample]
}

public struct SectionExample: Codable {
    var title: String
    var deeplink: String
}
