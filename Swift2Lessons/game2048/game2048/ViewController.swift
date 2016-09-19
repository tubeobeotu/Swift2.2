//
//  ViewController.swift
//  game2048
//
//  Created by CanDang on 1/6/16.
//  Copyright © 2016 CanDang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var b = Array(count: 4, repeatedValue: Array(count: 4, repeatedValue: 0))
    
    @IBOutlet weak var score: UILabel!
    var lose = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let directions: [UISwipeGestureRecognizerDirection] = [.Right, .Left, .Up, .Down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: Selector("respondToSwipeGesture:"))
            gesture.direction = direction
            self.view.addGestureRecognizer(gesture)
        }
        randomNum(-1)
    }
    func randomNum(type: Int)
    {
        if (!lose)
        {
            switch(type)
            {
                case 0 : left()
                case 1 : right()
                case 2 : up()
                case 3 : down()
                default : break
            }
        }
        if (checkRandom())
        {
            var rnlableX  = arc4random_uniform(4)
            var rnlableY = arc4random_uniform(4)
            let rdNum = arc4random_uniform(2) == 0 ? 2 : 4;
            
            while (b[Int(rnlableX)][Int(rnlableY)] != 0)
            {
                rnlableX = arc4random_uniform(4)
                rnlableY = arc4random_uniform(4)
            }
            b[Int(rnlableX)][Int(rnlableY)] = rdNum
            let numlabel = 100 + (Int(rnlableX) * 4) + Int(rnlableY)
            ConvertNumLabel(numlabel, value: String(rdNum))
            transfer()
        }
        else if (checkLose())
        {
            lose = true
            let alert = UIAlertController(title: "Game Over", message: "You Lose", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    func changeBackColor(numlabel: Int, color: UIColor)
    {
        let label = self.view.viewWithTag(numlabel) as! UILabel
        label.backgroundColor = color
    }
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Left:
                randomNum(0)
            case UISwipeGestureRecognizerDirection.Right:
                randomNum(1)
            case UISwipeGestureRecognizerDirection.Up:
                randomNum(2)
            case UISwipeGestureRecognizerDirection.Down:
                randomNum(3)
            default:
                break
            }
        }
    }
    func transfer()
    {
        for (var i = 0; i < 4; i++)
        {
            for (var j = 0; j < 4; j++)
            {
                let numlabel = 100 + (i * 4) + j;
                ConvertNumLabel(numlabel, value: String(b[i][j]));
                switch(b[i][j])
                {
                case 2,4:changeBackColor(numlabel, color: UIColor.cyanColor())
                case 8,16:changeBackColor(numlabel, color: UIColor.greenColor())
                case 16,32:changeBackColor(numlabel, color: UIColor.orangeColor())
                case 64:changeBackColor(numlabel, color: UIColor.redColor())
                case 128,256,512:changeBackColor(numlabel, color: UIColor.yellowColor())
                case 1024,2048:changeBackColor(numlabel, color: UIColor.purpleColor())
                default: changeBackColor(numlabel, color: UIColor.brownColor())
                }
            }
        }
    }
    func ConvertNumLabel(numlabel: Int, let value: String)
    {
        let label = self.view.viewWithTag(numlabel) as! UILabel
        label.text = value
    }
    func up()
    {
        
        for (var col = 0; col < 4; col++)
        {
            var check = false
            for (var row = 1; row < 4; row++)
            {
                var tx = row
                if (b[row][col] == 0)
                {
                    continue;
                }
                for (var rowc = row - 1; rowc != -1; rowc--)
                {
                    if (b[rowc][col] != 0 && (b[rowc][col] != b[row][col] || check))
                    {
                        break
                    }
                    else
                    {
                        tx = rowc
                    }
                }
                if (tx == row)
                {
                    continue
                }
                if (b[row][col] == b[tx][col])
                {
                    check = true
                    GetScore(b[tx][col])
                    b[tx][col] *= 2
                }
                else
                {
                    b[tx][col] = b[row][col]
                }
                b[row][col] = 0;
            }
        }
    }
    func down()
    {
        for (var col = 0; col < 4;col++ )
        {
            var check = false
            for (var row = 0; row < 4; row++)
            {
                var tx = row
                
                if (b[row][col] == 0)
                {
                    continue
                }
                for (var rowc = row + 1; rowc < 4; rowc++)
                {
                    if (b[rowc][col] != 0 && (b[rowc][col] != b[row][col] || check))
                    {
                        break;
                    }
                    else
                    {
                        tx = rowc
                    }
                }
                if (tx == row)
                {
                    continue
                }
                if (b[tx][col] == b[row][col])
                {
                    check = true
                    GetScore(b[tx][col])
                    b[tx][col] *= 2
                    
                }
                else
                {
                    b[tx][col] = b[row][col]
                }
                b[row][col] = 0;
            }
        }
    }
    func left()
    {
        for(var row = 0; row < 4; row++)
        {
            var check = false
            for (var col = 1; col < 4; col++)
            {
                if (b[row][col] == 0)
                {
                    continue
                }
                var ty = col
                for (var colc = col - 1; colc != -1; colc--)
                {
                    if (b[row][colc] != 0 && (b[row][colc] != b[row][col] || check))
                    {
                        break
                    }
                    else
                    {
                        ty = colc
                    }
                }
                if (ty == col)
                {
                    continue;
                }
                if (b[row][ty] == b[row][col])
                {
                    check = true
                    GetScore(b[row][ty])
                    b[row][ty] *= 2
                    
                }
                else
                {
                    b[row][ty]=b[row][col]
                }
                b[row][col] = 0
                
            }
        }
    }
    func right()
    {
        for(var row = 0; row < 4; row++)
        {
            var check = false
            for (var col = 3; col != -1; col--)
            {
                if (b[row][col] == 0)
                {
                    continue
                }
                var ty = col
                for (var colc = col + 1; colc < 4; colc++)
                {
                    if (b[row][colc] != 0 && (b[row][colc] != b[row][col] || check))
                    {
                        break
                    }
                    else
                    {
                        ty = colc
                    }
                }
                if (ty == col)
                {
                    continue;
                }
                if (b[row][ty] == b[row][col])
                {
                    check = true
                    GetScore(b[row][ty])
                    b[row][ty] *= 2
                    
                }
                else
                {
                    b[row][ty] = b[row][col]
                }
                b[row][col] = 0
                
            }
        }
    }
    func GetScore(value: Int)
    {
        score.text = String(Int(score.text!)! + value)
    }
    func checkRandom() -> Bool
    {
        for  i in 0...3
        {
            for j in 0...3
            {
                if (b[i][j] == 0)
                {
                    return true
                }
            }
        }
        return false
    }
    func checkLose() -> Bool
    {
        for (var i = 0; i < 4; i++)
        {
            for (var j = 0; j < 4; j++)
            {
                if (b[i][j] != 0)
                {
                    if (i != 0 && j != 0 && i != 3 && j != 3)
                    {
                        if (b[i + 1][j] == b[i][j] || b[i - 1][j] == b[i][j] || b[i][j + 1] == b[i][j] || b[i][j - 1] == b[i] [j])
                        {
                            return false
                        }
                    }
                    else if (i == 0)
                    {
                        if (j == 0)
                        {
                            if (b[i + 1][j] == b[i][j] || b[i][j + 1] == b[i][j] )
                            {
                                return false
                            }
                        }
                        else if (j == 3)
                        {
                            if (b[i + 1][j] == b[i][j] || b[i][j - 1] == b[i][j])
                            {
                                return false
                            }
                        }
                        else
                        {
                            if (b[i + 1][j] == b[i][j] || b[i][j + 1] == b[i] [j] || b[i][j - 1] == b[i][j])
                            {
                                return false
                            }
                        }
                    }
                    else if (i == 3)
                    {
                        if (j == 0)
                        {
                            if (b[i - 1][j] == b[i][j] || b[i][j + 1] == b[i][j] )
                            {
                                return false
                            }
                        }
                        else if (j == 3)
                        {
                            if (b[i - 1][j] == b[i][j] || b[i][j - 1] == b[i][j])
                            {
                                return false
                            }
                        }
                        else
                        {
                            if (b[i - 1][j] == b[i][j] || b[i][j + 1] == b[i][j] || b[i][j - 1] == b[i][j])
                            {
                                return false
                            }
                        }
                    }
                    else if (j == 0)
                    {
                        if (i == 0)
                        {
                            if (b[i + 1][j] == b[i][j] || b[i][j + 1] == b[i][j] )
                            {
                                return false
                            }
                        }
                        else if (i == 3)
                        {
                            if (b[i - 1][j] == b[i][j] || b[i][j + 1] == b[i][j])
                            {
                                return false
                            }
                        }
                        else
                        {
                            if (b[i + 1][j] == b[i][j] || b[i - 1][j] == b[i][j] || b[i][j + 1] == b[i][j])
                            {
                                return false
                            }
                        }
                    }
                    else if (j == 3)
                    {
                        if (i == 0)
                        {
                            if (b[i + 1] [j] == b[i][j]  || b[i][j - 1] == b[i][j])
                            {
                                return false
                            }
                        }
                        else if (i == 3)
                        {
                            if (b[i - 1][j] == b[i][j] || b[i][j - 1] == b[i][j])
                            {
                                return false
                            }
                        }
                        else
                        {
                            if (b[i + 1][j] == b[i][j] || b[i - 1][j] == b[i][j]  || b[i][j - 1] == b[i][j])
                            {
                                return false;
                            }
                        }
                    }
                }
                
            }
        }
        return true;
    }
    
}

