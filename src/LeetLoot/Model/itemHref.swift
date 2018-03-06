//
//  ItemHerf.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 3/2/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit


struct ItemHerf: Codable, Networking {
    typealias Model = ItemHerf
    
    var shortDescription: String?,
        image: thumbnailImages?,
        additionalImages: [thumbnailImages]?,
        items: [items]?
    
    init?(herfUrl: String, completion: @escaping (ItemHerf) -> ()) {
        guard let url = URL(string: herfUrl) else { return }
        
        requestData(forUrl: url) { (_response, _itemHref) in
            guard let itemHref = _itemHref else { return }
            DispatchQueue.main.async {
                completion(itemHref)
            }
        }
    }
    
    var description: String {
        let groupHrefDescription = self.items?.first?.shortDescription,
            itemsHrefDescription = self.shortDescription
        return groupHrefDescription != nil ? groupHrefDescription ?? "" : itemsHrefDescription ?? ""
    }
    
    private var imgURL: thumbnailImages {
        let groupHrefImage = self.items?.first?.primaryItemGroup?.itemGroupImage,
            itemsHrefImage = self.image
        return groupHrefImage != nil ? groupHrefImage ?? thumbnailImages(imageUrl: "") : itemsHrefImage ?? thumbnailImages(imageUrl: "")
    }
    
    var groupAadditionalImages: [thumbnailImages] {
        let itemAdditionalHrefImages = self.additionalImages,
            addtionalGroupHrefIamges = items?.first?.primaryItemGroup?.itemGroupAdditionalImages
        
        var completeHrefImages = addtionalGroupHrefIamges != nil ? addtionalGroupHrefIamges ?? [] : itemAdditionalHrefImages ?? []
            completeHrefImages.insert(imgURL, at: 0)
        
        return completeHrefImages
    }
 }

struct items: Codable {
    let primaryItemGroup: primaryItemGroup?,
        shortDescription: String?

}

struct primaryItemGroup: Codable {
    let itemGroupImage: thumbnailImages?,
        itemGroupAdditionalImages: [thumbnailImages]?
}
