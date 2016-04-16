import UIKit
import Banana

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            
            /// Mapping from JSON to models
            let customers: [Customer] =  try Banana.load(file: "customers") <~~ keyPath("response.customers") <<~ Customer.fromJSON
            print(customers)
            
            /// Mapping from models to JSON
            let jsonAsString = try customers <<~ Customer.toJSON <~~ Banana.dump(options: [.PrettyPrinted]) <~~ Banana.toString(encoding: NSUTF8StringEncoding)
            print(jsonAsString)
            
        } catch {
            // Failed to parse JSON
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

