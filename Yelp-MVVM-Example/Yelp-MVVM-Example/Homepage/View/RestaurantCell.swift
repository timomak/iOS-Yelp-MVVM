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
    
    /// Take the data from the viewmodel to put into the UI
    var restaurantCellViewModel : RestaurantCellViewModel? {
        didSet {
            self.restaurantImage.downloaded(from: restaurantCellViewModel!.previewImage, contentMode: .scaleAspectFit)
            
//            let url = URL(string: restaurantCellViewModel!.previewImage)
//            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//            self.restaurantImage.image = UIImage(data: data!)
            
            // self.restaurantImage.image = #imageLiteral(resourceName: "CashApp")
//
//            let url = URL(string: restaurantCellViewModel!.previewImage)
//
//            DispatchQueue.global().async {
//                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//                DispatchQueue.main.async {
//                    self.restaurantImage.image = UIImage(data: data!)
//                }
//            }
            
            self.nameTextView.text = restaurantCellViewModel?.name
            self.descriptionTextView.text = restaurantCellViewModel?.descriptionText
        }
    }
    
    /// THE IMAGE OR GIF IN THE MIDDLE FOR EACH CELL OF ONBOARDING
    var restaurantImage: UIImageView = {
        var v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFit
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.3
        v.layer.shadowOffset = CGSize(width: 1, height: 20)
        v.layer.shadowRadius = 10
        return v
    }()
    
    /// Name
    let nameTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.font = UIFont.boldSystemFont(ofSize: 16.0)
//        textView.textColor = PSColor.gray.value
        textView.textAlignment = .center
        return textView
    }()
    
    /// DESCRIPTION
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
//        textView.font = UIFont(name: Font.regular.name, size: CGFloat(Font.small.size))
//        textView.textColor = PSColor.gray.value
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
        
        restaurantImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        restaurantImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        nameTextView.topAnchor.constraint(equalTo: self.restaurantImage.bottomAnchor, constant: 14).isActive = true
        nameTextView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: self.nameTextView.bottomAnchor, constant: 5).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: self.nameTextView.leftAnchor).isActive = true
        
        
    
        
            

//            phoneFrame.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            phoneFrame.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -Padding.consecutive.cgFloat()),
//            phoneFrame.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
//
//            imageView.topAnchor.constraint(equalTo: phoneFrame.topAnchor, constant: 6),
//            imageView.trailingAnchor.constraint(equalTo: phoneFrame.trailingAnchor, constant: -5),
//            imageView.heightAnchor.constraint(equalTo: phoneFrame.heightAnchor, constant: -Padding.consecutive.cgFloat()),
//            imageView.widthAnchor.constraint(equalTo: phoneFrame.widthAnchor, constant: -10),

    }
}

