import Foundation

// Func to use repeat-while
func repeatWhileExample() {
    var userInput: Int = 0
    
    print("Enter a number greater than 10 (repeat-while):")
    
    repeat {
        if let input = readLine(), let number = Int(input) {
            userInput = number
        } else {
            print("Invalid input, please enter a valid number.")
            continue
        }
        print("You entered: \(userInput)")
    } while userInput <= 10
    
    print("You entered a number greater than 10: \(userInput)")
}

// Func to use while
func whileExample() {
    var userInput: Int = 0
    
    print("\nEnter a number greater than 10 (while):")
    
    while userInput <= 10 {
        if let input = readLine(), let number = Int(input) {
            userInput = number
        } else {
            print("Invalid input, please enter a valid number.")
            continue
        }
        print("You entered: \(userInput)")
    }
    
    print("You entered a number greater than 10: \(userInput)")
}

// Llamada a ambas funciones
repeatWhileExample()
whileExample()
