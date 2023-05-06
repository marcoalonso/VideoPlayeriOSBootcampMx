//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Marco Alonso Rodriguez on 06/05/23.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, VideoManagerProtocol, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    @IBOutlet weak var videosCollection: UICollectionView!
    @IBOutlet weak var categoriasVideos: UISegmentedControl!
    
    var manager = VideoManager()
    
    var videos: [Video] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegado = self
        
        videosCollection.delegate = self
        videosCollection.dataSource = self
        
        setupCollection()
        
        obtenerVides(categoria: "playa")
        
    }
    
    private func setupCollection(){
        videosCollection.collectionViewLayout = UICollectionViewFlowLayout()
        
        if let flowLayout = videosCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
    
    func obtenerVides(categoria: String) {
        Task {
            await manager.encontrarVideos(categoria: categoria)
        }
    }
    
    //Delegado
    func mostrarVideos(listaVideos: [Video]) {
        videos = listaVideos
        DispatchQueue.main.async {
            self.videosCollection.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
        
        if let url = URL(string: videos[indexPath.row].image) {
            celda.fondoImagenVideo.kf.setImage(with: url)
            celda.fondoImagenVideo.layer.cornerRadius = 20
        }
        
        return celda
    }
    
    @IBAction func buscarButton(_ sender: UIBarButtonItem) {
        
    }
    
    
    @IBAction func categoriaSeleccionada(_ sender: UISegmentedControl) {
        
    }
    


}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 170)
    }
}
