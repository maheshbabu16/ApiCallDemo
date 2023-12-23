//
//  MusicHomeViewModel.swift
//  MusicAPPDemo
//
//  Created by Mahesh babu on 22/12/23.
//

import Foundation
import UIKit

class MusicHomeViewModel: NSObject{
    
    //MARK: - OutSide Variables
    var objMusicVC: MusicHomeViewController? { didSet { self.setUpUI() } }
    var arrMusicList: [MusicDataModel]? = []
    var arrData: [DataResult]? = []
    var imgView: UIImageView?
    var refreshControl:UIRefreshControl!
    var isPullToRefreseh: Bool = false
    
    //MARK: - Functions
    
    func setUpUI(){
        guard let objVC = objMusicVC else { return }
        if refreshControl == nil{
            refreshControl = UIRefreshControl()
            refreshControl.attributedTitle = NSAttributedString(string: "")
            refreshControl.tintColor = UIColor.textColor
            refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
            objVC.tblMusicList.addSubview(refreshControl)
        }
        
        objVC.activityIndicator = UIActivityIndicatorView(style: .large)
        objVC.activityIndicator.center = objVC.view.center
        objVC.view.addSubview(objVC.activityIndicator)
        
        objVC.topHeaderLbl.font = Constants.Fonts.headerLabelFont
        objVC.topHeaderView.backgroundColor = UIColor.pineGreen
        
        objVC.tblMusicList.dataSource = self
        objVC.tblMusicList.delegate = self
        
        //MARK: - register cell
        objVC.tblMusicList.register(MusicHomeTableCell.nibName, forCellReuseIdentifier: MusicHomeTableCell.reUseIdentifier)
        
        self.apiCall(strUrl: Constants.API.apiUrl)
    }
    //MARK: - Pull to refresh
    @objc func refresh(_ sender:AnyObject)
    {
        
        isPullToRefreseh = true
        self.apiCall(strUrl: Constants.API.apiUrl)
        refreshControl.endRefreshing()
    }
    //MARK: - Api Call
    func apiCall(strUrl:URL?){
        guard let objVC = objMusicVC else { return }
        guard let url = strUrl else{ return }
        let decoder = JSONDecoder()
        let request = URLRequest(url: url)
        
        objVC.activityIndicator.startAnimating()
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil{
                print(error?.localizedDescription as Any)
            }
            else{
                
                if let data = data{
                    let responseString = String(data: data, encoding: .utf8)
                    print("Response String: \(responseString ?? Constants.TextStrings.apiErrorMessage)")
                    do{
                        let result = try decoder.decode([MusicDataModel].self, from: data)
                        
                        self.arrMusicList = result
                        
                        DispatchQueue.main.async {
                            
                            objVC.tblMusicList.reloadData()
                        }
                        print(result )
                        
                        
                    }catch{
                        print("<----------\(url)---------->")
                        print(error.localizedDescription)
                    }
                }
            }
            DispatchQueue.main.async {
                objVC.activityIndicator.stopAnimating()
                objVC.activityIndicator.hidesWhenStopped
            }
            
        }.resume()
    }
    
    func onClickShowMore(arrData:[DataResult]?, strTitle:String?) {
        //navigation to next screen
        guard let vc = Constants.Storyboards.main.instantiateViewController(withIdentifier: "MusicDetailViewController") as? MusicDetailViewController else { return }
        vc.arrDetailData = arrData
        vc.titleTxt = strTitle
        self.objMusicVC?.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

//MARK: - TableView Meathods
extension MusicHomeViewModel: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrMusicList?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MusicHomeTableCell.reUseIdentifier, for: indexPath) as? MusicHomeTableCell {
            
            if arrMusicList?.count ?? 0 > 0 {
                
                let arrM = arrMusicList?[indexPath.row]
                
                cell.mainLbl.text = arrM?.categoryName
                
                if let dataArray = arrM?.data {
                    
                    self.arrData = dataArray
                    cell.arrListData = dataArray
                    cell.showMoreBlockHandler = {
                        self.onClickShowMore(arrData: dataArray, strTitle: arrM?.categoryName)
                    }
                }
                
                cell.btnShowMore.titleLabel?.font = Constants.Fonts.btnTextFont
                cell.btnShowMore.backgroundColor = UIColor.darkBlue
                return cell
                
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
