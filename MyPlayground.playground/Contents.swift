import Cocoa

var str = "Hello, playground"


/// Property observers
struct Temprature {
    var celcius: Double
    var tempFarenheat: Double {
        get {
           return (celcius * 9/5 + 32)
        }
        set(newFarenheatValue) {
            celcius = (newFarenheatValue - 32) * 5/9
        }
    }
}

var obj = Temprature(celcius: 0.0)
obj.tempFarenheat
obj.celcius

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

var step = StepCounter()
step.totalSteps = 10
step.totalSteps = 100

/********************************************************/

/// Error enum
enum PasswordValidationError: Error {
    case noCapitalletter
    case noNumber
    case notEnoughCharacter(length: Int)
}

class ErrorHandling {
    
    /// Handling errors internaly
    func callHandleErrorInternal() {
        handleErrorInternal(password: "asdasdasd")
    }
    
    /// Handling thrown error
    func callThrowError() {
        do {
            let notError = try throwError(password: "asd123asd")
            print(notError ? "Password success" : "Password failed")
        } catch PasswordValidationError.noCapitalletter {
            print("noCapitalletter")
        } catch PasswordValidationError.noNumber {
            print("noNumber")
        } catch PasswordValidationError.notEnoughCharacter(let length) {
            print(length)
        } catch {
            print("unexpected error")
        }
    }
    
    func treatErrorOptional() {
        let notError = try? throwError(password: "asd123asd")
        if notError == nil {
            print("Error thrown")
        } else {
            print("password success")
        }
    }
    
    /// Handling only specific error
    func callThrowUnExpectedError() {
        do {
            try throwUnExpectedError()
        } catch let error as NSError  {
            print(error)
        }
    }
    
    /// Throw only unexpected error and handle all other errors
    /// - Throws: throw only unexpected error
    /// - Returns: password strength
    func throwUnExpectedError() throws -> Bool {
        do {
            throw NSError(domain: "com.test.error", code: 401, userInfo: ["error":"UnExpectedError"])
        } catch PasswordValidationError.noCapitalletter {
            print("noCapitalletter")
            return false
        } catch PasswordValidationError.noNumber {
            print("noNumber")
            return false
        } catch PasswordValidationError.notEnoughCharacter(let length) {
            print(length)
            return false
        }
    }
    
    /// Throw errors
    /// - Parameter password: password
    /// - Throws: throw errors
    /// - Returns: password strength
    func throwError(password: String) throws -> Bool {
        if password == "asd123asd" {
            throw PasswordValidationError.noCapitalletter
        } else if password == "asdasdasd" {
            throw PasswordValidationError.noNumber
        } else if password == "asd" {
            throw PasswordValidationError.notEnoughCharacter(length: 4)
        } else {
            return true
        }
    }
    
    /// Handle error internally not throw error
    /// - Parameter password: password
    /// - Returns: password strength
    func handleErrorInternal(password: String) -> Bool {
        do {
            if password == "asd123asd" {
                throw PasswordValidationError.noCapitalletter
            } else if password == "asdasdasd" {
                throw PasswordValidationError.noNumber
            } else if password == "asd" {
                throw PasswordValidationError.notEnoughCharacter(length: 4)
            } else {
                return true
            }
        } catch let error as NSError {
            print(error)
            return false
        }
    }
    
    func callDivide() {
        do {
            let result =  try divide(value1: 10, value2: 0)
            print(result)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func divide(value1: Int, value2: Int) throws -> Double {
        guard value2 != 0 else {
            throw NSError(domain: "com.error.zero", code: 101, userInfo: [:])
        }
        return Double(value1/value2)
    }
}

let error = ErrorHandling()
error.callThrowError()
error.callHandleErrorInternal()
error.callThrowUnExpectedError()
error.treatErrorOptional()
error.callDivide()

/********************************************************/

/// Type method - Reference type
class Maths1 {
    class func addNumber(a: Int, b: Int) ->  Int {
        return a+b
    }
}
print(Maths1.addNumber(a: 1, b: 2))


/// Type method - value type
enum Maths2 {
    case Add
    case Subtract
    case Multiply
    case Divide
    
    static func addNumber(a: Int, b: Int) ->  Int {
        return a+b
    }
}
print(Maths2.addNumber(a: 1, b: 2))

/********************************************************/

/// Mutating function in swift

struct Maths3 {
    var a: Int = 0
    var b: Int = 0
    var c: Int = 0
    
    mutating func addition(a: Int, b: Int) {
        c = a+b
    }
}


var add = Maths3(a: 0, b: 0, c: 0)
add.addition(a: 1, b: 1)
print(add.c, add.a, add.b)

/********************************************************/

/// Subscript
struct subexample {
   let decrementer: Int
   subscript(index: Int) -> Int {
      return decrementer / index
   }
}
let division = subexample(decrementer: 100)

print("The number is divisible by \(division[9]) times")
print("The number is divisible by \(division[2]) times")

/********************************************************/

/// Type checking and type casting
class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

class Student: Person {
    var number: Int
    
    init(name: String, age: Int, number: Int) {
        self.number = number
        super.init(name: name, age: age)
    }
}

let students = [
    Student(name: "name1", age: 1, number: 1),
    Student(name: "name2", age: 2, number: 2),
    Person(name: "name3", age: 3)
]

/// "is" type checking
for person in students {
    if person is Student {
        print("obj is student")
    } else {
        print("object is person")
    }
}
/// "as" downcasting
let tempStudent: Student? = students[0] as? Student
if let stud = tempStudent {
    print(stud.name)
}
/********************************************************/

/// Nested types
class Fooditems {
    
    enum FoodTypes {
        case Fruites
        case vegetables
    }
    
    class Hotel {
        var name: String
        init(name: String) {
            self.name = name
        }
    }
    
    var name: String
    var foodType: FoodTypes
    var hotel: Hotel
    
    init(name: String, foodType: FoodTypes, hotel: Hotel) {
        self.name = name
        self.foodType = foodType
        self.hotel = hotel
    }
}

let foodItems = Fooditems(name: "Apple", foodType: .Fruites, hotel: Fooditems.Hotel(name: "Hotel name"))
print(foodItems.name, foodItems.foodType, foodItems.hotel.name)

/********************************************************/

/// Optional chaining
struct Engine {
    var cylinder: Int
    var maxHorsePower: Int
}
class Car {
    var make: String
    var engine: Engine?
    init(make: String, engine: Engine) {
        self.make = make
        self.engine = engine
    }
    init(make: String) {
        self.make = make
    }
}

let realCar = Car(make: "Audi", engine: Engine(cylinder: 2, maxHorsePower: 1000))
let toyCar = Car(make: "Audi")

print(realCar.engine?.cylinder as Any)
print(toyCar.engine?.cylinder as Any)

/********************************************************/

/// Advanced operator - Unsigned integer
let myNum1: UInt8 = 0b00000000 //0
let myNum2: UInt8 = ~myNum1

let myNum3: UInt8 = 0b00110010 //50
let myNum4: UInt8 = 0b10001111 //143

let bitwiseAnd = myNum3 & myNum4 //00000010
let bitwiseOr = myNum3 | myNum4 //10111111
let bitwiseXor = myNum3 ^ myNum4 //10111101

/********************************************************/

infix operator **
/// Operator overloading
/// - Parameters:
///   - lhs: left hand side
///   - rhs: right hand side
/// - Returns: power value (i.e) 2^3
func **(lhs: Double, rhs: Double) -> Double {
    return pow(lhs, rhs)
}

print(2 ** 3)

/********************************************************/

/// Default parameter
/// - Parameters:
///   - firstName: first name
///   - seperator: seperator
///   - lastName: last name
func combineString(firstName: String, seperator: String = "-", lastName: String) {
    print(firstName+seperator+lastName)
}

combineString(firstName: "hello", lastName: "world")
combineString(firstName: "hello", seperator:"+", lastName: "world")

/********************************************************/

/// Variadic parameter
/// - Parameter numbers: number
/// - Returns: double
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
print(arithmeticMean(3, 8.25, 18.75))

/********************************************************/

/// inout
/// - Parameter input: input string
func combineWord(input: inout String) {
    input = "input changed"
}

var input = "hello"
combineWord(input: &input)
print(input)

/********************************************************/


/// Function type

func addTwoInts(_ a: Int, _ b: Int) -> Int {
return a + b
}

var mathCalculation: (Int, Int) -> Int = addTwoInts

print(mathCalculation(2,2))

func printMathResult(mathFunction:(Int, Int) -> Int, a: Int, b: Int) {
    print(mathFunction(a,b))
}

printMathResult(mathFunction: addTwoInts, a: 2, b: 1)

/********************************************************/
