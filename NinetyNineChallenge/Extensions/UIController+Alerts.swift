import UIKit

extension UIViewController {
    
    func showAlert(_ alertMessage: String,
                   _ alertTitle: String?,
                   _ alertActionTitle: String?,
                   _ alertAction: (() -> Void)?) {

        let title = alertTitle ?? "ALERT"
        let actionTitle = alertActionTitle ?? "OK"
        
        let alertController = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        alertController.view.tintColor = UIColor.possitive
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (_) in
            guard let alertAction = alertAction else {return}
            alertAction()
        }))
        present(alertController, animated: true, completion: nil)
    }

    func showActionAlert(msg alertMessage: String,
                         title alertTitle: String?,
                         actionTitle aTitle: String?,
                         actionStyle aStyle: UIAlertAction.Style,
                         action: (() -> Void)?) {
        let title = alertTitle ?? "ALERT"
        let aTitleText = aTitle ?? "OK"
        
        let alertController = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        alertController.view.tintColor = UIColor.negative
        alertController.addAction(UIAlertAction(title: aTitleText, style: aStyle, handler: { (_) in
            guard let aAction = action else {return}
            aAction()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
