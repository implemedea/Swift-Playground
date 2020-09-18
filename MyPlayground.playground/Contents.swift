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
