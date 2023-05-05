//
//  PrayerTimings.swift
//  TestingPrayer
//
//  Created by Kumayl Kara on 2023-05-04.
//

import Foundation

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

//other variables


let calendar = Calendar.current
let currentDate = Date()
var currentDay: Int = calendar.component(.day, from: currentDate)
var currentMonth: Int = calendar.component(.month, from: currentDate)
var dayPointer: Int = currentDay-1
var monthPointer: Int = currentMonth-1
