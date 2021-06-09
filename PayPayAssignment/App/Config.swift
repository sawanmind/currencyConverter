//
//  Config.swift
//  PayPayAssignment
//

//

import Foundation

struct Config {
    private init(){}
    static let baseUrl:String = "http://api.currencylayer.com/"
    static let apiKey:String = "9bd924c057e960f59af252b3470ed16f"
    static let defaultFromCurrencyCode:String = "USD"
    static let defaultToCurrencyCode:String = "INR"
    static let errorTitle:String = "Oops!"
    static let errorDefaultMessage:String = "Something went wrong. Please try again later"
    static let refreshInterval:TimeInterval = 1
    static let refreshTimeInterval:Int = 2
    static let refreshTimeIntervalKey:String = "lastTimeSave"
}
