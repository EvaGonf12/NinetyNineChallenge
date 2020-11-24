import UIKit

class FavouriteCell: UITableViewCell {

    @IBOutlet weak var nameStack: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var name: UILabel!

    var viewModel: FavouriteCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewDelegate = self
            
            self.nameLabel?.text = NSLocalizedString("Fav Id: ", comment: "")
            self.name?.text = viewModel.favourite
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    fileprivate func setupUI() {
    }
    
}

extension FavouriteCell: FavouriteCellViewDelegate {
}
