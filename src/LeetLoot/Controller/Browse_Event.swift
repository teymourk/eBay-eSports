//
//  Browse_Event.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/20/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Browse_Event: Browse_Game {
    
    let eventHeader = { ()-> Event_Header in
        let view = Event_Header()
            view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupMenuBar() {
        view.addSubview(eventHeader)
        view.addSubview(menuBar)
        
        NSLayoutConstraint.activate([
            eventHeader.topAnchor.constraint(equalTo: view.topAnchor),
            eventHeader.heightAnchor.constraint(equalToConstant: 45),
            eventHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eventHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            menuBar.topAnchor.constraint(equalTo: eventHeader.bottomAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 45),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension Browse_Event {
    //Space Between Header and Collection itself
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let height = menuBar.frame.height + eventHeader.frame.height + 20
        collectionView.scrollIndicatorInsets.top = height
        return UIEdgeInsets(top: height,
                            left: 19,
                            bottom: 0,
                            right: 19)
    }
}


class Event_Header: ParentView {
    private let eventImage = { () -> UIImageView in
        let image = UIImageView(image: #imageLiteral(resourceName: "Bitmap"))
            image.contentMode = .scaleAspectFit
            image.translatesAutoresizingMaskIntoConstraints = false
            image.backgroundColor = .red
       return image
    }()
    
    private let eventTitle = { () -> UILabel in
        let label = UILabel()
            label.text = "June 12 - June 14 . Los Angeles Convention Center"
            label.font = UIFont.systemFont(ofSize: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let location = { () -> UILabel in
        let label = UILabel()
            label.text = "Los Angeles, California"
            label.font = UIFont.systemFont(ofSize: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupView() {
        backgroundColor = .white
        addSubview(eventImage)
        addSubview(eventTitle)
        addSubview(location)
        
        NSLayoutConstraint.activate([
            eventImage.widthAnchor.constraint(equalToConstant: 40),
            eventImage.heightAnchor.constraint(equalToConstant: 40),
            eventImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            eventImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            eventTitle.topAnchor.constraint(equalTo: eventImage.topAnchor, constant: 2),
            eventTitle.leadingAnchor.constraint(equalTo: eventImage.trailingAnchor, constant: 4),
            eventTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            location.topAnchor.constraint(equalTo: eventTitle.bottomAnchor, constant: 3.5),
            location.leadingAnchor.constraint(equalTo: eventTitle.leadingAnchor),
            location.trailingAnchor.constraint(equalTo: eventTitle.trailingAnchor)
        ])
    }
}
