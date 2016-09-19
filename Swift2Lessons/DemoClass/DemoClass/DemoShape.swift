//
//  DemoShape.swift
//  DemoClass
//
//  Created by techmaster on 8/22/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

import UIKit

class DemoShape: GenericVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.demoShape()
        self.demoRectangle()
        self.demoSquare()
        self.demoTriangle()
    }

    func demoShape() {
        let shape = Shape(numberOfSides: 3, name: "Triangle")
        self.inRa("\(shape.name) has \(shape.numberOfSides) sides")
        
        shape.printDescription()
        
        self.inRa("\(shape.description)")
    }
    
    func demoRectangle() {
        let rec = Rectangle(width: 10, height: 15)
        self.inRa("\(rec.name) has area = \(rec.area()) and perimeter = \(rec.perimeter())")
    }
    
    func demoSquare() {
        let square = Square(width: 15)
        self.inRa("\(square.name) has area = \(square.area()) and perimeter = \(square.perimeter())")
    }
    
    func demoTriangle() {
        let tri = Triangle(a: 10, b: 12, c: 14)
        self.inRa("\(tri.name) has area = \(tri.area()) and perimeter = \(tri.perimeter())")
    }
    
    func demoIdenticalOperator() {
        let tri1 = Triangle(a: 10, b: 12, c: 14)
        let tri2 = Triangle(a: 10, b: 12, c: 14)
        
    }
}
