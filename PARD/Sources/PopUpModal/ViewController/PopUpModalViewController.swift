//
//  PopUpModalViewController.swift
//  PARD
//
//  Created by 진세진 on 3/5/24.
//
import UIKit
import SnapKit

final class PopUpModalViewController: UIViewController {
    private let modalView = PopUpModalView()
    private let dimmedView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func configurePopup(
        title: String?,
        body: String?,
        image : String?,
        button: ModalButtonType?
    ) {
        modalView.updateComponents(
            title: title ?? "",
            body: body ?? "", 
            image: image ?? "",
            button: button,
            dismissAction: { [weak self] in
                self?.dismiss(animated: true)
            }
        )
    }

    private func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(dimmedView)

        dimmedView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        dimmedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDimmedArea)))
        
        dimmedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        dimmedView.addSubview(modalView)
        modalView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
    }

    @objc func didTapDimmedArea() {
        self.dismiss(animated: true)
    }
}
