//
//  HomePardnerShipView.swift
//  PARD
//
//  Created by 진세진 on 6/27/24.
//

import UIKit
import SnapKit
import Then

class HomePardnerShipView : UIView {
    private weak var viewController: UIViewController?
    
    private let pardnerShipLabel = UILabel().then {
        $0.text = "🏄‍♂️ PARDNERSHIP 🏄‍♂️"
        $0.font = .pardFont.head2
        $0.textColor = .white
    }
    
    private lazy var moreButton = UIButton().then {
        $0.setTitle("더보기", for: .normal)
        $0.titleLabel?.font = .pardFont.caption2
        $0.titleLabel?.textColor = .pard.white100
        $0.setUnderline()
        $0.addTarget(self, action: #selector(tappedmoreButton), for: .touchUpInside)
    }
    
    private let podPointLabel = UILabel().then {
        $0.text = "파드 포인트"
        $0.textColor = .pard.gray10
        $0.font = .pardFont.body2
    }
    
    private let penaltyLabel = UILabel().then {
        $0.text = "벌점"
        $0.textColor = .pard.gray10
        $0.font = .pardFont.body2
    }
    
    private let podPointValueLabel = UILabel().then {
        $0.text = "+\(totalBonus)점"
        $0.textColor = .pard.primaryGreen
        $0.font = .pardFont.head2
    }
    
    private let penaltyValueLabel = UILabel().then {
        $0.text = "-\(totalMinus)점"
        $0.textColor = .pard.errorRed
        $0.font = .pardFont.head2
    }
    
    
    private let separator = UIView().then { view in
        view.backgroundColor = .pard.gray10
    }
    
    private let verticalSeparator = UIView().then { view in
        view.backgroundColor = .pard.gray10
    }
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        super.init(frame: .zero)
        setUpUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func tappedmoreButton() {
        getRankTop3 { ranks in
                    guard let ranks = ranks else { return }
                    DispatchQueue.main.async {
                        RankManager.shared.rankList = ranks
                        // 데이터를 받은 후 필요한 처리를 합니다.
                    }
                }
//        getRankTop3()
        
        
        let myScoreViewController = MyScoreViewController()
        viewController?.navigationController?.pushViewController(myScoreViewController, animated: true)
    }
    
    private func setUpUI() {
        addSubview(pardnerShipLabel)
        addSubview(moreButton)
        addSubview(separator)
        addSubview(podPointLabel)
        addSubview(podPointValueLabel)
        addSubview(penaltyLabel)
        addSubview(penaltyValueLabel)
        addSubview(verticalSeparator)

        pardnerShipLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(26)
        }

        moreButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-26)
        }

        separator.snp.makeConstraints { make in
            make.top.equalTo(pardnerShipLabel.snp.bottom).offset(15.5)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }

        podPointLabel.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(20.5)
            make.leading.equalToSuperview().offset(55)
        }

        podPointValueLabel.snp.makeConstraints { make in
            make.top.equalTo(podPointLabel.snp.bottom).offset(8.0)
            make.leading.equalToSuperview().offset(65.5)
        }

        penaltyLabel.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(20.5)
            make.trailing.equalToSuperview().offset(-71.5)
        }

        penaltyValueLabel.snp.makeConstraints { make in
            make.top.equalTo(penaltyLabel.snp.bottom).offset(8.0)
            make.trailing.equalToSuperview().offset(-67.5)
        }

        verticalSeparator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(separator.snp.bottom).offset(20.5)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(1)
        }
    }
    
}
