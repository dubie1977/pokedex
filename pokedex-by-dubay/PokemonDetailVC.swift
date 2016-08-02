//
//  PokemonDetailVC.swift
//  pokedex-by-dubay
//
//  Created by Joseph DuBay on 8/1/16.
//  Copyright © 2016 DuBay Designs. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Sender was \(pokemon.name)")
        // Do any additional setup after loading the view.
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
