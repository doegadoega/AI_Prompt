# Swift Engineer Rules

## ファイル分割ルール

### Enum
- enumは階層でなければ1ファイルにまとめる
- 例: `Priority.swift`, `TaskCategory.swift`, `TaskStatus.swift`

### Struct
- structも同様に1ファイルにまとめる
- 例: `Task.swift`, `TaskStatistics.swift`

### UI Components
- UIコンポーネントは`***View`、`***TabView`、`***Button`などの命名規則に従う
- 例: `FilterChipView.swift`, `TaskListView.swift`, `AddTaskView.swift`

## SwiftUI View設計パターン

### コンポーネント分割原則
- **再利用可能なコンポーネント**は独立したViewとして分離
- **複雑なUI**は複数の小さなViewに分割
- **プレビュー用のView**は`#Preview`で独立してテスト可能にする

### FilterBannerView設計パターン
```swift
// メインのFilterBannerView
struct FilterBannerView: View {
    @StateObject var viewModel: TaskListViewModel
    
    var body: some View {
        VStack {
            FilterBannerContentsView(
                selectedCategory: viewModel.selectedCategory,
                selectedStatus: viewModel.selectedStatus,
                filterRemove: { viewModel.setCategoryFilter(nil) },
                statusRemove: { viewModel.setStatusFilter(nil) },
                clearAction: { viewModel.resetFilters() }
            )
        }
    }
}

// 内部実装用のFilterBannerContentsView
private struct FilterBannerContentsView: View {
    @State var selectedCategory: TaskCategory?
    @State var selectedStatus: TaskStatus?
    
    var filterRemove: (() -> Void)
    var statusRemove: (() -> Void)
    var clearAction: (() -> Void)
    
    var body: some View {
        // 実装詳細
    }
}
```

### View設計のベストプラクティス
- **@StateObject**: ViewModelを保持する場合は`@StateObject`を使用
- **@State**: ローカル状態は`@State`を使用
- **クロージャー渡し**: アクションはクロージャーとして渡す
- **private修飾子**: 内部実装用のViewは`private`にする
- **プレビュー分離**: 複雑なViewは独立したプレビューでテスト

### フィルターUI設計
- **FilterChipView**: 個別のフィルター項目を表示
- **条件分岐**: `if let`でオプショナルな状態を表示
- **Spacer()**: レイアウトの調整に使用
- **アクセシビリティ**: ボタンには適切なラベルを設定

## MVVMアーキテクチャルール

### MVVM方式の採用判断
- **複雑な状態管理**が必要な場合はMVVMを採用
- **Repositoryパターン**を使用する場合はMVVMを採用
- **SwiftUI/UIKit両対応**が必要な場合はMVVMを採用
- **テスト容易性**を重視する場合はMVVMを採用
- **単純な画面**の場合は従来のMVC/Vでも可

### UseCase層（オプション）
- **複雑なビジネスロジック**がある場合はUseCaseを採用
- **複数のRepository**を組み合わせる場合はUseCaseを採用
- **ビジネスルールのテスト**を重視する場合はUseCaseを採用
- **単純なCRUD操作**の場合はUseCaseは不要

### Repository層
- データアクセスとビジネスロジックを分離
- `***RepositoryProtocol`を定義してテスト可能にする
- Combineを使用したリアクティブな状態管理を実装

### ViewModel層
- `@MainActor`を使用してメインスレッドでの実行を保証
- `@Published`プロパティで状態管理
- Combineを使用したバインディング設定
- プロトコルベースの設計でSwiftUI/UIKit両対応
- UseCaseがある場合は、RepositoryではなくUseCaseを使用

### View層
- ViewModelを`@StateObject`で保持
- Repositoryは直接使用せず、ViewModel経由でアクセス
- UseCaseがある場合は、UseCase経由でアクセス
- エラーハンドリングとローディング状態の表示

### 命名規則
- Repository: `***Repository.swift`, `***RepositoryProtocol.swift`
- UseCase: `***UseCase.swift`, `***UseCaseProtocol.swift`
- ViewModel: `***ViewModel.swift`, `***ViewModelProtocol.swift`
- View: `***View.swift`

### Combine活用
- `Publishers.CombineLatest`で複数の状態を監視
- `debounce`でパフォーマンス最適化
- `assign(to:on:)`で状態の自動同期
- `AnyCancellable`でメモリリーク防止

### エラーハンドリング
- UseCase層でビジネスルールエラーを定義
- `LocalizedError`プロトコルに準拠したエラー型
- ViewModel層でエラーをキャッチしてUIに反映
- ユーザーフレンドリーなエラーメッセージを提供
