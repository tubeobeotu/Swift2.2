//
//  DemoStruct.swift
//  DemoClass
//
//  Created by techmaster on 8/26/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

import UIKit
struct Resolution {
    var width = 0
    var height = 0
}
struct Point {
    var x: Int = 0
    var y: Int = 0
}

func == (lhs: Point, rhs: Point) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}
struct Size {
    var width: Int = 0
    var height: Int = 0
}
func == (lhs: Size, rhs: Size) -> Bool {
    return lhs.width == rhs.width && lhs.height == rhs.height
}
struct Rect {
    var origin: Point
    var size: Size
    var description: String {
        return "origin = \(origin.x)-\(origin.y), size = \(size.width)-\(size.height)"
    }
    func area() -> Int {
        return size.width * size.height
    }
}

func == (lhs: Rect, rhs: Rect) -> Bool {
    return lhs.origin == rhs.origin && lhs.size == rhs.size
}
class DemoStruct: GenericVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.demoStruct()
        self.demoStructByRef()
    }
    
    func demoStruct() {
        let rec = Rect(origin: Point(x:10,y:10), size: Size(width:100, height:200))
        
        self.inRa(rec.description)
        self.inRa("rec.area = \(rec.area())")
    }
    
    func demoStructByRef () {
        var rect = Rect(origin: Point(x:10,y:10), size: Size(width:100, height:200))
        self.inRa("Before: \(rect.description)")
        self.assignStructByRef(&rect)
        self.inRa("After: \(rect.description)")
        
        let rect2 = Rect(origin: Point(x:10,y:10), size: Size(width:100, height:200))
        
        let point1 = Point(x: 10, y: 11)
        let point2 = Point(x: 10, y: 12)
        
       
        if point1 == point2 {
            self.inRa("point1 == point2")
        } else {
            self.inRa("point1 != point2")
        }
        let rect3 = rect2
        if rect3 == rect2 {
             self.inRa("rect3 == rect2")
        }
    }
    func assignStructByRef(inout rect: Rect) {
        rect.origin = Point(x: -10, y: -15)
        rect.size = Size(width: 10, height: 20)
    }

}
