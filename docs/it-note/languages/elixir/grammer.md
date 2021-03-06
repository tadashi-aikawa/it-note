# [Elixir] Grammer


以下を参考にメモ。

{{link("https://elixirschool.com/ja/")}}


基本
----

### アトム

自身の名前が値になる定数。

```elixir
iex> :foo
:foo
```

`true`/`false`の実体はアトムの`:true`/`:false`。

### 文字列

* *UTF-8エンコードされた符合* (Unicodeではない)
* ダブルクォート
* 式展開は`#{変数名}`
* 連結は`<>`

### 割り算

* 常に浮動小数点を返す
* 整数同士の割り算や剰余は`div()`、`rem()`を使う

### 論理

`&&`や`||`、`!`について  
0、空文字、空配列は全てtrue。

真理値(bool)の後には`and`/`or`/`not`が使える。

### 比較

* `===`は厳密等価判定
* 異なる型同士の比較ができる
  * `number < atom < reference < function < port < pid < tuple < map < list < bitstring`


コレクション
------------

### リスト

* 複数の型を含むことができる `[1, "one", :one]`
* 連結リスト
  * 長さ取得に弱い
  * 要素の追加は先頭の方が良い `["hoge" | list]`
  * 末尾へ追加の場合は`++/2`を使う
* 減算は`--/2`

関数は`function_name/arity`で表現。arityは引数の数。

| 関数名 |        説明        |      例      |  結果  |
| ------ | ------------------ | ------------ | ------ |
| hd     | 先頭を取り出す     | hd [1, 2, 3] | 1      |
| tl     | 先頭以外を取り出す | tl [1, 2, 3] | [2, 3] |

### タプル

* メモリ上に隣接して格納される
  * 長さの取得に強い
  * 修正は遅い
* 分割代入/パターンマッチでよく使う

### キーワードリスト

* `[id: 1, name: "tadashi"]`
  * 上記は`[{:id, 1}, {:name, "tadashi"}]`と等価
* キーはアトム
* キーは順序付けされる
* *キーは一意とは限らない*

あくまでリスト。

### マップ

* `%{:id => 1, "name" => "tadashi"}`
  * `%`ではじまる
  * キーはどんな型でも使える. 変数もOK.
  * `=>`で値を指す
  * `map[key]`で要素を取得
* キーがアトムだけであればJavaScriptに近い書き方ができる
  * `%{id: 1, name: "tadashi"}`
  * `map.key`で要素を取得
* `|`で新しいmapのassignができる
  * `%{map | id: 100}`
  * 新しいキーの追加はできない.. `Map.put/3`を使う
    * `Map.put(map, :hoge, "hoga")`

Enum
----

関数型チックな処理です。

* デフォルトは即時処理
  * 遅延処理の場合はStreamモジュールを使う


|   関数名    |                説明                |                           例                           |                 結果                  |
| ----------- | ---------------------------------- | ------------------------------------------------------ | ------------------------------------- |
| empty?      | 空かどうかを確認する               | Enum.empty? []                                         | true                                  |
| all?        | 全てがtrueならtrue                 | Enum.all? [0, true, :true]                             | true                                  |
| any?        | 1つでもtrueならtrue                | Enum.any? [0, true, :false]                            | true                                  |
| chunk_every | 特定サイズの配列に分割する         | Enum.chunk_every 1..5, 2                               | [[1,2],[3,4],[5]]                     |
| chunk_by    | 関数の結果が同じもの同士で分割する |                                                        |                                       |
| map_every   | 一定間隔ごとに変換する             | Enum.map_every 1..5, 3, &(&1*100)                      | [100, 2, 3, 400, 5]                   |
| each        | 反復して処理を実行する             | Enum.each 1..5, &(IO.puts &1)                          | :ok                                   |
| map         | 変換する                           | Enum.map 1..5, &(&1*2)                                 | [2, 4, 6, 8, 10]                      |
| flat_map    | 変換してからフラット化する         | Enum.flat_map 1..5, &([&1, &1])                        | [1, 1, 2, 2, 3, 3, 4, 4, 5, 5]        |
| min         | 最小値を取得する                   | Enum.min 1..5                                          | 1                                     |
| max         | 最大値を取得する                   | Enum.max 1..5                                          | 5                                     |
| find        | 条件に最初に一致する要素を取得する | Enum.find 1..5, &(&1 > 2)                              | 3                                     |
| filter      | 条件に一致する要素だけ取得する     | Enum.filter 1..5, &(&1 < 3)                            | [1, 2]                                |
| reject      | 条件に一致する要素を除外する       | Enum.reject 1..5, &(&1 < 3)                            | [3, 4, 5]                             |
| reduce      | 畳み込む                           | Enum.reduce 1..5, fn(x, acc) -> x + acc end            | 15                                    |
| sum         | 全て足した値を求める               | Enum.sum 1..5                                          | 15                                    |
| sort        | ソートする                         | Enum.shuffle(5..1) &#124;> Enum.sort`                  | [1, 2, 3, 4, 5]                       |
| sort_by     | 計算した結果でソートする           | Enum.sort_by 1..5, &(rem(&1, 3))                       | [3, 1, 4, 2, 5]                       |
| reverse     | 順序を逆転する                     | Enum.reverse 1..5                                      | [5, 4, 3, 2, 1]                       |
| uniq        | ユニークにする                     | 1..10 &#124;> Enum.map(&(rem &1, 3)) &#124;> Enum.uniq | [1, 2, 0]                             |
| uniq_by     | 関数の結果でユニークにする         | 1..10 &#124;> Enum.uniq_by(&(rem &1, 3))               | [1, 2, 3]                             |
| group_by    | グルーピングする                   | Enum.group_by 1..5, &(div(&1, 2))                      | %{0 => [1], 1 => [2, 3], 2 => [4, 5]} |
| at          | 指定indexの要素を取得する          | Enum.at 1..5, 2                                        | 3                                     |
| take        | 先頭から指定した数の要素を取得する | Enum.take 1..5, 2                                      | [1, 2]                                |
| map_reduce  | mapとreductを別々に同時実行する    | Enum.map_reduce 1..5, 0, &({&1 * 10, &1 + &2})         | {[10, 20, 30, 40, 50], 15}            |
| join        | 結合して文字列にする               | Enum.join 1..5, "*"                                    | "1*2*3*4*5"                           |
| count       | 要素数を数える                     | Enum.count 1..5                                        | 5                                     |
| random      | ランダムに1要素抽出する            | Enum.random 1..5                                       | 4 (毎回変わる)                        |


パターンマッチング
------------------

### マッチ演算子

`=`のこと。代数学における統合。

#### 左辺が変数なら代入

* `x = 2`で代入
* `list = [1, 2, 3]`で代入

#### 左辺が変数ではなければマッチ

* `2 = x`はマッチ
* `[1 | tail] = list`はマッチ

### ピン演算子

`^`のこと。左辺が変数でも代入ではなくマッチになる。

* `x = 2`は代入
* `2 = x`はマッチ
* `^x = 2`はマッチ

マップでも使える。

```elixir
key = :hello
%{^key => value} = %{hello: "world"}
```

以下はいずれも受けつけない。

* `%{key: value}`
* `%{^key: value}`


制御構文
--------

### ifとunless

* `if ... do ... end`
* ifの逆が `unless ... do ... end`
* `do`と`end`の間にelseが入ることがある

### case

パターンマッチ

```elixir
case ... do
  ... -> ...
  ... -> ...
  _ -> ...
end
```

定義済み変数にマッチさせる場合、`->`の左辺はピン演算子にする。

### when

パターンマッチ中のガード節として使う。

```elixir
case {1, 2, 3} do
  {1, x, 3} when x > 0 -> "match"
  _ -> "not match"
end
```

### cond

条件をマッチできる。`else if`のようなもの。

```elixir
cond do
  x + y == 5 -> "five"
  x * 2 == 7 -> "seven"
  true -> "other"
end
```

`default`的なものは`true`で拾う。

### with

`case/2`がネストするケースをflatに表現するのに便利

```elixir
with {:ok, id} <- Map.fetch(user, :id),
     {:ok, name} <- Map.fetch(user, :name),
     do: "[#{id}] #{name}"
```

`else`節で`:error`をキャッチできる


関数
----

### 匿名関数

#### 定義

```
func = fn (x, y) -> x + y end
```

省略記法を使うと

```
func = &(&1 + &2)
```

#### 呼び出し

```elixir
func.(2, 4)
```

❓ `func 2, 4`ではダメ..


### 名前付き関数

モジュールの中に`def ... do ... end`で定義する。

```elixir
defmodule Module do
  def func() do
    ...
  end
end
```

1行でもOK。

```elixir
defmodule Module do
  def func(), do: "Hello"
end
```

`,`と`:`がポイント

#### 命名とアリティ

名前が同じでもアリティが異なれば、異なる関数 (オーバーロードとは違う).

