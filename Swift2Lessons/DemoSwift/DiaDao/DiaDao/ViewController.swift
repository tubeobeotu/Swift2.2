//
//  ViewController.swift
//  DiaDao
//
//  Created by Tuuu on 5/23/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit
struct ToaDo
{
    var h: Int
    var c: Int
}
class ViewController: UIViewController {
    var huong = [ToaDo(h:-1, c:0), ToaDo(h:0, c:1), ToaDo(h:1, c:0), ToaDo(h:0, c:-1)]
    var map = Array(count: 111, repeatedValue: Array(count: 111, repeatedValue:""))
    var mapVisited = [ToaDo]()
    var check = 0
    var hgDi = 0
    var nHang = 0
    var nCot = 0
    var route:[Character] = ["S", "S"]
    var index = 0
    var rowStart = 0
    var colStart = 0
    var blockWidth = 30
    var margin:CGFloat = 20
    var spaceBetweenBlock = 4
    @IBOutlet weak var txt_Route: UITextField!
    var imgv_robot: CustomView!
    @IBOutlet weak var btn_action: UIButton!
    var checkStart = false
    func getHuong(c: String, preHg: Int) -> Int {
        if (c == "N")
        {
            return 0
        }
        if (c == "E")
        {
            return 1
        }
        if (c == "S")
        {
            return 2
        }
        return 3
    }
    
    func input()
    {
        currentCountTest = currentCountTest + 1
        nHang = Int(myStrings[currentCountTest])!
        currentCountTest = currentCountTest + 1
        nCot = Int(myStrings[currentCountTest])!
        for i in 0..<nHang
        {
            for j in 0..<nCot
            {
                currentCountTest = currentCountTest + 1
                let c = myStrings[currentCountTest]
                map[i][j] = c
                
            }
        }
        for i in 0..<nHang
        {
            for j in 0..<nCot
            {
                print("\(map[i][j])", terminator: "")
            }
            print("")
        }
    }
    func isOutSide(h: Int, c: Int) -> Bool {
        if (h > nHang - 1 || h < 0) {
            return true
        }
        if (c > nCot - 1 || c < 0)
        {
            return true
        }
        return false
    }
    func doMove(robot: ToaDo, hg: Int) -> ToaDo
    {
        var nH = robot.h
        var nC = robot.c
        
        nH = nH + huong[hg].h
        nC = nC + huong[hg].c
        //Kiểm tra có di chuyên ra ngoài hay không
        if (isOutSide(nH, c: nC))
        {
            print("Bạn đã di chuyển ra ngoài")
            return robot
        }
        if (map[nH][nC] == "*")
        {
            print("Bạn đã gặp tường")
            return robot
        }
        let newRobot = ToaDo(h: nH, c: nC)
        return newRobot
    }
    func solve()
    {
        mapVisited = [ToaDo]()
        index = 0
        var robot  = ToaDo(h: rowStart, c: colStart)
        for i in 0..<route.count
        {
            hgDi = getHuong(String(route[i]), preHg: hgDi)
            mapVisited.append(ToaDo(h: robot.h, c: robot.c))
            robot = doMove(robot, hg: hgDi)
        }
        mapVisited.append(ToaDo(h: robot.h, c: robot.c))
        print(robot)
    }
    var currentCountTest = Int()
    var myStrings = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let fileURL = NSBundle.mainBundle().URLForResource("input", withExtension: "inp")
            else
        {
            return
        }
        if let content = try? String(contentsOfURL: fileURL, encoding: NSUTF8StringEncoding)
        {
            myStrings = content.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            currentCountTest = -1
            input()
            addView()
        }
    }
    func run()
    {
        solve()
    }
    func simulator()
    {
        
        UIView.animateWithDuration(1, animations: {
            self.imgv_robot.frame.origin = CGPointMake(CGFloat(self.mapVisited[self.index].c*self.blockWidth) + CGFloat(self.spaceBetweenBlock*self.mapVisited[self.index].c) + self.margin, CGFloat(self.mapVisited[self.index].h*self.blockWidth) + CGFloat(self.spaceBetweenBlock*self.mapVisited[self.index].h) + self.margin)
            
            }, completion: { (finished) in
                if (self.index == self.mapVisited.count - 1)
                {
                    return
                }
                self.index = self.index + 1
                self.simulator()
        })
        
    }
    func addView()
    {
        for i in 0..<nHang
        {
            for j in 0..<nCot
            {
                let customView = CustomView.init(frame: CGRectMake(CGFloat(j * 30) + CGFloat(4*j) + 20, CGFloat(i * 30) + CGFloat(4*i) + 20, 30, 30), value: map[i][j])
                self.view.addSubview(customView)
            }
            print("")
        }
    }
    @IBAction func action_Run(sender: NSObject) {
        route = [Character](txt_Route.text!.characters)
        if (!checkStart)
        {
            checkStart = true
            txt_Route.text = ""
            rowStart = 0
            colStart = 0
            colStart = Int(String(route[0]))!
            if (imgv_robot != nil)
            {
                self.imgv_robot.removeFromSuperview()
            }
            imgv_robot = CustomView.init(frame: CGRectMake(CGFloat(colStart * 30) + CGFloat(4*colStart) + 20, CGFloat(rowStart * 30) + CGFloat(4*rowStart) + 20, 30, 30), value: "!")
            btn_action.setTitle("Tìm kiếm", forState: .Normal)
            self.view.addSubview(imgv_robot)
        }
        else
        {
            run()
            simulator()
            txt_Route.text = ""
            btn_action.setTitle("Ô bắt đầu", forState: .Normal)
            checkStart = false
        }
    }
}

