//
//  MusicHomeViewController.swift
//  MusicAPPDemo
//
//  Created by Mahesh babu on 22/12/23.
//

import UIKit

class MusicHomeViewController: UIViewController {

    //MARK: - IB-Outlets
    
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var topHeaderLbl: UILabel!
    @IBOutlet weak var tblMusicList: UITableView!
    
    //MARK: - OutSide Variables
    let objMusicViewModel = MusicHomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objMusicViewModel.objMusicVC = self
        self.navigationController?.navigationBar.isHidden = true

    }
    

}
