//
//  PopUpModalBuilder.swift
//  PARD
//
//  Created by 진세진 on 7/12/24.
//

import UIKit

final class ModalBuilder {
    private var title: String?
    private var body: String?
    private var image: String?
    private var buttonType: ModalButtonType?

    init() {}

    func add(title: String) -> Self {
        self.title = title
        return self
    }

    func add(body: String) -> Self {
        self.body = body
        return self
    }
    
    func add(image: String) -> Self {
        self.image = image
        return self
    }

    func add(button: ModalButtonType) -> Self {
        self.buttonType = button
        return self
    }
    
    func show(on viewController: UIViewController) {
        let modal = PopUpModalViewController()
        modal.configurePopup(title: title, body: body, image: image, button: buttonType)
        modal.modalPresentationStyle = .overCurrentContext
        modal.modalTransitionStyle = .crossDissolve

        viewController.present(modal, animated: true)
    }
}

