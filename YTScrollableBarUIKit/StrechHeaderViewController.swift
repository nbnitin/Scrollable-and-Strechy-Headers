//
//  StrechHeaderViewController.swift
//  YTScrollableBarUIKit
//
//  Created by Nitin Bhatia on 16/03/22.
//

import UIKit

class StrechHeaderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var strechyHeaderView : StrechyHeaderView!
    var defaultHeaderFrame : CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        strechyHeaderView = StrechyHeaderView(frame: view.frame)
        strechyHeaderView.frame.size.height = 300
        strechyHeaderView.backgroundColor = .red
        defaultHeaderFrame = strechyHeaderView.frame
        tableView.tableHeaderView = strechyHeaderView

        // Do any additional setup after loading the view.
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
        cell.layer.cornerRadius = 5
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .cyan
        } else {
            cell.backgroundColor = .lightGray
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        var frame = strechyHeaderView.imgHeader.frame
        let header : StrechyHeaderView = self.strechyHeaderView
        
        
        if offset.y == -47 {
            strechyHeaderView.resetView()
            return
        }
        
        if (offset.y > 0)
        {
            frame.origin.y = max(offset.y * 0.5, 0)
            strechyHeaderView.imgHeader.frame = frame;
            strechyHeaderView.bluredView.alpha =   1 / defaultHeaderFrame.size.height * offset.y * 2;
            strechyHeaderView.clipsToBounds = true
            header.frame = frame
        } else {
            var delta = 0.0
            var rect = defaultHeaderFrame
            delta = fabs(min(0.0, offset.y))
            rect?.origin.y -= delta
            rect?.size.height += delta
            strechyHeaderView.imgHeader.frame = rect!
            strechyHeaderView.clipsToBounds = false
            strechyHeaderView.lblTitle.alpha = 1 - (delta) * 1 / 100;
            header.frame = rect!
        }
       header.layoutMargins.top = scrollView.contentOffset.y
        tableView.tableHeaderView = strechyHeaderView
    }
}
