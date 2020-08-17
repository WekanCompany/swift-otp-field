# swift-otp-field

A sample implementation for OTP or Pin entry textfield

We are using the library [SVPinView](https://github.com/xornorik/SVPinView)


![alt text](https://github.com/WekanCompany/swift-otp-field/blob/master/otpPreview1.png)
![alt text](https://github.com/WekanCompany/swift-otp-field/blob/master/otpPreview2.png)
![alt text](https://github.com/WekanCompany/swift-otp-field/blob/master/otpPreview3.png)
![alt text](https://github.com/WekanCompany/swift-otp-field/blob/master/otpPreview4.png)


## What does it support ##

##### - Secured or plain text entry
##### - Flexible number of digits
##### - Styles - Underlined, Box with sharp and round corners
##### - Colors, spaces, placeholder, secured text symbol, etc can be easily configured
##### - Properties can be set in storyboard and code


## How to get it work ##

#### 1. Install pod
````
pod 'SVPinView' #, '~> 1.0'
````

#### 2. Import class ````import SVPinView```` in your ViewController.

#### 3. ````ViewController```` class has the code to configure the otp textfield.

##### Add a UIView and link outlet
````
    @IBOutlet var pinView: SVPinView!
````

##### All the properties can be set in the storyboard itself. Or it can be configured in code like this:

````

     func configurePinView() {
        pinView.pinLength = 4
        pinView.secureCharacter = "\u{25CF}"
        pinView.interSpace = 10
        pinView.textColor = UIColor.darkText
        pinView.borderLineColor = UIColor.darkText
        pinView.activeBorderLineColor = UIColor.systemBlue
        pinView.borderLineThickness = 1
        pinView.shouldSecureText = true
        pinView.allowsWhitespaces = false
        pinView.style = .none
        pinView.fieldBackgroundColor = UIColor.white.withAlphaComponent(0.3)
        pinView.activeFieldBackgroundColor = UIColor.white.withAlphaComponent(0.5)
        pinView.fieldCornerRadius = 15
        pinView.activeFieldCornerRadius = 15
        pinView.placeholder = "******"
        pinView.tintColor = .white
        pinView.becomeFirstResponderAtIndex = 0
        pinView.shouldDismissKeyboardOnEmptyFirstField = false
        
        pinView.font = UIFont.systemFont(ofSize: 15)
        pinView.keyboardType = .phonePad
        pinView.pinInputAccessoryView = { () -> UIView in
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
            doneToolbar.barStyle = UIBarStyle.default
            let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(dismissKeyboard))
            
            var items = [UIBarButtonItem]()
            items.append(flexSpace)
            items.append(done)
            
            doneToolbar.items = items
            doneToolbar.sizeToFit()
            return doneToolbar
        }()
        
        pinView.didFinishCallback = didFinishEnteringPin(pin:)
        pinView.didChangeCallback = { pin in
            print("The entered pin is \(pin)")
        }
    }
````
