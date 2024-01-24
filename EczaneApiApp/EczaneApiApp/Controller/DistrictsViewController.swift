




import UIKit

class DistrictsViewController: UIViewController {
    
    @IBOutlet weak var searchBarDistrict: UISearchBar!
    @IBOutlet weak var tableVİewDistrict: UITableView!
    var districtManager = DistrictManager()
    var model: [DistrictManagerModel] = []
    var chosedCity = ""
    var selectedDistrict = ""
    var distrcitArray: [String] = []
    var filteredArray: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableVİewDistrict.dataSource = self
        tableVİewDistrict.delegate = self
        districtManager.delegate = self
        searchBarDistrict.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        distrcitArray.removeAll()
        districtManager.readJsonFile(city: chosedCity)
        for i in model[0].districtNameArray{
            for j in model {
                if j.cityName == chosedCity{
                    distrcitArray.append(i.name)
                }
            }
        }
        filteredArray = distrcitArray
        tableVİewDistrict.reloadData()

    }
}

extension DistrictsViewController: DistrictDelegate{
    func getCityModels(models: [CityModel]) {
        
    }
    
    func getDistrictModels(models: [DistrictManagerModel]) {
        self.model = models
    }
}

extension DistrictsViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return model[self.chosedCount].districtNameArray.count
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var title = cell.defaultContentConfiguration()
        title.text = filteredArray[indexPath.row]
        cell.contentConfiguration = title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDistrict = filteredArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            let destinationVC = segue.destination as! pharmacyListViewController
            destinationVC.chosedCity = chosedCity
            destinationVC.chosedDistrict = selectedDistrict
        }
    }
}
extension DistrictsViewController: UITableViewDelegate{
    
}

extension DistrictsViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArray = []
       if searchText.isEmpty {
             filteredArray = distrcitArray
         } else {
             for word in distrcitArray{
                 if word.lowercased().contains(searchText.lowercased()){
                     filteredArray.append(word)
                 }
             }
         }
        tableVİewDistrict.reloadData()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
}


