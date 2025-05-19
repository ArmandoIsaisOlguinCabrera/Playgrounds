import UIKit
import CoreNFC

// Class to handle NFC reading
class NFCReader: NSObject, NFCNDEFReaderSessionDelegate {
    
    var nfcSession: NFCNDEFReaderSession?
    
    // Starts the NFC scanning session
    func startScanning() {
        if NFCNDEFReaderSession.readingAvailable {
            // Create a new NFC session
            nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
            nfcSession?.begin()
            print("NFC scanning started...")
        } else {
            print("NFC is not available on this device.")
        }
    }
    
    // Delegate method called when NDEF messages are detected
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                // Check if the record's payload is a valid URL
                if let urlPayload = String(data: record.payload, encoding: .utf8), isValidURL(urlPayload) {
                    print("Detected URL: \(urlPayload)")
                    openURL(urlPayload)
                } else {
                    print("No valid URL found in the NFC tag.")
                }
            }
        }
    }
    
    // Checks if the given string is a valid URL
    func isValidURL(_ urlString: String) -> Bool {
        return URL(string: urlString) != nil
    }
    
    // Opens the URL in the default web browser (Safari)
    func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                // Open the URL in Safari
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Unable to open URL: \(urlString)")
            }
        }
    }
    
    // Delegate method called when the NFC session becomes active
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        print("The NFC session is active.")
    }
    
    // Delegate method called when the session encounters an error
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("The NFC session was invalidated with error: \(error.localizedDescription)")
    }
}

// Create an instance of the NFC reader
let nfcReader = NFCReader()

// Start scanning (this should happen in an appropriate context, like in a real app)
nfcReader.startScanning()
