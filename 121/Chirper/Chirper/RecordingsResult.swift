//
//  RecordingsResult.swift
//  Chirper
//
//  Created by Andy Ron on 2018/11/10.
//  Copyright © 2018 Andy Ron. All rights reserved.
//

import Foundation

/*
 查询
 */
struct RecordingsResult {
    let recordings: [Recording]?
    let error: Error?
    let currentPage: Int
    let pageCount: Int
    
    var hasMorePages: Bool {
        return currentPage < pageCount
    }
    
    var nextPage: Int {
        return hasMorePages ? currentPage + 1 : currentPage
    }
}
