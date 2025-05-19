import Foundation
import CryptoKit
import Security

// MARK: - 1. SHA256 Hash

let message = "Hola mundo".data(using: .utf8)!
let digest = SHA256.hash(data: message)
print("SHA256:", digest.map { String(format: "%02x", $0) }.joined())

// MARK: - 2. Symmetric Encryption using ChaCha20-Poly1305

let symmetricKey = SymmetricKey(size: .bits256) // Generate a secure 256-bit key

// Encrypt the message
let sealedBox = try! ChaChaPoly.seal(message, using: symmetricKey)
print("Encrypted (ChaCha20):", sealedBox.ciphertext.base64EncodedString())

// Decrypt the message
let decryptedData = try! ChaChaPoly.open(sealedBox, using: symmetricKey)
print("Decrypted:", String(data: decryptedData, encoding: .utf8)!)

// MARK: - 3. Cryptographically Secure Random Number

var randomBytes = [UInt8](repeating: 0, count: 16)
let status = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)

if status == errSecSuccess {
    print("Secure random bytes:", randomBytes)
} else {
    print("Failed to generate secure random bytes")
}

// MARK: - 4. Asymmetric Key Generation and Digital Signature (P256)

let privateKey = P256.Signing.PrivateKey() // Generate private key
let publicKey = privateKey.publicKey       // Get public key

// Sign the message
let signature = try! privateKey.signature(for: message)

// Verify the signature
let isValid = publicKey.isValidSignature(signature, for: message)
print("Is signature valid?", isValid)
