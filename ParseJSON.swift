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
         [{
           "id": "312",
           "code": "8480-6",
           "display": "Body temperature",
           "category" :"vital-signs",
           "issued": "2019-01-26T19:54:07Z",
           "valueQuantity": {
             "value": 39,
             "_value": {
               "fhir_comments": [
                 "   Temperature=39 degrees Celsius   "
               ]
             },
             "unit": "degrees C",
             "system": "http://snomed.info/sct",
             "code": "258710007"
           },
           "method": {
             "coding": [
               {
                 "system": "http://snomed.info/sct",
                 "code": "89003005",
                 "display": "Oral temperature taking"
               }
             ]
           }
         },
         {
           "id": "313",
           "code": "8480-6",
           "display": "Body temperature",
           "category" :"vital-signs",
           "issued": "2019-01-26T18:25:07Z",
           "valueQuantity": {
             "value": 38,
             "_value": {
               "fhir_comments": [
                 "   Temperature=38 degrees Celsius   "
               ]
             },
             "unit": "degrees C",
             "system": "http://snomed.info/sct",
             "code": "258710007"
           },
           "method": {
             "coding": [
               {
                 "system": "http://snomed.info/sct",
                 "code": "89003005",
                 "display": "Oral temperature taking"
               }
             ]
           }
         },
        {
          "id": "314",
          "code": "8480-6",
          "display": "Body temperature",
          "category" :"vital-signs",
          "issued": "2019-01-25T16:15:07Z",
          "valueQuantity": {
            "value": 37,
            "_value": {
              "fhir_comments": [
                "   Temperature=37 degrees Celsius   "
              ]
            },
            "unit": "degrees C",
            "system": "http://snomed.info/sct",
            "code": "258710007"
          },
          "method": {
            "coding": [
              {
                "system": "http://snomed.info/sct",
                "code": "89003005",
                "display": "Oral temperature taking"
              }
            ]
          }
        },
        {
          "id": "315",
          "code": "8867-4",
          "display": "Heart rate",
          "category" :"vital-signs",
          "issued": "2019-01-29T09:35:17Z",
          "valueQuantity": {
            "value": 72,
            "_value": {
              "fhir_comments": [
                "   Heart rate=72 bpm   "
              ]
            },
            "unit": "bpm",
            "system": "http://snomed.info/sct",
            "code": "somecodehere"
          },
          "method": {
            "coding": [
              {
                "system": "http://snomed.info/sct",
                "code": "somecodehere",
                "display": "wrist"
              }
            ]
          }
        },

        ]
"""

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

// Parse JSON string into list of observation objects
let observations = jsonString.parse(to:[Observation].self)!


// Filter observations by code
print("--filtered--")
let filteredObservations = observations.filter({$0.code=="8480-6"})
for obs in filteredObservations{
    print("\(obs.display) - \(obs.valueQuantity.value)\(obs.valueQuantity.unit) \(obs.method.coding[0].display) - \(obs.issued)")
}

// Sort observations by date
print("--sorted--")
let sortedFilteredObservations = filteredObservations.sorted(by:{$0.issued.compare($1.issued) == .orderedDescending})
for obs in sortedFilteredObservations{
    print("\(obs.display) - \(obs.valueQuantity.value)\(obs.valueQuantity.unit) \(obs.method.coding[0].display) - \(obs.issued)")
}

