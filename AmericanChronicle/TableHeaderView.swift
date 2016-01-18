//
//  TableHeaderView.swift
//  AmericanChronicle
//
//  Created by Ryan Peterson on 8/30/15.
//  Copyright (c) 2015 ryanipete. All rights reserved.
//



class TableHeaderView: UITableViewHeaderFooterView {
    var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }
    private let label = UILabel()
    func commonInit() {

        contentView.backgroundColor = Colors.offWhite

        contentView.addSubview(label)
        label.font = UIFont(name: "AvenirNext-Regular", size: UIFont.systemFontSize())
        label.textColor = Colors.darkBlue
        label.numberOfLines = 2
        label.snp_makeConstraints { make in
            make.leading.equalTo(Measurements.horizontalMargin)
            make.trailing.equalTo(-Measurements.horizontalMargin)
            make.bottom.equalTo(-1.0)
            make.top.equalTo(1.0)
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

//    override func sizeThatFits(size: CGSize) -> CGSize {
//        var updatedSize = label.sizeThatFits(size)
//        updatedSize.width += CGFloat(2 * Measurements.horizontalMargin)
//        updatedSize.height += CGFloat(2 * Measurements.verticalMargin)
//        print("[RP] sizeThatFits(\(size)): \(updatedSize)")
//        return size
//    }
//
//    override func intrinsicContentSize() -> CGSize {
//        var size = label.intrinsicContentSize()
//        size.width += CGFloat(2 * Measurements.horizontalMargin)
//        size.height += CGFloat(2 * Measurements.verticalMargin)
//        print("[RP] intrinsicContentSize: \(size)")
//        return size
//    }
}
