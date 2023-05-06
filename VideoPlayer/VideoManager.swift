//
//  VideoManager.swift
//  VideoPlayer
//
//  Created by Marco Alonso Rodriguez on 06/05/23.
//

import Foundation

// Cómo mandar la info al VC
//1.- Delegation Pattern
//2.- escaping closure

protocol VideoManagerCategoryVideosProtocol {
    func mostrarVideos(listaVideos: [Video])
}

protocol VideoManagerPopularProtocol {
    func mostrarVideos(listaVideos: [VideoPopular])
}


struct VideoManager {
    
    var delegado: VideoManagerCategoryVideosProtocol?
    
    var delegadoPopular: VideoManagerPopularProtocol?
    
    func encontrarVideos(categoria: String) async {
        
        do {
            guard let url = URL(string: "https://api.pexels.com/videos/search?query=\(categoria)&locale=es-ES&per_page=80&orientation=portrait") else { return }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("BPuUOkpCZlGHv4bo9kU1mepVkcFUFcnG4LxF1bI4dk6iTSkWbR6wcjzU", forHTTPHeaderField: "Authorization")
            let (data, respuesta) = try await URLSession.shared.data(for: urlRequest)
            
            guard (respuesta as? HTTPURLResponse)?.statusCode == 200 else { return }
            
            let decoder = JSONDecoder()
            let dataDecodificada = try decoder.decode(CategoryVideosModel.self, from: data)
        
            print(dataDecodificada)
            
            
            //Devolverla al ViewController
            let listaVideos = dataDecodificada.videos
            delegado?.mostrarVideos(listaVideos: listaVideos)
            
        } catch {
            print("Error, \(error.localizedDescription)")
        }
        
    }
    
    func obtenerVideosPopulares() async {
        
        do {
            guard let url = URL(string: "https://api.pexels.com/videos/popular") else {
                print("Error al consultar la API")
                return }
            print(url)
            
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("BPuUOkpCZlGHv4bo9kU1mepVkcFUFcnG4LxF1bI4dk6iTSkWbR6wcjzU", forHTTPHeaderField: "Authorization")
            let (data, respuesta) = try await URLSession.shared.data(for: urlRequest)
            
            guard (respuesta as? HTTPURLResponse)?.statusCode == 200 else { return }
            
            let dataDecodificada = try JSONDecoder().decode(PopularVideosModel.self, from: data)
            
            
            //Devolverla al ViewController
            let listaVideos = dataDecodificada.videos
            delegadoPopular?.mostrarVideos(listaVideos: listaVideos)
            
        } catch {
            print("Error, \(error.localizedDescription)")
        }
        
    }
    


    
}
