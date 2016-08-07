//
//  ViewController.swift
//  pokedex-by-dubay
//
//  Created by Joseph DuBay on 7/22/16.
//  Copyright © 2016 DuBay Designs. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var backgrounMusicBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!

    var pokemon = [Pokemon]()
    var pokemonSelected: Int?
    var musicPlayer: AVAudioPlayer!
    var playAudo = false
    var inSearchMode = false
    var pokemonFiltered = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        musicPlayer = initAuido("music", fileType: "mp3")
        playBackground()
        
        parsePokemonCSV()
    }
    
    func initAuido(fileName: String, fileType: String) -> AVAudioPlayer{
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)!
        
        
        do{
            let player = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            player.prepareToPlay()
            player.numberOfLoops = -1
            return player
            
        } catch let err as NSError{
            print(err.debugDescription)
            return AVAudioPlayer()
            
        }
        
    }
    
    func parsePokemonCSV(){
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
    
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows{
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
            
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell{
            
            let poke: Pokemon
            
            if inSearchMode{
                poke = pokemonFiltered[indexPath.row]
            } else{
                poke = pokemon[indexPath.row]
            }
            
            cell.configureCell(poke)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        if indexPath.row == pokemonSelected{
            var poke: Pokemon
            if inSearchMode{
                poke = pokemonFiltered[indexPath.row]
            } else {
                poke = pokemon[indexPath.row]
            }
            
            performSegueWithIdentifier("PokemonDetailVC", sender: poke)
            return
        }
        
        if let cell = collectionView.cellForItemAtIndexPath(indexPath){
            print("selected \((cell as? PokeCell)!.pokemon.name )")
            cell.sizeThatFits(CGSizeMake(300, 300))
            
            var cells = [NSIndexPath]()
            if let oldSelection = pokemonSelected{
                cells.append(NSIndexPath(forItem: oldSelection, inSection: 0))
            }
            
            pokemonSelected = indexPath.row
            cells.append(indexPath)
            collectionView.reloadItemsAtIndexPaths(cells)
           
            
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode{
            return pokemonFiltered.count - 1
        } else {
            return pokemon.count - 1
        }
        
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let set = 5
        
        let large = (indexPath.row / set) % 2 == 0
        
        
        if let selected = pokemonSelected where selected==indexPath.row{
            return CGSizeMake(200, 200)
        
        }else if(large){
           // return CGSizeMake(250, 200)
        }
        
        return CGSizeMake(100, 100)
    }
    
    @IBAction func musicBtnPressed(sender: UIButton) {
        if playAudo{
            playAudo = false
            
            
        } else {
            playAudo = true
        }
        
        playBackground()
    }
    
    func playBackground(){
        if playAudo{
            musicPlayer.play()
            backgrounMusicBtn.alpha = 1
        } else {
            musicPlayer.pause()
            musicPlayer.currentTime = 0
            backgrounMusicBtn.alpha = BUTTON_OPACITY        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            pokemonSelected = nil
            view.endEditing(true)
            collection.reloadData()
        } else{
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            pokemonFiltered = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            pokemonSelected = nil
            collection.reloadData()
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailVC"{
            if let detailsVC = segue.destinationViewController as? PokemonDetailVC{
                if let poke = sender as? Pokemon{
                    detailsVC.pokemon = poke
                }
            }
        }
    }
    
    
}

