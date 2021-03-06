//
//  LocalCurrencyConverter.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 09/06/21.
//

import Foundation

class LocalCurrencyConverter {

    // Updated on: 9 June 2021.
    static let loaclExchangeRates : [String : Double] = [
        "AED":3.673101,
        "AFN":78.50389,
        "ALL":100.909524,
        "AMD":519.829783,
        "ANG":1.794257,
        "AOA":642.000274,
        "ARS":94.938098,
        "AUD":1.29214,
        "AWG":1.8,
        "AZN":1.703019,
        "BAM":1.605482,
        "BBD":2.018057,
        "BDT":84.752575,
        "BGN":1.60575,
        "BHD":0.376934,
        "BIF":1975,
        "BMD":1,
        "BND":1.322974,
        "BOB":6.901547,
        "BRL":5.036498,
        "BSD":0.999565,
        "BTC":3.0669347e-5,
        "BTN":72.854997,
        "BWP":10.566729,
        "BYN":2.515309,
        "BYR":19600,
        "BZD":2.014907,
        "CAD":1.210585,
        "CDF":1997.000185,
        "CHF":0.896403,
        "CLF":0.02601,
        "CLP":717.69754,
        "CNY":6.397604,
        "COP":3594.6,
        "CRC":618.812694,
        "CUC":1,
        "CUP":26.5,
        "CVE":90.874981,
        "CZK":20.883302,
        "DJF":177.7196,
        "DKK":6.105502,
        "DOP":57.064986,
        "DZD":133.682249,
        "EGP":15.651099,
        "ERN":15.00199,
        "ETB":43.619379,
        "EUR":0.821025,
        "FJD":2.033403,
        "FKP":0.711515,
        "GBP":0.70618,
        "GEL":3.130027,
        "GGP":0.711515,
        "GHS":5.82012,
        "GIP":0.711515,
        "GMD":51.196685,
        "GNF":9822.488769,
        "GTQ":7.721922,
        "GYD":208.806993,
        "HKD":7.759529,
        "HNL":24.024396,
        "HRK":6.156969,
        "HTG":91.097667,
        "HUF":286.385977,
        "IDR":14273,
        "ILS":3.24369,
        "IMP":0.711515,
        "INR":72.93885,
        "IQD":1461.5,
        "IRR":42104.999944,
        "ISK":120.549954,
        "JEP":0.711515,
        "JMD":148.288118,
        "JOD":0.709012,
        "JPY":109.440996,
        "KES":107.902255,
        "KGS":84.630799,
        "KHR":4081.999776,
        "KMF":404.375041,
        "KPW":900.000118,
        "KRW":1115.619994,
        "KWD":0.30082,
        "KYD":0.832998,
        "KZT":427.426902,
        "LAK":9454.999784,
        "LBP":1527.000492,
        "LKR":197.918719,
        "LRD":171.507442,
        "LSL":13.580264,
        "LTL":2.95274,
        "LVL":0.60489,
        "LYD":4.454956,
        "MAD":8.822957,
        "MDL":17.70452,
        "MGA":3772.110128,
        "MKD":50.616326,
        "MMK":1645.324485,
        "MNT":2850.913096,
        "MOP":7.988738,
        "MRO":356.999828,
        "MUR":40.462788,
        "MVR":15.449707,
        "MWK":798.499288,
        "MXN":19.69525,
        "MYR":4.117497,
        "MZN":61.803518,
        "NAD":13.579712,
        "NGN":412.000066,
        "NIO":34.911592,
        "NOK":8.26615,
        "NPR":116.568985,
        "NZD":1.389105,
        "OMR":0.384946,
        "PAB":0.999655,
        "PEN":3.912968,
        "PGK":3.509735,
        "PHP":47.731502,
        "PKR":155.724975,
        "PLN":3.66385,
        "PYG":6705.274434,
        "QAR":3.641003,
        "RON":4.0422,
        "RSD":96.521975,
        "RUB":72.238498,
        "RWF":985,
        "SAR":3.751099,
        "SBD":7.984064,
        "SCR":15.697092,
        "SDG":427.490392,
        "SEK":8.268011,
        "SGD":1.323295,
        "SHP":0.711515,
        "SLL":10224.999468,
        "SOS":584.99954,
        "SRD":20.8565,
        "STD":20735.784508,
        "SVC":8.747189,
        "SYP":1257.535268,
        "SZL":13.580183,
        "THB":31.169544,
        "TJS":11.400486,
        "TMT":3.5,
        "TND":2.736501,
        "TOP":2.220497,
        "TRY":8.605102,
        "TTD":6.780728,
        "TWD":27.716299,
        "TZS":2318.086951,
        "UAH":27.142306,
        "UGX":3528.590895,
        "USD":1,
        "UYU":43.587649,
        "UZS":10527.967034,
        "VEF":213830222338.07285,
        "VND":22953,
        "VUV":108.407216,
        "WST":2.51595,
        "XAF":538.446447,
        "XAG":0.036207,
        "XAU":0.000528,
        "XCD":2.70255,
        "XDR":0.693213,
        "XOF":539.503383,
        "XPF":98.32497,
        "YER":250.000276,
        "ZAR":13.58555,
        "ZMK":9001.197455,
        "ZMW":22.541085,
        "ZWL":322.000305
    ]
   
    static func fetchExchangeRates() -> [String : Double] {
        return loaclExchangeRates
    }
    
}
