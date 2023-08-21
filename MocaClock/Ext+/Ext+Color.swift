//
//  Color.swift
//  MocaClock
//
//  Created by 최진용 on 2023/06/03.
//

import SwiftUI

extension Color {
    static let brightBlue = UIColor(hexCode: "9ABCFF")
    static let skyBlue = UIColor(hexCode: "579FFF")
    static let deepBlue = UIColor(hexCode: "354291")
    static let darkBlue = UIColor(hexCode: "012559")
    static let brightOrange = UIColor(hexCode: "F5D19A")
    static let newBringtOrange = UIColor(hexCode: "DBBA88")
    static let bottomSky = UIColor(hexCode: "#bac8ff")
    static let darkornage = UIColor(hexCode: "93524A")
    static let newDarkOrnage = UIColor(hexCode: "A95231")
    static let earlyNightFallOrange = UIColor(hexCode: "F39272")
    static let orange = UIColor(hexCode: "DF6C41")
    static let burgundy = UIColor(hexCode: "57328B")
    static let newBurgundy = UIColor(hexCode: "7050AB")
    static let clear = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
    
    static let indigo = UIColor(hexCode: "#364fc7")
    static let violet = UIColor(hexCode: "#7048e8")
    static let deepViolet = UIColor(hexCode: "#5f3dc4")
    
    static let blue = UIColor(hexCode: "3E4BA8")
    static let bottomBlue = UIColor(hexCode: "#c5f6fa")
    static let defaultWhite = Color(UIColor(hexCode: "#FFFFFF"))
}


struct BackGroundColors {
    
    static var night = LinearGradient(colors: [Color(uiColor: Color.darkBlue), Color(uiColor: Color.deepBlue)], startPoint: .top, endPoint: .bottom)
    static var nightBottom = LinearGradient(colors: [Color(uiColor: Color.darkBlue), Color(uiColor: Color.blue)], startPoint: .top, endPoint: .bottom)
    static var nightTop = LinearGradient(colors: [Color(uiColor: Color.darkBlue), Color(uiColor: Color.darkBlue)], startPoint: .top, endPoint: .bottom)
    static var lateNight = LinearGradient(colors: [Color(uiColor: Color.darkBlue), Color(uiColor: Color.burgundy)], startPoint: .top, endPoint: .bottom)
    static var dawn = LinearGradient(colors: [Color(uiColor: Color.darkBlue), Color(uiColor: Color.darkornage)], startPoint: .top, endPoint: .bottom)
    
    static var earlyDawnTop = LinearGradient(colors: [Color(uiColor: Color.darkBlue), Color(uiColor: Color.deepBlue)], startPoint: .top, endPoint: .bottom)
    static var earlyDawn = LinearGradient(colors: [Color(uiColor: Color.deepBlue), Color(uiColor: Color.darkornage)], startPoint: .top, endPoint: .bottom)
    static var earlyMorining = LinearGradient(colors: [Color(uiColor: Color.deepBlue), Color(uiColor: Color.newBringtOrange)], startPoint: .top, endPoint: .bottom)
    static var lateDinnerBottom = LinearGradient(colors: [Color(uiColor: Color.deepBlue), Color(uiColor: Color.newBurgundy)], startPoint: .top, endPoint: .bottom)
    
    static var moringTop = LinearGradient(colors: [Color(uiColor: Color.deepBlue), Color(uiColor: Color.skyBlue)], startPoint: .top, endPoint: .bottom)
    static var moring = LinearGradient(colors: [Color(uiColor: Color.skyBlue), Color(uiColor: Color.brightOrange)], startPoint: .top, endPoint: .bottom)
    
    static var lunchTop = LinearGradient(colors: [Color(uiColor: Color.blue), Color(uiColor: Color.skyBlue)], startPoint: .top, endPoint: .bottom)
    static var lunch = LinearGradient(colors: [Color(uiColor: Color.skyBlue), Color(uiColor: Color.bottomSky)], startPoint: .top, endPoint: .bottom)
    static var latelunch = LinearGradient(colors: [Color(uiColor: Color.skyBlue), Color(uiColor: Color.bottomBlue)], startPoint: .top, endPoint: .bottom)
    
    static var lateLunchBottom = LinearGradient(colors: [Color(uiColor: Color.skyBlue), Color(uiColor: Color.bottomSky)], startPoint: .top, endPoint: .bottom)
    static var lateLunchTop = LinearGradient(colors: [Color(uiColor: Color.indigo), Color(uiColor: Color.skyBlue)], startPoint: .top, endPoint: .bottom)
    static var earlyNightfall = LinearGradient(colors: [Color(uiColor: Color.skyBlue), Color(uiColor: Color.brightOrange)], startPoint: .top, endPoint: .bottom)
    static var nightfall = LinearGradient(colors: [Color(uiColor: Color.skyBlue), Color(uiColor: Color.newDarkOrnage)], startPoint: .top, endPoint: .bottom)
    static var otherNightfall = LinearGradient(colors: [Color(uiColor: Color.skyBlue), Color(uiColor: Color.earlyNightFallOrange)], startPoint: .top, endPoint: .bottom)
    
    
    static var dinnerTop = LinearGradient(colors: [Color(uiColor: Color.darkBlue), Color(uiColor: Color.deepBlue)], startPoint: .top, endPoint: .bottom)
    static var dinnerBottom = earlyDawn
    static var lateDwanBottom = lateDinnerBottom
    
}


