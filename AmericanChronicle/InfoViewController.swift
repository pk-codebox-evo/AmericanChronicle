//
//  InfoViewController.swift
//  AmericanChronicle
//
//  Created by Ryan Peterson on 1/18/16.
//  Copyright © 2016 ryanipete. All rights reserved.
//

class InfoViewController: UIViewController {

    var userDidDismiss: ((Void) -> Void)?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.darkGray
        label.textAlignment = .Center
        label.font = UIFont.boldSystemFontOfSize(16)
        label.numberOfLines = 0
        label.text = "About this app"
        return label
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.darkGray
        label.textAlignment = .Center
        label.numberOfLines = 0
        label.font = UIFont.systemFontOfSize(16)
        label.text = "American Chronicle gets its data from the Chronicling America website.\n\nChronicling America is a project funded by the National Endowment for the Humanities and maintained by the Library of Congress."
        return label
    }()

    private let websiteButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Visit chroniclingamerica.gov.loc", forState: .Normal)

        return btn
    }()

    // MARK: UIViewController Init methods

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not supported. Use designated initializer instead")
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        navigationItem.title = "About this app"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .Plain, target: self, action: "dismissButtonTapped:")
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        view.backgroundColor = UIColor.whiteColor()

        view.addSubview(bodyLabel)
        bodyLabel.snp_makeConstraints { make in
            make.top.equalTo(Measurements.verticalMargin)
            make.leading.equalTo(Measurements.horizontalMargin)
            make.trailing.equalTo(-Measurements.horizontalMargin)
        }

        websiteButton.addTarget(self, action: "websiteButtonTapped:", forControlEvents: .TouchUpInside)
        view.addSubview(websiteButton)
        websiteButton.snp_makeConstraints { make in
            make.top.equalTo(bodyLabel.snp_bottom).offset(Measurements.verticalMargin * 2)
            make.leading.equalTo(Measurements.horizontalMargin)
            make.trailing.equalTo(-Measurements.horizontalMargin)
            make.height.equalTo(Measurements.buttonHeight)
        }
    }

    func dismissButtonTapped(sender: UIBarButtonItem) {
        userDidDismiss?()
    }

    func websiteButtonTapped(sender: UIBarButtonItem) {
        let vc = ChroniclingAmericaWebsiteViewController()
        vc.userDidDismiss = {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        let nvc = UINavigationController(rootViewController: vc)
        presentViewController(nvc, animated: true, completion: nil)
    }
}
