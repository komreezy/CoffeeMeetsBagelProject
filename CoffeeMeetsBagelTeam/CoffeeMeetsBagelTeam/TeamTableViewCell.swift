//
//  TeamTableViewCell.swift
//  CoffeeMeetsBagelTeam
//
//  Created by Komran Ghahremani on 6/5/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loader.activityIndicatorViewStyle = .gray
        loader.frame = avatarImageView.frame
        loader.startAnimating()
        
        avatarImageView.layer.cornerRadius = 40.0
        avatarImageView.clipsToBounds = true
        avatarImageView.backgroundColor = UIColor(hex: "#DCDCDC")
        
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
