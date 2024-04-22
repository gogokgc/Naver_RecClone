//
//  Double+Extensions.swift
//  voiceMemo
//

import Foundation

extension Double {
    var formattedTimeInterval: String {
        let totalSceonds = Int(self)
        let sec = totalSceonds % 60
        let min = (totalSceonds / 60) % 60
        
        return String(format: "%02d:%02d", min, sec)
    }
}
