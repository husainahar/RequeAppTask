//
//  Decoder.swift
//  RequeAppTask
//
//  Created by Husain Nahar on 2/3/20.
//  Copyright © 2020 Husain Nahar. All rights reserved.
//

import Foundation

struct ResponseDecoder: Decodable {
    let status: Bool
    let message: String
    let result: [Product]?
}

struct Product: Decodable {
    let name: String?
    let image: String?
    let cur_price: String?
}
