//
//  DateExtension.swift
//  DinDin
//
//  Created by Ben Patch on 1/21/17.
//  Copyright © 2017 PatchWork. All rights reserved.
//

import Foundation

extension Date {
    static var formatter: DateFormatter {
        let formatString = DateFormatter.dateFormat(fromTemplate: "EEE, MMM d, h:mm a", options: 0, locale: Locale.current)
        let formatter = DateFormatter()
        formatter.dateFormat = formatString
        return formatter
    }
}
