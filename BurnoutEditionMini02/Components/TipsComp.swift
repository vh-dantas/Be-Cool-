//
//  TipsComp.swift
//  BurnoutEditionMini02
//
//  Created by João Victor Bernardes Gracês on 30/10/23.
//

import Foundation
import TipKit
@available(iOS 17.0, *)
struct TextTip: Tip {
    var titleText: String
    var body: String
    var title: Text {
        Text(titleText)
    }
    var message: Text? {
        Text(body)
    }
}
