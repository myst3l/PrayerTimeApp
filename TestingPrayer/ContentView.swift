//
//  ContentView.swift
//  TestingPrayer
//
//  Created by Kumayl Kara on 2023-05-03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        PrayerTimesView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PrayerTimings: Codable {
    let data: [Data]
    
}

struct Data: Codable {
    
    let timings: Timings
    let date: Dates
}

struct Dates: Codable {
    let readable: String
    
}

struct Timings: Codable {
    let Fajr: String
    let Sunrise: String
    let Dhuhr: String
    let Asr: String
    let Maghrib: String
    let Isha: String
    
}


let calendar = Calendar.current
let currentDate = Date()
var currentDay: Int = calendar.component(.day, from: currentDate)
var currentMonth: Int = calendar.component(.month, from: currentDate)
var dayPointer: Int = currentDay-1
var monthPointer: Int = currentMonth-1

struct PrayerTimesView: View {
    @State private var prayerTimings: PrayerTimings?
    
    var body: some View {
        VStack {
            if let prayerTimings = prayerTimings {
                Text("Date: \(prayerTimings.data[dayPointer].date.readable)")
                Text("Fajr: \(prayerTimings.data[dayPointer].timings.Fajr)")
                Text("Sunrise: \(prayerTimings.data[dayPointer].timings.Sunrise)")
                Text("Dhuhr: \(prayerTimings.data[dayPointer].timings.Dhuhr)")
                Text("Asr: \(prayerTimings.data[dayPointer].timings.Asr)")
                Text("Maghrib: \(prayerTimings.data[dayPointer].timings.Maghrib)")
                Text("Isha: \(prayerTimings.data[dayPointer].timings.Isha)")
                Text("Day: \(currentDay)")
                Text("Month: \(currentMonth)")
            } else {
                Text("Loading...")
            }
        }
        .onAppear(perform: fetchPrayerTimings)
    }
    
    func fetchPrayerTimings() {
        let url = URL(string: "https://api.aladhan.com/v1/calendarByCity/2023/5?city=Montreal&country=Canada&method=0")!
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
    }
}

struct PrayerTimesView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerTimesView()
    }
}



//testing push



