



import Foundation

struct JsonModel: Codable{
    let rowCount: Int
    let data: [JsonResult]
}

struct JsonResult: Codable{
    let EczaneAdi: String
    let Sehir: String
    let ilce: String
    let Adresi: String
    let Telefon: String
    let latitude: Double
    let longitude: Double
}


