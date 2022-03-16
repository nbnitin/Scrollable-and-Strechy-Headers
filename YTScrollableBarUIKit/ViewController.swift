//
//  ViewController.swift
//  YTScrollableBarUIKit
//
//  Created by Nitin Bhatia on 16/03/22.
//

import UIKit

extension UIViewController {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var customMenuTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var customNavTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var customNavHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customNavBar: CustomNavBar!
    @IBOutlet weak var statusBarHeightConstraint: NSLayoutConstraint!
    
    var defaultHeaderFrame : CGRect!
    var oldContentOffset : CGFloat = 0
    var currentContentOffset : CGFloat = 0
    var isStatusBarViewAdded : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        defaultHeaderFrame = customNavBar.frame
        tableView.contentInset.top = 80
        tableView.verticalScrollIndicatorInsets.top = 80
       // statusBarHeightConstraint.constant = view.window.keyWi view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 40
        
        statusBarHeightConstraint.constant = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    
    private func setupConstraintForStatusBarView() {
        if !isStatusBarViewAdded {
            let statusBarView = UIView(frame: .zero)
            statusBarView.backgroundColor = .red
            view.addSubview(statusBarView)
           
            statusBarView.translatesAutoresizingMaskIntoConstraints = false
            statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
            statusBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
            statusBarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            statusBarView.heightAnchor.constraint(equalToConstant: view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0).isActive = true
            isStatusBarViewAdded = true
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = "\(indexPath.row)"
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .blue
            cell.textLabel?.textColor = .white
        } else {
            cell.backgroundColor = .yellow
            cell.textLabel?.textColor = .black
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    
        let offset = scrollView.contentOffset
        
        if  tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height)  {
            print("reached at bottom")
            return
        }
        
        if Int(offset.y) <= Int(-customNavHeightConstraint.constant) {
            print("reached at top")
            customNavBar.frame.origin.y = defaultHeaderFrame.origin.y
            return
        }

        if (oldContentOffset > offset.y)
        {
            self.edgesForExtendedLayout = .all
            if customNavBar.frame.origin.y < defaultHeaderFrame.origin.y {
                customNavBar.frame.origin.y -= (scrollView.contentOffset.y - oldContentOffset)
            } else {
                customNavBar.frame.origin.y = defaultHeaderFrame.origin.y
            }
           // self.bluredImageView.alpha =   1 / kDefaultHeaderFrame.size.height * offset.y * 2;
            customNavBar.clipsToBounds = true
        } else {
            self.edgesForExtendedLayout = UIRectEdge()
            var delta : CGFloat = 0.0
            var rect = customNavBar.frame
            delta = max(offset.y * 0.5, 0)
            rect.origin.y -= delta
           // rect!.size.height += delta;
            if customNavBar.frame.origin.y > -(navigationController!.navigationBar.frame.height) {
                customNavBar.frame.origin.y -= (scrollView.contentOffset.y - oldContentOffset)
               
            } else {
                customNavBar.frame.origin.y = -(customNavHeightConstraint.constant)
            }
            customNavBar.clipsToBounds = false
        }
        
        oldContentOffset = scrollView.contentOffset.y
    }
    
}

