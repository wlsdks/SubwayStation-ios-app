//
//  StationSearchViewController.swift
//  SubwayStation-ios-app
//
//  Created by 최진안 on 2023/05/20.
//

import SnapKit
import UIKit

class StationSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 상단 네비게이션바 설정
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "지하철역을 입력해주세요"
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
    }


}

