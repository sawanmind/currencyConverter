//
//  CurrencyConverter.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 09/06/21.
//

import Foundation

protocol CurrencyConverterDelegate:AnyObject {
    func refreshUI(exchangeRates: [String : Double])
}

class CurrencyConverter {
    private var exchangeRates: [String : Double] = [:]
    private let persistence = PersistenceManager(.userDefault)
    private let service = NetworkService()
    private var isPersistenceEnabled: Bool = false
    weak var delegate:CurrencyConverterDelegate?
    
    struct Keys {
        static let exchangeRates = "exchangeRates"
    }
    
    init() {
        self.exchangeRates = LocalCurrencyConverter.loaclExchangeRates
        self.configureTimer()
    }
    
    func convert(_ value : Double, valueCurrency : String, outputCurrency : String) -> Double? {
        guard let valueRate = exchangeRates[valueCurrency] else { return nil }
        guard let outputRate = exchangeRates[outputCurrency] else { return nil }
        let multiplier = outputRate/valueRate
        return value * multiplier
    }
 
    func fetchExchangeRates(_ isPersistenceEnabled: Bool) {
        self.isPersistenceEnabled = isPersistenceEnabled
        
        if let userDefaultsExchangeRates = persistence.fetch(for: Keys.exchangeRates) as? [String : Double] {
            self.exchangeRates.merge(dict: userDefaultsExchangeRates)
            self.delegate?.refreshUI(exchangeRates: userDefaultsExchangeRates)
        } else {
            let _exchangeRates = LocalCurrencyConverter.fetchExchangeRates()
            self.exchangeRates.merge(dict: _exchangeRates)
            self.delegate?.refreshUI(exchangeRates: _exchangeRates)
        }
        
        self.refreshExchangeRates()
    }
  
    private func saveExchangeRates(exchangeRates : [String : Double], isPersistenceEnabled:Bool = false) {
        self.exchangeRates.merge(dict: exchangeRates)
        if isPersistenceEnabled {
            persistence.update(exchangeRates, for: Keys.exchangeRates)
        }
    }
    
    func refreshExchangeRates() {
        self.service.request(query:[URLQueryItem(name: "source", value: Config.defaultFromCurrencyCode)],endpoint: Endpoint.live.get, method: .get) { [weak self] result in
            switch result {
            case .success(let data):
                if let model = data.decoder(with: UserInputScreenModel.self) {
                    for item in model.quotes ?? [:] {
                        // Here, I am removing prefix USD from currency list
                        let _key = item.key.deletingPrefix(Config.defaultFromCurrencyCode)
                        self?.exchangeRates.updateValue(item.value, forKey: _key)
                    }
                    
                    self?.saveExchangeRates(exchangeRates: self?.exchangeRates ?? [:], isPersistenceEnabled: self?.isPersistenceEnabled ?? false)
                    self?.persistence.save(Date().adding(minutes: Config.refreshTimeInterval), for: Config.refreshTimeIntervalKey)
                    self?.delegate?.refreshUI(exchangeRates: self?.exchangeRates ?? [:])
                }
            case .failure(let error):
                print("Failed to refresh exchange rates with error: => ",error.description)
            }
        }
        
    }
    
    private func configureTimer() {
        Timer.scheduledTimer(timeInterval: Config.refreshInterval, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {
        if let lasttimeSave = self.persistence.fetch(for: Config.refreshTimeIntervalKey) as? Date {
            if Date() >= lasttimeSave {
                self.refreshExchangeRates()
            }
        }
    }
}
