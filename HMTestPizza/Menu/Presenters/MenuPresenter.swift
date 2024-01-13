
import Foundation
import UIKit

protocol MenuViewProtocol: AnyObject {
    func success()
}

protocol MenuViewPresenterProtocol: AnyObject {
    init(view: MenuViewProtocol, apiHandler: ApiFetchProtocol, imageFetcher: imageFetchProtocol)
    func getItems()
    func getCurrentCategory(atIndex: Int) -> Int
    var items: [ItemModel]? {get set}
    var categories: [String]? {get set}
    var urls: [String]? {get set}
    var images: [(url: String, image: UIImage)] {get set}
}

class MenuPresenter: MenuViewPresenterProtocol {
    
    weak var view: MenuViewProtocol?
    let apiHandler: ApiFetchProtocol
    let imageFetcher: imageFetchProtocol
    var items: [ItemModel]?
    var categories: [String]? = []
    var urls: [String]? = []
    var images: [(url: String, image: UIImage)] = []
    
    required init(view: MenuViewProtocol, apiHandler: ApiFetchProtocol, imageFetcher: imageFetchProtocol) {
        self.view = view
        self.apiHandler = apiHandler
        self.imageFetcher = imageFetcher
        getItems()
    }
    
    func getItems() {
        DispatchQueue.main.async { 
            self.apiHandler.fetchItemsData { [weak self] items in
                guard let self = self else {return}
                self.items = items
                for item in self.items! {
                    if (!self.categories!.contains(item.categoryName)) {
                        self.categories!.append(item.categoryName)
                    }
                    self.urls!.append(item.imageLink)
                }
                
                self.imageFetcher.takeImages(urls: self.urls ?? []) { images in
                    self.images = images
                }
                
                self.view?.success()
            }
  
        }
    }
    
    func getCurrentCategory(atIndex: Int) -> Int {
        return (self.categories?.firstIndex(of: (self.items?[atIndex].categoryName)!))!
    }
}
