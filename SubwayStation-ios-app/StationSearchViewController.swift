//
//  StationSearchViewController.swift
//  SubwayStation-ios-app
//
//  Created by 최진안 on 2023/05/20.
//

import SnapKit
import UIKit

class StationSearchViewController: UIViewController {
    
    private var numberOfCells: Int = 0
    
    // MARK: - 테이블뷰 선언
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.isHidden = true
        
        return tableView
    }()

    // MARK: - 앱 실행되면 가장먼저 실행됨
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItems()
        setTableViewLayout()
    }
    
    // MARK: - 상단 네비게이션바 설정
    private func setNavigationItems() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "지하철역을 입력해주세요"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }
    
    // MARK: - 테이블 뷰 레이아웃 설정
    private func setTableViewLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            // 전체 뷰 ui에 딱 맞는 사이즈로 변경시켜줌
            $0.edges.equalToSuperview()
        }
    }


}

// MARK: - 검색바 delegate를 확장선언
extension StationSearchViewController: UISearchBarDelegate {
    
    // 검색어 수정을 할때 동작함
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        numberOfCells = 10
        tableView.isHidden = false
    }
    
    // 검색어를 다 쓰고 나서 검색바를 닫을때 동작
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        numberOfCells = 0
        tableView.isHidden = true
    }
    
}

// MARK: - cell의 데이터 설정 확장선언
extension StationSearchViewController: UITableViewDataSource {
    
    // 섹션당 셀의 개수 세팅
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    // 셀의 세부설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.item)"
        
        return cell
    }
    
}
