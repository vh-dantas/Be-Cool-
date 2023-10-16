import UIKit

//View controller principal com métodos adicionais do botão azul de ir pra próxima tela
class ViewController: UIViewController {
    private var originalKeyboardAccessoryViewBottomConstraintValue: CGFloat?
    private var keyboardAccessoryViewBottomConstraint: NSLayoutConstraint?
    
    deinit {
        // Unregister the keyboard notifications
        NotificationCenter.default.removeObserver(self)
    }
    
    func stickViewToKeyboard(bottomConstraint: NSLayoutConstraint) {
        keyboardAccessoryViewBottomConstraint = bottomConstraint
        originalKeyboardAccessoryViewBottomConstraintValue = bottomConstraint.constant
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardAccessoryViewBottomConstraint else {
            return
        }
        guard let keyboardHeight = keyboardHeight(from: notification), keyboardAccessoryViewBottomConstraint.constant == originalKeyboardAccessoryViewBottomConstraintValue else {
            return
        }
        
        // Adjust the frame of the UIView
        UIView.animate(withDuration: 0.3) {
            keyboardAccessoryViewBottomConstraint.isActive = false
            keyboardAccessoryViewBottomConstraint.constant -= keyboardHeight
            keyboardAccessoryViewBottomConstraint.isActive = true
        }
    }
    
    private func keyboardHeight(from notification: Notification) -> CGFloat? {
        return (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        guard let keyboardAccessoryViewBottomConstraint, let originalKeyboardAccessoryViewBottomConstraintValue else {
            return
        }
        // Reset the frame of the UIView to its original position
        UIView.animate(withDuration: 0.3) {
            keyboardAccessoryViewBottomConstraint.isActive = false
            keyboardAccessoryViewBottomConstraint.constant = originalKeyboardAccessoryViewBottomConstraintValue
            keyboardAccessoryViewBottomConstraint.isActive = true
        }
    }
}
