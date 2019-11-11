import Foundation

struct Observation {
    let kind:String!
    let reading:Int!
    let dtm:Date!
}

let obsList:[Observation] = [Observation(kind: "heart rate", reading: 70, dtm: Date(timeIntervalSinceNow: -86400)),
                             Observation(kind: "temperature", reading: 98, dtm: Date(timeIntervalSinceNow: -86400)),
                             Observation(kind: "heart rate", reading: 73, dtm: Date(timeIntervalSinceNow: 0)),
                             Observation(kind: "temperature", reading: 99, dtm: Date(timeIntervalSinceNow: 0)),
                             Observation(kind: "heart rate", reading: 79, dtm: Date(timeIntervalSinceNow: -86400*2)),
                             Observation(kind: "temperature", reading: 100, dtm: Date(timeIntervalSinceNow: -86400*2)),
                             Observation(kind: "spO2", reading: 95, dtm: Date(timeIntervalSinceNow: -86400*2)),
                             Observation(kind: "spO2", reading: 98, dtm: Date(timeIntervalSinceNow: 0)),
                             Observation(kind: "spO2", reading: 99, dtm: Date(timeIntervalSinceNow: -86400)),
                            ]

let filteredAndSortedObservations = obsList.filter({$0.kind=="temperature"}).sorted(by:{$0.dtm.compare($1.dtm) == .orderedDescending})

for i in filteredAndSortedObservations {
    print("Kind:\(i.kind ?? "Unknown"), Reading:\(i.reading ?? -1), Date:\(i.dtm ?? Date(timeIntervalSince1970: 0))")
}

