//
//  Reusable.swift
//  SampleProject
//
//  Created by RAVI K GUPTA on 04/01/22.
//

import Foundation

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
    static var nib: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return nib
    }
    static var nib: String {
        return String(describing: self)
    }
}


