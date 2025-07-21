## 概要

本仕様書は、iOSアプリ開発における標準的なXcodeプロジェクトのディレクトリ構成を定義します。機能別・レイヤー別の階層構造により、コードの可読性・保守性・拡張性を向上させることを目的としています。

## 基本設計思想

- **機能別グルーピング**: 関連する機能を同一ディレクトリに配置
- **レイヤー分離**: UI層、ビジネスロジック層、データ層を明確に分離
- **共通コンポーネントの再利用**: 共通で使用する要素は専用ディレクトリで管理
- **階層の明確化**: ネストレベルを適切に設定し、プロジェクト構造を直感的に理解可能

## ディレクトリ構成

### ルートレベル

```
ProjectRoot/
├── ViewControllers/     # 画面制御ロジック
├── Views/              # 共通UI部品
├── Structs/            # データ構造定義
├── Enumerations/       # 列挙型定義
├── Extensions/         # 既存クラス拡張
├── Models/             # データモデル
└── Utils/              # ユーティリティ

```

### ViewControllers ディレクトリ

画面の制御ロジックとUI定義を格納する最上位ディレクトリ

### 構成パターン1: 単一画面

```
ViewControllers/
├── LoginViewController.swift    # ログイン画面制御
└── Login.storyboard            # ログイン画面UI定義

```

### 構成パターン2: 機能別グルーピング

```
ViewControllers/
└── UserManagement/             # ユーザー管理機能
    ├── UserStartViewController.swift     # 一覧画面制御
    ├── UserStart.storyboard             # 一覧画面UI
    ├── UserEditViewController.swift     # 編集画面制御
    ├── UserEdit.storyboard              # 編集画面UI
    ├── Views/                           # 機能専用View
    │   ├── UserEditCell.swift           # カスタムセル
    │   └── UserEditCell.xib             # セルUI定義
    ├── Structs/                         # 機能専用データ構造
    │   └── UserModel.swift              # ユーザーデータモデル
    └── Enumerations/                    # 機能専用列挙型
        └── UserType.swift               # ユーザー種別定義

```

## 各ディレクトリの役割と規則

### 1. ViewControllers

**役割**: 画面の制御ロジックとUI定義の管理

**命名規則**:

- ViewController: `[機能名]ViewController.swift`
- Storyboard: `[機能名].storyboard`
- 機能ディレクトリ: `[機能名]` (PascalCase)

**配置基準**:

- 単一画面の場合: ViewControllersディレクトリ直下
- 複数画面で構成される機能: 機能名でディレクトリを作成し、その下に配置

### 2. Views (共通)

**役割**: プロジェクト全体で再利用可能なUI部品

**格納対象**:

- カスタムビュー
- 共通ヘッダー/フッター
- 再利用可能なUI部品
- 共通アニメーション

**命名規則**: `[部品名]View.swift`

### 3. Views (機能専用)

**役割**: 特定機能でのみ使用するUI部品

**格納対象**:

- カスタムセル
- 機能専用のUI部品
- .xibファイル

**命名規則**: `[機能名][部品名].swift`, `[機能名][部品名].xib`

### 4. Structs

**役割**: データ構造とValueTypeの定義

**分類**:

- **共通Structs**: プロジェクト全体で使用するデータ構造
- **機能専用Structs**: 特定機能でのみ使用するデータ構造

**格納対象**:

- データモデル
- リクエスト/レスポンス構造体
- 設定情報構造体

### 5. Enumerations

**役割**: 列挙型とオプション定義

**分類**:

- **共通Enumerations**: アプリ全体で使用する列挙型
- **機能専用Enumerations**: 特定機能の状態や種別定義

**格納対象**:

- 状態定義 (State, Status)
- 種別定義 (Type, Category)
- エラー定義 (Error)

### 6. Extensions

**役割**: 既存クラス・構造体の機能拡張

**格納対象**:

- Foundation/UIKit拡張
- 自作クラスの拡張
- プロトコル拡張

**命名規則**: `[対象クラス名]+[拡張内容].swift`

### 7. Models

**役割**: ビジネスロジックとデータ永続化

**格納対象**:

- ビジネスロジック
- データアクセス層
- APIクライアント
- データベース操作

### 8. Utils

**役割**: 汎用的なユーティリティ機能

**格納対象**:

- ヘルパークラス
- 共通定数
- 設定管理
- ログ機能

## 適用例

### 例1: TODOアプリの構成

```
TodoApp/
├── ViewControllers/
│   ├── TodoListViewController.swift
│   ├── TodoList.storyboard
│   └── TodoDetail/
│       ├── TodoDetailViewController.swift
│       ├── TodoDetail.storyboard
│       ├── Views/
│       │   ├── TodoDetailCell.swift
│       │   └── TodoDetailCell.xib
│       ├── Structs/
│       │   └── TodoItem.swift
│       └── Enumerations/
│           └── TodoStatus.swift
├── Views/
│   ├── CustomButton.swift
│   └── LoadingView.swift
├── Structs/
│   └── AppConfig.swift
├── Enumerations/
│   └── AppError.swift
├── Extensions/
│   ├── UIViewController+Alert.swift
│   └── Date+Format.swift
├── Models/
│   ├── TodoRepository.swift
│   └── APIClient.swift
└── Utils/
    ├── Logger.swift
    └── Constants.swift

```

### 例2: ECアプリの構成

```
ShopApp/
├── ViewControllers/
│   ├── Product/
│   │   ├── ProductListViewController.swift
│   │   ├── ProductList.storyboard
│   │   ├── ProductDetailViewController.swift
│   │   ├── ProductDetail.storyboard
│   │   ├── Views/
│   │   │   ├── ProductCell.swift
│   │   │   └── ProductCell.xib
│   │   ├── Structs/
│   │   │   └── Product.swift
│   │   └── Enumerations/
│   │       └── ProductCategory.swift
│   └── Cart/
│       ├── CartViewController.swift
│       ├── Cart.storyboard
│       ├── Views/
│       │   ├── CartItemCell.swift
│       │   └── CartItemCell.xib
│       └── Structs/
│           └── CartItem.swift
├── Views/
│   ├── RatingView.swift
│   └── PriceLabel.swift
├── Models/
│   ├── ProductRepository.swift
│   ├── CartManager.swift
│   └── PaymentService.swift
└── Utils/
    ├── ImageCache.swift
    └── NetworkMonitor.swift

```

## 運用ガイドライン

### ディレクトリ作成の判断基準

1. **機能の独立性**: 他機能と明確に分離できる場合は機能ディレクトリを作成
2. **ファイル数**: 3ファイル以上の関連ファイルがある場合はディレクトリ化を検討
3. **再利用性**: 他機能でも使用する可能性がある場合は共通ディレクトリに配置

### 命名規則

- **ディレクトリ**: PascalCase (例: UserManagement)
- **ファイル**: PascalCase + 用途サフィックス (例: UserEditViewController.swift)
- **機能専用要素**: [機能名] + [要素名] (例: UserEditCell)

### 保守運用

- 定期的な構成見直し (機能追加時)
- 共通化可能な要素の抽出
- 不要ファイルの削除とリファクタリング
- ドキュメントの更新

## まとめ

この構成により、以下の効果が期待できます：

- **開発効率向上**: 目的のファイルを迅速に特定可能
- **チーム開発**: 一貫した構成により協調開発が円滑
- **保守性向上**: 影響範囲の特定と変更が容易
- **拡張性確保**: 新機能追加時の構成が明確