//
//  MusicCollectionViewCell.swift
//  MusicAPPDemo
//
//  Created by Mahesh babu on 22/12/23.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    //MARK: - IB-Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!    
    
    //MARK: - Registering Cell
    static let reUseIdentifier = Constants.CellRegister.MusicCollectionViewCell
    static let nibName = UINib(nibName: MusicCollectionViewCell.reUseIdentifier, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainView.layer.cornerRadius = 5
        self.mainView.backgroundColor = UIColor.textColor?.withAlphaComponent(0.15)
        
    }

}
