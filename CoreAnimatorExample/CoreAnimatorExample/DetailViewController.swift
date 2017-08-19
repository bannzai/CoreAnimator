//
//  DetailViewController.swift
//  KaeruDemo
//
//  Created by Hirose.Yudai on 2016/08/30.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import UIKit
import CoreAnimator

internal extension UIImage {
    func blur(_ radius: CGFloat) -> UIImage {
        guard let cgImage = cgImage,
            let filteredImage = Optional(CoreImage.CIImage(cgImage: cgImage)),
            let blurFilter = CIFilter(name: "CIGaussianBlur")
            else {
                return self
        }
        
        blurFilter.setDefaults()
        blurFilter.setValue(filteredImage, forKey: kCIInputImageKey)
        blurFilter.setValue(radius, forKey: kCIInputRadiusKey)
        
        guard let cropFilter = CIFilter(name: "CICrop") else {
            return self
        }
        
        cropFilter.setValue(blurFilter.outputImage, forKey: kCIInputImageKey)
        cropFilter.setValue(CIVector(cgRect: filteredImage.extent), forKey: "inputRectangle")
        
        guard let outputImage = cropFilter.outputImage else {
            return self
        }
        
        return UIImage(ciImage: outputImage)		
    }		
}		




class DetailViewController: UIViewController {
    class func instance() -> DetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        return viewController
    }
    
    var image: UIImage?
    var blurImage: UIImage?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        
        label.text = [
            "Now is \(navigationController!.viewControllers.count)th page.",
            "You can press [ShowList] or [ShowHistory] buttons",
            "When [ShowList] pressed, push to List ViewController ",
            "When [ShowHistory] pressed, see the history of snapshot about ViewController from UINavigationController.viewControllers stack.",
            "And you can tap ViewController, when close history and return in choose ViewController.",
            ]
            .reduce("")
            { $0 + $1 + "\n" }
        
        setupBlurImagesInBackground()
    }
    
    
    @IBAction func animationButtonPressed(_ sender: Any) {
        let imageViewOriginSize = imageView.frame.size
        SequenceAnimator()
            .add(
                duration: 0.3,
                view: imageView,
                options: .curveEaseInOut) {
                    $0.frame.size = CGSize(width: imageViewOriginSize.width / 2, height: imageViewOriginSize.height / 2)
            }
            .add(
                duration: 0.3,
                view: imageView,
                options: .curveEaseInOut) {
                    $0.frame.size = CGSize(width: imageViewOriginSize.width, height: imageViewOriginSize.height)
            }
            .add(
                duration: 1,
                layer: view.layer,
                options: .easeInOut,
                keyPath: KeyPathValueType.cornerRadius.self,
                fromValue: 0,
                toValue: 100
            )
            .addCompletion {
                print("end")
            }
            .animate()
    }
    
    fileprivate func setupBlurImagesInBackground() {
        DispatchQueue.global().async {
            let blurImage = self.image?.blur(10)
            DispatchQueue.main.async {
                self.blurImage = blurImage
            }
        }
    }
}
