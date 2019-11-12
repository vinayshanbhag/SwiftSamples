import Foundation

// Filter and sort a list of observation objects


// Observation
struct Observation {
    var kind:String
    var reading:Int
    var dtm:Date
}

// list of observations
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

// filter specific observations and sort on a property
let filteredAndSortedObservations = obsList.filter(
    {$0.kind=="temperature"} // filter observations based on the kind of observation
).sorted(
    by:{
        $0.dtm.compare($1.dtm) == .orderedDescending // sort by observation datetime descending
})

// print
for i in filteredAndSortedObservations {
    print("Kind:\(i.kind), Reading:\(i.reading), Date:\(i.dtm)")
}
