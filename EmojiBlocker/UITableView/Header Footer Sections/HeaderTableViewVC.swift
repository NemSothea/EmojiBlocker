//
//  HeaderTableVievVC.swift
//  EmojiBlocker
//
//  Created by Bizplay on 2022/09/05.
//

import UIKit

class HeaderTableViewVC: UIViewController {
    

    @IBOutlet weak var MytableView: UITableView!
    
    let games = [
    "January",
    "February",
    "March",
    "April"
    ]
    let cellID = "cellID"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUp()
        
        
    }
    func setUp() {
        setTableView()
        setupTableViewHeader()
        setupTableViewFooter()
    }
    func  setTableView() {
        MytableView.delegate = self
        MytableView.dataSource = self
        MytableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    func setupTableViewHeader() {
        let header = HeaderView(frame: .zero)
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        MytableView.tableHeaderView = header
    }
    func setupTableViewFooter() {
        let footer = SectionFooterView(frame: .zero)
        var size = footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        footer.frame.size = size
        
        // Recalculate header size after populated with content
        size = footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        footer.frame.size = size
        MytableView.tableFooterView = footer
    }
    
    
}
extension HeaderTableViewVC : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SectionHeaderView()
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = SectionFooterView()
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = games[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
    // MARK: editing support
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
}


