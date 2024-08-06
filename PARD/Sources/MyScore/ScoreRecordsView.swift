//
//  ScoreRecordsView.swift
//  PARD
//
//  Created by 김민섭 on 7/2/24.
//

import UIKit
import Then
import SnapKit

class ScoreRecordsView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var scoreRecords: [ReasonPardnerShip] = []
    var collectionView : UICollectionView
    private let unRegisterView = UIView().then { view in
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8.0
        view.backgroundColor = .pard.blackCard
    }
    private let unResgiterLabel = UILabel().then { label in
        label.text = "파드에 등록되지 않은 이메일 이거나\n 혹은 파드너십 및 벌점 목록이 비어있습니다."
        label.numberOfLines = 2
        label.textColor = .pard.gray10
        label.textAlignment = .center
        label.font = .pardFont.body6
        label.setLineSpacing(spacing: 10)
    }
    
    
    
    override init(frame: CGRect) {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .horizontal
       layout.minimumLineSpacing = 0
       layout.minimumInteritemSpacing = 0
       layout.itemSize = CGSize(width: 144, height: 136)

       collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       super.init(frame: frame)
       setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if scoreRecords.isEmpty {
            setupCollectionView()
        } else {
            setupCollectionView()
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 144, height: 136)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .pard.blackBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ScoreRecordCell.self, forCellWithReuseIdentifier: ScoreRecordCell.identifier)
        
        collectionView.layer.cornerRadius = 12
        collectionView.layer.masksToBounds = true
        
        addSubview(collectionView)
        addSubview(unRegisterView)
        unRegisterView.addSubview(unResgiterLabel)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        unRegisterView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        unResgiterLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    func configure(with records: [ReasonPardnerShip]) {
        self.scoreRecords = records
        print("✅ ScoreRecordsView - Configure: \(records)")
        if records.isEmpty {
            collectionView.isHidden = true
            unRegisterView.isHidden = false
            unResgiterLabel.isHidden = false
        } else {
            collectionView.isHidden = false
            unRegisterView.isHidden = true
            unResgiterLabel.isHidden = true
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scoreRecords.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScoreRecordCell.identifier, for: indexPath) as? ScoreRecordCell else {
            return UICollectionViewCell()
        }
        
        let record = scoreRecords[indexPath.item]
        let isLastItem = indexPath.item == scoreRecords.count - 1
        let isFirstItem = indexPath.item == 0
        cell.configure(with: record, isLastItem: isLastItem, isFirstItem: isFirstItem)
        return cell
    }
}
