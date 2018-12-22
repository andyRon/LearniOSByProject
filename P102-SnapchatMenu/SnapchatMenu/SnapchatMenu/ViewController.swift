//
//  ViewController.swift
//  SnapchatMenu
//
//  Created by andyron<http://andyron.com> on 2018/6/7.
//  Copyright © 2018年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    enum VCName: String {
        case chat = "ChatViewVC"
        case stories = "StoriesVC"
        case discover = "DiscoverVC"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加三个控制器到当前控制器中，构成父子控制器关系
        let chatVC = UIViewController(nibName: VCName.chat.rawValue, bundle: nil)
        let storiesVC = UIViewController(nibName: VCName.stories.rawValue, bundle: nil)
        let discoverVC = UIViewController(nibName: VCName.discover.rawValue, bundle: nil)
        add(childVC: chatVC, parentVC: self)
        add(childVC: storiesVC, parentVC: self)
        add(childVC: discoverVC, parentVC: self)
        
        let snapImageView = UIImageView(image: UIImage(named: "Snap"))
        changeX(ofView: snapImageView, xPostion: view.frame.width)
        scrollView.addSubview(snapImageView)
        
        changeX(ofView: storiesVC.view, xPostion: view.frame.width * 2)
        changeX(ofView: discoverVC.view, xPostion: view.frame.width * 3)
        
        // 设置scrollView的内容大小
        scrollView.contentSize = CGSize(width: view.frame.width * 4, height: view.frame.height)
        // 设置内容偏移位置，也就是开始在那个页面
        scrollView.contentOffset.x = view.frame.width * 2
        
    }

    func add(childVC: UIViewController, parentVC: UIViewController) {
        self.addChildViewController(childVC)
        scrollView.addSubview(childVC.view)
        childVC.didMove(toParentViewController: parentVC)
    }
    // 设置给定View在父页面中位置
    func changeX(ofView view: UIView, xPostion: CGFloat) {
        var frame = view.frame
        frame.origin.x = xPostion
        view.frame = frame
    }

}

