//
//  DetailFavoriteViewController.swift
//  TestWnF
//
//  Created by Александр Щербинин on 13.06.2023.
//

import UIKit

class DetailFavoriteViewController: UIViewController {

    @IBOutlet weak var userLbl: UILabel!
    
    @IBOutlet weak var creationDateLbl: UILabel!
    
    @IBOutlet weak var locationLbl: UILabel!
    
    @IBOutlet weak var downloadsLbl: UILabel!
    
    @IBOutlet weak var picImageView: UIImageView!
    
    // нажатие кнопки Назад
    @IBAction func backAction(_ sender: CustomAnyButton) {
        dismiss(animated: true)
    }
    
    // нажатие кнопки Dislike
    @IBAction func dislikeAction(_ sender: CustomAnyButton) {
        
        let realmObject = AppDelegate.realm.objects(Liked.self)
        try! AppDelegate.realm.write {
            AppDelegate.realm.delete(realmObject[indexPath!.row])
        }
        tableView!.deleteRows(at: [indexPath!], with: .fade)
        dismiss(animated: true)
    }
    
    
    var image: UIImage?
    var user: String?
    var creation_date: String?
    var location: String?
    var downloads: Int?
    var indexPath: IndexPath?
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        picImageView.image = image
        userLbl.text = user
        creationDateLbl.text = creation_date
        locationLbl.text = location
        downloadsLbl.text = downloads!.description
        
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
