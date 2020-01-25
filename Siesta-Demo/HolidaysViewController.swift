import UIKit
import Siesta

class HolidaysViewController: UIViewController {
 
    var tasks: [String] = []
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
        
        self.tasks = holidays
        self.tableView.reloadData()
    }
}


extension HolidaysViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "holidayCell")!
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
}
