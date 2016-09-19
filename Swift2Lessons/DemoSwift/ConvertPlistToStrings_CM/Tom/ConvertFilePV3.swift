/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
func convertPlistToStrings(path:NSString)
{
  guard let array = NSArray(contentsOfFile: path as String )
    else
  {
    return
  }
  
  var content = ""
  for dict in array
  {
    
    for key in dict.allKeys
    {
      if let subArray = dict.valueForKey(key as! String) as? NSArray {
        content = content + "-\(key)\n"
        for value in subArray {
          content = content + "+\(value)\n"
        }
      }
      else
      {
        if let value =  dict.valueForKey(key as! String) {
          content = content + "-\(key)\n+\(value)\n"
        }
        
      }
    }
    content = content + "\n-------\n"
    
    
    //this path to your desktop
    //(fileName).strings is file name after converting
    let newPath = path.stringByDeletingPathExtension + ".strings"
    do
    {
      try content.writeToFile(newPath, atomically: false, encoding: NSUTF8StringEncoding);
    }
    catch let error as NSError
    {
      print("Error:" + error.localizedDescription)
    }
    
  }
}
func convertStringsToPlist(path: NSString)
{
  var nsstringContent = ""
  do
  {
    try nsstringContent = NSString(contentsOfFile: path as String, encoding: NSUTF8StringEncoding) as String
  }
  catch let error as NSError
  {
    print("Error:" + error.localizedDescription)
  }
  let array = nsstringContent.componentsSeparatedByString("\n-------\n")
  var arrayPlist = [NSMutableDictionary]();
  for value in array
  {
    let dictData = NSMutableDictionary()
    if value.characters.count > 1{
      let aDict = value.componentsSeparatedByString("\n")
      var key = ""
      var valuesArray = [String]()
      for data in aDict
      {
        if (data.characters.first == "-") {
          let index = data.startIndex.advancedBy(1)
          if (valuesArray.count > 0) {
            if valuesArray.count == 1 {
              dictData.setValue(valuesArray.first!, forKey: key)
            }
            else
            {
              dictData.setValue(valuesArray, forKey: key)
            }
            valuesArray = [String]()
          }
          key = data.substringFromIndex(index)
        }
        if (data.characters.first == "+") {
          let index = data.startIndex.advancedBy(1)
          valuesArray.append(data.substringFromIndex(index))
        }
      }
      if (key.characters.count > 1 && valuesArray.count > 0) {
        if valuesArray.count == 1 {
          dictData.setValue(valuesArray.first!, forKey: key)
        }
        else
        {
          dictData.setValue(valuesArray, forKey: key)
        }
        valuesArray = [String]()
      }
      arrayPlist.append(dictData)
    }
    
  }
  let arrayToWrite = NSArray(array: arrayPlist)
  ///Users/dangcan/Desktop/\(fileName).plist is the path after the .strings file convert completely with name is (fileName).plist
  let newPath = path.stringByDeletingPathExtension + ".plist"
  arrayToWrite.writeToFile(newPath, atomically: true)
}
if Process.argc == 3 {
  let option = Process.arguments[1]
  if (option == "-p")
  {
    convertPlistToStrings(Process.arguments[2])
  }
  if (option == "-s")
  {
    convertStringsToPlist(Process.arguments[2])
  }
}
