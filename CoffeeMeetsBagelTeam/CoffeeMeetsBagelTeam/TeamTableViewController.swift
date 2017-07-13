//
//  TeamTableViewController.swift
//  CoffeeMeetsBagelTeam
//
//  Created by Komran Ghahremani on 6/3/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit

fileprivate let leftCellReuseIdentifier = "leftTeamCell"
fileprivate let rightCellReuseIdentifier = "rightTeamCell"

class TeamTableViewController: UITableViewController {
    var viewModel: TeamViewModel?
    var background = GradientView()
    var transitionAnimator: DetailTransitionAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "LeftTeamTableViewCell", bundle: nil), forCellReuseIdentifier: leftCellReuseIdentifier)
        self.tableView.register(UINib(nibName: "RightTeamTableViewCell", bundle: nil), forCellReuseIdentifier: rightCellReuseIdentifier)
        self.tableView.backgroundColor = .clear
        
        setupNavBar()
        
        background.frame = tableView.bounds
        background.gradientLayer.gradient = GradientPoint.topBottom.draw()
        tableView.backgroundView = background
        
        viewModel = TeamViewModel(view: self)
        viewModel?.fetchEmployeeData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxOffset = scrollView.contentSize.height - scrollView.frame.height
        let currentOffset = scrollView.contentOffset.y
        let progress = Float(currentOffset / maxOffset)
        
        navigationItem.titleView?.alpha = 1.0 - min(currentOffset / 90.0, 1.0)
        background.calculateGradient(for: progress, in: background, with: startColor, middleColor, secondMiddleColor, finalColor)
    }
    
    func setupNavBar() {
        let attributes = [
            NSForegroundColorAttributeName: UIColor.black.withAlphaComponent(0.95),
            NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 14.0)!,
            NSKernAttributeName: 1.0
        ] as [String : Any]
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 125, height: 25))
        titleLabel.textAlignment = .center
        titleLabel.attributedText = NSAttributedString(string: "coffee 🤝 bagel".uppercased(), attributes: attributes)
        navigationItem.titleView = titleLabel
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel?.employees.count else {
            return 0
        }
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = viewModel, let gradient = background.gradientLayer.colors as? [CGColor] else { return }
        let employee = viewModel.employees[indexPath.row]
        let detailVC = EmployeeDetailViewController(employee: employee, gradient: gradient)
        
        if let cell = tableView.cellForRow(at: indexPath) as? TeamTableViewCell, let image = cell.avatarImageView.image {
            let origin = cell.convert(cell.avatarImageView.frame.origin, to: UIApplication.shared.keyWindow)
            presentViewControllerWithCustomTransitionAnimator(presentingController: detailVC, profileImage: image, origin: origin)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = indexPath.row % 2 == 0 ? leftCellReuseIdentifier : rightCellReuseIdentifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TeamTableViewCell,
            let employee = viewModel?.employees[indexPath.row] else {
                return UITableViewCell()
        }
        
        cell.nameLabel.text = "\(employee.firstName) \(employee.lastName)"
        cell.positionLabel.text = "\(employee.title)"
        cell.avatarImageView.loadImage(with: employee.avatar) {
            cell.loader.stopAnimating()
            cell.loader.isHidden = true
        }
        
        return cell
    }
}

extension TeamTableViewController: EmployeeListView {
    func didLoadEmployeeData() {
        tableView.reloadData()
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
}

extension TeamTableViewController: UIViewControllerTransitioningDelegate {
    func presentViewControllerWithCustomTransitionAnimator(presentingController: UIViewController, duration: TimeInterval = 0.35, profileImage: UIImage, origin: CGPoint) {
        guard let gradient = background.gradientLayer.colors as? [CGColor] else { return }
        transitionAnimator = DetailTransitionAnimator(presenting: true,
                                                      duration: duration,
                                                      gradient: gradient,
                                                      image: profileImage,
                                                      origin: origin)
        presentingController.transitioningDelegate = self
        presentingController.modalPresentationStyle = .custom
        present(presentingController, animated: true, completion: nil)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DetailTransitionAnimator(presenting: false)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let animator = transitionAnimator {
            return animator
        } else {
            return DetailTransitionAnimator(presenting: true)
        }
    }
}


