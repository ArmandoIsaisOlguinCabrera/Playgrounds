import Foundation
import Accelerate

// MARK: - 1. Matrix Multiplication using Accelerate

let a: [Float] = [1, 2, 3, 4]      // 2x2 matrix A
let b: [Float] = [5, 6, 7, 8]      // 2x2 matrix B
var result = [Float](repeating: 0, count: 4)

vDSP_mmul(a, 1,
          b, 1,
          &result, 1,
          2, 2, 2) // Matrix multiply: A (2x2) * B (2x2)

print("Matrix multiplication result: \(result)") // [19, 22, 43, 50]

// MARK: - 2. Trigonometric operations

let angleDegrees: Double = 45
let angleRadians = angleDegrees * .pi / 180
let sine = sin(angleRadians)
let cosine = cos(angleRadians)

print("sin(45°) = \(sine), cos(45°) = \(cosine)")

// MARK: - 3. Statistical analysis

let data: [Double] = [10, 12, 23, 23, 16, 23, 21, 16]
var mean = 0.0
var stdDev = 0.0

vDSP_normalizeD(data, 1, nil, 1, &mean, &stdDev, vDSP_Length(data.count))

print("Mean: \(mean), Standard deviation: \(stdDev)")

// MARK: - 4. Histogram using vDSP

let histogramBins: vDSP.BinCount = 4
let histogram = vDSP.histogram(data,
                                using: .linear,
                                binCount: histogramBins,
                                range: 10...25)

print("Histogram bins: \(histogram.binCounts)")

// MARK: - 5. Solving linear equations Ax = B

let matrixA: [Double] = [3, 2,
                         1, 2] // 2x2
var matrixB: [Double] = [5, 5]   // Right-hand side
var solution = matrixB

var inMatrix = matrixA
var N = __CLPK_integer(2)
var NRHS = __CLPK_integer(1)
var LDA = N
var LDB = N
var IPIV = [__CLPK_integer](repeating: 0, count: Int(N))
var INFO: __CLPK_integer = 0

dgesv_(&N, &NRHS, &inMatrix, &LDA, &IPIV, &solution, &LDB, &INFO)

if INFO == 0 {
    print("Solution for Ax = B: \(solution)")
} else {
    print("Failed to solve linear system, INFO = \(INFO)")
}
