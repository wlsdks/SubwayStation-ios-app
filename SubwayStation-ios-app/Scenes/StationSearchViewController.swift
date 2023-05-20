//
//  StationSearchViewController.swift
//  SubwayStation-ios-app
//
//  Created by 최진안 on 2023/05/20.
//

import Alamofire
import SnapKit
import UIKit

class StationSearchViewController: UIViewController {
    
    private var numberOfCells: Int = 0
    
    // MARK: - 테이블뷰 선언
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        
        return tableView
    }()

    // MARK: - 앱 실행되면 가장먼저 실행됨
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItems()
        setTableViewLayout()
        
        requestStationName()
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

    
    // 역의 이름을 가져오는 메서드
    private func requestStationName() {
        let urlString = "http://openapi.seoul.go.kr:8088/sample/json/SearchInfoBySubwayNameService/1/5/서울역"
        
        AF.request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationResponseModel.self) { response in
                guard case .success(let data) = response.result else { return }
                
                print(data.stations)
            }
            .resume()
    }
    
    

}

// MARK: - 검색바 delegate를 확장선언
extension StationSearchViewController: UISearchBarDelegate {
    
    // 검색어 수정을 할때 동작함
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        numberOfCells = 10
        // 검색어를 누르면 테이블뷰를 reload해준다.
        tableView.reloadData()
        tableView.isHidden = false
    }
    
    // 검색어를 다 쓰고 나서 검색바를 닫을때 동작
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        numberOfCells = 0
        tableView.isHidden = true
    }
    
}

extension StationSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StationDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
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
