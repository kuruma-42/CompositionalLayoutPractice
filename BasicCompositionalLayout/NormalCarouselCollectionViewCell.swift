//
//  NormalCarouselCollectionViewCell.swift
//  BasicCompositionalLayout
//
//  Created by Yong Jun Cha on 4/16/24.
//

import Foundation
import SnapKit
import UIKit
import Kingfisher

class NormalCarouselCollectionViewCell: UICollectionViewCell {
    static let id  = "NormalCarouselCell"
    
    private let mainImage = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    override init(frame: CGRect) {
        super .init(frame: frame)
        setUI()
    }
    
    
    // Layout 구성
    private func setUI() {
        addSubview(mainImage)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        mainImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(mainImage.snp.bottom).offset(8)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    
    func config(imageURL: String, title: String, subTitle: String) {
        mainImage.kf.setImage(with: URL(string: imageURL))
        titleLabel.text = title
        subTitleLabel.text = subTitle
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

