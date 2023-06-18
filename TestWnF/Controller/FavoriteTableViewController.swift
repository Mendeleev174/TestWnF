//
//  FavoriteTableViewController.swift
//  TestWnF
//
//  Created by Александр Щербинин on 13.06.2023.
//

import UIKit
import RealmSwift

class FavoriteTableViewController: UITableViewController {

    static var isActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
//        let alert = UIAlertController(title: "Внимание!", message: "Таблица любимых фото пока не обновляется при добавлении новых!", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
//        present(alert, animated: true)
        FavoriteTableViewController.isActive = true
    }

    // MARK: - Table view data source

    // количество секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // количество строк (ячеек) в секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AppDelegate.realm.objects(Liked.self).count
    }

    // заполнение кастомной ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "likedCell", for: indexPath) as! FavoriteTableViewCell

        let realmObject = AppDelegate.realm.objects(Liked.self)
        cell.userLbl.text = realmObject[indexPath.row].user
        
        //
        let url = realmObject[indexPath.row].url
        guard let picURL = URL(string: url) else {
            fatalError("Can't get link of the picture")
        }
        
        let connection = Connection()
        connection.loadThumb(url: picURL, cell: cell)
        
        return cell
    }
    
    // нажатие на элемент
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        let addVC = storyboard?.instantiateViewController(withIdentifier: "detFavVC")
        let addVC2 = addVC as! DetailFavoriteViewController
        let cell = tableView.cellForRow(at: indexPath) as! FavoriteTableViewCell
        let realmObject = AppDelegate.realm.objects(Liked.self)
        addVC2.image = cell.thumbImageView.image
        addVC2.user = realmObject[indexPath.row].user
        addVC2.creation_date = realmObject[indexPath.row].creation_date
        addVC2.location = realmObject[indexPath.row].location
        addVC2.downloads = realmObject[indexPath.row].downloads
        addVC2.indexPath = indexPath
        addVC2.tableView = tableView
        present(addVC2, animated: true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // удаляем данные в базе и ячейку в таблице
            let realmObject = AppDelegate.realm.objects(Liked.self)
            try! AppDelegate.realm.write {
                AppDelegate.realm.delete(realmObject[indexPath.row])
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
