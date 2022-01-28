import Foundation
@available(iOS 13.0, *)
public class ISE: ObservableObject {
    
    var host: String
    var iseVersion = 3.1
    public var ersUser: String
    public var ersPassword: String
    
    public var sponsorUsername: String?
    
    
    @Published var allGuestResources =  [Resource]()
    
    public init(host: String, ersUser: String, ersPassword: String, iseVersion: Int) {
        self.host = host
        self.ersUser = ersUser
        self.ersPassword = ersPassword
        
        
    }
    
    
    
    
    
    public func fetchAllGuestUsers() -> Void {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = "/ers/config/guestuser"
        let task = URLSession.shared.allTask(with: components.url!) { all, response, error in
            if let error = error {
                print(error)
                return
            }
            if let all = all {
                self.allGuestResources = all.searchResult.resources
            }
        }
        task.resume()
        return
    }
    
}
