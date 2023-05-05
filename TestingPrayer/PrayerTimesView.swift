//
//  PrayerTimesView.swift
//  TestingPrayer
//
//  Created by Kumayl Kara on 2023-05-05.
//

import Foundation
import SwiftUI

struct PrayerTimesView: View {
    @ObservedObject var apiHandler = APIHandler()
    @State var location: String = ""
    var body: some View {
        VStack {
            TextField("Enter location", text: $location, onCommit: {
                apiHandler.fetchPrayerTimings(for: location)
            })
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            if let prayerTimings = apiHandler.prayerTimings {
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
    }
}

//struct PrayerTimesView_Previews: PreviewProvider {
//    static var previews: some View {
//        PrayerTimesView()
//    }
//}
