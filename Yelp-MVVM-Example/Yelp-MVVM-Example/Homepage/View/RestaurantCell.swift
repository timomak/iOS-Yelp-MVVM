//
//  TableViewCell.swift
//  Yelp-MVVM-Example
//
//  Created by timofey makhlay on 11/30/20.
//

import UIKit

/// Holds Cell UI. Takes the data from Cell View Model
class RestaurantCell: UITableViewCell {
    
    /// Cell identifier
    static var identifier = "RestaurantCell"
    
    /// Take the data from the Cell View Model to put into the UI
    var restaurantCellViewModel : RestaurantCellViewModel? {
        didSet {
            self.restaurantImage.image = restaurantCellViewModel?.previewImage
            self.restaurantImage.contentMode = .scaleToFill
            
            self.nameTextView.text = restaurantCellViewModel?.name
            self.descriptionTextView.text = restaurantCellViewModel?.descriptionText
        }
    }
    
    /// Restaurant image
    var restaurantImage: UIImageView = {
        var v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFit
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.3
        v.layer.shadowOffset = CGSize(width: 1, height: 20)
        v.layer.shadowRadius = 10
        v.clipsToBounds = true
        return v
    }()
    
    /// Restaurant Name
    let nameTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.font = UIFont.boldSystemFont(ofSize: 16.0)
        textView.textColor = UIColor.white
        textView.textAlignment = .center
        return textView
    }()
    
    /// Restaurant Details
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textColor = UIColor.gray
        textView.textAlignment = .center
        return textView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        installConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func installConstraints() {
        addSubview(restaurantImage)
        addSubview(descriptionTextView)
        addSubview(nameTextView)
        
        restaurantImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 14).isActive = true
        restaurantImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        restaurantImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        restaurantImage.widthAnchor.constraint(equalToConstant: 300).isActive = true
        restaurantImage.layer.cornerRadius = 10
        
        nameTextView.topAnchor.constraint(equalTo: self.restaurantImage.bottomAnchor, constant: 5).isActive = true
        nameTextView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: self.nameTextView.bottomAnchor, constant: -5).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: self.nameTextView.leftAnchor).isActive = true

    }
}

