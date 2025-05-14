import Foundation

// MARK: - Property Wrapper Definition
/*Clamped es un property wrapper que puede trabajar con cualquier tipo llamado Value, siempre y cuando ese tipo conforme al protocolo Comparable*/
@propertyWrapper
struct Clamped<Value: Comparable> {
    
    private var value: Value
    private let range: ClosedRange<Value>

    var wrappedValue: Value {
        get { value }
        set {
            value = min(max(newValue, range.lowerBound), range.upperBound)
        }
    }

    init(wrappedValue: Value, _ range: ClosedRange<Value>) {
        self.range = range
        self.value = min(max(wrappedValue, range.lowerBound), range.upperBound)
    }
}

// MARK: - Usage Example

struct Player {
    @Clamped(0...100) var health: Int = 120
    @Clamped(0...10) var level: Int = 5
}

let player = Player()
print("🧍 Player health (clamped): \(player.health)") // Output: 100
print("🧍 Player level: \(player.level)")             // Output: 5

