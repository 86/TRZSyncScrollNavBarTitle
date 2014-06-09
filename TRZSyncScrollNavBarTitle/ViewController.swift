//
//  ViewController.swift
//  TRZSyncScrollNavBarTitle
//
//  Created by yam on 2014/06/05.
//  Copyright (c) 2014年 86. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController, UIScrollViewDelegate {
                            
    @IBOutlet var scrollView : UIScrollView
    @IBOutlet var titleViewWrapper : UIView
    @IBOutlet var titleView : UIScrollView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.genScrollViewContents(scrollView, pages: 10)
        self.genTitleScrollViewContents(titleView, pages: 10)
        
        // Add layer mask
        titleViewWrapper.layer.masksToBounds = true
        let maskLayer = CAGradientLayer()
        maskLayer.frame = titleViewWrapper.bounds
        maskLayer.startPoint = CGPoint(x:0.0, y:0.5)
        maskLayer.endPoint = CGPoint(x:1.0, y:0.5)
        let points: Float[] = [0.0, 0.25, 0.75, 1.0]
        let colors: AnyObject![] = [
            UIColor(white:1.0, alpha:0.0).CGColor,
            UIColor(white:1.0, alpha:1.0).CGColor,
            UIColor(white:1.0, alpha:1.0).CGColor,
            UIColor(white:1.0, alpha:0.0).CGColor,
        ]
        maskLayer.locations = points
        maskLayer.colors = colors
        titleViewWrapper.layer.mask = maskLayer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func genScrollViewContents (scrollView: UIScrollView!, pages: Int) {
        let width: CGFloat = self.view.frame.size.width
        let height: CGFloat = self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - 20
        scrollView.contentSize = CGSize(width: width * CGFloat(pages), height: height)
        scrollView.delegate = self
        for n in 0..pages {
            var i = CGFloat(n)
            var testView = UIView(frame: CGRect(x: width * i, y: 0.0, width: width, height: height))
            var val = 0.05 * i + 0.8
            testView.backgroundColor = UIColor(red: val, green: val - 0.2, blue: val - 0.4, alpha: 1.0)
            var label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 20.0))
            label.text = "Page \(n+1)"
            label.textAlignment = NSTextAlignment.Center
            label.center = CGPoint(x: width / 2, y: height / 2)
            testView.addSubview(label)
            scrollView.addSubview(testView)
        }
    }
    
    func genTitleScrollViewContents (titleView: UIScrollView!, pages: Int) {
        let width: CGFloat = titleView.frame.size.width
        let height: CGFloat = titleView.frame.size.height
        titleView.contentSize = CGSize(width: width * CGFloat(pages), height: height)
        for n in 0..pages {
            var i = CGFloat(n)
            var title = UILabel(frame: CGRect(x: width * i, y: 0.0, width: width, height: height))
//            var val = 0.05 * i + 0.8
//            title.backgroundColor = UIColor(red: val, green: val - 0.2, blue: val - 0.4, alpha: 1.0)
            title.textAlignment = NSTextAlignment.Center
            title.text = "Page \(n+1)"
            titleView.addSubview(title)
        }
    }
    
    // ScrollView Delegate
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        let sizeRatio: CGFloat = titleView.frame.size.width / scrollView.frame.size.width
        titleView.contentOffset = CGPoint(x:scrollView.contentOffset.x * sizeRatio, y:titleView.contentOffset.y)
    }
}

