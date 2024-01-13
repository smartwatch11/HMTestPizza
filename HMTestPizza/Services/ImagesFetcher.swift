
import UIKit

protocol imageFetchProtocol {
    func takeImages(urls: [String], complition: @escaping ([(url: String, image: UIImage)])->())
}

class ImagesFetcher: imageFetchProtocol {
    
    var images: [(url: String, image: UIImage)] = []
    
    func takeImages(urls: [String], complition: @escaping ([(url: String, image: UIImage)])->()){
        DispatchQueue.global().async {
            for url in urls {
                guard let urlImage = URL(string: imageUrl + url), let imageData = try? Data(contentsOf: urlImage), let image = UIImage(data: imageData) else {return}
                self.images.append((url: url, image: image))
            }
            
            DispatchQueue.main.async {
                complition(self.images)
            }
        }
    }
}
