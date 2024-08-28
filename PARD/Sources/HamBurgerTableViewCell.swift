//
//  TableViewCell.swift
//  PARD
//
//  Created by 진세진 on 3/17/24.
//

import UIKit

protocol MenuTableViewCellButtonTapedDelegate : AnyObject {
    func cellButtonTaped(index : Int, isHiddenView : Bool)
    func cellTapped(with url: URL)

}

class HamBurgerTableViewCell: UITableViewCell {
    private let imageViewInCell = UIImageView()
    private let subtitleLabel = UILabel().then { label in
        label.textAlignment = .center
        label.textColor = .pard.gray10
        label.font = UIFont.pardFont.body4
    }
    
    private let pardNotionView = UIView()
    var index: Int = 0
    weak var delegate: MenuTableViewCellButtonTapedDelegate?
    
    private var isTapedButton = false {
        didSet {
            if isTapedButton {
                button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
                self.backgroundColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
                
                self.layer.sublayers?.forEach { sublayer in
                    if sublayer.backgroundColor == UIColor.pard.gray30.cgColor {
                        sublayer.isHidden = true
                    }
                }
                
                if let parentView = self.superview?.superview as? HamburgerBarView {
                    parentView.updateHeaderViewVisibility(isHidden: true)
                }
                
            } else {
                button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
                self.backgroundColor = .pard.blackCard
                
                self.layer.sublayers?.forEach { sublayer in
                    if sublayer.backgroundColor == UIColor.pard.gray30.cgColor {
                        sublayer.isHidden = false
                    }
                }
                
                if let parentView = self.superview?.superview as? HamburgerBarView {
                    parentView.updateHeaderViewVisibility(isHidden: false)
                }
            }
        }
    }

    
    private lazy var button = UIButton().then { button in
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .pard.gray10
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTapButton))
        return recognizer
    }()
    
    
    @objc func handleCellTap() {
        let urlString: String?
        
        switch subtitleLabel.text {
        case "PARD 노션":
            didTapButton()
            return
        case "세미나 구글폼":
            urlString = "https://we-pard.notion.site/a2739c33900847fd95ba4346cd4f4e24?pvs=4"
        case "인스타그램":
            urlString = "https://www.instagram.com/official_pard_/"
        case "웹사이트":
            urlString = "https://we-pard.com/"
        default:
            urlString = nil
        }
        
        if let urlString = urlString, let url = URL(string: urlString) {
            delegate?.cellTapped(with: url)
        }
    }
    
    
    
    @objc func didTapButton() {
        let urlString: String?
        
        switch subtitleLabel.text {
        case "PARD 노션":
            isTapedButton.toggle()
            self.delegate?.cellButtonTaped(index: index, isHiddenView: isTapedButton)
            contentView.addSubview(pardNotionView)
            pardNotionView.snp.makeConstraints { make in
            }
            return
            
        case "세미나 구글폼":
            urlString = "https://we-pard.notion.site/a2739c33900847fd95ba4346cd4f4e24?pvs=4"
            
        case "인스타그램":
            urlString = "https://www.instagram.com/official_pard_/"
            
        case "웹사이트":
            urlString = "https://we-pard.com/"
            
        default:
            urlString = nil
        }
        
        if let urlString = urlString, let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "menuTableView")
        self.backgroundColor = .pard.blackCard
        setUpComponent()
        self.addGestureRecognizer(tapRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.backgroundColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
            
            // PARD 노션 셀의 구분선 숨기기
            self.layer.sublayers?.forEach { sublayer in
                if sublayer.backgroundColor == UIColor.pard.gray30.cgColor {
                    sublayer.isHidden = true
                }
            }
            
        } else {
            self.backgroundColor = .pard.blackCard
            
            // PARD 노션 셀의 구분선 다시 보이기
            self.layer.sublayers?.forEach { sublayer in
                if sublayer.backgroundColor == UIColor.pard.gray30.cgColor {
                    sublayer.isHidden = false
                }
            }
        }
    }

}


// - MARK: setUp UI
extension HamBurgerTableViewCell {
    func configureCell(text : String, image : String, isHiddenButton : Bool, at cellIndexPath : IndexPath) {
        imageViewInCell.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        subtitleLabel.text = text
        index = cellIndexPath.row
        button.isHidden = isHiddenButton
        
        imageViewInCell.snp.removeConstraints()
        subtitleLabel.snp.removeConstraints()
        
        if text == "PARD 노션" {
            imageViewInCell.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalTo(self.snp.leading).offset(20)
            }
            
            subtitleLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalTo(imageViewInCell.snp.trailing).offset(10)
            }
        } else {
            imageViewInCell.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalTo(self.snp.leading).offset(24)
            }
            
            subtitleLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalTo(imageViewInCell.snp.trailing).offset(10)
            }
        }
        self.layer.addBorder(edges: [.bottom], color: .pard.gray30, thickness: 0.5)
    }
    
    private func setUpComponent() {
        contentView.addSubview(imageViewInCell)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(button)
        
        imageViewInCell.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.snp.leading).offset(24)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(imageViewInCell.snp.trailing).offset(10)
        }
        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
}
