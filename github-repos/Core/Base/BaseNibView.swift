//
//  BaseNibView.swift
//  FYMMobil
//
//  Created by Burhan on 16.03.2020.
//  Copyright © 2020 Horizon. All rights reserved.
//

import UIKit

class BaseNibView: BaseView
{

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.addSelfFromNib()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.addSelfFromNib()
    }
    
    static func getViewWith(name: String, owner:Any?) -> UIView?
    {
        if let viewFromNib = UINib(nibName: name, bundle: nil).instantiate(withOwner: owner, options: nil).last as? UIView
        {
            return viewFromNib
        }
        
        return nil
    }
    
    func addSelfFromNib()
    {
        if let view = BaseNibView.getViewWith(name: self.nibName(), owner: self)
        {
            self.addFullSizeSubview(view: view)
        }
    }
    
    func nibName() -> String {
        return String(describing: type(of: self))
    }
}
