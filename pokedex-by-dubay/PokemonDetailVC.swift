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
        pokemonName.text = pokemon.name.capitalizedString
        pokemonImage.image = pokemon.image
        pokedexID.text = "\(pokemon.pokedexId)"
        pokemonEvo1.image = pokemon.image
        pokemonEvo2.hidden = true
        discription.text = ""
        
        pokemon.downloadPokemonDetails { //() -> () in
            
            self.updateUI()
            
                    }

        print("Sender was \(pokemon.name)")
        // Do any additional setup after loading the view.
    }
    
    func updateUI(){
        
        type.text = pokemon.type
        defence.text = pokemon.defense
        height.text = pokemon.height
        weight.text = pokemon.weight
        attack.text = pokemon.attack
        discription.text = pokemon.discription
        
        if let nextEv = UIImage(named: "\(pokemon.nextEvolutionId)") {
            pokemonEvo2.image = nextEv
            pokemonEvo2.hidden = false
        } else {
            pokemonEvo2.hidden = true
        }
        
        
        
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
