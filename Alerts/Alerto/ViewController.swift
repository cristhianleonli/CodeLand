import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private var messageTextField: UITextField!
    @IBOutlet private var primaryTextField: UITextField!
    @IBOutlet private var secondaryTextField: UITextField!
    @IBOutlet private var dismissSwitch: UISwitch!
    @IBOutlet private var autoCloseSegment: UISegmentedControl!
    @IBOutlet private var resultLabel: UILabel!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [titleTextField, messageTextField, primaryTextField, secondaryTextField].forEach { field in
            field?.clearButtonMode = .whileEditing
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fillDummyData()
    }
}

private extension ViewController {
    @IBAction func restoreValues(_ sender: Any) {
        fillDummyData()
    }
    
    @IBAction func createAlert(_ sender: Any) {
        let alert = Alert.instanceFromNib()
        alert.model = createAlertModel()
        
        alert.onSecondaryTapped = { [weak self] in
            self?.resultLabel.text = "Secondary button pressed"
        }
        
        alert.onPrimaryTapped = { [weak self] in
            self?.resultLabel.text = "Primary button pressed"
        }
        
        alert.onTapOutside = { [weak self] in
            self?.resultLabel.text = "Tapped outside"
        }
        
        alert.onAutoClose = { [weak self] in
            self?.resultLabel.text = "Auto closed"
        }
        
        alert.show(in: self.view)
    }
    
    func createAlertModel() -> AlertModel {
        let model = AlertModel(
            title: titleTextField.text ?? "",
            message: messageTextField.text ?? "",
            primaryButton: primaryTextField.text!.isEmpty ? nil : primaryTextField.text,
            secondaryButton: secondaryTextField.text!.isEmpty ? nil : secondaryTextField.text,
            isDismissable: dismissSwitch.isOn,
            autoCloseDuration: AutoCloseDuration.allCases[autoCloseSegment.selectedSegmentIndex]
        )
        
        return model
    }
    
    func fillDummyData() {
        titleTextField.text = "Do you really want to delete your account?"
        messageTextField.text = "If you delete your account, you will lose you profile, messages, and phothos."
        primaryTextField.text = "No, keep it"
        secondaryTextField.text = "Yes, delete it"
        dismissSwitch.isOn = true
        autoCloseSegment.selectedSegmentIndex = 0
        resultLabel.text = ""
    }
}







































