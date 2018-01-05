//
//  ViewController.swift
//  Example
//
//  Created by nhope on 2018/1/5.
//  Copyright © 2018年 nhope. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonAction(_ sender: UIButton) {
        let contentViewController = UIViewController()
        contentViewController.view.backgroundColor = .purple
        presentPopoverPresentationController(contentViewController, preferredContentSize: CGSize(width: 200.0, height: 300.0), shouldDismissPopover: true) {
            print("ViewController show finish.")
        }
        
//        let contentView = UIView()
//        contentView.layer.cornerRadius = 14.0
//        contentView.layer.masksToBounds = true
//        contentView.backgroundColor = .purple
//        presentPopoverView(contentView, preferredContentSize: CGSize(width: 200.0, height: 300.0), shouldDismissPopover: false) {
//            print("View is showed.");
//            DispatchQueue.main.asyncAfter(deadline: .now()+3.0, execute: {
//                self.presentedViewController?.dismiss(animated: true, completion: nil)
//            })
//        }
    }
    
}

