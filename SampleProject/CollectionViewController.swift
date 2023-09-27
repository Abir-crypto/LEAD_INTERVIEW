//
//  ViewController.swift
//  SampleProject
//
//  Created by Abir on 24/9/23.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    let picker = UIImagePickerController()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
        collectionView.dataSource = self
        collectionView.delegate = self
        picker.allowsEditing = true
        picker.delegate = self
        // Do any additional setup after loading the view.
        DataParser.shared.getAllAlbums{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    @IBAction func didTapImageView(_ sender: UIControl) {
    
        present(picker, animated: true)
        
    }
    
}

extension CollectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        DispatchQueue.main.async {
            self.imageView.image = image
        }

        dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MyData.shared.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.titleLabel.text = MyData.shared.albums[indexPath.row].title
        cell.titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        cell.titleLabel.textColor = .white
        cell.layer.cornerRadius = 10
        cell.layer.backgroundColor = UIColor.orange.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 3 - 15
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        
        vc.albumId = MyData.shared.albums[indexPath.row].id
        self.present(vc, animated: true)
    }
}
