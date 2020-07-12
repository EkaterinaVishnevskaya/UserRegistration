//
//  ViewController.swift
//  Homework5
//
//  Created by Екатерина Вишневская - ВТБ on 01.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Locals {
        static let cellID = "cell"
        static let cellHeight: CGFloat = 50
    }
    
    
    // MARK: - Properties

    @IBOutlet var tableView: UITableView!
    private var cellModels: [CarCellModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        configureTableView()
        loadData()
        view.addSubview(tableView)
    }
    
    
    // MARK: - Configurations
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CarCell.self, forCellReuseIdentifier: Locals.cellID)
    }

    private func loadData() {
        
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellID, for: indexPath) as? CarCell {
            cell.viewModel = self.cellModels[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return Locals.cellHeight
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cellModels.remove(at: indexPath.row)
        }
    }
}

