//
//  Utils.swift
//  libros
//
//  Created by Juan Kuga Palomino on 12/04/22.
//

import UIKit


class Utils {
    
    func visualizarImgFrom(urlImg url:String)->UIImage{
        var image = UIImage()
        guard let urlImg =  URL(string: url) else {return UIImage()}
        do{
            let dataImg = try  Data(contentsOf: urlImg)
                image = UIImage(data: dataImg) ?? UIImage()
        }catch{
            print("error")
        }
        
        return image
    }
   
}
