import UIKit
import PlaygroundSupport

let alert = UIAlertController(title: "Hello", message: "Hello, World!", preferredStyle: .alert)
let actionOk = UIAlertAction(title: "Ok", style: .default, handler: { _ in print("Ok clicked")})
let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in print("Cancel clicked")})
alert.addAction(actionOk)
alert.addAction(actionCancel)
let vc = UIViewController()
PlaygroundPage.current.liveView = vc
vc.present(alert, animated: true, completion: nil)
