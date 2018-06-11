//
//  DecodableDataParser.swift
//  SiriShortcutsSample
//
//  Created by Ryuta Kibe on 2017/11/17.
//  Copyright © 2017 AWA Co. Ltd. All rights reserved.
//

import APIKit

final class DecodableDataParser: DataParser {
    var contentType: String? {
        return "application/json"
    }
    
    func parse(data: Data) throws -> Any {
        return data
    }
}
