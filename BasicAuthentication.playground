import UIKit


let username = "user"
let password = "pass"
let loginString = String(format: "%@:%@", username, password)
let loginData = loginString.data(using: String.Encoding.utf8)!
let base64LoginString = loginData.base64EncodedString()

let url = URL(string: "some url to an image here")!
var request = URLRequest(url: url)
request.httpMethod = "POST"
request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
    guard let data = data else { return }
    let img = UIImage(data: data)
}

task.resume()
