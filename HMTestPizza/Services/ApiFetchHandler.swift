
import Foundation

protocol ApiFetchProtocol {
    func fetchItemsData(complition: @escaping ([ItemModel])->())
}

class ApiFetchHandler: ApiFetchProtocol {
    
    func fetchItemsData(complition: @escaping ([ItemModel])->()) {
        let url = URL(string: mainUrl)
        var requiredDataArr: [ItemModel] = []
        var errorOccured: Bool = false
        let task = URLSession.shared.dataTask(with:  url!) { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                
                if let _ = json["error"] {
                    errorOccured = true
                }
                
                
                DispatchQueue.main.async {
                    if !errorOccured {
                        var index = 0
                        if let root = json["products"] {
                            for i in stride(from: 0, through: 10, by: 1) {
                                let category =  root[i] as! [String: AnyObject]
                                for j in stride(from: 0, through: (category["items"]?.count)!-1, by: 1) {
                                    let catItem =  category["items"]![j]! as! [String: AnyObject]
                                    for k in stride(from: 0, through: (catItem["items"]?.count)!-1, by: 1) {
                                        if k == 1 {
                                            continue
                                        }
                                        let reqParam =  catItem["items"]![k]! as! [String: AnyObject]
                                        requiredDataArr.append(ItemModel(categoryName: category["title"] as! String, imageLink: reqParam["image"] as! String, name: catItem["title"] as! String, description: catItem["description"] as! String, price: reqParam["price"] as! Int == 0 ? 400 : reqParam["price"] as! Int, id: index))
                                        index += 1
                                    }
                                }
                            }
                        }
                        complition(requiredDataArr)
                    }
                }
            }
            catch let jsonError {
                print(jsonError)
            }
        }
        
        task.resume()
    }
    
}
