//
//  HeroCell.swift
//  Homework5
//
//  Created by Екатерина Вишневская - ВТБ on 01.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class CarCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet var label: UILabel?
    var viewModel: CarCellModel? {
        didSet {
            if let viewModel = viewModel {
                updateContent(with: viewModel)
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        label = UILabel(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height))
        label?.text = self.textLabel?.text
        label?.textColor = .blue
        contentView.addSubview(label!)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Private
    
    private func updateContent(with viewModel: HeroCellModel) {
        label?.text = viewModel.number
    }
}
