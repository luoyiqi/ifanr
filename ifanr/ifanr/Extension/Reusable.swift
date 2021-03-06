//
//  Reusable.swift
//  EyepetizerApp
//
//  Created by 梁亦明 on 16/3/16.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier : String {
        return String(Self)
    }  
}

// MARK: - 扩展UITableView, 不用传入identifier参数  identifier参数为类名
public extension UITableView {
    func dequeueReusableCell<T: Reusable>() -> T? {
        return self.dequeueReusableCellWithIdentifier(T.reuseIdentifier) as! T?
    }
}

public extension UICollectionView {
    
    func dequeueReusableCell<T: Reusable>(indexPath: NSIndexPath) -> T {
        return self.dequeueReusableCellWithReuseIdentifier(T.reuseIdentifier, forIndexPath: indexPath) as! T
    }
    
    func registerClass<T: UICollectionViewCell where T: Reusable>(_: T.Type) {
        self.registerClass(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerClass<T: UICollectionReusableView where T: Reusable>(_: T.Type, forSupplementaryViewOfKind: String) {
        return self.registerClass(T.self, forSupplementaryViewOfKind: forSupplementaryViewOfKind, withReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableSupplementaryViewOfKind<T: UICollectionReusableView where T: Reusable>(elementKind: String, indexPath: NSIndexPath) -> T {
        return self.dequeueReusableSupplementaryViewOfKind(elementKind, withReuseIdentifier: T.reuseIdentifier, forIndexPath: indexPath) as! T
    }
}