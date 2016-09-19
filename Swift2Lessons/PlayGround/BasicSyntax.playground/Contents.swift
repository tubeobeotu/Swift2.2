//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

print(str)

let listOfNums = 1...5
var sum = 0
for num in listOfNums {
    sum += num
}

print(sum)

var famousPeople = ["Martin Lutherking", "Mike Tyson", "Anna Conda"]
for person in famousPeople {
    print("-",  person)
}

for var i = 0; i < famousPeople.count; i++ {
    print(" ", famousPeople[i])
}

for i in 0..<famousPeople.count{
    print(i)
}

famousPeople.append("Queen")

//Array if
var shoppingList: [String]  = []
shoppingList.append("Banana")
if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}

//Define class
class Car : CustomStringConvertible {
    var model : String = ""
    init (model: String) {
        self.model = model
    }
    
    var description: String {
        return self.model
    }

}
//create object
let ford = Car(model: "T40")
print("x = \(ford)")

//Define function
func sayHello(personName: String) -> String {
    let greeting = "Hello, " + personName + "!"
    return greeting
}
print(sayHello("Cuong"))

//Enum
enum CompassPoint {
    case North
    case South
    case East
    case West
}
var direction: CompassPoint
direction = CompassPoint.East
print(direction)
enum State : String {
    case SLEEP = "sleep",
    AWAKE = "awake",
    DRUNK = "drunk"
}

var humanState: State
humanState = State.AWAKE
print(humanState)





