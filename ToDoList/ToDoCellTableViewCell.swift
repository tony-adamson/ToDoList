//
//  ToDoCellTableViewCell.swift
//  ToDoList
//
//  Created by Антон Адамсон on 01.05.2023.
//

import UIKit

protocol ToDoCellDelegate: AnyObject {
    func checkmarkTapped(sender: ToDoCellTableViewCell)
}

class ToDoCellTableViewCell: UITableViewCell {

    weak var delegate: ToDoCellDelegate?
    
    //MARK: - @IBOutlets
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // Действие по нажатию на кнопку завершения
    @IBAction func completeButtonTapped(_ sender: Any) {
        delegate?.checkmarkTapped(sender: self)
    }
}
