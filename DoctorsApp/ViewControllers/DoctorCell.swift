//
//  DoctorCell.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/11/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class DoctorCell : UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var posterImageView: UIImageView!

  class func cellIdentifier() -> String {
    return "DoctorCell"
  }

  override func awakeFromNib() {
    posterImageView.layer.cornerRadius = posterImageView.frame.size.width / 2.0
    posterImageView.layer.borderWidth = 1.5
    posterImageView.layer.borderColor = addressLabel.textColor.cgColor
  }

  func updateCell(doctorViewModel: DoctorViewModel) {
    nameLabel.text = doctorViewModel.name
    addressLabel.text = doctorViewModel.address

    let placeHolderImage = UIImage(named: "placeHolder.png")
    posterImageView.image = placeHolderImage
    if let posterRequest = doctorViewModel.posterRequest {
      posterImageView.af_setImage(withURLRequest: posterRequest)
    }
  }
}

