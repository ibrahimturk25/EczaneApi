



//  BorsApp
//

import UIKit


protocol JsonManagerDelegate{
    func didUpdate(model: [Model])
}
struct JsonManager{
    var count: Int?
    var delegate: JsonManagerDelegate?
    let urlString = "https://www.nosyapi.com/apiv2/pharmacyLink?apikey=tz7MtHPScqBVfdQXgiegkKseu7RD6w3oOPG47XxKPIfrJIqP6NYJahTlmhiY"

    
    func getURL(city: String,district: String){
        if let url = URL(string: "\(urlString)&city=\(city)&county=\(district)"){
            performRequest(url: url)
        }else{
            print("URL HATASI")
        }

    }
    func performRequest(url: URL){
        let sessions = URLSession(configuration: .default)
        let task = sessions.dataTask(with: url) { data, response, error in
            if error != nil{
                print(error!)
            }
            else{
                if let data = data {
                    if let model = self.fetchData(data: data){
                        self.delegate?.didUpdate(model: model)
                    }
                }
            }
        }
        task.resume()
    }
    
    func fetchData(data: Data) -> [Model]?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(JsonModel.self, from: data)
            let rowCount = decodedData.rowCount
            var models: [Model] = []
            for i in 0..<rowCount {
                let name = decodedData.data[i].EczaneAdi
                let sehir = decodedData.data[i].Sehir
                let adresi = decodedData.data[i].Adresi
                let telefon = decodedData.data[i].Telefon
                let latitude = decodedData.data[i].latitude
                let longitude = decodedData.data[i].longitude
                let ilce = decodedData.data[i].ilce
                let model = Model(eczaneAdi: name, Sehir: sehir,ilce: ilce,  Adresi: adresi, Telefon: telefon, latitude: latitude, longitude: longitude,rowCount: rowCount)
                models.append(model)
            }
            return models

        }catch{
            print("error")
            return nil
          
        }
    }
}
