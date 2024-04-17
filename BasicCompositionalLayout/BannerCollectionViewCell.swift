//
//  BannerCollectionViewCell.swift
//  BasicCompositionalLayout
//
//  Created by Yong Jun Cha on 4/14/24.
//

//import Foundation
import UIKit
import SnapKit
import Kingfisher

class BannerCollectionViewCell: UICollectionViewCell {
    static let id = "BannerCell"
    let titleLabel = UILabel()
    let backgroundImage = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .blue
        setUI()
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        
        self.addSubview(titleLabel)
        self.addSubview(backgroundImage)
        // Snapkit
        titleLabel.snp.makeConstraints { make in
            // 해당 부모뷰 가운데 위치
            make.center.equalToSuperview()
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    public func config(title: String, imageURL: String) {
        // title, image set
        titleLabel.text = title
        let url = URL(string: imageURL)
        backgroundImage.kf.setImage(with: url)
    }
    
}
