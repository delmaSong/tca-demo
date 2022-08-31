//
//  UIView+Extension.swift
//  tca-pokemon
//
//  Created by Devsisters on 2022/08/30.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
