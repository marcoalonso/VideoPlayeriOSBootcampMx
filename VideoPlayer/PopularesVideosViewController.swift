//
//  PopularesVideosViewController.swift
//  VideoPlayer
//
//  Created by Marco Alonso Rodriguez on 06/05/23.
//

import UIKit
import Kingfisher
import AVKit

class PopularesVideosViewController: UIViewController, VideoManagerPopularProtocol {
    
    
    @IBOutlet weak var videosCollection: UICollectionView!
    var videosPopulares = [VideoPopular]()
    
    var manager = VideoManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegadoPopular = self
        
        videosCollection.delegate = self
        videosCollection.dataSource = self
        
        obtenerVidesPopulates()
        
        setupCollection()
    }

    func setupCollection() {
        videosCollection.collectionViewLayout = UICollectionViewFlowLayout()
        if let flowLayout = videosCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
    }
    
    

    func obtenerVidesPopulates() {
        Task {
            await manager.obtenerVideosPopulares()
        }
    }

    
    func mostrarVideos(listaVideos: [VideoPopular]) {
        videosPopulares = listaVideos
        
        DispatchQueue.main.async {
            self.videosCollection.reloadData()
        }
    }
}

extension PopularesVideosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videosPopulares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosPopularesCell", for: indexPath) as! VideosPopularesCell
        
        celda.setupCell(url: videosPopulares[indexPath.row].image)
        
        return celda
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let urlString = videosPopulares[indexPath.row].video_files[0].link
        print("Debug: \(urlString)")

        
        guard let url = URL(string: urlString) else { return }
        
        print("Debug: url \(url)")

        
        let reproductor = AVPlayer(url: url)
        
        let viewController = AVPlayerViewController()
        viewController.player = reproductor
        
        present(viewController, animated: true) {
            reproductor.play()
        }
    }
    
    
}

extension PopularesVideosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 500)
    }
}
