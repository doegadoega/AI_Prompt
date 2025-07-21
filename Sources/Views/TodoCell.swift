import UIKit
import SnapKit

protocol TodoCellDelegate: AnyObject {
    func todoCell(_ cell: TodoCell, didToggleCompletionFor todo: TodoItem)
}

final class TodoCell: UITableViewCell {
    
    // MARK: - Properties
    weak var delegate: TodoCellDelegate?
    private var todo: TodoItem?
    
    // MARK: - UI Components
    private lazy var checkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priorityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .systemBackground
        selectionStyle = .none
        
        contentView.addSubview(checkButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priorityLabel)
        
        checkButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(12)
            make.trailing.equalTo(priorityLabel.snp.leading).offset(-12)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        priorityLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
    }
    
    // MARK: - Configuration
    func configure(with todo: TodoItem) {
        self.todo = todo
        
        titleLabel.text = todo.title
        titleLabel.attributedText = createAttributedText(for: todo)
        
        priorityLabel.text = todo.priority.rawValue
        priorityLabel.backgroundColor = UIColor(named: todo.priority.color) ?? .systemGray
        
        let imageName = todo.isCompleted ? "checkmark.circle.fill" : "circle"
        checkButton.setImage(UIImage(systemName: imageName), for: .normal)
        checkButton.tintColor = todo.isCompleted ? .systemGreen : .systemBlue
    }
    
    private func createAttributedText(for todo: TodoItem) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: todo.title)
        
        if todo.isCompleted {
            attributedString.addAttribute(
                .strikethroughStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: NSRange(location: 0, length: todo.title.count)
            )
            attributedString.addAttribute(
                .foregroundColor,
                value: UIColor.systemGray,
                range: NSRange(location: 0, length: todo.title.count)
            )
        }
        
        return attributedString
    }
    
    // MARK: - Actions
    @objc private func checkButtonTapped() {
        guard let todo = todo else { return }
        delegate?.todoCell(self, didToggleCompletionFor: todo)
    }
} 