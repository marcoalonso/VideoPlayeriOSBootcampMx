//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Marco Alonso Rodriguez on 06/05/23.
//

import UIKit

class ViewController: UIViewController, VideoManagerProtocol {
    @IBOutlet weak var videosCollection: UICollectionView!
    @IBOutlet weak var categoriasVideos: UISegmentedControl!
    
    var manager = VideoManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegado = self
        
        Task {
            await manager.encontrarVideos(categoria: "playa")
        }
    }
    
    func mostrarVideos(listaVideos: [Video]) {
        //pintar las lista de videos.
        print(listaVideos)
    }
    
    
    @IBAction func buscarButton(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func categoriaSeleccionada(_ sender: UISegmentedControl) {
        
    }
    


}

