//
//  CollectionViewController.swift
//  TestWnF
//
//  Created by Александр Щербинин on 12.06.2023.
//

import UIKit

private let reuseIdentifier = "cell"

class CollectionViewController: UICollectionViewController {
    
    let connection = Connection()

    override func viewDidLoad() {
        super.viewDidLoad()

        // путь к базе данных Realm
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        // Do any additional setup after loading the view.
        
        view.addSubview(searchBarView)
        setupLayout()
        searchBarView.delegate = self
    }

    // строка поиска
    let searchBarView: UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.searchBarStyle = .default
        sb.placeholder = "Search..."
        sb.sizeToFit()
        sb.isTranslucent = true
        sb.showsCancelButton = false
        return sb
    }()
    
    // отступы строки поиска
    func setupLayout() {
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    // количество секций в коллекции
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // количество элементов в секции
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    // заполнение элемента
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        // если ячейка пустая - загружаем в неё данные
        if cell.id == nil {
            // зелёный фон пустого элемента
            cell.imageOfCell.backgroundColor = .green
            
            connection.loadRandomId(to: cell)
        }
     
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    // нажатие на элемент
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let addVC = storyboard?.instantiateViewController(withIdentifier: "detRanVC")
        let addVC2 = addVC as! DetailRandomViewController
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        addVC2.id = cell.id
        addVC2.image = cell.imageOfCell.image
        addVC2.user = cell.user
        addVC2.creation_date = cell.creation_date
        addVC2.location = cell.location
        addVC2.downloads = cell.downloads
        addVC2.url = cell.url
        addVC2.vcFromTabBarController = tabBarController?.viewControllers
        present(addVC2, animated: true)
    }
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension CollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print(searchBar.text!)
    }
}
