//
//  ViewController.swift
//  BasicCompositionalLayout
//
//  Created by Yong Jun Cha on 4/14/24.
//

import UIKit

class ViewController: UIViewController {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    let imageURL = "https://upload.wikimedia.org/wikipedia/commons/c/cf/Fried_Chicken_strips.jpg"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        collectionView.register(NormalCarouselCollectionViewCell.self, forCellWithReuseIdentifier: NormalCarouselCollectionViewCell.id)
        collectionView.register(ListCarouselCollectionViewCell.self, forCellWithReuseIdentifier: ListCarouselCollectionViewCell.id)
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        setDataSource()
        setSnapshot()
        setUI()
    }
    
    private func setUI() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            switch itemIdentifier {
            case .banner(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.id, for: indexPath) as? BannerCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.config(title: item.title, imageURL: item.imageURL)
                return cell
                
            case .normalCarousel(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCarouselCollectionViewCell.id, for: indexPath) as? NormalCarouselCollectionViewCell else { return UICollectionViewCell() }
                cell.config(imageURL: item.imageURL, title: item.title, subTitle: item.subTitle ?? "")
                return cell
                
            case .listCarousel(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCarouselCollectionViewCell.id, for: indexPath) as? ListCarouselCollectionViewCell else { return UICollectionViewCell()}
                cell.config(imageURL: item.imageURL, title: item.title, subTitle: item.subTitle ?? "")
                return cell
            }
            
           
        })
    }
    
    private func setSnapshot() {
        // 빈 스냅샷 생성
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        // 스냅샷에 같은 색션을 여러 개 넣을 수 없다.
        snapshot.appendSections([Section(id: "Banner")])
        let bannerItems = [
            Item.banner(HomeItem(title: "교촌치킨", subTitle: "", imageURL: imageURL)),
            Item.banner(HomeItem(title: "굽네", subTitle: "", imageURL: imageURL)),
            Item.banner(HomeItem(title: "푸라닭", subTitle: "", imageURL: imageURL))
        ]
        snapshot.appendItems(bannerItems, toSection: Section(id: "Banner"))
       
        let normalCarousel = Section(id: "NormalCarousel")
        snapshot.appendSections([normalCarousel])
        let normalItems = [
            Item.normalCarousel(HomeItem(title: "교촌치킨", subTitle: "간장 치킨", imageURL: imageURL)),
            Item.normalCarousel(HomeItem(title: "굽네치킨", subTitle: "후라이드", imageURL: imageURL)),
            Item.normalCarousel(HomeItem(title: "BBQ치킨", subTitle: "닭강정", imageURL: imageURL)),
            Item.normalCarousel(HomeItem(title: "BHC치킨", subTitle: "양념", imageURL: imageURL)),
            Item.normalCarousel(HomeItem(title: "네네치킨", subTitle: "고추 바사삭", imageURL: imageURL)),
            Item.normalCarousel(HomeItem(title: "멕시칸 치킨", subTitle: "반반치킨", imageURL: imageURL)),
            Item.normalCarousel(HomeItem(title: "치킨 공주", subTitle: "뿌링클 치킨", imageURL: imageURL)),
        ]
        
        snapshot.appendItems(normalItems, toSection: normalCarousel)
        
        let listCarousel = Section(id: "ListCarousel")
        snapshot.appendSections([listCarousel])
        let listItems = [
            Item.listCarousel(HomeItem(title: "교촌치킨", subTitle: "간장 치킨", imageURL: imageURL)),
            Item.listCarousel(HomeItem(title: "굽네치킨", subTitle: "후라이드", imageURL: imageURL)),
            Item.listCarousel(HomeItem(title: "BBQ치킨", subTitle: "닭강정", imageURL: imageURL)),
            Item.listCarousel(HomeItem(title: "BHC치킨", subTitle: "양념", imageURL: imageURL)),
            Item.listCarousel(HomeItem(title: "네네치킨", subTitle: "고추 바사삭", imageURL: imageURL)),
            Item.listCarousel(HomeItem(title: "멕시칸 치킨", subTitle: "반반치킨", imageURL: imageURL)),
            Item.listCarousel(HomeItem(title: "치킨 공주", subTitle: "뿌링클 치킨", imageURL: imageURL)),
        ]
        
        snapshot.appendItems(listItems, toSection: listCarousel)
        
        dataSource?.apply(snapshot)
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        // 레이아웃 컨피그
        let config = UICollectionViewCompositionalLayoutConfiguration()
        // 섹션간 스페이스 설정
        config.interSectionSpacing = 30
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            
            switch sectionIndex {
            case 0:
                return self?.createBannerSection()
            case 1:
                return self?.createNormalCarouselSection()
            case 2:
                return self?.createListCarouselSection()
                
            default:
                return self?.createBannerSection()
            }
        }, configuration: config)
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func createNormalCarouselSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createListCarouselSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        // 스크롤 넣어주고
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }

}


