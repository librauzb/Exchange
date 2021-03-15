//
//  ExchangeManager.swift
//  Exchange
//
//  Created by Mac on 2021/03/15.
//

import Foundation

protocol ExchangeManagerDelegate {
    func didUpdateCurrency(_ exchangeManager: ExchangeManager, currency: ExchangeModel)
    func didFailWithError(error: Error)
}

struct ExchangeManager {
    
    let exchangeURL = "https://dbo.infinbank.com:9443/api/v1/nci/NCIRate"
    
    var delegate: ExchangeManagerDelegate?
    
    func fetchExchange (){
        let urlString = "\(exchangeURL)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let currency = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCurrency(self, currency: currency)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ exchangeData : Data) -> ExchangeModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ExchangeData.self, from: exchangeData)
 
            let currencyTitle = decodedData.Currency
            let currencySellRate = decodedData.SellCourse
            let currencyBuyRate = decodedData.BuyCourse
            
            
            let currency = ExchangeModel(Currency: currencyTitle, BuyCourse: currencyBuyRate, SellCourse: currencySellRate)
            return currency
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
