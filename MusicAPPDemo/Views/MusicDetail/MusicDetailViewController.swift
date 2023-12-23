//
//  MusicDetailViewController.swift
//  MusicAPPDemo
//
//  Created by Mahesh babu on 22/12/23.
//

import UIKit

class MusicDetailViewController: UIViewController {
    //MARK: - IB-Outlets
    @IBOutlet weak var topheaderView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var collectionList: UICollectionView!
    
    //MARK: - Outside variables
let objViewModel = MusicDetailViewModel()
    var arrDetailData: [DataResult]?
    var titleTxt: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.objViewModel.objDetailVC = self
        // Do any additional setup after loading the view.
    }
    //MARK: - IB-Actions
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
