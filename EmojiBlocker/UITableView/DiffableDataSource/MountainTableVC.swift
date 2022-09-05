//
//  MountainVC.swift
//  EmojiBlocker
//
//  Created by Bizplay on 2022/08/31.
//

import UIKit

class MountainTableVC: UIViewController, UISearchBarDelegate {

    enum Section  {
        case main
    }
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    var dataSource : UITableViewDiffableDataSource<Section,MountainVC.Mountain>!
    let nameFilter : String? = nil
    let reuseIdentifier = "reuse_identifier"
    
    let mountainVC = MountainVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        configureDataSource()
    }
    
    func layout() {
        for viewable in [searchBar, tableView] {
            view.addSubview(viewable)
            viewable.translatesAutoresizingMaskIntoConstraints = false
        }
        
        searchBar.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        /* Constraints of the form,
         receiver [= | ≥ | ≤] 'anchor' + 'multiplier' * system space
         */
        searchBar.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
        searchBar.leadingAnchor.constraint(equalToSystemSpacingAfter:view.leadingAnchor, multiplier: 1).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchBar.trailingAnchor, multiplier: 1).isActive = true
        
        tableView.topAnchor.constraint(equalToSystemSpacingBelow: searchBar.bottomAnchor, multiplier: 0).isActive = true
        tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 0).isActive = true
        view.bottomAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 0).isActive = true
    }
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section,MountainVC.Mountain>(tableView : tableView) {
            
            (tableView : UITableView,indexPath : IndexPath, item : MountainVC.Mountain) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier:self.reuseIdentifier, for: indexPath)
            cell.textLabel?.text = item.name
            return cell
        }
    }
    func performQuery(with filter : String?) {
        let mountains = mountainVC
    }

}
