//
//  Connection.swift
//  TestWnF
//
//  Created by Александр Щербинин on 12.06.2023.
//

import Foundation
import UIKit

class Connection {
    
    let clientId = "AuOnzRbqEueeH6KBpsjL4vn66B6tiQCYt6Ua_CJUxU0"
    
    func loadRandomId(to cell: CollectionViewCell) {
        Task { @MainActor in
            
            struct Picture: Decodable {
                var id: String
                var links: Links
                var urls: Urls
                var downloads: Int
                var location: Location
                var created_at: String
                var user: User
                        
                enum CodingKeys: String, CodingKey {
                    case id
                    case links
                    case urls
                    case downloads
                    case location
                    case created_at
                    case user
                        }
                    }
            
            struct Links: Decodable {
                var `self`: String
                var html: String
                var download: String
                var download_location: String
            }
            
            struct Urls: Decodable {
                var raw: String
                var full: String
                var regular: String
                var small: String
                var thumb: String
            }
            
            struct Location: Decodable {
                var name: String?
                var city: String?
                var country: String?
            }
            
            struct User: Decodable {
                var username: String
            }
            
                let api = "https://api.unsplash.com/photos/random?client_id=" + clientId
                    
                guard let apiURL = URL(string: api) else {
                    fatalError("Some error")
                }
                    
                do {
                    // получаем JSON
                    let (data, _) = try await URLSession.shared.data(from: apiURL)

                    let jsonObject = try! JSONDecoder().decode(Picture.self, from: data)
                    cell.id = jsonObject.id
                    cell.photoCounter.text = ""
                    cell.user = jsonObject.user.username
                    cell.creation_date = jsonObject.created_at
                    cell.location = jsonObject.location.name
                    cell.downloads = jsonObject.downloads
                    cell.url = jsonObject.urls.small
                    
                    guard let picURL = URL(string: jsonObject.urls.small) else {
                        fatalError("Can't get link of the picture")
                    }
                    // получаем JPEG
                    let (data2, _) = try! await URLSession.shared.data(from: picURL)
                    cell.imageOfCell.image = UIImage(data: data2)
                    
                } catch {
                    fatalError("Some error")
                }
            
        }
        
    }
    
    func loadThumb(url: URL, cell: FavoriteTableViewCell) {
        Task { @MainActor in
            // получаем JPEG
            let (data, _) = try! await URLSession.shared.data(from: url)
            cell.thumbImageView.image = UIImage(data: data)
        }
        
    }
    
}
