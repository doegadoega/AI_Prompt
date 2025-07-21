import Foundation

protocol TodoRepositoryProtocol {
    func getAllTodos() -> [TodoItem]
    func addTodo(_ todo: TodoItem)
    func updateTodo(_ todo: TodoItem)
    func deleteTodo(withId id: UUID)
    func toggleTodoCompletion(withId id: UUID)
}

final class TodoRepository: TodoRepositoryProtocol {
    private var todos: [TodoItem] = []
    private let userDefaults = UserDefaults.standard
    private let todosKey = "todos"
    
    init() {
        loadTodos()
    }
    
    func getAllTodos() -> [TodoItem] {
        return todos.sorted { $0.createdAt > $1.createdAt }
    }
    
    func addTodo(_ todo: TodoItem) {
        todos.append(todo)
        saveTodos()
    }
    
    func updateTodo(_ todo: TodoItem) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index] = todo
            saveTodos()
        }
    }
    
    func deleteTodo(withId id: UUID) {
        todos.removeAll { $0.id == id }
        saveTodos()
    }
    
    func toggleTodoCompletion(withId id: UUID) {
        if let index = todos.firstIndex(where: { $0.id == id }) {
            todos[index].isCompleted.toggle()
            saveTodos()
        }
    }
    
    private func saveTodos() {
        if let encoded = try? JSONEncoder().encode(todos) {
            userDefaults.set(encoded, forKey: todosKey)
        }
    }
    
    private func loadTodos() {
        if let data = userDefaults.data(forKey: todosKey),
           let decoded = try? JSONDecoder().decode([TodoItem].self, from: data) {
            todos = decoded
        }
    }
} 