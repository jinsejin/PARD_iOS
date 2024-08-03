//
//  PardNotionLinkView.swift
//  PARD
//
//  Created by 진세진 on 3/20/24.
//

import UIKit
import Then
import SnapKit
import PARD_DesignSystem

class PardNotionLinkView: UIView {
    private let identifier = "pardNotionCell"
    private let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.itemSize = CGSize(width: 200, height: 48)
    }
    private lazy var collectionView = UICollectionView(
        frame: .zero, collectionViewLayout: collectionViewFlowLayout
    ).then {
        $0.register(PardNotionLinkCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        $0.backgroundColor = .pard.blackCard
    }
    
    convenience init(superView : UIView) {
        self.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCollectionViewUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUpCollectionViewUI() {
        self.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
extension PardNotionLinkView : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PardNotionLinkData.menuTableModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? PardNotionLinkCollectionViewCell else {
            return UICollectionViewCell()
        }
        let pardNotionData = PardNotionLinkData.menuTableModel[indexPath.row]
        cell.configuarePardNotionCell(partName: pardNotionData.title)
        cell.backgroundColor = .gradientColor.gra
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let pardNotionData = PardNotionLinkData.menuTableModel[indexPath.row]
       if let url = URL(string: pardNotionData.notionLink) {
           UIApplication.shared.open(url, options: [:], completionHandler: nil)
       }
   }
}

extension PardNotionLinkView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// - MARK: PardNotionLinkData 모델
struct PardNotionLinkData {
    let title : String
    let notionLink : String
}

extension PardNotionLinkData {
   static let menuTableModel = [
        PardNotionLinkData(title: "전체", notionLink: "https://www.notion.so/we-pard/PARD-3-40d40282e3f3431aa70bea7ab740ee21?pvs=4"),
        PardNotionLinkData(title: "기획", notionLink: "https://www.notion.so/we-pard/ac25d42d9b3646079f67e312a3071e2a?pvs=4"),
        PardNotionLinkData(title: "디자인", notionLink: "https://www.notion.so/we-pard/cbc88d0f2f9845de855b6070e8eeda86?pvs=4"),
        PardNotionLinkData(title: "웹", notionLink: "https://www.notion.so/we-pard/e759b19bcff74d5985208258e958fc07?pvs=4"),
        PardNotionLinkData(title: "서버", notionLink: "https://www.notion.so/we-pard/38ab70a2d2cd441a905e0a6953a10367?pvs=4"),
        PardNotionLinkData(title: "iOS", notionLink: "https://www.notion.so/we-pard/iOS-e4c415e2e9c447f3ba5ab2747a613d00?pvs=4")
    ]
}
