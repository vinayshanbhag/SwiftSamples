import Foundation

// Parse a String containing a JSON list, into an array of Observation objects.
// Filter array to retrieve objects of specific kind of Observation
// Sort the array by observation date

// add extension to parse JSON from String
extension String {
    func parse<D>(to type: D.Type) -> D? where D: Decodable {
        let data: Data = self.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let _object = try decoder.decode(type, from: data)
            return _object
        } catch {
            return nil
        }
    }
}

func query(address: String) -> String {
    let url = URL(string: address)
    let semaphore = DispatchSemaphore(value: 0)
    
    var result: String = ""
    
    let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
        result = String(data: data!, encoding: String.Encoding.utf8)!
        semaphore.signal()
    }
    
    task.resume()
    semaphore.wait()
    return result
}

// Sample JSON - list of observations
let jsonString = query(address: "https://raw.githubusercontent.com/vinayshanbhag/SwiftSamples/master/observations.json")


struct Observation : Codable {
    struct Quantity : Codable {
        let value: Float
        let unit: String
        let system:URL
        let code:String
    }

    struct Method : Codable {
        struct Coding : Codable {
            let display:String
            let system:URL
            let code: String
        }
        let coding: [Coding]
    }
    
    let valueQuantity:Quantity
    let method: Method
    let code: String
    let display: String
    let id:String
    let category:String
    let issued:Date
}

// parse observations 
let observations = jsonString.parse(to:[Observation].self)!

// filter observations by code
print("--filtered--")
let filteredObservations = observations.filter({$0.code=="8480-6"})
for obs in filteredObservations{
    print("\(obs.display) - \(obs.valueQuantity.value)\(obs.valueQuantity.unit) \(obs.method.coding[0].display) - \(obs.issued)")
}

// Sort observations by issued date
print("--sorted--")
let sortedFilteredObservations = filteredObservations.sorted(by:{$0.issued.compare($1.issued) == .orderedDescending})
for obs in sortedFilteredObservations{
    print("\(obs.display) - \(obs.valueQuantity.value)\(obs.valueQuantity.unit) \(obs.method.coding[0].display) - \(obs.issued)")
}

// Latest observation
print("--latest--")
var obs = filteredObservations.sorted(by:{$0.issued.compare($1.issued) == .orderedDescending})[0]
print("\(obs.display) - \(obs.valueQuantity.value)\(obs.valueQuantity.unit) \(obs.method.coding[0].display) - \(obs.issued)")
