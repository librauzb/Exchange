//
//  ViewController.swift
//  Exchange
//
//  Created by Mac on 2021/03/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reloadBtn: UIButton!
    
    var result: Result?
    let exchangeURL = "https://dbo.infinbank.com:9443/api/v1/nci/NCIRate"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        makeViewCurved(view: reloadBtn)
        performRequest(with: exchangeURL)
        tableView.reloadData()
        
    }

    func makeViewCurved(view:UIView){
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
    }

    @IBAction func reloadPressed(_ sender: UIButton) {
        performRequest(with: exchangeURL)
        tableView.reloadData()
    }
    
}

extension ViewController:UITableViewDelegate, UITableViewDataSource{
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do{
                        self.result =  try decoder.decode(Result.self, from: safeData)
                    }
                        
                    catch{
                        print("Error in parsing JSON")
                    }
                }
            }
            task.resume()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(self.result?.data.count ?? 0)
        return result?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyTableViewCell
        cell.currencyLbl.text = result?.data[indexPath.row].currency
        cell.sellCourse.text = String(result?.data[indexPath.row].sellCourse ?? 0)
        cell.buyCourseLbl.text = String(result?.data[indexPath.row].buyCourse ?? 0)

        return cell
        
    }
    
    
}
