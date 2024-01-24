


import Foundation



protocol DistrictDelegate{
    func getDistrictModels(models: [DistrictManagerModel])
    func getCityModels(models: [CityModel])
}

struct DistrictManager{
    
    var delegate: DistrictDelegate?
    func readJsonFile(city: String) -> [DistrictManagerModel]? {
        let decoder = JSONDecoder()
        var districtModels: [DistrictManagerModel] = []
        do {
            if let path = Bundle.main.path(forResource: "jasonData", ofType: "json"){
                if let jsonData = try String(contentsOfFile: path).data(using: .utf8){
                    let jsonObject = try decoder.decode(DistrictModel.self,from: jsonData)
                    for i in 0..<jsonObject.data.count{
                        let districtNameArray = jsonObject.data[i].districts
                        let cityName = jsonObject.data[i].name
                        let cityId = jsonObject.data[i].id
                        if cityName == city{
                            let model = DistrictManagerModel(districtNameArray: districtNameArray,cityName: cityName)
                            districtModels.append(model)
                        }
                    }
                }
            }
            delegate?.getDistrictModels(models: districtModels)
            return districtModels
        } catch {
            print("JSON dosyasını okuma ve çözme hatası: \(error)")
            return nil
        }
    }
    
    func readJsonCity(district: String) -> [DistrictManagerModel]? {
        let decoder = JSONDecoder()
        var districtModels: [DistrictManagerModel] = []
        do {
            if let path = Bundle.main.path(forResource: "jasonData", ofType: "json"){
                if let jsonData = try String(contentsOfFile: path).data(using: .utf8){
                    let jsonObject = try decoder.decode(DistrictModel.self,from: jsonData)
                    for i in 0..<jsonObject.data.count{
                        let districtNameArray = jsonObject.data[i].districts
                        let cityName = jsonObject.data[i].name
                        let cityId = jsonObject.data[i].id
                        if districtNameArray[0].name == district{
                            let model = DistrictManagerModel(districtNameArray: districtNameArray, cityName: cityName)
                            districtModels.append(model)
                        }
                    }
                }
            }
            delegate?.getDistrictModels(models: districtModels)
            return districtModels
        } catch {
            print("JSON dosyasını okuma ve çözme hatası: \(error)")
            return nil
        }
    }
    func readJsonData() -> [CityModel]? {
        let decoder = JSONDecoder()
        var cityModels: [CityModel] = []
        do {
            if let path = Bundle.main.path(forResource: "jasonData", ofType: "json"){
                if let jsonData = try String(contentsOfFile: path).data(using: .utf8){
                    let jsonObject = try decoder.decode(DistrictModel.self,from: jsonData)
                    for i in 0..<jsonObject.data.count{
                        let districtNameArray = jsonObject.data[i].districts
                        let cityName = jsonObject.data[i].name
                        let model = CityModel(cityName: cityName)
                       cityModels.append(model)
                    }
                }
            }
            delegate?.getCityModels(models: cityModels)
            return cityModels
        } catch {
            print("JSON dosyasını okuma ve çözme hatası: \(error)")
            return nil
        }
        
    }
    func convertWord(word: String) -> String{
        word.folding(options: .diacriticInsensitive, locale: nil)
            .replacingOccurrences(of: "ı", with: "i")
            .replacingOccurrences(of: "İ", with: "i")
            .replacingOccurrences(of: "ğ", with: "g")
            .replacingOccurrences(of: "ü", with: "u")
            .replacingOccurrences(of: "ö", with: "o")
            .replacingOccurrences(of: "ş", with: "s")
            .replacingOccurrences(of: "ç", with: "c")
            .lowercased()
    }
}
