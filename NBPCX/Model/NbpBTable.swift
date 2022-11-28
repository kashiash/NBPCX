//
//  NbpBTable.swift
//  NBPCX
//
//  Created by Jacek Kosiński G on 28/11/2022.
//

import Foundation


import Foundation

struct NbpBtable: Codable {

  var table         : String
  var id            : String
  var effectiveDate : String
  var rates         : [CurrencyBRate] = []

  enum CodingKeys: String, CodingKey {

    case table         = "table"
    case id            = "no"
    case effectiveDate = "effectiveDate"
    case rates         = "rates"
  
  }



}


struct CurrencyBRate: Codable,Identifiable {

  var currency : String
  var id     : String
  var mid      : Double

  enum CodingKeys: String, CodingKey {

    case currency = "currency"
    case id     = "code"
    case mid      = "mid"
  
  }

     static let example = CurrencyBRate(currency: "Euro radzieckie", id: "EUR", mid: 4.1234)

}


struct DailyBTable: Codable {

  var table    : String
  var currency : String
  var id     : String
  var rates    : [DailyBRate] = []

  enum CodingKeys: String, CodingKey {

    case table    = "table"
    case currency = "currency"
    case id     = "code"
    case rates    = "rates"
  
  }

}

struct DailyBRate: Codable ,Identifiable{

  var id            : String
  var effectiveDate : String
  var mid           : Double

  enum CodingKeys: String, CodingKey {

    case id            = "no"
    case effectiveDate = "effectiveDate"
    case mid           = "mid"
  
  }

    static let example = DailyBRate(id: "69/666/2022", effectiveDate: "2022.11.25", mid: 4.1233)

}
