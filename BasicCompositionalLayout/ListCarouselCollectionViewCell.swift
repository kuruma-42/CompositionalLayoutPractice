//
//  ListCarouselCollectionView.swift
//  BasicCompositionalLayout
//
//  Created by Yong Jun Cha on 4/16/24.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class ListCarouselCollectionViewCell: UICollectionViewCell {
    static let id = "ListCarouselCell"
    private let mainImage = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        addSubview(mainImage)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        mainImage.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(mainImage.snp.trailing).offset(8)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(mainImage.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
        }
        
    }
    
    public func config(imageURL: String, title: String, subTitle: String) {
        mainImage.kf.setImage(with: URL(string: imageURL))
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
