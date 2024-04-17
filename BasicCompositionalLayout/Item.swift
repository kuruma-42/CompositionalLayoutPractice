//
//  Item.swift
//  BasicCompositionalLayout
//
//  Created by Yong Jun Cha on 4/14/24.
//

import Foundation

// 섹션 아이템 정의
struct Section: Hashable {
    let id: String
}

enum Item: Hashable {
    case banner(HomeItem)
    case normalCarousel(HomeItem)
    case listCarousel(HomeItem)
}

struct HomeItem: Hashable {
    let title: String
    let subTitle: String?
    let imageURL: String
    
    init(title: String, subTitle: String? = "", imageURL: String) {
        self.title = title
        self.subTitle = subTitle
        self.imageURL = imageURL
    }
}
