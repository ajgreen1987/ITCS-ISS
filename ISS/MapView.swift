//
//  MapView.swift
//  ISS
//
//  Created by AJ Green on 3/14/22.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        Text("Hello, Map!").onTapGesture {
            getLocation()
        }
    }
    
    func getLocation()
    {
        guard let url = URL(string: "http://api.open-notify.org/iss-now.json" ) else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                
                // MARK: - LocationResponse
                struct LocationResponse: Codable {
                    let issPosition: IssPosition?
                    let message: String?
                    let timestamp: Int?

                    enum CodingKeys: String, CodingKey {
                        case issPosition = "iss_position"
                        case message, timestamp
                    }
                }

                // MARK: - IssPosition
                struct IssPosition: Codable {
                    let latitude, longitude: String?
                }
                
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        
                        let locationResponse = try JSONDecoder().decode(LocationResponse.self, from: data)
                        print(locationResponse.issPosition)
                        
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
