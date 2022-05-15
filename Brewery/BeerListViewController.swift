//
//  BearListViewController.swift
//  Brewery
//
//  Created by 구희정 on 2022/05/12.
//

import UIKit

class BeerListViewController : UITableViewController {
    var beerList = [Beer]()
    var dataTasks = [URLSessionTask]()
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UINavigation Bar
        title = "구희정의 맥주추천"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //UITableView 설정
        tableView.register(BeerListCell.self, forCellReuseIdentifier: "BeerListCell")
        tableView.rowHeight = 150
        
        //무한 스크롤
        tableView.prefetchDataSource = self
        
        
        fetchBeer(of: currentPage)
    }
    
}

//UItableView DataSource , Delegate
extension BeerListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath) as? BeerListCell else { return UITableViewCell() }
        
        let beer = beerList[indexPath.row]
        cell.configure(with: beer)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBeer = beerList[indexPath.row]
        let detailViewController = BeerDetailViewController()
        
        detailViewController.beer = selectedBeer
        self.show(detailViewController, sender: nil)
    }
}

//미리 보여질 row들을 불러온다.
extension BeerListViewController : UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard currentPage != 1 else {return }
        
        indexPaths.forEach {
            //현재 페이지가 currentPage 값과 같다면,
            if ($0.row + 1)/25 + 1 == currentPage {
                self.fetchBeer(of: currentPage)
            }
        }
    }
    
    
}

//Data Fetching
private extension BeerListViewController {
    func fetchBeer(of page : Int) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)"),
              //새롭게 요청 된 URL 인지 체크
              dataTasks.firstIndex(where : { $0.originalRequest?.url == url }) == nil else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let beers = try? JSONDecoder().decode([Beer].self, from: data) else {
                print("ERROR: URLSession data task \(error?.localizedDescription ?? "")")
                return
            }
            
            switch response.statusCode {
            case (200...299): //성공 (성공하면 리스트에 하나씩 넣어준다)
                self.beerList += beers
                self.currentPage += 1
                
                //
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            case (400...499): //클라이언트 에러
                print("""
                    ERROR: Client ERROR \(response.statusCode)
                    Response: \(response)
                """)
            case (500...599): //서버 에러
                print("""
                    ERROR: Client ERROR \(response.statusCode)
                    Response: \(response)
                """)
            default:
                print("""
                    ERROR: Client ERROR \(response.statusCode)
                    Response: \(response)
                """)
            }
        }
        //DataTask 실행
        dataTask.resume()
        dataTasks.append(dataTask)
    }
}
