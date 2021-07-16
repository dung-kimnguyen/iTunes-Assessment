//
//  PendingOperations.swift
//  Nocero-Assessment
//
//  Created by Nocero Beguhe on 07/14/21.
//  Copyright © 2021 Nocero Beguhe. All rights reserved.
//

import Foundation

class PendingOperations {
    var downloadsInProgress = [IndexPath: Operation]()
    
    let downloadQueue = OperationQueue()
}
