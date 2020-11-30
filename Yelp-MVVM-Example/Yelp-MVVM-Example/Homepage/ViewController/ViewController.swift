//
//  ViewController.swift
//  Yelp-MVVM-Example
//
//  Created by timofey makhlay on 11/30/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /// View model property  in the VC
    lazy var viewModel: RestaurantViewModel = {
        return RestaurantViewModel()
    }()
    
    // Tableview
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Restaurants"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        
        // set a background color so we can easily see the table
        self.view.backgroundColor = UIColor.black
        
        setupTableView()
        
        viewModel.reloadCollectionViewClosure = {
            DispatchQueue.main.async {
                print("Success")
                self.tableView.reloadData()
                
            }
        }
        
        viewModel.getRestaurantRequest()
    }
    
    func setupTableView() {
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = true
        
        self.view.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32.0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0).isActive = true
        
        //tableView.register(BottomTableViewCell.self, forCellReuseIdentifier: BottomTableViewCell.identifier)
        
        // register a defalut cell
        tableView.register(RestaurantCell.self, forCellReuseIdentifier: RestaurantCell.identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create Cells one by one using this as a blueprint.
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantCell.identifier, for: indexPath) as! RestaurantCell

        //Getting the view model for a cell
        let cellVM = viewModel.getCellViewModel(at: indexPath)
//        cell.bottomTableViewCellViewModel = cellVM
//
//        // Remove cell bottom line
//        cell.selectionStyle = .none
//        cell.emptyView.isUserInteractionEnabled = false
//        cell.sideImage.isUserInteractionEnabled = false
//        cell.textLabel?.isUserInteractionEnabled = false
        
        cell.restaurantCellViewModel = cellVM
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "\(indexPath)"
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        return cell
    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        delegate?.bottomTableViewPressed(at: indexPath.row)
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

