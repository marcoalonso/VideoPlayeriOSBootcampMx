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

protocol VideoManagerProtocol {
    func mostrarVideos(listaVideos: [Video])
}

struct VideoManager {
    
    var delegado: VideoManagerProtocol?
    
    func encontrarVideos(categoria: String) async {
        
        do {
            guard let url = URL(string: "https://api.pexels.com/videos/search?query=\(categoria)&locale=es-ES&per_page=80&orientation=portrait") else { return }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("BPuUOkpCZlGHv4bo9kU1mepVkcFUFcnG4LxF1bI4dk6iTSkWbR6wcjzU", forHTTPHeaderField: "Authorization")
            let (data, respuesta) = try await URLSession.shared.data(for: urlRequest)
            
            guard (respuesta as? HTTPURLResponse)?.statusCode == 200 else { return }
            
            let decoder = JSONDecoder()
            let dataDecodificada = try decoder.decode(ResponseDataModel.self, from: data)
        
            print(dataDecodificada)
            
            
            //Devolverla al ViewController
            let listaVideos = dataDecodificada.videos
            delegado?.mostrarVideos(listaVideos: listaVideos)
            
        } catch {
            print("Error, \(error.localizedDescription)")
        }
        
    }
}
