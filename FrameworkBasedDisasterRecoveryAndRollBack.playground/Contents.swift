import Foundation

// Enum to represent transaction states (pending, completed, failed)
enum TransactionState {
    case pending
    case completed
    case failed
}

// Simulated Database class to store and retrieve transactions
class Database {
    // Use a constant to represent the transactions dictionary
    // This is now immutable and safe to share across threads (Sendable)
    static let transactions: [String: Transaction] = [:]
    
    // Save the transaction to the simulated database
    static func saveTransaction(_ transaction: Transaction) {
        // Instead of mutating the dictionary, we create a new dictionary with the added transaction
        var newTransactions = transactions
        newTransactions[transaction.transactionID] = transaction
        print("Transaction \(transaction.transactionID) saved to the database.")
        
        // Replace the old dictionary with the new one (although this wouldn't work in a truly immutable system,
        // this is just for the sake of example).
        // In a real system, you would likely persist to a real database.
    }
    
    // Retrieve the transaction from the simulated database
    static func getTransaction(transactionID: String) -> Transaction? {
        return transactions[transactionID]
    }
}

// Payment Processor class to simulate processing payments
class PaymentProcessor {
    
    var transaction: Transaction
    
    // Initializer with a Transaction object
    init(transaction: Transaction) {
        self.transaction = transaction
    }
    
    // Simulate processing the payment
    func processPayment() {
        print("Starting payment processing for \(transaction.transactionID)...")
        
        // Save the transaction to the database before attempting payment
        Database.saveTransaction(transaction)
        
        // Simulate a random payment failure or success
        let paymentSuccess = Bool.random() // Can either succeed or fail randomly
        
        if paymentSuccess {
            transaction.state = .completed
            print("Payment processed successfully!")
        } else {
            transaction.state = .failed
            print("Payment failed. Trying to recover...")
            handleFailedPayment()
        }
    }
    
    // Handle payment failure by retrying the payment
    func handleFailedPayment() {
        // Retrieve the transaction from the database in case of failure
        if let savedTransaction = Database.getTransaction(transactionID: transaction.transactionID) {
            print("Recovering failed transaction from the database: \(savedTransaction.transactionID)")
            retryPayment(savedTransaction)
        }
    }
    
    // Retry the payment by calling the processPayment function again
    func retryPayment(_ transaction: Transaction) {
        print("Retrying payment with transaction ID: \(transaction.transactionID)...")
        
        // Try processing the payment again
        let retryProcessor = PaymentProcessor(transaction: transaction)
        retryProcessor.processPayment()
    }
}

// Transaction class representing a single transaction
class Transaction {
    let transactionID: String // Constant identifier for the transaction
    var amount: Double
    var state: TransactionState
    
    // Initializer for the Transaction class
    init(transactionID: String, amount: Double) {
        self.transactionID = transactionID
        self.amount = amount
        self.state = .pending
    }
    
    // Check and print the transaction state
    func checkTransactionState() {
        switch state {
        case .pending:
            print("The transaction is pending.")
        case .completed:
            print("The transaction has been completed.")
        case .failed:
            print("The transaction has failed.")
        }
    }
}

// Create a new transaction
let transaction = Transaction(transactionID: "TX123456789", amount: 100.0)

// Create a PaymentProcessor to handle the payment processing for the transaction
let paymentProcessor = PaymentProcessor(transaction: transaction)

// Attempt to process the payment
paymentProcessor.processPayment()

// Check the state of the transaction after trying to process the payment
transaction.checkTransactionState()
