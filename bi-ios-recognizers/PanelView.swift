//
//  PanelView.swift
//  bi-ios-recognizers
//
//  Created by Dominik Vesely on 03/11/15.
//  Copyright © 2015 Ackee s.r.o. All rights reserved.
//

import Foundation
import UIKit


class PanelView : UIView {
    
    var delegate : PanelViewDelegate?
    //var onSliderChange : ((CGFloat) -> ())?
        
    weak var slider : UISlider!
    weak var stepper : UIStepper!
    weak var sControl: UISegmentedControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGray
        
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.addTarget(self, action: #selector(PanelView.sliderChanged(_:)), for: UIControlEvents.valueChanged)
        
        addSubview(slider)
        self.slider = slider
        
        let stepper = UIStepper()
        stepper.minimumValue = 0;
        stepper.maximumValue = 100;
        stepper.stepValue = 1;
        stepper.value = 0;
        stepper.addTarget(self, action: #selector(PanelView.stepperChanged(_:)),
            for: UIControlEvents.valueChanged)
        
        
        addSubview(stepper)
        self.stepper = stepper
        
        let sControl = UISegmentedControl()
        sControl.insertSegment(withTitle: "Red", at: 0, animated: true)
        sControl.insertSegment(withTitle: "Green", at: 1, animated: true)
        sControl.insertSegment(withTitle: "Blue", at: 2, animated: true)
        sControl.insertSegment(withTitle: "Yellow", at: 3, animated: true)
        sControl.selectedSegmentIndex = 0
        
        sControl.addTarget(self, action: #selector(PanelView.segmentedControlChanged(_:)),
                          for: UIControlEvents.valueChanged)
        
        
        addSubview(sControl)
        self.sControl = sControl
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.slider.frame = CGRect(x: 8, y: 8, width: self.bounds.width - 16, height: 44);
        self.stepper.frame = CGRect(x: 8, y: 8 + 44+8, width: (self.bounds.width - 16) / 2, height: 44);
        self.sControl.frame = CGRect(x: 8, y: 8 + 44+8 + 44+8, width: self.bounds.width - 16, height: 44);
        
    }
    
    func sliderChanged(_ slider : UISlider) {
        //if let onSliderChange = self.onSliderChange {
        //    onSliderChange(CGFloat(slider.value))
        //} else {
        //    print ("Nastav funkci nebo se nebude dit nic!")
        //}
        delegate?.sliderDidChange(slider, panel: self)
    }
    
    func stepperChanged(_ stepper: UIStepper) {
        delegate?.stepperDidChange(stepper, panel: self)
    }
    
    func segmentedControlChanged(_ sControl: UISegmentedControl) {
        delegate?.segmentedControlDidChange(sControl, panel: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol PanelViewDelegate {
    
    
    func sliderDidChange(_ slider : UISlider, panel:PanelView)
    func stepperDidChange(_ stepper : UIStepper, panel:PanelView)
    func segmentedControlDidChange(_ sControl : UISegmentedControl, panel:PanelView)
    
}
