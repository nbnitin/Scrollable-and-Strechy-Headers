//
//  CustomView.swift
//  TTT
//
//  Created by Nitin Bhatia on 12/03/22.
//

import UIKit
@IBDesignable
class CustomNavBar: UIView{
    
    
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        let view = Bundle.main.loadNibNamed("CustomNavBar", owner: self, options: nil)?[0] as! UIView
        addSubview(view)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth,.flexibleTopMargin]
        contentView.backgroundColor = .clear
    }
    
    
}
