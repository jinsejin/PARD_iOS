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
    
    private let topStackView = UIStackView().then { stack in
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
    }
    
    private let podPointStackView = UIStackView().then { stack in
        stack.axis = .vertical
        stack.spacing = 8.0
        stack.alignment = .center
    }
    
    private let penaltyStackView = UIStackView().then { stack in
        stack.axis = .vertical
        stack.spacing = 8.0
        stack.alignment = .center
    }
    
    
    private let separator = UIView().then { view in
        view.backgroundColor = .pard.gray10
    }
    
    private let verticalSeparator = UIView().then { view in
        view.backgroundColor = .pard.gray10
    }
    
    convenience init(viewController: UIViewController) {
        self.init(frame: .zero)
        self.viewController = viewController
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
        getUsersMe()
        let myScoreViewController = MyScoreViewController()
        viewController?.navigationController?.pushViewController(myScoreViewController, animated: true)
    }
    
    
    private func setUPStackView() {
        topStackView.addArrangedSubview(pardnerShipLabel)
        topStackView.addArrangedSubview(moreButton)
        
        podPointStackView.addArrangedSubview(podPointLabel)
        podPointStackView.addArrangedSubview(podPointValueLabel)
        
        penaltyStackView.addArrangedSubview(penaltyLabel)
        penaltyStackView.addArrangedSubview(penaltyValueLabel)
    }
    
    private func setUpUI() {
        setUPStackView()
        
        addSubview(topStackView)
        addSubview(separator)
        addSubview(podPointStackView)
        addSubview(penaltyStackView)
        addSubview(verticalSeparator)
        
        topStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(17.5)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }

        podPointStackView.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(20.5)
            make.leading.equalToSuperview().offset(55)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        verticalSeparator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(separator).offset(20.5)
            make.width.equalTo(1)
            make.height.equalTo(podPointStackView)
        }
        
        penaltyStackView.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(20.5)
            make.trailing.equalToSuperview().inset(55)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
}
