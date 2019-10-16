import UIKit

class Article {
    var urlString:String
    var title:String
    var content:String
    var img:UIImage?
    
    init(urlString:String, title:String, content:String) {
        self.urlString = urlString
        self.title = title
        self.content = content
    }
}

func loadImage(article:Article) {
    let url = URL(string: article.urlString)!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    _ = URLSession.shared.dataTask(with: request) {(data, response, error) -> Void in
        guard let data = data else { print("Failed - \(article.title)");return }
        article.img = UIImage(data: data)
        print("Loaded image for - \(article.title)")
    }.resume()
}



let articles:[Article] = [Article(urlString: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Colosseo_2008.jpg/512px-Colosseo_2008.jpg", title: "The Colosseum", content: "The Coloseum, Rome"),
                          Article(urlString: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Rome_Pantheon_front.jpg/512px-Rome_Pantheon_front.jpg", title: "The Pantheon", content: "The Pantheon, Rome"),
                          Article(urlString: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Rzym_Fontanna_Czterech_Rzek.jpg/512px-Rzym_Fontanna_Czterech_Rzek.jpg", title: "Piazza Navona", content: "Piazza Navona, Rome")
                         ]
articles.map(loadImage)
articles[0].img
articles[1].img
articles[2].img
