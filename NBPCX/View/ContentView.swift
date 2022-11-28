//
//  ContentView.swift
//  NBPCX
//
//  Created by Jacek Kosiński G on 28/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var rates = [CurrencyBRate]()
    var body: some View {
        NavigationStack {

                
                VStack {
                    Image("NBP1")
                        .scaledToFit()
                    List(rates) { rate in
                        NavigationLink() {
                            BRateView(rate: rate)
                        } label: {
                            HStack{
                                Text(rate.id).font(.title)
                                Text(rate.currency).font(.callout)
                                Text(String(format: "%.4f", rate.mid))
                                    .foregroundColor(.red)
                                    .background{
                                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                                            .stroke(Color.white.opacity(0.2),lineWidth: 1)
                                    }
                            }
                        }
                    }
                    
                }
            }

            .navigationTitle("NBP Currency Rates")
            .task(loadRates)
            // .refreshable(action: loadRates)
        
    }
      
    
    @Sendable func loadRates() async {
        let url = URL(string: "https://api.nbp.pl/api/exchangerates/tables/B")!
        fetch(url: url)
    }

    func fetch(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Something wrong with fetching data")
            } else if let data = data {
//                print(String(data: data, encoding: .utf8)!)
//                print("---------------------------------------")
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([NbpBtable].self, from:data)
//                    print(result)
                    if (result[0].rates != nil){
                        rates = result[0].rates
                    }
                    
                } catch {
                    print("Something wrong while jSON decoding")
                }
            }
        }.resume()
    }
}
    struct ColorDetail: View {
        var color: Color


        var body: some View {
            color.navigationTitle(color.description)
        }
    }
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


