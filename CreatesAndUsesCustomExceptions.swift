import Foundation

// MARK: - Define Custom Error
enum BookingError: Error {
    case invalidDestination
    case invalidDate
    case flightNotFound(message: String)
}

// MARK: - Booking Manager
class FlightBookingManager {
    
    func bookFlight(to destination: String, date: Date) throws -> String {
        // Validate destination
        guard !destination.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw BookingError.invalidDestination
        }
        
        // Validate date (no past dates)
        if date < Date() {
            throw BookingError.invalidDate
        }

        // Simulate flight not found
        if destination == "Atlantis" {
            throw BookingError.flightNotFound(message: "No flights available to Atlantis.")
        }
        
        // If all is OK
        return "Flight to \(destination) booked for \(dateFormatter.string(from: date))."
    }
}

// MARK: - Usage Example
let bookingManager = FlightBookingManager()
let destination = "Atlantis" // Try changing this to "New York" or "" for different errors
let travelDate = Calendar.current.date(byAdding: .day, value: 2, to: Date())! // Future date

do {
    let confirmation = try bookingManager.bookFlight(to: destination, date: travelDate)
    print("✅ SUCCESS:", confirmation)
} catch BookingError.invalidDestination {
    print("❌ ERROR: The destination is invalid.")
} catch BookingError.invalidDate {
    print("❌ ERROR: The selected date is in the past.")
} catch BookingError.flightNotFound(let message) {
    print("❌ ERROR:", message)
} catch {
    print("❌ ERROR: An unknown error occurred.")
}

// Helper for date formatting
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
