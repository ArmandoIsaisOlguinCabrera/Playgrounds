import SwiftUI
import SwiftValidator
import PhoneNumberKit

struct ValidationFormView: View {
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""

    @State private var errors: [String] = []

    let validator = Validator()
    let phoneNumberKit = PhoneNumberKit()

    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)

            TextField("Phone Number", text: $phone)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            Button("Validate") {
                validateInputs()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            if !errors.isEmpty {
                ForEach(errors, id: \.self) { error in
                    Text(error).foregroundColor(.red).font(.caption)
                }
            }

            Spacer()
        }
        .padding()
    }

    private func validateInputs() {
        errors = []

        validator.unregisterAllFields()

        validator.registerField("email", rules: [RequiredRule(), EmailRule(message: "Invalid email format")])
        validator.registerField("password", rules: [RequiredRule(), MinLengthRule(length: 6)])

        let fields: [String: String] = [
            "email": email,
            "password": password
        ]

        validator.validate(fields: fields) { result in
            switch result {
            case .valid:
                validatePhone()
            case .invalid(let failures):
                errors = failures.map { $0.1.first?.errorMessage ?? "Unknown error" }
            }
        }
    }

    private func validatePhone() {
        do {
            _ = try phoneNumberKit.parse(phone)
        } catch {
            errors.append("Invalid phone number")
        }
    }
}
