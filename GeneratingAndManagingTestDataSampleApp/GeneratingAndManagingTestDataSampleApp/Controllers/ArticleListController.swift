//
//  ViewController.swift
//  GeneratingAndManagingTestDataSampleApp
//
//  Created by Omose Ogala on 11/1/18.
//  Copyright © 2018 Ogala Apps. All rights reserved.
//

import UIKit

class ArticleListController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    static let mainBgColor = UIColor.white
    let cellId = "MyCell"
    let sampleDataLink = "http://localhost:8080/sample-data"
    var articles = [Article]()
    var imageCache = [String: UIImage]()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = ArticleListController.mainBgColor
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    let isTesting: Bool = {
        return ProcessInfo.processInfo.arguments.contains(TestingConstants.isTestArg)
    }()
    
    let mockedJson: String? = {
        guard let index = (ProcessInfo.processInfo.arguments.index { $0 == TestingConstants.mockedJsonArg}) else { return nil }
        return ProcessInfo.processInfo.arguments[index+1]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = ArticleListController.mainBgColor
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        setConstraints()
        
        loadArticles()
    }
    
    private func loadArticles() {
        
        let url = URL(string: sampleDataLink)!
        
        getData(from: url) { (data, response, error) in
            
            var jsonData: Data? = data
            
            // Only when in testing mode, swap json data
            if self.isTesting {
                guard
                    let mockedJson = self.mockedJson,
                    let testingJsonData = mockedJson.data(using: .utf8)
                else { return }
                    
                jsonData = testingJsonData
            }
            
            guard
                let data = jsonData,
                let appData = try? JSONDecoder().decode(AppData.self, from: data)
                else { return }
            
            DispatchQueue.main.async {
                self.articles = appData.articles.shuffled()
                self.tableView.reloadData()
            }
        }
    }
    
    private func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellId)
        cell.selectionStyle = .none
        cell.imageView?.contentMode = .scaleAspectFit
        
        if let image = imageCache[self.articles[indexPath.row].photoLink] {
            cell.imageView?.image = UIImage(cgImage: image.cgImage!, scale: image.size.width/60, orientation: image.imageOrientation)
        } else {
            let image = UIImage(named: "newspaper")
            cell.imageView?.image = UIImage(cgImage: image!.cgImage!, scale: image!.size.width/60, orientation: image!.imageOrientation)
            downloadImage(link: self.articles[indexPath.row].photoLink, imageView: cell.imageView!)
        }
        
        
        cell.textLabel?.sizeToFit()
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.accessibilityIdentifier = TestingConstants.headlineAccessibilityId
        cell.textLabel?.text = self.articles[indexPath.row].headline
        // Will cause test to fail when uncommented
        // cell.textLabel?.text = self.articles[indexPath.row].author
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy - hh:mm a"
        
        let date = Date(timeIntervalSince1970: TimeInterval(self.articles[indexPath.row].date))
        let dateString = formatter.string(from: date)
        
        cell.detailTextLabel?.sizeToFit()
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.accessibilityIdentifier = TestingConstants.fullTextAccessibilityId
        cell.detailTextLabel?.text = "\(dateString)\n\(self.articles[indexPath.row].fullText)\nWritten By: \(self.articles[indexPath.row].author)"
    
        return cell
    }
    
    // Network Functions
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(link: String, imageView: UIImageView) {
        guard let url = URL(string: link) else { return }
        
        getData(from: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imageCache[link] = image
                imageView.image = UIImage(cgImage: image!.cgImage!, scale: image!.size.width/60, orientation: image!.imageOrientation)
            }
        }
    }
}
