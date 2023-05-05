//
//  APIHandler.swift
//  TestingPrayer
//
//  Created by Kumayl Kara on 2023-05-04.
//

import Foundation
import Combine
import CoreLocation
import MapKit

class APIHandler: ObservableObject {
    @Published var prayerTimings: PrayerTimings?
    

    func fetchPrayerTimings(for location: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { placemarks, error in
            if let placemark = placemarks?.first,
               let latitude = placemark.location?.coordinate.latitude,
               let longitude = placemark.location?.coordinate.longitude {
                
                let url = URL(string: "https://api.aladhan.com/v1/calendar/2023/5?latitude=\(latitude)&longitude=\(longitude)&method=0")!
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        do {
                            let decodedResponse = try JSONDecoder().decode(PrayerTimings.self, from: data)
                            DispatchQueue.main.async {
                                self.prayerTimings = decodedResponse
                            }
                        } catch {
                            print("Error decoding JSON: \(error.localizedDescription)")
                        }
                    } else if let error = error {
                        print("Error fetching data: \(error.localizedDescription)")
                    }
                }.resume()
            } else {
                print("Error geocoding location: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    //    func fetchPrayerTimings() {
    //        let url = URL(string: "https://api.aladhan.com/v1/calendar/2023/5?latitude=45.50884&longitude=-73.58781&method=0")!
    //
    //        URLSession.shared.dataTask(with: url) { data, response, error in
    //            if let data = data {
    //                do {
    //                    let decodedResponse = try JSONDecoder().decode(PrayerTimings.self, from: data)
    //                    DispatchQueue.main.async {
    //                        self.prayerTimings = decodedResponse
    //                    }
    //                } catch {
    //                    print("Error decoding JSON: \(error.localizedDescription)")
    //                }
    //            } else if let error = error {
    //                print("Error fetching data: \(error.localizedDescription)")
    //            }
    //        }.resume()
    //    }
}
