import UIKit

final class AuthTextField: UIView {
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(
            ofSize: 14,
            weight: .semibold
        )
        label.textColor = .secondaryLabel
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = .label
        textField.backgroundColor = .clear
        textField.leftView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 12,
                height: 0
            )
        )
        textField.leftViewMode = .always
        return textField
    }()
    
    // MARK: - Init
    
    init(
        title: String,
        placeholder: String,
        isSecure: Bool = false
    ) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = title
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
        
        setupUI()
        setupConstraints()
    }
    
    
    func setupUI() {
        
        addSubview(titleLabel)
        addSubview(textField)
        
        textField.layer.cornerRadius = 24
        textField.layer.borderWidth = 1
        textField.layer.borderColor =
            UIColor.systemGray4.cgColor
    }
    
    func setupConstraints() {
           
           titleLabel.translatesAutoresizingMaskIntoConstraints = false
           textField.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               
               titleLabel.topAnchor.constraint(
                   equalTo: topAnchor
               ),
               
               titleLabel.leadingAnchor.constraint(
                   equalTo: leadingAnchor
               ),
               
               titleLabel.trailingAnchor.constraint(
                   equalTo: trailingAnchor
               ),
               
               titleLabel.heightAnchor.constraint(
                   equalToConstant: 20
               ),
               
               
               textField.topAnchor.constraint(
                   equalTo: titleLabel.bottomAnchor,
                   constant: 8
               ),
               
               textField.leadingAnchor.constraint(
                   equalTo: leadingAnchor
               ),
               
               textField.trailingAnchor.constraint(
                   equalTo: trailingAnchor
               ),
               
               textField.heightAnchor.constraint(
                   equalToConstant: 50
               )
           ])
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
