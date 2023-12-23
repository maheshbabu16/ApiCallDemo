//
//  MusicDetailViewModel.swift
//  MusicAPPDemo
//
//  Created by Mahesh babu on 22/12/23.
//

import Foundation
import UIKit



class MusicDetailViewModel: NSObject{
    //MARK: - Outside variables
    var objDetailVC: MusicDetailViewController? { didSet { self.setUpUI() } }
    var arrData:[DataResult]?
    
    
    func setUpUI(){
        objDetailVC?.topheaderView.backgroundColor = UIColor.pineGreen
        
        self.arrData = objDetailVC?.arrDetailData
        self.objDetailVC?.lblTitle.text = objDetailVC?.titleTxt
        self.objDetailVC?.collectionList.dataSource = self
        self.objDetailVC?.collectionList.delegate = self
        self.objDetailVC?.collectionList.register(MusicCollectionViewCell.nibName, forCellWithReuseIdentifier: MusicCollectionViewCell.reUseIdentifier)
    }
    
    func onClickBack(){
        self.objDetailVC?.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - Collection View delegates
extension MusicDetailViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objDetailVC?.arrDetailData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.reUseIdentifier , for: indexPath) as? MusicCollectionViewCell{
            let arrM  = objDetailVC?.arrDetailData?[indexPath.row]
            cell.mainTitle.text = arrM?.subcategoryName
            if let url = URL(string: arrM?.url ?? "") {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let data = data, error == nil else {
                        return
                    }
                    DispatchQueue.main.async {
                        cell.imgView.image = UIImage(data: data)
                    }
                }.resume()
            }

            cell.mainView.backgroundColor = UIColor.black.withAlphaComponent(0.15)
            return cell
            
        }
        
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = collectionView.frame.size.width / 3
        return CGSize(width: size, height: 150)
    }
    
}
