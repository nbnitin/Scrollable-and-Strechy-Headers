//
//  StrechyHeaderView.swift
//  YTScrollableBarUIKit
//
//  Created by Nitin Bhatia on 16/03/22.
//

import UIKit

class StrechyHeaderView : UIView {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imgHeader: UIImageView!
    
    @IBOutlet weak var bluredView: UIVisualEffectView!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        let view = Bundle.main.loadNibNamed("StrechyHeaderView", owner: self, options: nil)?[0] as! UIView
        addSubview(view)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth,.flexibleTopMargin]
        contentView.backgroundColor = .clear
    }
    
    func resetView() {
        lblTitle.alpha = 1
        bluredView.alpha = 0
    }
}
