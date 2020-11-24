import UIKit

protocol FavouriteCellViewDelegate: class {
}

class FavouriteCellViewModel {
    weak var viewDelegate: FavouriteCellViewDelegate?

    let favourite: String
 
    init(favourite: String) {
        self.favourite = favourite
    }
}
