//
//  PopUpModalView.swift
//  PARD
//
//  Created by 진세진 on 3/5/24.
//
import UIKit
import SnapKit

enum ModalButtonType {
    case confirm(
        title: String,
        action: (() -> Void)?
    )
    case cancellable(
        cancelButtonTitle: String,
        confirmButtonTitle: String,
        cancelButtonAction: (() -> Void)?,
        confirmButtonAction: (() -> Void)?
    )
    case noButton
}

final class PopUpModalView: UIView {
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    private let bodyLabel = UILabel()
    private let bodyImageView = UIImageView()
    private let cancelButton = UIButton()
    private let confirmButton = UIButton()
    private let buttonsStackView = UIStackView()

    private var cancelButtonAction: (() -> Void)?
    private var confirmButtonAction: (() -> Void)?
    private var dismissAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateComponents(
        title: String,
        body: String,
        image: String?,
        content: String?,
        button: ModalButtonType?,
        dismissAction: (() -> Void)?
    ) {
        self.titleLabel.text = title
        self.titleLabel.textColor = .GradientColor.gra
        self.bodyLabel.text = body
        self.bodyLabel.textColor = .pard.white100
        if let imageName = image, !imageName.isEmpty {
            self.bodyImageView.image = UIImage(named: imageName)
            self.bodyImageView.isHidden = false
        } else {
            self.bodyImageView.isHidden = true
        }
        self.contentLabel.text = content
        self.dismissAction = dismissAction
        configureButtons(button)
        
        titleLabel.isHidden = title.isEmpty
        bodyLabel.isHidden = body.isEmpty
    }

    @objc private func didTapLeftButton() {
        cancelButtonAction?()
        dismissAction?()
    }

    @objc private func didTapRightButton() {
        confirmButtonAction?()
        dismissAction?()
    }

    private func setupViews() {
        setupContainerStackView()
        setupLabels()
        setupButtons()
        setupSubviews()
    }

    private func setupContainerStackView() {
        addGestureRecognizer(UITapGestureRecognizer())
        backgroundColor = .pard.blackBackground
        layer.cornerRadius = 8
        layer.borderColor = UIColor.GradientColor.gra.cgColor
        layer.borderWidth = 1

        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.spacing = 16
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.axis = .horizontal
    }

    private func setupSubviews() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyImageView, contentLabel, bodyLabel, buttonsStackView])
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
        
        buttonsStackView.addArrangedSubview(cancelButton)
        buttonsStackView.addArrangedSubview(confirmButton)
        
        buttonsStackView.snp.makeConstraints { make in
            make.leading.equalTo(stackView.snp.leading).offset(40)
            make.trailing.equalTo(stackView.snp.trailing).offset(-40)
            make.height.equalTo(44)
        }
    }

    private func setupButtons() {
        configureButtonAppearance(button: cancelButton, backgroundColor: .pard.blackCard, titleColor: .pard.white100, action: #selector(didTapLeftButton))
        configureButtonAppearance(button: confirmButton, backgroundColor: .GradientColor.gra, titleColor: .pard.white100, action: #selector(didTapRightButton))
    }

    private func setupLabels() {
        titleLabel.numberOfLines = 0
        bodyLabel.numberOfLines = 0
        contentLabel.numberOfLines = 0
        titleLabel.font = .pardFont.head1
        contentLabel.font = .pardFont.body5
        contentLabel.textColor = .pard.white100
        contentLabel.textAlignment = .center
        bodyLabel.font = .pardFont.body5
    }

    private func configureButtonAppearance(button: UIButton, backgroundColor: UIColor, titleColor: UIColor, action: Selector) {
        button.layer.cornerRadius = 22
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = .pardFont.body6
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    private func configureButtons(_ buttonType: ModalButtonType?) {
        switch buttonType {
        case .confirm(let title, let action):
            confirmButton.setTitle(title, for: .normal)
            confirmButtonAction = action
            cancelButton.isHidden = true
        case .cancellable(let cancelButtonTitle, let confirmButtonTitle, let cancelButtonAction, let confirmButtonAction):
            cancelButton.setTitle(cancelButtonTitle, for: .normal)
            confirmButton.setTitle(confirmButtonTitle, for: .normal)
            self.cancelButtonAction = cancelButtonAction
            self.confirmButtonAction = confirmButtonAction
            cancelButton.isHidden = false
        case .noButton:
            buttonsStackView.isHidden = true
        case .none:
            buttonsStackView.isHidden = true
        }
    }
}
