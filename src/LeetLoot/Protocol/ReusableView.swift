//
//  ReusableID.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/6/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

protocol ReusableView {
    static var identifier: String { get }
}

extension ReusableView where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func registerCell<T: ParentCell>(_ cell: T.Type, isHeader:Bool? = nil) {
        if isHeader != nil {
            register(cell,
                    forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                    withReuseIdentifier: T.identifier)
            return
        }
        register(cell,
                 forCellWithReuseIdentifier: T.identifier)
    }
    
    func reusableCell<T: ParentCell>(indexPath: IndexPath, kind: String? = nil ) -> T {
        if kind != nil {
            let header = dequeueReusableSupplementaryView(ofKind: kind!,
                                                          withReuseIdentifier: T.identifier,
                                                          for: indexPath) as? T ?? T()
            return header
        }
        
        let cell = dequeueReusableCell(withReuseIdentifier: T.identifier,
                                       for: indexPath) as? T ?? T()
        return cell
    }
}

extension ParentCell: ReusableView {}


