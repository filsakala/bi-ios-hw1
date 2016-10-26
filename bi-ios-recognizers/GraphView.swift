//
//  GraphView.swift
//  bi-ios-recognizers
//
//  Created by Dominik Vesely on 03/11/15.
//  Copyright © 2015 Ackee s.r.o. All rights reserved.
//

import Foundation
import UIKit

class GraphView : UIView {
    weak var label: UILabel!
    
    var amplitude : CGFloat = 40.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var period : CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var offset : CGFloat! = 0   {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var xoffset : CGFloat! = 0   {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var graphColor : CGColor = UIColor.red.cgColor   {
        didSet {
            setNeedsDisplay()
        }
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        offset = self.bounds.height / 2.0
        xoffset = self.bounds.width / 2.0
        
        self.label.frame = CGRect(x: 8, y: 8, width: self.bounds.width - 16, height: 44);

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        
        let label = UILabel()
        label.text =  "y=\(amplitude)*sin(\(period)*x + \(offset))"
        addSubview(label)
        self.label = label
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        self.label.text =  "y=\(String(format: "%.0f", amplitude))*sin(\(String(format: "%.0f", period))*x + \(String(format: "%.0f", xoffset))) + \(String(format: "%.0f", -offset))"
        
        super.draw(rect)
        var context = UIGraphicsGetCurrentContext();
        context?.setStrokeColor(graphColor);
        context?.setLineWidth(2);
        context?.move(to: CGPoint(x: 0, y: offset));
        
        let range = 0 ..< Int(frame.width)
        for i in range {
            let x = CGFloat(i)
            let y = self.amplitude * sin(x/frame.width * period * 2 * CGFloat(M_PI) - xoffset) + offset
            context?.addLine(to: CGPoint(x: x, y: y));
        }
        //CGContextSetLineJoin(context, CGLineJoin.Bevel)
        //CGContextSetLineCap(context, CGLineCap.Round)
        context?.strokePath();
        
        context = UIGraphicsGetCurrentContext();
        context?.setStrokeColor(UIColor.black.cgColor);
        context?.setLineWidth(2);
        context?.move(to: CGPoint(x: xoffset - 10, y: offset));
        context?.addLine(to: CGPoint(x: xoffset + 10, y: offset));
        context?.strokePath();
        
        context = UIGraphicsGetCurrentContext();
        context?.setStrokeColor(UIColor.black.cgColor);
        context?.setLineWidth(2);
        context?.move(to: CGPoint(x: xoffset, y: offset - 10));
        context?.addLine(to: CGPoint(x: xoffset, y: offset + 10));
        context?.strokePath();
    }
}
    
  
