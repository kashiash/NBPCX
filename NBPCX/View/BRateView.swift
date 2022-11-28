//
//  BRateView.swift
//  NBPCX
//
//  Created by Jacek Kosiński G on 29/11/2022.
//

import SwiftUI

struct BRateView: View {
    let rate: CurrencyBRate
    
    @State private var rates = [DailyBRate]()
    
    var body: some View {
        VStack{
            Text(rate.id).font(.title)
            Text(rate.currency).font(.callout)
            List(rates) { item in
                HStack{
                    Text(item.id).font(.callout)
                    Text(item.effectiveDate).font(.callout)
                    Text(String(format: "%.4f", item.mid)).font(.title).foregroundColor(.red)
                }
            }
        }
        .navigationTitle("Daily rates")
        .task(loadRates)
    }
    
    @ Sendable func loadRates() async {
        let url = URL(string: "https://api.nbp.pl/api/exchangerates/rates/B/\(rate.id)/last/100/")!
        print(url)
        fetch(url: url)
    }
       
    func fetch(url: URL) {

         
            
            URLSession.shared.dataTask(with: url) {data, response, error in
                if let error = error{
                    print("Problem witch fetching data")
                } else if let data = data {
                    print(String(data: data, encoding: .utf8)!)
                    do {
                     
                      let decoder = JSONDecoder()
                        let result = try  decoder.decode(DailyBTable.self, from: data)
                        print(result)
                        if (result.rates != nil){
                            rates = result.rates.sorted{$0.effectiveDate < $1.effectiveDate}
                        }
                    } catch {
                        print("something wrong with decoding JSON")
                    }
                }
                
            }
            .resume()

    }
}

struct BRateView_Previews: PreviewProvider {
    static var previews: some View {
        BRateView(rate: CurrencyBRate.example)
    }
}
