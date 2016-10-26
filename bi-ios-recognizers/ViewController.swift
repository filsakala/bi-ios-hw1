//
//  ViewController.swift
//  bi-ios-recognizers
//
//  Created by Dominik Vesely on 03/11/15.
//  Copyright © 2015 Ackee s.r.o. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PanelViewDelegate {
    
    weak var graphView : GraphView!
    weak var panelView : PanelView!
    
    var center : CGPoint = CGPoint(x: 0,y: 0)

    
    override func loadView() {
        self.view = UIView()
        view.backgroundColor = .white
        
        let gv = GraphView(frame: CGRect.zero)
        gv.autoresizingMask = UIViewAutoresizing.flexibleWidth;
        
        self.view.addSubview(gv)
        self.graphView = gv
        
        let pv = PanelView(frame: CGRect.zero)
        pv.autoresizingMask = UIViewAutoresizing.flexibleWidth;
        pv.delegate = self
        
        //pv.onSliderChange = { [weak self]  (value : CGFloat) in
        //    self?.graphView.amplitude = value
        //}
        
        view.addSubview(pv)
        panelView = pv
    }
    
    //MARK: PanelViewDelegate
    func sliderDidChange(_ slider: UISlider, panel: PanelView) {
       self.graphView.amplitude = CGFloat(slider.value);
        
    }
    
    func stepperDidChange(_ stepper: UIStepper, panel: PanelView) {
        self.graphView.period = CGFloat(stepper.value);
        
    }
    
    func segmentedControlDidChange(_ sControl : UISegmentedControl, panel:PanelView) {
        switch sControl.selectedSegmentIndex {
        case 0:
            self.graphView.graphColor = UIColor.red.cgColor
        case 1:
            self.graphView.graphColor = UIColor.green.cgColor
        case 2:
            self.graphView.graphColor = UIColor.blue.cgColor
        case 3:
            self.graphView.graphColor = UIColor.yellow.cgColor
        default:
            self.graphView.graphColor = UIColor.red.cgColor
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.graphView.frame = CGRect(x: 8, y: 20 + 8, width: self.view.bounds.width - 16, height: 200);
        self.panelView.frame = CGRect(x: 8, y: 20 + 16 + 200, width: self.view.bounds.width - 16, height: 178);
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapReco = UITapGestureRecognizer(target: self,
            action: #selector(ViewController.tapReco(_:)))
        tapReco.numberOfTapsRequired = 1
        tapReco.numberOfTouchesRequired = 1
        
        let doubleTapReco = UITapGestureRecognizer(target: self,
            action: #selector(ViewController.doubleTapReco(_:)))
        doubleTapReco.numberOfTapsRequired = 2
        
        tapReco.require(toFail: doubleTapReco)
        
        self.view.addGestureRecognizer(doubleTapReco)
        self.view.addGestureRecognizer(tapReco)
        
        let panReco = UIPanGestureRecognizer(target: self
            , action: #selector(ViewController.pan(_:)))
        graphView.addGestureRecognizer(panReco);
        
        
    }
    
    func tapReco(_ reco : UITapGestureRecognizer) {
       // print(reco.view)
        print("tapped")
    }
    
    func doubleTapReco(_ reco : UITapGestureRecognizer) {
        
        print("Double tapped")
    }
    
    func pan(_ reco : UIGestureRecognizer) {
        let point = reco.location(in: self.graphView)
        
        switch(reco.state) {
        case .began: break;
        case .changed:
            self.graphView.offset = point.y
            self.graphView.xoffset = point.x
        default:
            return
    }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

