import UIKit

class FakeViewController: UIViewController {
    var didCall_presentViewController_withViewController: UIViewController?
    var didCall_presentViewController_withAnimatedFlag: Bool?
    var didCall_presentViewController_withCompletion: (() -> Void)?
    override func presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        didCall_presentViewController_withViewController = viewControllerToPresent
        didCall_presentViewController_withAnimatedFlag = flag
        didCall_presentViewController_withCompletion = completion
    }

    var didCall_dismissViewController = false
    override func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?) {
        didCall_dismissViewController = true
    }
}
