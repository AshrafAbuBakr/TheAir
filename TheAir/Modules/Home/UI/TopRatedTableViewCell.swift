//
//  TopRatedTableViewCell.swift
//  TheAir
//
//  Created by Ashraf Abu Bakr on 02/12/2020.
//

import UIKit
import Kingfisher

class TopRatedTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(title: String, airDate: String, avgRate: Float, posterURL: String) {
        titleLabel.text = title
        dateLabel.text = airDate
        rateLabel.text = "\(avgRate)"
        
        if let imageURL = URL(string: posterURL) {
            posterImageView.kf.setImage(with: imageURL)
        } else {
            posterImageView.image = UIImage(systemName: "photo.fill")
        }
    }
    
}
