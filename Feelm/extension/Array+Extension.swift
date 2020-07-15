//
//  Array+Extension.swift
//  TipBoook
//
//  Created by feel on 2020/04/27.
//  Copyright © 2020 ___FEEL___. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    public func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    public mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
