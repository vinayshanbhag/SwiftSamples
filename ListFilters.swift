import Foundation

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
    {
        "kind":"heart rate",
        "reading":70,
        "dtm":"2019-11-11T10:00:00Z"
    },
    {
        "kind":"heart rate",
        "reading":72,
        "dtm":"2019-11-09T13:00:00Z"
    },
    {
        "kind":"heart rate",
        "reading":75,
        "dtm":"2019-11-10T14:00:00Z"
    },
    {
        "kind":"temperature",
        "reading":98,
        "dtm":"2019-11-11T10:00:00Z"
    },
    {
        "kind":"temperature",
        "reading":100,
        "dtm":"2019-11-09T16:00:00Z"
    },
    {
        "kind":"temperature",
        "reading":99,
        "dtm":"2019-11-10T15:00:00Z"
    },
    {
        "kind":"spO2",
        "reading":98,
        "dtm":"2019-11-11T11:00:00Z"
    },
    {
        "kind":"spO2",
        "reading":95,
        "dtm":"2019-11-09T09:00:00Z"
    },
    {
        "kind":"spO2",
        "reading":99,
        "dtm":"2019-11-10T17:00:00Z"
    }
   ]
"""

// Observation type
struct Observation: Codable {
    var kind:String
    var reading:Int
    var dtm:Date
}

// Parse JSON into a list of Observations
let observations = jsonString.parse(to: [Observation].self)

// filter observations to required kind
let filteredObservations = observations!.filter({$0.kind=="heart rate"})

// sort filtered observations by date descending
let sortedFilteredObservations = filteredObservations.sorted(by:{$0.dtm.compare($1.dtm) == .orderedDescending})

// print
for i in sortedFilteredObservations {
    print("Kind:\(i.kind), Reading:\(i.reading), Date:\(i.dtm)")
}

