import UIKit
import PlaygroundSupport

class GestureViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let label = UILabel()
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLabel()
        setupTextField()
        addTapGesture()
        addSwipeGesture()
        observeKeyboardNotifications()
    }
    
    func setupLabel() {
        label.text = "Tap or swipe me"
        label.textAlignment = .center
        label.backgroundColor = .systemBlue
        label.textColor = .white
        label.frame = CGRect(x: 50, y: 150, width: 250, height: 50)
        label.isUserInteractionEnabled = true
        view.addSubview(label)
    }
    
    func setupTextField() {
        textField.placeholder = "Tap here to show keyboard"
        textField.borderStyle = .roundedRect
        textField.frame = CGRect(x: 50, y: 250, width: 250, height: 40)
        view.addSubview(textField)
    }
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.numberOfTapsRequired = 1
        tap.delegate = self
        label.addGestureRecognizer(tap)
    }
    
    func addSwipeGesture() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipe.direction = .left
        swipe.delegate = self
        label.addGestureRecognizer(swipe)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: label)
        print("Tapped at \(location)")
        label.text = "Tapped!"
    }
    
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        print("Swiped left on label")
        label.text = "Swiped!"
    }
    
    func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        print("Keyboard will show")
        view.frame.origin.y = -100
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        print("Keyboard will hide")
        view.frame.origin.y = 0
    }
}

PlaygroundPage.current.liveView = GestureViewController()
