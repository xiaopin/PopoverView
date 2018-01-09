//
//  UIViewController+CenterPopover.swift
//  https://github.com/xiaopin/PopoverView.git  `Swift` branch
//
//  Created by nhope on 2018/1/5.
//

import UIKit


private var key: Void?

extension UIViewController {
    
    private var strongTransitioningDelegate: UIViewControllerTransitioningDelegate? {
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &key) as? UIViewControllerTransitioningDelegate
        }
    }
    
    /// 显示一个居中Popover视图控制器
    ///
    /// - Parameters:
    ///   - contentViewController:  弹窗视图控制器
    ///   - preferredContentSize:   弹窗大小
    ///   - shouldDismissPopover:   当点击弹窗内容之外的区域时是否关闭弹窗
    ///   - completion:             回调
    @available(iOS 8.0, *)
    func presentPopoverPresentationController(_ contentViewController: UIViewController, preferredContentSize: CGSize, shouldDismissPopover: Bool, completion: (() -> Void)?) {
        contentViewController.modalPresentationStyle = .custom
        contentViewController.preferredContentSize = preferredContentSize
        
        let transitioningDelegate = PopoverTransitioningDelegate()
        contentViewController.transitioningDelegate = transitioningDelegate
        // Keep strong references.
        contentViewController.strongTransitioningDelegate = transitioningDelegate
        
        if let popoverPresentationController = contentViewController.presentationController as? PopoverPresentationController {
            popoverPresentationController.isShouldDismissPopover = shouldDismissPopover
        }
        
        present(contentViewController, animated: true, completion: completion)
    }
    
    
    
    /// 显示一个居中Popover视图
    ///
    /// 内部会创建一个UIViewController并将contentView添加到该控制器的view上,并且设置约束为`距离父视图上下左右均为0`的约束.
    /// 如果需要手动关闭Popover,则`谁弹出谁负责关闭`,即`self.presentedViewController?.dismiss(animated: true, completion: nil)`
    ///
    /// - Parameters:
    ///   - contentView:            弹窗视图
    ///   - preferredContentSize:   弹窗大小
    ///   - shouldDismissPopover:   当点击弹窗内容之外的区域时是否关闭弹窗
    ///   - completion:             回调
    @available(iOS 8.0, *)
    func presentPopoverView(_ contentView: UIView, preferredContentSize: CGSize, shouldDismissPopover: Bool, completion: (() -> Void)?) {
        let contentViewController = UIViewController()
        contentViewController.view.backgroundColor = .clear
        contentViewController.view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["contentView": contentView]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView]|", options: .directionLeadingToTrailing, metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView]|", options: .directionLeadingToTrailing, metrics: nil, views: views))
        
        presentPopoverPresentationController(contentViewController, preferredContentSize: preferredContentSize, shouldDismissPopover: shouldDismissPopover, completion: completion)
    }
    
}


private class PopoverTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PopoverPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animation = PopoverAnimatedTransitioning()
        animation.isPresentation = true
        return animation
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animation = PopoverAnimatedTransitioning()
        animation.isPresentation = false
        return animation
    }
    
}


private class PopoverAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresentation = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
            else { return }
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        
        if isPresentation, let toView = toView {
            transitionContext.containerView.addSubview(toView)
        }
        
        let presentedTransform = CGAffineTransform.identity
        let dismissedTransform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        let animatingVC = isPresentation ? toVC : fromVC
        animatingVC.view.frame = transitionContext.finalFrame(for: animatingVC)
        animatingVC.view.transform = isPresentation ? dismissedTransform : presentedTransform
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
            animatingVC.view.transform = self.isPresentation ? presentedTransform : dismissedTransform
        }) { (_) in
            if !self.isPresentation {
                fromView?.removeFromSuperview()
            }
            transitionContext.completeTransition(true)
        }
    }
}


private class PopoverPresentationController: UIPresentationController {
    
    var isShouldDismissPopover = true
    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        return view
    }()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction(_:)))
        dimmingView.addGestureRecognizer(tap)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerSize = containerView?.bounds.size else {
            return .zero
        }
        var presentedViewFrame = CGRect.zero
        let width = min(containerSize.width, presentedViewController.preferredContentSize.width)
        let height = min(containerSize.height, presentedViewController.preferredContentSize.height)
        
        presentedViewFrame.size = CGSize(width: width, height: height)
        presentedViewFrame.origin = CGPoint(x: containerSize.width/2, y: containerSize.height/2)
        presentedViewFrame.origin.x -= presentedViewFrame.size.width/2
        presentedViewFrame.origin.y -= presentedViewFrame.size.height/2
        return presentedViewFrame
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        dimmingView.frame = containerView?.bounds ?? .zero
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.addSubview(dimmingView)
        dimmingView.alpha = 0.0;
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 1.0
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 0.0
        }, completion: nil)
    }
    
    @objc func tapGestureRecognizerAction(_ sender: UITapGestureRecognizer) {
        if isShouldDismissPopover {
            presentedViewController.dismiss(animated: true, completion: nil)
        }
    }
    
}
