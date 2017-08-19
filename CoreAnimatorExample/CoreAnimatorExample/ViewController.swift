//
//  ViewController.swift
//  CoreAnimatorExample
//
//  Created by Yudai.Hirose on 2017/08/19.
//  Copyright © 2017年 廣瀬雄大. All rights reserved.
//

import UIKit
import CoreAnimator

class ViewController: UIViewController {

    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var yellowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
    }
    
    func tapped() {
        redView.alpha = 0
        
        SequenceAnimator()
            .add(duration: 1, view: redView) {
                $0.alpha = 1
            }
            .add(duration: 2, view: blueView) {
                $0.frame.origin = .zero
            }
            .add(
                duration: 1,
                layer: yellowView.layer,
                options: .easeInOut,
                keyPath: KeyPathValue.cornerRadius.self,
                fromValue: 0,
                toValue: 20
            )
            .addCompletion {
                print("end")
            }
            .animate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

