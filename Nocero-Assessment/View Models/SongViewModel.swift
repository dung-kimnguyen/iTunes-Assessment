//
//  SongViewModel.swift
//  Nocero-Assessment
//
//  Created by Dung Kim Nguyen on 07/14/21.
//  Copyright © 2021 Dung Kim Nguyen. All rights reserved.
//

import Foundation

struct SongViewModel {
    let title: String
    let runtime: String
}

extension SongViewModel {
    init(song: Song) {
        self.title = song.censoredName
        
        // Track time in milliseconds
        let timeInSeconds = song.trackTime / 1000
        let minutes = timeInSeconds / 60 % 60
        let seconds = timeInSeconds % 60
        
        self.runtime = "\(minutes): \(seconds)"
    }
}
