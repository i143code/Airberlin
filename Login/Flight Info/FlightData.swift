//
//  PokeAnnotation.swift
//  Pokemon
//
//  Created by Ashish Ranjan
//
import Foundation

//
// Flight model
//

struct FlightData {
  let summary: String
  let flightNr: String
  let gateNr: String
  let departingFrom: String
  let arrivingTo: String
  let weatherImageName: String
  let showWeatherEffects: Bool
  let isTakingOff: Bool
  let flightStatus: String
}

//
// Pre- defined flights
//

let londonToParis = FlightData(
  summary: "25 DEC 2016 09:42",
  flightNr: "AB 1107",
  gateNr: "T1 A33",
  departingFrom: "CVG",
  arrivingTo: "TXL",
  weatherImageName: "bg-snowy",
  showWeatherEffects: true,
  isTakingOff: true,
  flightStatus: "Delayed 4 hr")

let parisToRome = FlightData(
  summary: "25 DEC 2016 09:42",
  flightNr: "AB 1107",
  gateNr: "T1 A33",
  departingFrom: "CVG",
  arrivingTo: "TXL",
  weatherImageName: "bg-sunny",
  showWeatherEffects: false,
  isTakingOff: false,
  flightStatus: "Flight Status")

