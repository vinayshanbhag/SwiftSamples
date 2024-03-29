import Foundation

// Parse a JSON response from url, into an array of Observation objects.
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

// extend URL to add http get request
extension URL {
  func get() -> String {
      let semaphore = DispatchSemaphore(value: 0)
      var result: String = ""
      let task = URLSession.shared.dataTask(with: self) {(data, response, error) in
          result = String(data: data!, encoding: String.Encoding.utf8)!
          semaphore.signal()
      }
      task.resume()
      semaphore.wait()
      return result
  }
}

struct Patient:Codable {
  let name:String
  let hospital:String?
  let unit:String?
  let roomNumber:String?
  let gender:String
  let fin:String
  let dob:String
  let age:Int
  let admitDate:Date?
  let dischargeOrder:Date?
  let anticipatedDischargeDate:Date?
  let admissionStatus:String?
  let allergies:Bool?
  let details:Details
}

struct Details: Codable {
    let observations:[Observation]
}
struct Observation : Codable {
    let id:String
    let code: String
    let display: String
    let category:String
    let issued:Date
    
    struct Quantity : Codable {
        let value: Float
        let unit: String
        let system:URL
        let code:String
    }
    let valueQuantity:Quantity
    
    struct Method : Codable {
        struct Coding : Codable {
            let display:String
            let system:URL
            let code: String
        }
        let coding: [Coding]
    }
    let method: Method
}

// Utility functions to pretty print observations
func printObs(_ obs:[Observation]) {
  _ = obs.map(printObs)
}
func printObs(_ obs:Observation) {
  print("\(obs.display) - \(obs.valueQuantity.value)\(obs.valueQuantity.unit) \(obs.method.coding[0].display) - \(obs.issued)")
}


// Sample url- json response with list of observations
let url = "https://raw.githubusercontent.com/vinayshanbhag/SwiftSamples/master/observations.json"
let jsonString = URL(string:url)!.get()

// parse observations
let patient = jsonString.parse(to:Patient.self)!

// filter observations by code
print("--filtered--")
let filteredObservations = patient.details.observations.filter({$0.code=="8480-6"})
printObs(filteredObservations)


// Sort observations by issued date
print("\n\n--sorted--")
let sortedFilteredObservations = filteredObservations.sorted(by:{$0.issued.compare($1.issued) == .orderedDescending})
printObs(sortedFilteredObservations)

// Latest observation
print("\n\n--latest--")
printObs(sortedFilteredObservations[0])
