//
//  ViewController.swift
//  libros
//
//  Created by Juan Kuga Palomino on 7/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    let util = Utils()
    var books:[Book] = []

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        self.title = "Libros"
        self.tableview.dataSource = self
        self.tableview.delegate = self
        super.viewDidLoad()
        
        let db = DBHelper()
        self.books = db.readBooks()
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let book = self.books[indexPath.row]
 
        cel.lblTitleBook.text = book.name
        cel.lblAuthorName.text = "by: " + (book.author ?? "")
        cel.imgBook.image = util.visualizarImgFrom(urlImg: book.image ??  "")
        cel.lblPrice.text = "S/ " + String(format: "%.2f", book.price!)
        
        return cel
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            guard let indexPath =  self.tableview.indexPathForSelectedRow else {return}
            let destination = segue.destination as! DetailsViewController
            destination.book = self.books[indexPath.row]
        }
    }
    
    
    
}

