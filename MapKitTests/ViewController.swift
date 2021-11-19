//
//  ViewController.swift
//  MapKitTests
//
//  Created by Стас Жингель on 18.11.2021.
//

import UIKit
import MapKit
class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UITextFieldDelegate {
    var search:String=""
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    let button = UIButton()
    lazy var searchCompleter: MKLocalSearchCompleter = {
        let sC = MKLocalSearchCompleter()
           sC.delegate = self
           return sC
       }()
    var searchSource: [String]?
    let searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(searchBar)
        searchBar.searchBarStyle = .prominent
        searchBar.backgroundColor = .white
        button.setTitle("go SwiftUI", for: .normal)
        searchBar.delegate = self
        tableView.dataSource = self
        searchBar.constraints(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 60, paddingBottom: 0, paddingleft: 0, paddingRight: 0, width: 0, height: 50)
        tableView.constraints(top: searchBar.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingleft: 0, paddingRight: 0, width: 0, height: 500)
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        view.backgroundColor = .lightGray
        view.addSubview(button)
        button.constraints(top: nil, bottom: view.bottomAnchor, left: nil, right: view.rightAnchor, paddingTop: 0, paddingBottom: 50, paddingleft: 0, paddingRight: -50, width: 0, height: 0)
        button.addTarget(self, action: #selector(goToSwiftUI), for: .touchUpInside)
    }
    @objc func goToSwiftUI() {
        print("goToSwiftUI")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.label.text = self.searchSource?[indexPath.row]
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //change searchCompleter depends on searchBar's text
        if !searchText.isEmpty {
            searchCompleter.queryFragment = searchText
        }
    }
}







extension ViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        //get result, transform it to our needs and fill our dataSource
        self.searchSource = completer.results.map { $0.title }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        //handle the error
        print(error.localizedDescription)
    }
}













extension UIView {
    func constraints(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingBottom: CGFloat, paddingleft: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingleft).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
        }
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
