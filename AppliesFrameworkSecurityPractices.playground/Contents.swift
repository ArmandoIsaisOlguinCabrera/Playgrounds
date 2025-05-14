import Foundation
import Security
import CommonCrypto

// Simulated permission request for location access
func requestLocationPermission() {
    print("Requesting access to user location...")
    // In a real app, you'd use CLLocationManager to request permission.
    // Here, it's just a simulation of the process.
    print("We need access to your location to show nearby restaurants.")
}

// Function to save a password securely in the Keychain
func savePasswordToKeychain(password: String, account: String) {
    let passwordData = password.data(using: .utf8)!
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: account,
        kSecValueData as String: passwordData
    ]
    
    // Delete any previous object to avoid duplicates
    SecItemDelete(query as CFDictionary)
    
    // Add the new item to the Keychain
    let status = SecItemAdd(query as CFDictionary, nil)
    
    if status == errSecSuccess {
        print("Password saved to Keychain.")
    } else {
        print("Error saving password to Keychain: \(status)")
    }
}

// Function to retrieve a password from the Keychain
func getPasswordFromKeychain(account: String) -> String? {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: account,
        kSecReturnData as String: true,
        kSecMatchLimit as String: kSecMatchLimitOne
    ]
    
    var result: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &result)
    
    if status == errSecSuccess, let retrievedData = result as? Data {
        let password = String(data: retrievedData, encoding: .utf8)
        return password
    } else {
        print("Error retrieving password: \(status)")
        return nil
    }
}

// Function to encrypt data using CommonCrypto (AES)
func encryptData(data: String, key: String) -> Data? {
    let keyData = key.data(using: .utf8)!
    let dataToEncrypt = data.data(using: .utf8)!
    
    var encryptedData = Data(count: dataToEncrypt.count + kCCBlockSizeAES128)
    
    var numBytesEncrypted: size_t = 0
    
    let cryptStatus = encryptedData.withUnsafeMutableBytes { encryptedBytes in
        dataToEncrypt.withUnsafeBytes { dataBytes in
            keyData.withUnsafeBytes { keyBytes in
                CCCrypt(CCOperation(kCCEncrypt), CCAlgorithm(kCCAlgorithmAES), CCOptions(kCCOptionPKCS7Padding),
                        keyBytes.baseAddress, kCCKeySizeAES256, nil,
                        dataBytes.baseAddress, dataToEncrypt.count,
                        encryptedBytes.baseAddress, encryptedData.count,
                        &numBytesEncrypted)
            }
        }
    }
    
    if cryptStatus == kCCSuccess {
        return encryptedData.prefix(numBytesEncrypted)
    } else {
        print("Encryption failed with status \(cryptStatus)")
        return nil
    }
}

// Function to decrypt data using CommonCrypto (AES)
func decryptData(data: Data, key: String) -> String? {
    let keyData = key.data(using: .utf8)!
    
    var decryptedData = Data(count: data.count + kCCBlockSizeAES128)
    var numBytesDecrypted: size_t = 0
    
    let cryptStatus = decryptedData.withUnsafeMutableBytes { decryptedBytes in
        data.withUnsafeBytes { dataBytes in
            keyData.withUnsafeBytes { keyBytes in
                CCCrypt(CCOperation(kCCDecrypt), CCAlgorithm(kCCAlgorithmAES), CCOptions(kCCOptionPKCS7Padding),
                        keyBytes.baseAddress, kCCKeySizeAES256, nil,
                        dataBytes.baseAddress, data.count,
                        decryptedBytes.baseAddress, decryptedData.count,
                        &numBytesDecrypted)
            }
        }
    }
    
    if cryptStatus == kCCSuccess {
        return String(data: decryptedData.prefix(numBytesDecrypted), encoding: .utf8)
    } else {
        print("Decryption failed with status \(cryptStatus)")
        return nil
    }
}

// Example usage in the Playground:

// 1. Requesting access to location (simulated)
requestLocationPermission()

// 2. Saving a password to the Keychain
let password = "SuperSecretPassword123"
savePasswordToKeychain(password: password, account: "userAccount")

// 3. Retrieving the password from the Keychain
if let retrievedPassword = getPasswordFromKeychain(account: "userAccount") {
    print("Retrieved password: \(retrievedPassword)")
}

// 4. Encrypting and decrypting data with AES
let dataToEncrypt = "Sensitive data that needs to be encrypted"
let encryptionKey = "ThisIsASecretKey12345"  // A key of 16 bytes or more

if let encryptedData = encryptData(data: dataToEncrypt, key: encryptionKey) {
    print("Encrypted data: \(encryptedData)")
    
    if let decryptedData = decryptData(data: encryptedData, key: encryptionKey) {
        print("Decrypted data: \(decryptedData)")
    }
}
