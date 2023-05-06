//
//  PopularesVideosViewController.swift
//  VideoPlayer
//
//  Created by Marco Alonso Rodriguez on 06/05/23.
//

import UIKit

class PopularesVideosViewController: UIViewController, VideoManagerPopularProtocol {
    
    
    
    var manager = VideoManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegadoPopular = self

       obtenerVidesPopulates()
    }
    

    func obtenerVidesPopulates() {
        Task {
            await manager.obtenerVideosPopulares()
        }
    }

    
    func mostrarVideos(listaVideos: [VideoPopular]) {
        print(listaVideos)
    }
}
