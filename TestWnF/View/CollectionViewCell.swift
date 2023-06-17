//
//  CollectionViewCell.swift
//  TestWnF
//
//  Created by Александр Щербинин on 12.06.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageOfCell: UIImageView!
    
    @IBOutlet weak var photoCounter: UILabel!
    
    
//    Picture metadata
    var id: String?
    var user: String?
    var creation_date: String?
    var location: String?
    var downloads: Int?
    var url: String?

}
