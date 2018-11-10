//
//  ServiceResponse.swift
//  Chirper
//
//  Created by Andy Ron on 2018/11/10.
//  Copyright © 2018 Andy Ron. All rights reserved.
//

import Foundation

struct ServiceResponse: Codable {
    let recordings: [Recording]
    let page: Int
    let numPages: Int
}
