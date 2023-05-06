//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Marco Alonso Rodriguez on 06/05/23.
//

import UIKit
import Kingfisher
import AVKit

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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Video seleccionado \(videos[indexPath.row].videoFiles.first?.link ?? "")")
        
        let urlString = videos[indexPath.row].videoFiles.first?.link ?? ""
        
        guard let url = URL(string: urlString) else { return }
        
        let reproductor = AVPlayer(url: url)
        
        let viewController = AVPlayerViewController()
        viewController.player = reproductor
        
        present(viewController, animated: true) {
            reproductor.play()
        }
    }
    
    
    @IBAction func buscarButton(_ sender: UIBarButtonItem) {
        let alerta = UIAlertController(title: "Buscar Videos", message: "Escribe una categoría de tu interés", preferredStyle: .alert)
        
        alerta.addTextField { categoriaTF in
            categoriaTF.placeholder = "Carros"
            categoriaTF.textColor = .blue
            categoriaTF.font = UIFont(name: "Avenir", size: 18)
        }
        
        let botonBuscar = UIAlertAction(title: "Buscar", style: .default) { _ in
            ///Extraer el texto del TF y mandar metod obtenerVideos
            
            guard let categoria = alerta.textFields?.first?.text else { return }
            
            self.obtenerVides(categoria: categoria)
        }
        
        
        let botonCancelar = UIAlertAction(title: "Cancelar", style: .destructive)
        
        alerta.addAction(botonBuscar)
        alerta.addAction(botonCancelar)
        present(alerta, animated: true)
    }
    
    
    @IBAction func categoriaSeleccionada(_ sender: UISegmentedControl) {
       
        var categoria = ""
        
        switch sender.selectedSegmentIndex {
        case 0:
            categoria = sender.titleForSegment(at: 0) ?? ""
        case 1:
            categoria = sender.titleForSegment(at: 1) ?? ""
        case 2:
            categoria = sender.titleForSegment(at: 2) ?? ""
        case 3:
            categoria = sender.titleForSegment(at: 3) ?? ""
        case 4:
            categoria = sender.titleForSegment(at: 4) ?? ""
        
        default:
            categoria = "musica"
        }
        
        obtenerVides(categoria: categoria)
        
        
    }
    


}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 170)
    }
}
