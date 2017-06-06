//
//  EmployeeDetailViewController.swift
//  CoffeeMeetsBagelTeam
//
//  Created by Komran Ghahremani on 6/4/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit

class EmployeeDetailViewController: UIViewController {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    
    var employee: Employee
    var gradient: [CGColor]!
    
    init(employee: Employee, gradient: [CGColor]) {
        self.employee = employee
        self.gradient = gradient
        super.init(nibName: "EmployeeDetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.gradientLayer.gradient = GradientPoint.topBottom.draw()
        view.gradientLayer.colors = gradient
        
        loader.frame = CGRect(origin: loader.frame.origin, size: CGSize(width: 35.0, height: 35.0))
        loader.startAnimating()
        
        avatarImageView.layer.cornerRadius = 60.0
        
        setEmployeeValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pop(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setEmployeeValues() {
        nameLabel.text = "\(employee.firstName) \(employee.lastName)"
        positionLabel.text = employee.title
        avatarImageView.loadImage(with: employee.avatar) {
            self.loader.stopAnimating()
            self.loader.isHidden = true
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 20.0
        paragraphStyle.maximumLineHeight = 20.0
        paragraphStyle.minimumLineHeight = 20.0
        
        let attributes = [
            NSFontAttributeName: UIFont(name: "Avenir-Book", size: 14.0)!,
            NSParagraphStyleAttributeName: paragraphStyle,
            NSForegroundColorAttributeName: UIColor.black.withAlphaComponent(0.75)
        ]
        
        bioTextView.attributedText = NSAttributedString(string: employee.bio, attributes: attributes)
        bioTextView.contentOffset = .zero
    }
}
