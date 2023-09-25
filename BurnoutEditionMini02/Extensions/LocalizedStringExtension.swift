//
//  LocalizedStringExtension.swift
//  BurnoutEditionMini02
//
//  Created by Thayna Rodrigues on 21/09/23.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
