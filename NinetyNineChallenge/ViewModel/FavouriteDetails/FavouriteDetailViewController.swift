import UIKit

class FavouriteDetailViewController: UIViewController {
    
    lazy var iconView: UIImageView = {
        let image = UIImage(named: "Logo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.dark
        label.font = Fonts.headline
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var hotLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.dark
        label.font = Fonts.body
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var hotStackView: UIStackView = {
        let hotTitle = UILabel()
        hotTitle.translatesAutoresizingMaskIntoConstraints = false
        hotTitle.text = NSLocalizedString("Hot: ", comment: "")
        hotTitle.font = Fonts.headline
        hotTitle.textColor = UIColor.dark
        
        let hotStackView = UIStackView(arrangedSubviews: [hotTitle, self.hotLabel])
        hotStackView.translatesAutoresizingMaskIntoConstraints = false
        hotStackView.axis = .vertical
        hotStackView.spacing = Spacing.xxs
        
        return hotStackView
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.dark
        label.font = Fonts.body
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var categoryStackView: UIStackView = {
        let categoryTitle = UILabel()
        categoryTitle.translatesAutoresizingMaskIntoConstraints = false
        categoryTitle.text = NSLocalizedString("Category: ", comment: "")
        categoryTitle.font = Fonts.headline
        categoryTitle.textColor = UIColor.dark
        
        let categoryStackView = UIStackView(arrangedSubviews: [categoryTitle, self.categoryLabel])
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        categoryStackView.axis = .vertical
        categoryStackView.spacing = Spacing.xxs
        
        return categoryStackView
    }()
    
    
    lazy var ricCodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.dark
        label.font = Fonts.body
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ricCodeStackView: UIStackView = {
        let ricCodeTitle = UILabel()
        ricCodeTitle.translatesAutoresizingMaskIntoConstraints = false
        ricCodeTitle.text = NSLocalizedString("RicCode: ", comment: "")
        ricCodeTitle.font = Fonts.headline
        ricCodeTitle.textColor = UIColor.dark
        
        let ricCodeStackView = UIStackView(arrangedSubviews: [ricCodeTitle, self.ricCodeLabel])
        ricCodeStackView.translatesAutoresizingMaskIntoConstraints = false
        ricCodeStackView.axis = .vertical
        ricCodeStackView.spacing = Spacing.xxs
        
        return ricCodeStackView
    }()
    
    let viewModel: FavouriteDetailsViewModel
    
    init(viewModel: FavouriteDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        title = self.viewModel.title
        
        view = UIView()
        view.backgroundColor = UIColor.white
        
        view.addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.heightAnchor.constraint(equalToConstant: 80),
            iconView.widthAnchor.constraint(equalToConstant: 80),
            iconView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Spacing.s),
            iconView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Spacing.s),
            nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Spacing.s),
            nameLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: Spacing.m)
        ])
        
        view.addSubview(hotStackView)
        NSLayoutConstraint.activate([
            hotStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Spacing.s),
            hotStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Spacing.s),
            hotStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Spacing.s)
        ])
        
        view.addSubview(categoryStackView)
        NSLayoutConstraint.activate([
            categoryStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Spacing.s),
            categoryStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Spacing.s),
            categoryStackView.topAnchor.constraint(equalTo: hotStackView.bottomAnchor, constant: Spacing.s)
        ])
                
        view.addSubview(ricCodeStackView)
        NSLayoutConstraint.activate([
            ricCodeStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Spacing.s),
            ricCodeStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Spacing.s),
            ricCodeStackView.topAnchor.constraint(equalTo: categoryStackView.bottomAnchor, constant: Spacing.s)
        ])
        
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    @objc func backButtonTapped() {
        viewModel.backButtonTapped()
    }
    
    fileprivate func updateUI() {
        self.nameLabel.text = viewModel.name
        self.hotLabel.text = "\(viewModel.hot ?? 0)"
        self.categoryLabel.text = viewModel.category
        self.ricCodeLabel.text = viewModel.ricCode
    }
    
    fileprivate func showErrorFetchingTopicDetailAlert(error: String) {
        let alertMessage: String = NSLocalizedString("Error fetching favourite details:\n'\(error)'\nPlease try again later", comment: "")
        showAlert(alertMessage, "ERROR", "OK", nil)
    }
    
}

extension FavouriteDetailViewController: FavouriteDetailsViewDelegate {
    func favouriteDetailsFetched() {
        self.updateUI()
    }
    
    func errorFetchingFavouriteDetails(error: String) {
        self.showErrorFetchingTopicDetailAlert(error: error)
    }
}
