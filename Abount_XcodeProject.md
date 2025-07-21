## 基本のルール（これだけ覚える）

### ルール1: 機能ごとにフォルダを作る

```
ViewControllers/
├── Login/           # ログイン機能
├── UserList/        # ユーザー一覧機能
└── UserEdit/        # ユーザー編集機能

```

### ルール2: 1つの機能フォルダには必ず5つのファイル

```
UserEdit/
├── UserEditViewController.swift    # 画面制御
├── UserEdit.storyboard            # 画面デザイン
├── UserEditModel.swift            # データ
├── UserEditType.swift             # 設定・種類
└── UserEditProtocol.swift         # インターフェース定義

```

### ルール3: 共通で使うものは別フォルダ

```
Views/           # どの画面でも使うUI部品
Models/          # どの機能でも使うデータ
Protocols/       # どの機能でも使うインターフェース
Utils/           # どこでも使う便利機能

```

### ルール4: 1ファイル = 1クラス（絶対守る）

```
✅ 良い例:
UserModel.swift          → class UserModel のみ
UserType.swift           → enum UserType のみ
UserProtocol.swift       → protocol UserProtocol のみ

❌ 悪い例:
UserStuff.swift          → class UserModel + enum UserType（複数はダメ）

```

---

## 実際の例で覚える

### 📱 TODOアプリを作る場合

### Step 1: 機能を決める

- TODOリスト表示
- TODO詳細・編集
- 設定画面

### Step 2: フォルダを作る

```
ViewControllers/
├── TodoList/        # リスト画面
├── TodoEdit/        # 編集画面
└── Settings/        # 設定画面

```

### Step 3: 各機能フォルダの中身

```
TodoList/
├── TodoListViewController.swift    # リスト画面の制御
├── TodoList.storyboard            # リスト画面のデザイン
├── TodoListModel.swift            # TODOデータの構造
├── TodoListType.swift             # 並び順・フィルター設定
└── TodoListProtocol.swift         # データ取得のインターフェース

TodoEdit/
├── TodoEditViewController.swift   # 編集画面の制御
├── TodoEdit.storyboard           # 編集画面のデザイン
├── TodoEditModel.swift           # 編集用データ
├── TodoEditType.swift            # 優先度・カテゴリ設定
└── TodoEditProtocol.swift        # 保存処理のインターフェース

```

---

## 📸 写真アプリを作る場合

### 機能分析

- 写真一覧
- 写真詳細
- カメラ撮影
- アルバム管理

### フォルダ構成

```
ViewControllers/
├── PhotoList/       # 写真一覧
│   ├── PhotoListViewController.swift
│   ├── PhotoList.storyboard
│   ├── PhotoListModel.swift
│   ├── PhotoListType.swift
│   ├── PhotoListProtocol.swift
│   ├── Views/       # この機能だけで使うUI
│   │   ├── PhotoCell.swift          # 1クラスのみ
│   │   └── PhotoCell.xib
│   ├── Structs/     # この機能のデータ
│   │   ├── Photo.swift              # struct Photo のみ
│   │   └── PhotoMetadata.swift      # struct PhotoMetadata のみ
│   ├── Enumerations/ # この機能の設定
│   │   ├── PhotoSortType.swift      # enum PhotoSortType のみ
│   │   └── PhotoFilterType.swift    # enum PhotoFilterType のみ
│   └── Protocols/   # この機能のインターフェース
│       ├── PhotoDataSource.swift    # protocol PhotoDataSource のみ
│       └── PhotoCellDelegate.swift  # protocol PhotoCellDelegate のみ
│
├── Camera/          # カメラ機能
│   ├── CameraViewController.swift
│   ├── Camera.storyboard
│   ├── CameraModel.swift
│   ├── CameraType.swift
│   ├── CameraProtocol.swift
│   └── Views/
│       └── CameraControlView.swift  # class CameraControlView のみ
│
└── Album/           # アルバム機能
    ├── AlbumViewController.swift
    ├── Album.storyboard
    ├── AlbumModel.swift
    ├── AlbumType.swift
    └── AlbumProtocol.swift

```

---

## 判断基準（迷った時に使う）

### Q: 新しい画面を作る時、どこに置く？

**A: 3つの質問で決める**

1. **他の機能と関係ある？**
    - YES → 既存の機能フォルダに追加
    - NO → 新しい機能フォルダを作る
2. **ファイルが3個以上になる？**
    - YES → 機能フォルダを作る
    - NO → ViewControllersの直下でOK
3. **他の機能でも使う？**
    - YES → Views/, Models/, Utils/に置く
    - NO → 機能フォルダ内に置く

### 実例で判断

```
✅ 良い例: ユーザー一覧 → ユーザー詳細
UserList/
├── UserListViewController.swift
├── UserList.storyboard
├── UserDetailViewController.swift    # 関連機能なので同じフォルダ
└── UserDetail.storyboard

❌ 悪い例:
UserList/
├── (ユーザー関連ファイル)
└── SettingsViewController.swift     # 設定は別機能なので別フォルダにする

```

---

## よくある間違いと正解

### ❌ 間違い1: 全部バラバラに置く

```
ViewControllers/
├── ViewController1.swift
├── ViewController2.swift
├── ViewController3.swift
└── (100個のファイルが散乱...)

```

### ✅ 正解1: 機能でまとめる

```
ViewControllers/
├── User/
├── Product/
└── Order/

```

### ❌ 間違い3: 1ファイルに複数のクラス

```
UserManager.swift の中身:
class UserModel { }        # ←これと
enum UserType { }          # ←これが同じファイル（ダメ！）
protocol UserDelegate { } # ←これも同じファイル（ダメ！）

```

### ✅ 正解3: 1ファイル1クラス

```
UserModel.swift     → class UserModel のみ
UserType.swift      → enum UserType のみ
UserProtocol.swift  → protocol UserDelegate のみ

```

```
ViewControllers/
└── User/
    └── Management/
        └── Detail/
            └── Edit/
                └── Advanced/
                    └── Settings/    # 深すぎ！

```

### ❌ 間違い2: 深すぎる階層

```
ViewControllers/
└── User/
    └── Management/
        └── Detail/
            └── Edit/
                └── Advanced/
                    └── Settings/    # 深すぎ！

```

### ✅ 正解2: 最大3階層まで

```
ViewControllers/
└── User/
    ├── UserListViewController.swift
    └── Views/                      # 最大3階層
        └── UserCell.swift

```

---

## 命名ルール（絶対守る）

### ViewController

```
[機能名]ViewController.swift
例: UserListViewController.swift
   PhotoEditViewController.swift

```

### Storyboard

```
[機能名].storyboard
例: UserList.storyboard
   PhotoEdit.storyboard

```

### Model/Struct

```
[機能名]Model.swift
例: UserModel.swift
   PhotoModel.swift

```

### Enum/Type

```
[機能名]Type.swift
例: UserType.swift
   PhotoSortType.swift

```

### Protocol

```
[機能名]Protocol.swift
例: UserProtocol.swift
   PhotoDataSource.swift

```

### 1ファイル1クラスの例

```
✅ 正しいファイル分割:
UserModel.swift          → struct UserModel のみ
UserType.swift           → enum UserType のみ
UserProtocol.swift       → protocol UserDataSource のみ
UserRepository.swift     → class UserRepository のみ

❌ 間違った例（1ファイルに複数）:
UserStuff.swift          → struct + enum + protocol（ダメ！）

```

---

## 🚀 実装手順（新機能を作る時）

### Step 1: 機能名を決める

例：「商品検索機能」→ `ProductSearch`

### Step 2: フォルダを作る

```
ViewControllers/ProductSearch/

```

### Step 3: 基本5ファイルを作る

```
ProductSearch/
├── ProductSearchViewController.swift
├── ProductSearch.storyboard
├── ProductSearchModel.swift
├── ProductSearchType.swift
└── ProductSearchProtocol.swift

```

### Step 4: 必要に応じて追加（1ファイル1クラスで）

```
ProductSearch/
├── (基本5ファイル)
├── Views/              # カスタムUI が必要なら
│   ├── SearchResultCell.swift      # class SearchResultCell のみ
│   └── SearchFilterView.swift      # class SearchFilterView のみ
├── Structs/            # 複数のデータ構造があるなら
│   ├── SearchResult.swift          # struct SearchResult のみ
│   └── SearchQuery.swift           # struct SearchQuery のみ
├── Enumerations/       # 複数の設定があるなら
│   ├── SearchCategory.swift        # enum SearchCategory のみ
│   └── SortOrder.swift             # enum SortOrder のみ
└── Protocols/          # 複数のインターフェースがあるなら
    ├── SearchDataSource.swift      # protocol SearchDataSource のみ
    └── SearchDelegate.swift        # protocol SearchDelegate のみ

```

---

## まとめ

**覚えることは4つだけ：**

1. **機能ごとにフォルダを作る**
2. **1機能 = 5ファイル（Controller, Storyboard, Model, Type, Protocol）**
3. **1ファイル = 1クラス（絶対に混ぜない）**
4. **共通で使うものは別フォルダ**

**判断に迷ったら：**

- 「この機能は他と関係あるか？」→ YES なら一緒、NO なら別フォルダ
- 「1つのファイルに2つ以上のクラスを書きたい」→ 絶対にダメ！分割する

**ファイル分割の鉄則：**

- 1つの.swiftファイルには1つのclass/struct/enum/protocolのみ
- 複数の関連クラスでも必ず別ファイルに分ける

これだけ覚えれば、どんなアプリでも整理されたプロジェクトが作れます！