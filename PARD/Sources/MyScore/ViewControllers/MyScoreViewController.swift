//
//  MyScoreViewController.swift
//  PARD
//
//  Created by 김민섭 on 3/4/24.
//

import UIKit
import PARD_DesignSystem

class MyScoreViewController: UIViewController {
    
    let pardnerShipLabel = UILabel()
    let scoreRecordsView = ScoreRecordsView()
    
    private var toolTipView: ToolTipView?
    
    var scoreRecords: [(tag: String, title: String, date: String, points: String, pointsColor: UIColor)] = [
        ("스터디", "AI 스터디\n참여", "08.23(토) |", "+1점", UIColor.pard.gray30),
        ("MVP", "기디 연합 세미나\nMVP 선발", "08.16(토) | ", "+5점", UIColor.pard.gray30),
        ("벌점", "2차 세미나\n결석", "08.16(토) | ", "-1점", UIColor.pard.gray30),
        ("정보", "슬랙\n정보 공유", "08.09(토) | ", "+1점", UIColor.pard.gray30)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .pard.blackBackground
        
        setNavigation()
        setupTextLabel()
        setupRankingMedals()
        setupRankingButton()
        setupCrownImages()
        setupScoreView()
        setupScoreStatusView()
        setupScoreRecordsView()
    }
    
    private func setNavigation() {
        self.navigationItem.title = "내 점수"
        if let navigationBar = self.navigationController?.navigationBar {
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [
                .font: UIFont.pardFont.head2,
                .foregroundColor: UIColor.white
            ]
            
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.compactAppearance = appearance
        }
        let backButton = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = backButton
    }


    
    @objc func backButtonTapped() {
        let homeViewController = HomeViewController()
        navigationController?.setViewControllers([homeViewController], animated: true)
    }

    
    private func setupTextLabel() {
        let padding: CGFloat = 8
        
        let labelContainerView = UIView()
        labelContainerView.backgroundColor = .clear
        view.addSubview(labelContainerView)
        
        pardnerShipLabel.text = "🏆 PARDNERSHIP TOP 3 🏆"
        pardnerShipLabel.font = UIFont.pardFont.head2
        pardnerShipLabel.font = UIFont.boldSystemFont(ofSize: 16)
        pardnerShipLabel.textColor = UIColor(patternImage: gradientImage())
        pardnerShipLabel.textAlignment = .center
        labelContainerView.addSubview(pardnerShipLabel)
        
        pardnerShipLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
        }
        
        labelContainerView.layer.borderWidth = 1
        labelContainerView.layer.borderColor = UIColor(patternImage: gradientImage()).cgColor
        labelContainerView.layer.cornerRadius = 18
        
        labelContainerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(230 + padding * 2)
            $0.height.equalTo(36)
        }
    }
    
    
    
    private func setupRankingButton() {
        let rankingButton = UIButton(type: .system).then {
            $0.setTitle("전체랭킹 확인하기", for: .normal)
            $0.setTitleColor(.pard.gray30, for: .normal)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(rankingButtonTapped), for: .touchUpInside)
        }
        view.addSubview(rankingButton)
        
        rankingButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(240)
            $0.top.equalToSuperview().offset(325)
            $0.width.equalTo(120)
            $0.height.equalTo(14)
        }
        
        let attributedString = NSMutableAttributedString(string: "전체랭킹 확인하기", attributes: [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.pard.gray30
        ])
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        rankingButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    
    private func setupRankingMedals() {
        let goldRingImageView = UIImageView(image: UIImage(named: "goldRing"))
        view.addSubview(goldRingImageView)
        
        let goldRankLabel = UILabel().then {
            $0.text = "1"
            $0.font = UIFont.pardFont.head2
            $0.textAlignment = .center
            $0.textColor = .white
        }
        view.addSubview(goldRankLabel)
        
        let goldPartLabel = UILabel().then {
            $0.text = "디자인파트"
            $0.font = UIFont.pardFont.body3
            $0.textAlignment = .center
            $0.textColor = .pard.gray30
        }
        view.addSubview(goldPartLabel)
        
        let goldNameLabel = UILabel().then {
            $0.text = "김민섭"
            $0.font = UIFont.pardFont.body4
            $0.textAlignment = .center
            $0.textColor = .pard.gray10
        }
        view.addSubview(goldNameLabel)
        
        let silverRingImageView = UIImageView(image: UIImage(named: "silverRing"))
        view.addSubview(silverRingImageView)
        
        let silverRankLabel = UILabel().then {
            $0.text = "2"
            $0.font = UIFont.pardFont.head2
            $0.textAlignment = .center
            $0.textColor = .white
        }
        view.addSubview(silverRankLabel)
        
        let silverPartLabel = UILabel().then {
            $0.text = "디자인파트"
            $0.font = UIFont.pardFont.body3
            $0.textAlignment = .center
            $0.textColor = .pard.gray30
        }
        view.addSubview(silverPartLabel)
        
        let silverNameLabel = UILabel().then {
            $0.text = "손동우"
            $0.font = UIFont.pardFont.body4
            $0.textAlignment = .center
            $0.textColor = .pard.gray10
        }
        view.addSubview(silverNameLabel)
        
        let bronzeRingImageView = UIImageView(image: UIImage(named: "bronzeRing"))
        view.addSubview(bronzeRingImageView)
        
        let bronzeRankLabel = UILabel().then {
            $0.text = "3"
            $0.font = UIFont.pardFont.head2
            $0.textAlignment = .center
            $0.textColor = .white
        }
        view.addSubview(bronzeRankLabel)
        
        let bronzePartLabel = UILabel().then {
            $0.text = "디자인파트"
            $0.font = UIFont.pardFont.body3
            $0.textAlignment = .center
            $0.textColor = .pard.gray30
        }
        view.addSubview(bronzePartLabel)
        
        let bronzeNameLabel = UILabel().then {
            $0.text = "윤성익"
            $0.font = UIFont.pardFont.body4
            $0.textAlignment = .center
            $0.textColor = .pard.gray10
        }
        view.addSubview(bronzeNameLabel)
        
        goldRingImageView.snp.makeConstraints {
            $0.top.equalTo(pardnerShipLabel.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(22)
            $0.width.height.equalTo(40)
        }
        
        goldRankLabel.snp.makeConstraints {
            $0.centerX.equalTo(goldRingImageView)
            $0.centerY.equalTo(goldRingImageView)
        }
        
        goldPartLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(62)
            $0.top.equalToSuperview().offset(179)
        }
        
        
        goldNameLabel.snp.makeConstraints {
            $0.leading.equalTo(goldRingImageView.snp.trailing).offset(8)
            $0.top.equalTo(goldPartLabel.snp.bottom).offset(2)
        }
        
        silverRingImageView.snp.makeConstraints {
            $0.centerY.equalTo(goldRingImageView)
            $0.leading.equalToSuperview().offset(138)
            $0.width.height.equalTo(40)
        }
        
        silverRankLabel.snp.makeConstraints {
            $0.centerX.equalTo(silverRingImageView)
            $0.centerY.equalTo(silverRingImageView)
        }
        
        silverPartLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(178)
            $0.top.equalToSuperview().offset(179)
        }
        
        silverNameLabel.snp.makeConstraints {
            $0.leading.equalTo(silverRingImageView.snp.trailing).offset(8)
            $0.top.equalTo(silverPartLabel.snp.bottom).offset(2)
        }
        
        bronzeRingImageView.snp.makeConstraints {
            $0.centerY.equalTo(goldRingImageView)
            $0.leading.equalToSuperview().offset(254)
            $0.width.height.equalTo(40)
        }
        
        bronzeRankLabel.snp.makeConstraints {
            $0.centerX.equalTo(bronzeRingImageView)
            $0.centerY.equalTo(bronzeRingImageView)
        }
        
        bronzePartLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(294)
            $0.top.equalToSuperview().offset(179)
        }
        
        bronzeNameLabel.snp.makeConstraints {
            $0.leading.equalTo(bronzeRingImageView.snp.trailing).offset(8)
            $0.top.equalTo(bronzePartLabel.snp.bottom).offset(2)
        }
    }
    
    private func setupCrownImages() {
        let goldCrownImageView = UIImageView(image: UIImage(named: "gold"))
        view.addSubview(goldCrownImageView)
        
        goldCrownImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-155)
            $0.top.equalTo(pardnerShipLabel.snp.bottom).offset(16)
            $0.width.height.equalTo(20)
        }
        
        let silverCrownImageView = UIImageView(image: UIImage(named: "silver"))
        view.addSubview(silverCrownImageView)
        
        silverCrownImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-39)
            $0.top.equalTo(pardnerShipLabel.snp.bottom).offset(16)
            $0.width.height.equalTo(20)
        }
        
        let bronzeCrownImageView = UIImageView(image: UIImage(named: "bronze"))
        view.addSubview(bronzeCrownImageView)
        
        bronzeCrownImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(77)
            $0.top.equalTo(pardnerShipLabel.snp.bottom).offset(16)
            $0.width.height.equalTo(20)
        }
    }
    
    private func setupScoreView() {
        let myScoreBorderView = UIView().then {
            $0.backgroundColor = UIColor.pard.blackCard
            $0.layer.cornerRadius = 8
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(patternImage: gradientImage()).cgColor
        }
        view.addSubview(myScoreBorderView)
        
        myScoreBorderView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(245)
            $0.leading.equalToSuperview().offset(24)
            $0.width.equalTo(155.5)
            $0.height.equalTo(68)
        }
        
        let totalScoreBorderView = UIView().then {
            $0.backgroundColor = UIColor.pard.blackCard
            $0.layer.cornerRadius = 8
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(patternImage: gradientImage()).cgColor
        }
        view.addSubview(totalScoreBorderView)
        
        totalScoreBorderView.snp.makeConstraints {
            $0.top.equalTo(myScoreBorderView.snp.top)
            $0.leading.equalTo(myScoreBorderView.snp.trailing).offset(16)
            $0.width.equalTo(155.5)
            $0.height.equalTo(68)
        }
        
        let myScoreLabel = UILabel().then {
            $0.text = "파트 내 랭킹"
            $0.font = UIFont.pardFont.body2
            $0.textAlignment = .center
            $0.textColor = .pard.gray10
        }
        view.addSubview(myScoreLabel)
        
        myScoreLabel.snp.makeConstraints {
            $0.top.equalTo(myScoreBorderView.snp.top).offset(12)
            $0.centerX.equalTo(myScoreBorderView.snp.centerX)
        }
        
        let myRankLabel = UILabel().then {
            $0.text = "3위"
            $0.font = UIFont.pardFont.head2
            $0.textAlignment = .center
            $0.textColor = .white
        }
        view.addSubview(myRankLabel)
        
        myRankLabel.snp.makeConstraints {
            $0.top.equalTo(myScoreLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(myScoreBorderView.snp.centerX)
        }
        
        let totalScoreLabel = UILabel().then {
            $0.text = "전체 랭킹"
            $0.font = UIFont.pardFont.body2
            $0.textAlignment = .center
            $0.textColor = .pard.gray10
        }
        view.addSubview(totalScoreLabel)
        
        totalScoreLabel.snp.makeConstraints {
            $0.top.equalTo(totalScoreBorderView.snp.top).offset(12)
            $0.centerX.equalTo(totalScoreBorderView.snp.centerX)
        }
        
        let totalRankLabel = UILabel().then {
            $0.text = "13위"
            $0.font = UIFont.pardFont.head2
            $0.textAlignment = .center
            $0.textColor = .white
        }
        view.addSubview(totalRankLabel)
        
        totalRankLabel.snp.makeConstraints {
            $0.top.equalTo(totalScoreLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(totalScoreBorderView.snp.centerX)
        }
    }
    
    private func setupScoreStatusView() {
        let scoreStatusLabel = UILabel().then {
            $0.text = "내 점수 현황"
            $0.font = UIFont.pardFont.head1
            $0.textColor = .white
            $0.textAlignment = .left
        }
        view.addSubview(scoreStatusLabel)
        
        scoreStatusLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(367)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(260)
        }
        
        let scoreStatusView = UIView().then {
            $0.backgroundColor = UIColor.pard.blackCard
            $0.layer.cornerRadius = 8
        }
        view.addSubview(scoreStatusView)
        
        scoreStatusView.snp.makeConstraints {
            $0.top.equalTo(scoreStatusLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(92)
        }
        
        let partPointsLabel = UILabel().then {
            $0.text = "파트 포인트"
            $0.font = UIFont.pardFont.body2
            $0.textColor = .pard.gray10
            $0.textAlignment = .center
        }
        scoreStatusView.addSubview(partPointsLabel)
        
        partPointsLabel.snp.makeConstraints {
            $0.top.equalTo(scoreStatusView.snp.top).offset(24)
            $0.leading.equalTo(scoreStatusView.snp.leading).offset(54.5)
            $0.trailing.equalTo(scoreStatusView.snp.trailing).offset(-217.5)
        }
        
        let partPointsValueLabel = UILabel().then {
            $0.text = "+7점"
            $0.font = UIFont.pardFont.head2
            $0.textColor = UIColor.pard.primaryGreen
            $0.textAlignment = .center
        }
        scoreStatusView.addSubview(partPointsValueLabel)
        
        partPointsValueLabel.snp.makeConstraints {
            $0.top.equalTo(scoreStatusView.snp.top).offset(48)
            $0.leading.equalTo(scoreStatusView.snp.leading).offset(65)
            $0.trailing.equalTo(scoreStatusView.snp.trailing).offset(-228)
        }
        
        let separatorView = UIView().then {
            $0.backgroundColor = .pard.gray30
        }
        
        scoreStatusView.addSubview(separatorView)
        
        separatorView.snp.makeConstraints {
            $0.centerX.equalTo(scoreStatusView)
            $0.centerY.equalTo(scoreStatusView)
            $0.width.equalTo(1)
            $0.height.equalTo(44)
        }
        
        let penaltyPointsLabel = UILabel().then {
            $0.text = "벌점"
            $0.font = UIFont.pardFont.body3
            $0.textColor = .pard.gray10
            $0.textAlignment = .center
        }
        scoreStatusView.addSubview(penaltyPointsLabel)
        
        penaltyPointsLabel.snp.makeConstraints {
            $0.top.equalTo(scoreStatusView.snp.top).offset(24)
            $0.leading.equalTo(scoreStatusView.snp.leading).offset(234.5)
            $0.trailing.equalTo(scoreStatusView.snp.trailing).offset(-71.5)
        }
        
        let penaltyPointsValueLabel = UILabel().then {
            $0.text = "-1점"
            $0.font = UIFont.pardFont.head2
            $0.textColor = UIColor.pard.errorRed
            $0.textAlignment = .center
            
        }
        scoreStatusView.addSubview(penaltyPointsValueLabel)
        
        penaltyPointsValueLabel.snp.makeConstraints {
            $0.top.equalTo(scoreStatusView.snp.top).offset(48)
            $0.leading.equalTo(scoreStatusView.snp.leading).offset(230.5)
            $0.trailing.equalTo(scoreStatusView.snp.trailing).offset(-67.5)
        }
        
        let questionImageButton = UIButton().then {
            $0.setImage(UIImage(named: "myscore-question-line")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        view.addSubview(questionImageButton)
        
        questionImageButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(257)
            $0.top.equalToSuperview().offset(538)
            $0.width.equalTo(14)
            $0.height.equalTo(14)
        }
        
        questionImageButton.addTarget(self, action: #selector(tappedQuestionButton), for: .touchUpInside)
    }
    
    @objc private func tappedQuestionButton() {
        toggleToolTip()
    }

    @objc private func scorePolicyTapped() {
        toggleToolTip()
    }

    private func toggleToolTip() {
        if toolTipView == nil {
            let toolTip = ToolTipView()
            view.addSubview(toolTip)
            toolTip.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(563)
                make.leading.equalToSuperview().offset(45)
                make.trailing.equalToSuperview().offset(-18)
                make.height.equalTo(200)
            }
            toolTipView = toolTip
        } else {
            toolTipView?.removeFromSuperview()
            toolTipView = nil
        }
    }

    
    private func setupScoreRecordsView() {
        let scoreRecordsTitleLabel = UILabel().then {
            $0.text = "점수 기록"
            $0.font = UIFont.pardFont.head1
            $0.textColor = .white
            $0.textAlignment = .left
        }
        view.addSubview(scoreRecordsTitleLabel)
        
        let scorePolicyLabel = UILabel().then {
            $0.text = "점수정책 확인하기"
            $0.font = UIFont.pardFont.body2
            $0.textColor = .pard.primaryBlue
            $0.textAlignment = .right
            $0.isUserInteractionEnabled = true
        }
        view.addSubview(scorePolicyLabel)
        
        let questionImageView = UIImageView(image: UIImage(named: "questionImageMark"))
        view.addSubview(questionImageView)
        
        let scorePolicyTapGesture = UITapGestureRecognizer(target: self, action: #selector(scorePolicyTapped))
        scorePolicyLabel.addGestureRecognizer(scorePolicyTapGesture)
        
        scoreRecordsTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(531)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-280)
        }
        
        questionImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(538)
            $0.leading.equalToSuperview().offset(257)
        }
        
        scorePolicyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(537)
            $0.leading.equalToSuperview().offset(273)
        }
        
        view.addSubview(scoreRecordsView)
        
        scoreRecordsView.snp.makeConstraints {
            $0.top.equalTo(scoreRecordsTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(136)
        }
        
        scoreRecordsView.layer.cornerRadius = 12
        scoreRecordsView.layer.masksToBounds = true
        
        scoreRecordsView.configure(with: scoreRecords)
    }


    
    
    
    class ScoreRecordCell: UICollectionViewCell {
        static let identifier = "ScoreRecordCell"
        
        let tagLabel = UILabel()
        let titleLabel = UILabel()
        let dateLabel = UILabel()
        let pointsLabel = UILabel()
        let backgroundCardView = UIView()
        let separatorView = UIView()  // Separator view
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            contentView.backgroundColor = .clear
            
            backgroundCardView.backgroundColor = .pard.blackCard
            backgroundCardView.layer.borderWidth = 1
            backgroundCardView.layer.borderColor = UIColor.pard.blackBackground.cgColor
            contentView.addSubview(backgroundCardView)
            
            tagLabel.font = UIFont.pardFont.body2
            tagLabel.textAlignment = .center
            tagLabel.layer.cornerRadius = 8
            tagLabel.layer.borderWidth = 1
            tagLabel.layer.masksToBounds = true
            
            titleLabel.font = UIFont.pardFont.body4
            titleLabel.textColor = .pard.gray10
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
            
            dateLabel.font = UIFont.pardFont.body3
            dateLabel.textColor = .pard.gray30
            dateLabel.textAlignment = .left
            
            pointsLabel.font = UIFont.pardFont.body3
            pointsLabel.textColor = .pard.gray30
            pointsLabel.textAlignment = .right
            
            separatorView.backgroundColor = .pard.gray30  
            contentView.addSubview(separatorView)
            
            backgroundCardView.addSubview(tagLabel)
            backgroundCardView.addSubview(titleLabel)
            backgroundCardView.addSubview(dateLabel)
            backgroundCardView.addSubview(pointsLabel)
            
            backgroundCardView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            tagLabel.snp.makeConstraints { make in
                make.top.equalTo(backgroundCardView).offset(24)
                make.centerX.equalTo(backgroundCardView)
                make.width.equalTo(56)
                make.height.equalTo(24)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(tagLabel.snp.bottom).offset(12)
                make.leading.equalTo(backgroundCardView).offset(12)
                make.trailing.equalTo(backgroundCardView).offset(-12)
            }
            
            dateLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(8)
                make.leading.equalTo(backgroundCardView).offset(28)
            }
            
            pointsLabel.snp.makeConstraints { make in
                make.top.equalTo(dateLabel.snp.top)
                make.trailing.equalTo(backgroundCardView).offset(-28)
            }
            
            separatorView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.trailing.equalToSuperview()
                make.width.equalTo(1)
            }
        }
        
        func configure(with record: (tag: String, title: String, date: String, points: String, pointsColor: UIColor), isLastItem: Bool) {
            tagLabel.text = record.tag
            titleLabel.text = record.title
            dateLabel.text = record.date
            pointsLabel.text = record.points
            pointsLabel.textColor = record.pointsColor
            
            separatorView.isHidden = isLastItem
            
            if record.tag == "벌점" {
                tagLabel.layer.borderColor = UIColor.pard.errorRed.cgColor
                tagLabel.textColor = .pard.errorRed
                tagLabel.backgroundColor = .clear
            } else {
                tagLabel.layer.borderColor = UIColor.pard.primaryPurple.cgColor
                tagLabel.textColor = .pard.primaryPurple
                tagLabel.backgroundColor = .clear
            }
        }
    }



    class ToolTipView: UIView {

        private let closeButton = UIButton()
        private let contentView = UIView()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupUI() {
            backgroundColor = .pard.blackBackground
            layer.cornerRadius = 8
            layer.borderWidth = 1
            layer.borderColor = UIColor.pard.primaryPurple.cgColor

            let mvpLabel = createLabel(text: "MVP", color: .pard.primaryPurple)
            let mvpDetail = createDetailLabel(text: "주요 행사 MVP", details: [("5점", .gray)])
            let mvpSubDetail = createDetailLabel(text: "세미나 파트별 MVP", details: [("3점", .gray)])

            let studyLabel = createLabel(text: "스터디", color: .pard.primaryPurple)
            let studyDetail = createDetailLabel(text: "개최 및 수료", details: [("5점", .gray)])
            let studySubDetail = createDetailLabel(text: "참여 및 수료", details: [("3점", .gray)])

            let communicationLabel = createLabel(text: "소통", color: .pard.primaryPurple)
            let communicationDetail = createDetailLabel(text: "파드 구성원과의 만남 후 사진을 슬랙에 인증", details: [("1점/주 1회", .gray)])

            let reportLabel = createLabel(text: "회고", color: .pard.primaryPurple)
            let reportDetail = createDetailLabel(text: "디스코이엇 작성 후 파트장에게 공유", details: [("3점/필수과제 제외", .gray)])

            let penaltyLabel = createLabel(text: "벌점", color: .pard.errorRed)
            
            let penaltyDetail = createDetailLabel(text: "세미나 지각(10분 이내)", details: [("-1점", .gray)])
        
            let penaltyDetail1 = createDetailLabel(text: "세미나 결석", details: [("-2점", .gray)])
            
            let penaltyDetail2 = createDetailLabel(text: "과제 지각", details: [("-0.5점", .gray)])

            let penaltyDetail3 = createDetailLabel(text: "과제 미제출", details: [("-1점", .gray)])
            
            let mvpStackView = createStackView(arrangedSubviews: [mvpLabel, mvpDetail, mvpSubDetail])
            let studyStackView = createStackView(arrangedSubviews: [studyLabel, studyDetail, studySubDetail])
            let communicationStackView = createStackView(arrangedSubviews: [communicationLabel, communicationDetail])
            let reportStackView = createStackView(arrangedSubviews: [reportLabel, reportDetail])
            let penaltyStackView = createStackView(arrangedSubviews: [penaltyLabel, penaltyDetail, penaltyDetail1,penaltyDetail2, penaltyDetail3])

            let stackView = UIStackView(arrangedSubviews: [
                mvpStackView,
                studyStackView,
                communicationStackView,
                reportStackView,
                penaltyStackView
            ])

            stackView.axis = .vertical
            stackView.spacing = 8
            stackView.alignment = .leading

            contentView.addSubview(stackView)
            addSubview(contentView)

            contentView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(16)
            }

            stackView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }

            closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
            closeButton.tintColor = .white
            closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
            addSubview(closeButton)

            closeButton.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(8)
                make.trailing.equalToSuperview().offset(-8)
            }
        }

        private func createLabel(text: String, color: UIColor) -> UILabel {
            let label = UILabel()
            label.text = text
            label.textColor = color
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.layer.cornerRadius = 8
            label.layer.borderWidth = 1
            label.layer.borderColor = color.cgColor
            label.textAlignment = .center
            label.snp.makeConstraints { make in
                make.width.equalTo(50)
                make.height.equalTo(24)
            }
            return label
        }

        private func createDetailLabel(text: String, details: [(String, UIColor)]) -> UIStackView {
            let label = UILabel()
            label.text = text
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 10)
            label.numberOfLines = 1
            label.textAlignment = .left

            var views: [UIView] = [label]

            for (point, color) in details {
                let pointLabel = UILabel()
                pointLabel.text = point
                pointLabel.textColor = color
                pointLabel.font = UIFont.systemFont(ofSize: 10)
                pointLabel.backgroundColor = .darkGray
                pointLabel.layer.cornerRadius = 4
                pointLabel.layer.masksToBounds = true
                pointLabel.textAlignment = .center
                pointLabel.snp.makeConstraints { make in
                    make.width.equalTo(40)
                    make.height.equalTo(20)
                }
                views.append(pointLabel)
            }

            let stackView = UIStackView(arrangedSubviews: views)
            stackView.axis = .horizontal
            stackView.spacing = 4
            stackView.alignment = .center

            return stackView
        }

        private func createSubDetailLabel(text: String) -> UILabel {
            let label = UILabel()
            label.text = text
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 10)
            label.numberOfLines = 1
            label.textAlignment = .left

            return label
        }

        private func createStackView(arrangedSubviews: [UIView]) -> UIStackView {
            let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
            stackView.axis = .horizontal
            stackView.spacing = 8
            stackView.alignment = .center

            arrangedSubviews.forEach { subview in
                if let label = subview as? UILabel {
                    label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                }
            }

            return stackView
        }

        @objc private func closeTapped() {
            removeFromSuperview()
        }
    }


    @objc private func rankingButtonTapped() {
        let rankingViewController = RankingViewController()
        navigationController?.pushViewController(rankingViewController, animated: true)
    }
    
    func gradientImage() -> UIImage {
        let gradientLayer = CAGradientLayer().then {
            $0.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
            $0.colors = [UIColor(red: 82/255, green: 98/255, blue: 245/255, alpha: 1).cgColor, UIColor(red: 123/255, green: 63/255, blue: 239/255, alpha: 1).cgColor]
            $0.startPoint = CGPoint(x: 0, y: 0)
            $0.endPoint = CGPoint(x: 1, y: 1)
        }
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
