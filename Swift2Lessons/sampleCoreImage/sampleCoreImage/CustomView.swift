//
//  CustomView.swift
//  sampleCoreImage
//
//  Created by CanDang on 12/30/15.
//  Copyright © 2015 CanDang. All rights reserved.
//

import UIKit
protocol ParameterAdjustmentDelegate {
    func parameterValueDidChange(param: ObjectPara)
}
class CustomView: UIView {
    @IBOutlet var view: UIView!

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var slider: UISlider!
    var parameter: ObjectPara!
    var delegate: ParameterAdjustmentDelegate?
    init(frame: CGRect, parameter: ObjectPara) {
        super.init(frame: frame)
        self.parameter = parameter
        loadViewFromNib()
        addValue()
    }
    func addValue() {
        slider.minimumValue = parameter.minimumValue!
        slider.maximumValue = parameter.maximumValue!
        slider.value = parameter.currentValue
        
        
        descriptionLabel.font = UIFont.boldSystemFontOfSize(14)
        descriptionLabel.textColor = UIColor(white: 0.9, alpha: 1.0)
        descriptionLabel.text = parameter.name
        
        
        
        value.font = UIFont.systemFontOfSize(14)
        value.textColor = UIColor(white: 0.9, alpha: 1.0)
        value.textAlignment = .Right
        value.text = slider.value.description
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadViewFromNib()
    }
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CustomView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(view);
        
    }
    @IBAction func sliderValueDidChange(sender: AnyObject?) {
        value.text = String(format: "%0.2f", slider.value)
    }
    
    @IBAction func sliderTouchUpInside(sender: AnyObject?) {
        if delegate != nil {
            delegate!.parameterValueDidChange(ObjectPara(key: parameter.key, value: slider.value))
        }
    }
}
