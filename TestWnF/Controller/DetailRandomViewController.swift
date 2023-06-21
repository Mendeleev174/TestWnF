//
//  DetailRandomViewController.swift
//  TestWnF
//
//  Created by Александр Щербинин on 13.06.2023.
//

import UIKit

class DetailRandomViewController: UIViewController {

    @IBOutlet weak var picImageView: UIImageView!
    
    @IBOutlet weak var authorLbl: UILabel!
    
    @IBOutlet weak var creationDateLbl: UILabel!
    
    @IBOutlet weak var locationLbl: UILabel!
    
    @IBOutlet weak var downloadsLbl: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    // нажатие кнопки Назад
    @IBAction func backAction(_ sender: CustomAnyButton) {
        dismiss(animated: true)
    }
    
    // нажатие кнопки Like
    @IBAction func likeAction(_ sender: CustomAnyButton) {
        
        if isMatch(idForMatching: id!) {
            let alert = UIAlertController(title: "Внимание!", message: "Данное изображение уже находится в вашем списке избранных", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
        } else {
            
            let liked = Liked()
            liked.id = id!
            liked.user = user!
            liked.creation_date = creation_date!
            liked.location = location
            liked.downloads = downloads!
            liked.url = url!
            
            try! AppDelegate.realm.write {
                AppDelegate.realm.add(liked)
            }
            
            if FavoriteTableViewController.isActive {
                let fvc = vcFromTabBarController![1] as! FavoriteTableViewController
                let indexPath = IndexPath(row: fvc.tableView.numberOfRows(inSection: 0), section: 0)
                fvc.tableView.beginUpdates()
                fvc.tableView.insertRows(at: [indexPath], with: .fade)
                fvc.tableView.endUpdates()
            }
            dismiss(animated: true)
        }
        
    }
    
    var id: String?
    var image: UIImage?
    var user: String?
    var creation_date: String?
    var location: String?
    var downloads: Int?
    var url: String?
    var vcFromTabBarController: [UIViewController]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        picImageView.image = image
        authorLbl.text = user
        creationDateLbl.text = creation_date
        locationLbl.text = location
        downloadsLbl.text = downloads!.description
        
    }
    
    // проверяем, есть ли в базе Realm подобное изображение
    func isMatch(idForMatching id: String) -> Bool {
        
        let realmObject = AppDelegate.realm.objects(Liked.self)
        let realmQuery = realmObject.where {
            $0.id.contains(id)
        }
        guard realmQuery.isEmpty else { return true }
        return false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
