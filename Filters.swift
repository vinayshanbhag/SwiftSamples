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

// Sample JSON - list of observations
var jsonString = """
   [
    { "kind":"heart rate", "value":70, "unit":"bpm",  "dateObserved":"2019-11-11T10:00:00Z" },
    { "kind":"temperature","value":100,"unit":"F",    "dateObserved":"2019-11-09T16:00:00Z" },
    { "kind":"heart rate", "value":72, "unit":"bpm",  "dateObserved":"2019-11-09T13:00:00Z" },
    { "kind":"temperature","value":98, "unit":"F",    "dateObserved":"2019-11-11T10:00:00Z" },
    { "kind":"spO2",       "value":98, "unit":"%",    "dateObserved":"2019-11-11T11:00:00Z" },
    { "kind":"temperature","value":99, "unit":"F",    "dateObserved":"2019-11-10T15:00:00Z" },
    { "kind":"spO2",       "value":95, "unit":"%",    "dateObserved":"2019-11-09T09:00:00Z" },
    { "kind":"heart rate", "value":75, "unit":"bpm",  "dateObserved":"2019-11-10T14:00:00Z" },
    { "kind":"spO2",       "value":99, "unit":"%",    "dateObserved":"2019-11-10T17:00:00Z" },
    { "kind":"weight",     "value":150,"unit":"lbs",  "dateObserved":"2019-11-10T17:10:00Z" },
    { "kind":"height",     "value":1.8,"unit":"m",    "dateObserved":"2019-11-10T17:20:00Z" },
    { "kind":"BMI",        "value":22, "unit":"kg/m2","dateObserved":"2019-11-10T17:30:00Z" }
   ]
"""

// Observation type
struct Observation: Codable {
    var kind:String
    var value:Float
    var unit:String
    var dateObserved:Date
}

// Parse JSON into a list of Observations
let observations = jsonString.parse(to: [Observation].self)

// filter observations to required kind
let filteredObservations = observations!.filter({$0.kind=="heart rate"})

// sort filtered observations by date descending
let sortedFilteredObservations = filteredObservations.sorted(by:{$0.dateObserved.compare($1.dateObserved) == .orderedDescending})

// print
for i in sortedFilteredObservations {
    print("Kind:\(i.kind), Value:\(i.value)\(i.unit), Date:\(i.dateObserved)")
}

