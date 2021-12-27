//
//  ViewController.swift
//  rxDemo
//
//  Created by ForC on 2021/12/6.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "demo"
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 64), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }


    let data = [["Observable", ObservableViewController()],
                ["Observable-single", SignleViewController()],
                ["Hot_Cold 共享附加作用（冷热信号）", Hot_Cold()],
                ["Observer any&binder 监听者", Observer()],
                ["Subject 雌雄同体", Subject()]
    ]
    
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = data[indexPath.row].first as! String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let calss = data[indexPath.row].last
        
        navigationController?.pushViewController(calss as! UIViewController, animated: true)
    }
    
}
