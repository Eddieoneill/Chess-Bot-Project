//
//  Date+Extension.swift
//  CTA
//
//  Created by Edward O'Neill on 3/14/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import Foundation

extension Date {
    public func dateString(_ format: String = "EEEE, MMM d, h:mm a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        return dateFormatter.string(from: self)
    }
}
