import Foundation

struct TodoItem: Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    var createdAt: Date
    var priority: TodoPriority
    
    init(title: String, priority: TodoPriority = .medium) {
        self.id = UUID()
        self.title = title
        self.isCompleted = false
        self.createdAt = Date()
        self.priority = priority
    }
}

enum TodoPriority: String, CaseIterable, Codable {
    case low = "低"
    case medium = "中"
    case high = "高"
    
    var color: String {
        switch self {
        case .low:
            return "systemGreen"
        case .medium:
            return "systemOrange"
        case .high:
            return "systemRed"
        }
    }
} 