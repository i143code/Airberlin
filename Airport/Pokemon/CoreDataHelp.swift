//
//  PokeAnnotation.swift
//  Pokemon
//
//  Created by Ashish Ranjan
//

import UIKit
import CoreData

func addAllPokemon() {
    
    createPokemon(name: "Coffee Points:10 ", imageName: "mew")
    createPokemon(name: "Food Total:25", imageName: "meowth")
    createPokemon(name: "Enjoy First Class Lounge", imageName: "mankey")
    createPokemon(name: "Airbelin Miles Points. Total: 40 ", imageName: "pidgey")
    createPokemon(name: "Drinks & Food Copouns.Total: 30", imageName: "pikachu-2")
    createPokemon(name: "Airbelin In flight Points. Total: 20 Need: 100 More", imageName: "rattata")
    createPokemon(name: "Airport Spa. Total:30", imageName: "eevee")
    createPokemon(name: "Drinks  Total: 30", imageName: "snorlax")
    createPokemon(name: "Airbelin In flight Points Total:40", imageName: "weedle")
    createPokemon(name: "Food with Drinks Total:30", imageName: "zubat")
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}

func createPokemon(name :String, imageName: String) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let pokemon = Pokemon(context: context)
    pokemon.name = name
    pokemon.imageName = imageName
}

func getAllPokemon() -> [Pokemon] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    do {
        let pokemons = try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
        
        if pokemons.count == 0 {
            addAllPokemon()
            return getAllPokemon()
        }
        
        return pokemons
    } catch {}
    
    
    return []
}

func getAllCaughtPokemons() -> [Pokemon] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    fetchRequest.predicate = NSPredicate(format: "caught == %@", true as CVarArg)
    do {
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        return pokemons
    } catch {}
    return []
}

func getAllUncaughtPokemons() -> [Pokemon] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    fetchRequest.predicate = NSPredicate(format: "caught == %@", false as CVarArg)
    do {
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        return pokemons
    } catch {}
    return []
}

