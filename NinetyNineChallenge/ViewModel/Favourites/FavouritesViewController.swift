import UIKit

class FavouritesViewController: UIViewController {
    
    var viewModel: FavouritesViewModel
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "FavouriteCell", bundle: nil), forCellReuseIdentifier: "FavouriteCell")
        table.backgroundColor = .clear
        table.estimatedRowHeight = 44
        table.rowHeight = 44
        table.layer.borderWidth = 0
        table.layer.cornerRadius = 8
        table.separatorStyle = .singleLine
        return table
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.primary
        refreshControl.addTarget(self, action: #selector(refreshControlPulled), for: .valueChanged)
        return refreshControl
    }()
    
    init(viewModel: FavouritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        title = self.viewModel.title

        view = UIView()
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: Spacing.s),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Spacing.xl),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Spacing.xxl),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        tableView.tableFooterView = UIView()
        
        tableView.refreshControl = refreshControl
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel.viewWasLoaded()
    }
    
    @objc func refreshControlPulled() {
        self.viewModel.viewWasLoaded()
    }
    
    fileprivate func showErrorFetchingFavouritesAlert(error : String) {
        let alertMessage: String = NSLocalizedString("Error fetching favourites:\n'\(error)'\nPlease try again later", comment: "")
        showAlert(alertMessage, "ERROR", "OK", nil)
    }
}

extension FavouritesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as? FavouriteCell,
           let cellViewModel = viewModel.viewModel(at: indexPath) {
            cell.viewModel = cellViewModel
            return cell
        }
        fatalError()
    }
}

extension FavouritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension FavouritesViewController: FavouritesViewDelegate {
    func favouritesFetched() {
        self.refreshControl.endRefreshing()
        self.tableView.reloadData()
    }
    
    func errorFetchingFavourites(error : String) {
        self.refreshControl.endRefreshing()
        showErrorFetchingFavouritesAlert(error: error)
    }
}
