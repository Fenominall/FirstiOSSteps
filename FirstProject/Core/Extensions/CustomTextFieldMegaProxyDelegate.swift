import UIKit
 
class CustomTextFieldMegaProxyDelegate: UITextField {
    
    private weak var _delegate: UITextFieldDelegate?
 
    override var delegate: UITextFieldDelegate? {
        get {
            _delegate
        }
        set {
            _delegate = newValue
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        super.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        super.delegate = self
    }
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        if let outerDelegate = _delegate, outerDelegate.responds(to: aSelector) {
            return outerDelegate
        } else {
            return super.forwardingTarget(for: aSelector)
        }
    }
 
    override func responds(to aSelector: Selector!) -> Bool {
        if let outerDelegate = _delegate, outerDelegate.responds(to: aSelector) {
            return true
        } else {
            return super.responds(to: aSelector)
        }
    }
    
}
 
extension CustomTextFieldMegaProxyDelegate: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        someNiceLogic(textField, range, string)
    }
    
    func someNiceLogic(_ textField: UITextField, _ range: NSRange, _ string: String) -> Bool {
        // Здесь жирная логика
        true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let outerDelegate = _delegate, outerDelegate.responds(to: #selector(textFieldShouldReturn(_:))) {
            return outerDelegate.textFieldShouldReturn!(textField)
        } else {
            textField.resignFirstResponder()
            return true
        }
    }
    
}
