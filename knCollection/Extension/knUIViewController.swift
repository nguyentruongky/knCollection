//
//  UIViewController.swift
//  kLibrary
//
//  Created by Ky Nguyen on 8/27/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit


extension UIViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        _ = info[UIImagePickerControllerOriginalImage] as! UIImage
        dismiss(animated: true, completion: nil)
    }
    
    func pickImageFromPhotoLibrary() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func enabledView(_ enabled: Bool) {
        view.isUserInteractionEnabled = enabled
    }
    
    func createFakeBackButton() -> [UIBarButtonItem] {
        
        let height: CGFloat = 36
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: height))
        let image = UIImage(named: "back_arrow")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 36, height: height)
        backView.addSubview(imageView)
        let content = UILabel()
        content.text = ""
        content.sizeToFit()
        content.frame.size = CGSize(width: content.frame.size.width, height: height)
        content.frame.origin = CGPoint(x: 30, y: 0)
        backView.addSubview(content)
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: height))
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backView.addSubview(button)
        
        let barButton = UIBarButtonItem(customView: backView)
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -20
        
        return [negativeSpacer, barButton]
    }
    
    func addFakeBackButton() {
        guard let count = navigationController?.viewControllers.count else { return }
        guard count >= 2 else { return }
        let buttons = createFakeBackButton()
        navigationItem.leftBarButtonItems = buttons
    }
    
    func goBack() {
        dismiss(animated: true, completion: nil)
    }
}

extension UITableViewController {
    
    func animateTable() {
        
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableHeight = tableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        var index = 0
        for cell in cells {
            UIView.animate(withDuration: 1.25, delay: 0.05 * Double(index),
                                       usingSpringWithDamping: 0.65,
                                       initialSpringVelocity: 0.0,
                                       options: UIViewAnimationOptions(),
                                       animations:
                {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                },
                                       completion: nil)
            
            index += 1
        }
    }
}

extension UITabBarController {
    
    func setTabBar(visible: Bool) {
        tabBar.frame.size.height = visible ? 49 : 0
        tabBar.isHidden = !visible
    }
}


