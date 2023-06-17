//
//  Liked.swift
//  TestWnF
//
//  Created by Александр Щербинин on 13.06.2023.
//

import Foundation
import RealmSwift

class Liked: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var user: String = ""
    @objc dynamic var creation_date: String = ""
    @objc dynamic var location: String? = ""
    @objc dynamic var downloads = 0
    @objc dynamic var url: String = ""
}
