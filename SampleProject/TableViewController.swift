//
//  TableViewController.swift
//  SampleProject
//
//  Created by Abir on 24/9/23.
//

import UIKit

class TableViewController: UIViewController {

    var albumId: Int?
    var myTableData:[Photos] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        getUserAlbum()
    }

    func getUserAlbum(){
        if let albumId = albumId{
            DataParser.shared.getAllPhotos{
                
                for photo in MyData.shared.photos{
                    if photo.albumId == albumId{
                        self.myTableData.append(photo)
                    }
                }
                
                DispatchQueue.main.async{
                    print("My photos \(self.myTableData.count)")
                    self.tableView.reloadData()
                }
            }
        }
    }

}


extension TableViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.label.text = "User ID: \(myTableData[indexPath.row].id)"
        cell.myImage.load(url: URL(string: myTableData[indexPath.row].thumbnailUrl)!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.myImage = myTableData[indexPath.row].url
        vc.myLabel = "\(myTableData[indexPath.row].id)"
//        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
