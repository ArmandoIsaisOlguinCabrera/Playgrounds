import Foundation

// MARK: - 1. Real Numbers vs Integers

// Integer (whole number)
let integer: Int = 5

// Real number (floating point)
let real: Double = 5.5

print("Integer: \(integer)")
print("Real: \(real)")
print(integer is Int)       // true
print(real is Double)       // true

// MARK: - 2. Powers and Roots


let base: Double = 2.0
let exponent: Double = 3.0

// Power: base raised to the exponent
let power = pow(base, exponent)

// Square root
let squareRoot = sqrt(16.0)

// Cube root (using fractional exponent)
let cubeRoot = pow(27.0, 1.0 / 3.0)

print("2^3 = \(power)")
print("Square root of 16 = \(squareRoot)")
print("Cube root of 27 = \(cubeRoot)")

// MARK: - 3. Logarithms


let number: Double = 100.0

// Natural logarithm (base e)
let naturalLog = log(number)

// Base-10 logarithm
let logBase10 = log10(number)

print("ln(100) = \(naturalLog)")
print("log₁₀(100) = \(logBase10)")

// MARK: - 4. Exponential Value


let exponentValue = 2.0

// e raised to the power of exponentValue
let exponentialResult = exp(exponentValue)

print("e^2 = \(exponentialResult)")

// MARK: - 5. Trigonometric Functions

print("\n🔹 5. Trigonometric Functions")

let degrees = 90.0

// Convert degrees to radians (required by Swift's trig functions)
let radians = degrees * .pi / 180

// Basic trigonometric functions
let sine = sin(radians)
let cosine = cos(radians)
let tangent = tan(radians)

// Inverse tangent (result in radians), converted to degrees
let arctangent = atan(1.0) * 180 / .pi

print("sin(90°) = \(sine)")
print("cos(90°) = \(cosine)")
print("tan(90°) ≈ \(tangent)")
print("atan(1) = \(arctangent)°")  // Should be approximately 45°

// MARK: - Extras (Optional Useful Functions)


let negativeValue = -42.0

// Absolute value
let absolute = abs(negativeValue)

// Rounding a floating number to 3 decimal places
let rounded = round(3.14159 * 1000) / 1000

print("Absolute value of -42 = \(absolute)")
print("3.14159 rounded to 3 decimal places = \(rounded)")
