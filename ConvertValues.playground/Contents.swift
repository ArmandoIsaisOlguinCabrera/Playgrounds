import Foundation

// Information entered by the user (usually from a UITextField)
let passengerCountText = "3"
let pricePerPassenger = 1250  // Price in Mexican pesos

// ✅ Convert String to Int
if let passengerCount = Int(passengerCountText) {
    
    //  Calculate total cost
    let totalCost = passengerCount * pricePerPassenger
    print("Total cost: \(Double(totalCost)) MXN")
    
    // ✅ Calculate average cost per passenger using Float (requires explicit casting)
    let averageCostPerPassenger = Float(totalCost) / Float(passengerCount)
    print("Average per passenger: \(averageCostPerPassenger) MXN")
    
    // Use the destination name as a sequence of characters
    let destination = "Cancun"
    print("Your destination has \(destination.count) letters:")
    for letter in destination {
        print(letter)
    }

} else {
    print("Please enter a valid number of passengers.")
}
