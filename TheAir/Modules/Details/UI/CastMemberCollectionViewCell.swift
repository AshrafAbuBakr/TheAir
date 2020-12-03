//
//  CastMemberCollectionViewCell.swift
//  TheAir
//
//  Created by Ashraf Abu Bakr on 03/12/2020.
//

import UIKit
import Kingfisher

class CastMemberCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    
    func setupCell(withName name: String, character: String, profileURL: URL?) {
        nameLabel.text = name
        characterLabel.text = character
        if let profileURL = profileURL {
            profileImageView.kf.setImage(with: profileURL)
        }
    }
}
