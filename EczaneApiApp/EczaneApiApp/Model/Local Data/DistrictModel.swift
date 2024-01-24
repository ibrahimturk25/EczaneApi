






import Foundation


struct DistrictModel: Codable{
    var data: [City]
}

struct City: Codable{
    var districts: [District]
    var id: Int
    var name: String
}
struct District: Codable{
    var name: String
}


