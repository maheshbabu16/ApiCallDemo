//
//  MusicHomeTableCell.swift
//  MusicAPPDemo
//
//  Created by Mahesh babu on 22/12/23.
//

import UIKit

class MusicHomeTableCell: UITableViewCell {
    
    //MARK: - IB Outlets
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var btnShowMore: UIButton!
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    
    //MARK: - Outside Variables
    var arrListData:[DataResult]? = []
    var showMoreBlockHandler: (() -> Void)?
    
    //MARK: - Register cell
    static let reUseIdentifier = Constants.CellRegister.MusicHomeTableCell
    static let nibName = UINib(nibName: MusicHomeTableCell.reUseIdentifier, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUi()
    }

    func setUpUi(){
        self.btnShowMore.layer.cornerRadius = 5
        self.btnShowMore.backgroundColor = UIColor.systemPink
        self.btnShowMore.titleLabel?.text = Constants.TextStrings.showMore
        self.btnShowMore.titleLabel?.textColor = UIColor.white
        
        self.listCollectionView.dataSource = self
        self.listCollectionView.delegate = self
        self.listCollectionView.backgroundColor = UIColor.clear
        
        self.listCollectionView.register(MusicCollectionViewCell.nibName, forCellWithReuseIdentifier: MusicCollectionViewCell.reUseIdentifier)
      
        self.mainLbl.textColor = UIColor.textColor
        self.mainLbl.textColor = UIColor.textColor
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func onClickShowMore(_ sender: Any) {
        self.showMoreBlockHandler?() // used block handler to implement buttin action
    }
    
}

//MARK: - CollectionView Meathods
extension MusicHomeTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrListData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.reUseIdentifier, for: indexPath) as? MusicCollectionViewCell {
            let arrM = arrListData?[indexPath.row]
            cell.mainTitle.text = arrM?.subcategoryName

            if let url = URL(string: arrM?.url ?? "") { //converting data to image
                
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    
                    guard let data = data, error == nil else {
                        return
                    }
                    DispatchQueue.main.async {
                        cell.imgView.image = UIImage(data: data)
                    }
                    
                }.resume()
                
            }

            return cell
        }

        return UICollectionViewCell()
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.height - 5
        return CGSize(width: 150, height: size)
    }
    
    
}
