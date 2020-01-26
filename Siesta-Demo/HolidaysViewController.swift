import UIKit
import Siesta

class HolidaysViewController: UIViewController {
 
    var holidays: [String] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        HolidaysAPI.holidaysResource.addObserver(self)
        HolidaysAPI.holidaysResource.loadIfNeeded()
    }
}

extension HolidaysViewController: ResourceObserver {
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {

        let holidays = resource.jsonArray
            .compactMap { $0 as? [String: Any] }
            .compactMap { $0["name"] as? String }
        
        self.holidays = holidays
        self.tableView.reloadData()
    }
}


extension HolidaysViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holidays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "holidayCell")!
        cell.textLabel?.text = holidays[indexPath.row]
        return cell
    }
    
}
