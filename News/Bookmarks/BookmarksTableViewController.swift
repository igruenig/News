//
//  BookmarksTableViewController.swift
//  News
//
//  Created by Ian Grünig on 28.04.22.
//

import UIKit

class BookmarksTableViewController: UITableViewController {
    
    var bookmarkController: BookmarkController<JSONStorage<Bookmark>>!

    override func viewDidLoad() {
        super.viewDidLoad()

        bookmarkController = (UIApplication.shared.delegate as! AppDelegate).bookmarkController
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkController.findAll().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = bookmarkController.findAll()[indexPath.row].title
        
        cell.contentConfiguration = content

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBookmarkSegue", let webViewController = segue.destination as? WebViewController {
            if let selectedIndex = tableView.indexPath(for: sender as! UITableViewCell), selectedIndex.row < bookmarkController.findAll().count {
                webViewController.loadURL(bookmarkController.findAll()[selectedIndex.row].url)
            }
            
        }
    }

}
