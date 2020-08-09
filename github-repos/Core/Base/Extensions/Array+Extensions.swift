//
//  Array+Extensions.swift
//  FYMMobil
//
//  Created by Burhan on 8.03.2020.
//  Copyright © 2020 Horizon. All rights reserved.
//

import UIKit

extension Array {

    public subscript(safeIndex index: Int) -> Element {
        let index = index % self.count
        return self[index]
    }
}
