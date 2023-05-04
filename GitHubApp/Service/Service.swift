import Foundation

struct Service {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }

    func fetchList(of user: String, completion: @escaping ([Repository]?) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/\(user)/repos") else { return }
        network.performGet(url: url) { data in
            guard let data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode([Repository].self, from: data)
                completion(decodedData)
            } catch {
                print("Failed to convert Data to Repository")
            }
        }
    }
}
