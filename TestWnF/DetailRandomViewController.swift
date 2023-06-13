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
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        
        let liked = Liked()
        liked.user = user!
        liked.creation_date = creation_date!
        liked.location = location
        liked.downloads = downloads!
        liked.url = url!
        
        try! AppDelegate.realm.write {
            AppDelegate.realm.add(liked)
        }
    }
    
    
    var image: UIImage?
    var user: String?
    var creation_date: String?
    var location: String?
    var downloads: Int?
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        picImageView.image = image
        authorLbl.text = user
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
