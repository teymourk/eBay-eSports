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
    
    override func setupNavBar() {}
}

extension Browse_Event {
    //Space Between Header and Collection itself
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let height = menuBar.frame.height + eventHeader.frame.height + 25
        collectionView.scrollIndicatorInsets.top = height
        return UIEdgeInsets(top: height,
                            left: 25,
                            bottom: 0,
                            right: 25)
    }
}


class Event_Header: ParentView {
    
    var eventDetails: Categories? {
        didSet {
            let date = eventDetails?.date ?? "",
                locations = eventDetails?.location ?? "",
                imageURL = eventDetails?.imageName ?? ""
            
            eventDate.text = date
            location.text = locations
            
            eventImage.downloadImages(url: imageURL)
        }
    }
    
    private let eventImage = { () -> customeImage in
        let image = customeImage(frame: .zero)
            image.contentMode = .scaleAspectFit
            image.translatesAutoresizingMaskIntoConstraints = false
            image.backgroundColor = .clear
       return image
    }()
    
    private let dateIcon = { () -> UIImageView in
        let image = UIImageView(image: #imageLiteral(resourceName: "date"))
            image.contentMode = .scaleAspectFit
            image.translatesAutoresizingMaskIntoConstraints = false
            image.backgroundColor = .white
        return image
    }()
    
    private let eventDate = { () -> UILabel in
        let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let locationIcon = { () -> UIImageView in
        let image = UIImageView(image: #imageLiteral(resourceName: "location"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .white
        return image
    }()
    
    private let location = { () -> UILabel in
        let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupView() {
        backgroundColor = .white
        addSubview(eventImage)
        addSubview(dateIcon)
        addSubview(eventDate)
        addSubview(locationIcon)
        addSubview(location)
        
        NSLayoutConstraint.activate([
            eventImage.widthAnchor.constraint(equalToConstant: 40),
            eventImage.heightAnchor.constraint(equalToConstant: 40),
            eventImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            eventImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            dateIcon.widthAnchor.constraint(equalToConstant: 15),
            dateIcon.heightAnchor.constraint(equalToConstant: 15),
            dateIcon.leadingAnchor.constraint(equalTo: eventImage.trailingAnchor, constant: 10),
            dateIcon.topAnchor.constraint(equalTo: eventImage.topAnchor, constant: 2),
            
            eventDate.topAnchor.constraint(equalTo: eventImage.topAnchor, constant: 1.5),
            eventDate.leadingAnchor.constraint(equalTo: eventImage.trailingAnchor, constant: 32),
            eventDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            locationIcon.widthAnchor.constraint(equalToConstant: 13.5),
            locationIcon.heightAnchor.constraint(equalToConstant: 19),
            locationIcon.leadingAnchor.constraint(equalTo: eventImage.trailingAnchor, constant: 10.5),
            locationIcon.topAnchor.constraint(equalTo: eventDate.bottomAnchor, constant: 2),
            
            location.topAnchor.constraint(equalTo: eventDate.bottomAnchor, constant: 2),
            location.leadingAnchor.constraint(equalTo: eventDate.leadingAnchor),
            location.trailingAnchor.constraint(equalTo: eventDate.trailingAnchor)
        ])
    }
}
