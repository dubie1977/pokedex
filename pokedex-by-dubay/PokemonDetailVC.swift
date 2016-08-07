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
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var discription: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var defence: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var pokedexID: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var pokemonEvo1: UIImageView!
    @IBOutlet weak var pokemonEvo2: UIImageView!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonName.text = pokemon.name
        pokemonImage.image = pokemon.image

        print("Sender was \(pokemon.name)")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        //pokemonName.text = pokemon.name
    }


    @IBAction func backButtonTouched(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
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
