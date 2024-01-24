



import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var searchBarCity: UISearchBar!
    @IBOutlet weak var tableViewCity: UITableView!
    var selectedCount = 0
    var selectedCity = ""
    var districtManager = DistrictManager()
    var model: [CityModel] = []
    var cityArray: [String] = []
    var filteredCity: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        districtManager.delegate = self
        tableViewCity.dataSource = self
        tableViewCity.delegate = self
        searchBarCity.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        cityArray.removeAll()
        districtManager.readJsonData()
        for i in model{
            cityArray.append(i.cityName)
        }
        filteredCity = cityArray
        tableViewCity.reloadData()
    }
}

extension ViewController: UITableViewDelegate{
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var title = cell.defaultContentConfiguration()
        title.text = filteredCity[indexPath.row]
        title.secondaryText = "İLCE: \("---")"
        cell.contentConfiguration = title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toListVC"{
            let destinationVC = segue.destination as! DistrictsViewController
            destinationVC.chosedCity = selectedCity
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCity = filteredCity[indexPath.row]
        performSegue(withIdentifier: "toListVC", sender: nil)
    }
}

extension ViewController: DistrictDelegate{
    func getCityModels(models: [CityModel]) {
        model = models
    }
    
    func getDistrictModels(models: [DistrictManagerModel]) {
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCity = []
        if searchText.isEmpty {
              filteredCity = cityArray
          } else {
              for word in cityArray{
                  if word.lowercased().contains(searchText.lowercased()){
                      filteredCity.append(word)
                  }
              }
          }
        tableViewCity.reloadData()
     }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
}



