//
//  ScoreRecordsView.swift
//  PARD
//
//  Created by 김민섭 on 7/2/24.
//

import UIKit

import UIKit

class ScoreRecordsView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var scoreRecords: [ReasonPardnerShip] = []
    private var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
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
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(with records: [ReasonPardnerShip]) {
        self.scoreRecords = records
        print("✅ ScoreRecordsView - Configure: \(records)")
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
        cell.configure(with: record, isLastItem: isLastItem)
        return cell
    }
}
