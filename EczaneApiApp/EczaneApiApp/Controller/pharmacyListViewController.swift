



import UIKit
import CoreLocation
import MapKit
class pharmacyListViewController: UIViewController {
    @IBOutlet weak var tableViewList: UITableView!
    @IBOutlet weak var loadingİndicator: UIActivityIndicatorView!

    var chosedCity: String?
    var chosedDistrict: String?
    var jsonManager = JsonManager()
    var model: [Model] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewList.delegate = self
        tableViewList.dataSource = self
        jsonManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingİndicator.isHidden = false
        loadingİndicator.startAnimating()
//        districtManager.readJsonCity(district: chosedDistrict)
        jsonManager.getURL(city: chosedCity!, district: chosedDistrict!)
    }
}

extension pharmacyListViewController: UITableViewDelegate{
}

extension pharmacyListViewController: UITableViewDataSource,JsonManagerDelegate{
    func didUpdate(model: [Model]) {
        self.model = model
        DispatchQueue.main.async {
            self.loadingİndicator.stopAnimating()
            self.loadingİndicator.isHidden = true
            self.tableViewList.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! pharmacyTableViewCell
        cell.labelName.text = self.model[indexPath.row].eczaneAdi
        cell.labelNumber.text = self.model[indexPath.row].Telefon
        cell.labelAddress.text = self.model[indexPath.row].Adresi
        cell.buttonMapOutlet.tag = indexPath.row
        cell.buttonMapOutlet.addTarget(self, action: #selector(mapButton), for: .touchUpInside)
        loadingİndicator.isHidden = true
        return cell
    }
    @objc func mapButton(sender: UIButton){
        let latitudeX = model[sender.tag].latitude
        let longitudeY = model[sender.tag].longitude
        print(latitudeX)
        print(longitudeY)

        // Belirtilen latitude ve longitude değerleriyle bir konum oluşturduk
        let targetLocation = CLLocationCoordinate2D(latitude: latitudeX, longitude: longitudeY)
        // Belirtilen latitude ve longitude değerleriyle bir konum oluştur
        
        //region oluşturduk
        let region = MKCoordinateRegion(center: targetLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        // MKPlacemark oluşturduk
        let targetPlacemark = MKPlacemark(coordinate: targetLocation)
        
        // MKMapItem oluşturduk
        let targetMapItem = MKMapItem(placemark: targetPlacemark)
        targetMapItem.name = model[sender.tag].eczaneAdi
        
        // Harita uygulamasını açtık
        let options: [String: Any] = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span),
            MKLaunchOptionsShowsTrafficKey: NSNumber(value: true)
        ]
        
        targetMapItem.openInMaps(launchOptions: options)
      }
    
}




