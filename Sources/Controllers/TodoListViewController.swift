import UIKit
import SnapKit

final class TodoListViewController: UIViewController {
    
    // MARK: - Properties
    private let repository: TodoRepositoryProtocol
    private var todos: [TodoItem] = []
    
    // MARK: - UI Components
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(TodoCell.self, forCellReuseIdentifier: "TodoCell")
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .systemBackground
        return table
    }()
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        return button
    }()
    
    // MARK: - Initialization
    init(repository: TodoRepositoryProtocol = TodoRepository()) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.repository = TodoRepository()
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadTodos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTodos()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "TODOリスト"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = addButton
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Actions
    @objc private func addButtonTapped() {
        let addVC = AddTodoViewController(repository: repository)
        let navController = UINavigationController(rootViewController: addVC)
        present(navController, animated: true)
    }
    
    // MARK: - Data
    private func loadTodos() {
        todos = repository.getAllTodos()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        let todo = todos[indexPath.row]
        cell.configure(with: todo)
        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TodoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todo = todos[indexPath.row]
            repository.deleteTodo(withId: todo.id)
            loadTodos()
        }
    }
}

// MARK: - TodoCellDelegate
extension TodoListViewController: TodoCellDelegate {
    func todoCell(_ cell: TodoCell, didToggleCompletionFor todo: TodoItem) {
        repository.toggleTodoCompletion(withId: todo.id)
        loadTodos()
    }
} 