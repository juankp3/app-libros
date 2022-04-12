//
//  DetailsViewController.swift
//  libros
//
//  Created by Juan Kuga Palomino on 12/04/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var book:Book?
    @IBOutlet weak var tableview: UITableView!
    let util = Utils()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.dataSource = self
        self.tableview.delegate = self
    }
    
}

extension DetailsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = tableview.dequeueReusableCell(withIdentifier: "celldetail", for: indexPath) as! DetailsTableViewCell
        
        cel.lblAuthor.text = book?.author
        cel.lblBookName.text = book?.name
        cel.lblEdition.text = book?.edition
        cel.lblPrice.text =  "S/ " + String(format: "%.2f", book?.price ?? "")
        cel.imageBook.image = util.visualizarImgFrom(urlImg: book?.image ?? "")
        cel.lblDescription.text = book?.description
        
        return cel
    }
    
}
