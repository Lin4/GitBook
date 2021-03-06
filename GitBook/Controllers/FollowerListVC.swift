//
//  FollowerListVC.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/15/21.
//

import UIKit

class FollowerListVC: GBDataLoadingVC {
    
    enum Section { case main }
    
    var userName: String!
    var followers: [Follower]               = []
    var filteredFollowers: [Follower]       = []
    var hasMoreFollowers                    = true
    var isSearching                         = false
    var isLoadingMoreFollowers              = false
    var page                                = 1
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
   
    
    init(userName: String) {
        super.init(nibName: nil, bundle: nil)
        self.userName   = userName
        title           = userName
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(userName: userName, page: page)
        configureDataSource()
    }
     
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    @objc func addButtonTapped() {
        showLodingView()
        
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: userName)
                addUserToFavorites(user: user)
                dismissLodingView()
            } catch {
                if let gberror = error as? GBErrors {
                    presentGBAlert(title: "Somthing went wrong", message: gberror.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
                dismissLodingView()
         
            }
        }
    }

    
    
    func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistanceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else {return}
            guard let error = error else {
                DispatchQueue.main.async {
                    self.presentGBAlert(title: "Success", message: "You have successfully add favorite list", buttonTitle: "Ok")
                    }
                return
            }
            
            DispatchQueue.main.async {
            self.presentGBAlert(title: "Somthing went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.threeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    func configureSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "search for a user name"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }
     
    
    func getFollowers(userName: String, page: Int) {
        showLodingView()
        isLoadingMoreFollowers = true
        
        Task {
            do{
                let followers = try await NetworkManager.shared.getFollowers(for: userName, page: page)
                updateUI(with: followers)
                dismissLodingView()
                isLoadingMoreFollowers = false
            } catch {
                if let gberror = error as? GBErrors {
                    presentGBAlert(title: "Bad stuff Happened", message: gberror.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
                isLoadingMoreFollowers = false
                dismissLodingView()
            }
        }
    }
    
    
    func updateUI(with followers: [Follower]) {
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers. Go follow them ????."
            DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
            return
        }
        
        self.updateData(on: self.followers)
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: {(collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}


extension FollowerListVC : UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsety             = scrollView.contentOffset.y
        let contentHeight       = scrollView.contentSize.height
        let height              = scrollView.frame.size.height
        
        print("Lin test\(height)\( contentHeight)")
        
        if offsety > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else {return}
            page += 1
            getFollowers(userName: userName, page: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray         = isSearching ? filteredFollowers : followers
        let follower            = activeArray[indexPath.item]
        
        
        let destVC              = UserInfoVC()
        destVC.userName         = follower.login
        destVC.delegate         = self
        let navController   = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}


extension FollowerListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
            
        }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
}


extension FollowerListVC: UserInfoVCDelegate {
    func didRequestFollowers(for userName: String) {
        self.userName = userName
        title = userName
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(userName: userName, page: page)
        
    }
}
