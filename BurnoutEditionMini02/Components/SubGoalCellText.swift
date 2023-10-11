import UIKit

enum TextFieldType {
    case text
    case date
}

// Celula da NewSubGoalModalViewController que tem o textField
class SubGoalCellText: UITableViewCell, UITextFieldDelegate {
    let textField = UITextField()
    var subGoal: SubGoalStatic?
    
    weak var delegate: SubGoalCellTextDelegate?
    
    var type: TextFieldType = .text {
        didSet {
            switch type {
            case .text:
                setUpForText()
            case .date:
                setUpForDate()
            }
        }
    }
    
    private let stackView = UIStackView()
    let datePicker = UIDatePicker()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        backgroundColor = UIColor(named:"SubGoalCellColor")
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        contentView.addSubview(stackView)
        
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(textField)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -9),
            datePicker.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.size.width * 0.3)
        ])
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        // Configurar o UIDatePicker
        datePicker.datePickerMode = .time
        
        datePicker.addTarget(self, action: #selector(datePickerDidChange(_:)), for: .valueChanged)
        
        stackView.addArrangedSubview(datePicker)
        datePicker.isHidden = true
    }
    
    func setUpForText() {
        datePicker.isHidden = true
        // Configure a célula para o tipo de texto
    }
    
    func setUpForDate() {
        datePicker.isHidden = false
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text, let subGoal = subGoal else {
            return
        }
        delegate?.subGoalTextDidChangeText(subGoal, text: text)
    }
    
    @objc func datePickerDidChange(_ datePicker: UIDatePicker) {
        guard let subGoal = subGoal else {
            return
        }
        delegate?.subGoalDateDidChange(subGoal, date: datePicker.date)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let subGoal = subGoal else {
            return true
        }
        delegate?.subGoalTextReturnTouched(subGoal)
        return true
    }
}


protocol SubGoalCellTextDelegate: AnyObject {
    func subGoalTextReturnTouched(_ subGoal: SubGoalStatic)
    func subGoalTextDidChangeText(_ subGoal: SubGoalStatic, text: String)
    func subGoalDateDidChange(_ subGoal: SubGoalStatic, date: Date)
}
