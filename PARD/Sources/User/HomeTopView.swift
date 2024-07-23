//
//  HomView.swift
//  PARD
//
//  Created by 진세진 on 3/5/24.
//

import UIKit
import SnapKit
import Then



// - MARK: 원하는 View Class 사용하면 됩니다. (이름도 알맞게 변경, 추가해서 사용해주세요)
class HomeTopView : UIView {
    
    private var toolTipView: ToolTipView?
    private let reuseIdentifier = "StatusCell"
    private var isSelected : Bool = false {
        didSet {
            
        }
    }
    
    private let nameLabel = UILabel().then {
        
        $0.numberOfLines = 3
        $0.attributedText = NSMutableAttributedString()
            .head1MutableAttribute(string: "안녕하세요, ", fontSize: 18, fontColor: UIColor.pard.white100)
            .blueHighlight(UserDefaults.standard.string(forKey: "userName") ?? "사용자", font: .pardFont.head1)
            .head1MutableAttribute(string: "님\n", fontSize: 18, fontColor: UIColor.pard.white100)
            .head1MutableAttribute(string: "오늘도 PARD에서 함께 협업해요!", fontSize: 18, fontColor: UIColor.pard.white100)
    }
    
    private let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.register(StatusCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        $0.backgroundColor = .pard.blackCard
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let questionimageButton = UIButton().then {
        $0.setImage(UIImage(named: "question-line")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    
    private let currentPangulImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        getPangulImg()
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func getPangulImg() {
        let totalPangul = Float(totalBonus) + pangoolPoint
        let imageName : String
        switch totalBonus {
        case 0..<26:
            imageName = "level1"
        case 26..<51:
            imageName = "level2"
        case 51..<76:
            imageName = "level3"
        case 76...90:
            imageName = "level4"
        default:
            imageName = "level5"
        }
        currentPangulImage.image = UIImage(named: imageName)
    }
    
    func setUpUI() {
        self.addSubview(nameLabel)
        self.addSubview(collectionView)
        self.addSubview(questionimageButton)
        self.addSubview(currentPangulImage)
        
        questionimageButton.addTarget(self, action: #selector(tappedQuestionButton), for: .touchUpInside)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.leading.equalToSuperview().offset(24)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalTo(questionimageButton.snp.leading).offset(-10)
            make.height.equalTo(24)
        }
        questionimageButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-28)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        currentPangulImage.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func tappedQuestionButton() {
        toolTipView = TooltipBuilder()
            .setMessage("저는 파드 포인트와 출석 점수를 먹고 자라는 ")
            .setMessage2("'팡울이'")
            .setMessage3("예요.\n오늘도 PARD에서 저와 함께 성장해가요! ☺️")
            .setSuperview(self)
            .setTargetView(questionimageButton)
            .setOffset(8)
            .build()
    }
}

extension HomeTopView : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserDataInHome.userDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? StatusCollectionViewCell else {
            return UICollectionViewCell()
        }
        let dataModel = UserDataInHome.userDatas[indexPath.row]
        cell.configureLabelUI(text: dataModel.userData)
        return cell
    }
}

extension HomeTopView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let modelText = UserDataInHome.userDatas[indexPath.row]
        let tempLabel = UILabel()
        tempLabel.text = modelText.userData
        tempLabel.frame.size = tempLabel.intrinsicContentSize
        let itemWidth = tempLabel.frame.width + 20.0
        
        return CGSize(width: itemWidth, height: collectionView.bounds.height)
        }
}

class StatusCollectionViewCell : UICollectionViewCell {
    private let statusLabel = UILabel().then {
        $0.textColor = .pard.white100
        $0.font = .pardFont.body1.withSize(12)
        $0.frame.size = $0.intrinsicContentSize
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .GradientColor.gra
        contentView.layer.cornerRadius = 12.0
        contentView.layer.masksToBounds = true
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureLabelUI(text string : String) {
        statusLabel.text = string
    }
    
    private func setUpUI() {
        contentView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}

// - TODO: 이후 서버 연동시에 유저에게 알맞은 해당 데이터를 넣어야 합니다.
struct UserDataInHome {
    let userData : String
}

extension UserDataInHome {
    static let userDatas = [
        UserDataInHome(userData: "\(UserDefaults.standard.string(forKey: "userGeneration") ?? "오")기"),
        UserDataInHome(userData: UserDefaults.standard.string(forKey: "userPart") ?? "잡파트"),
        UserDataInHome(userData: UserDefaults.standard.string(forKey: "userRole") ?? "간식요정"),
    ]
}
