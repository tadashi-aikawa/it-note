# [Haskell] Grammer


基本文法
--------

クセがあるものだけを記載し、他言語によくあるものは省略します。

### Not equal

`a /= b`

### 関数

* 前置関数と中置関数がある
* 呼び出しは全てスペース区切り

#### 前置関数

```
関数名 引数1 引数2
```

ほとんどのケースは前置関数。

#### 中置関数

```
引数1 関数名 引数2
```

関数名が特殊文字だけからなる場合、デフォルトで中置関数となる。

```
> a !!! b = a*b
> 10 !!! 2
20
```

### 前置関数と中置換数の変換

前置関数をバッククォートで括ると中置換数になる。

```
> max 16 5
16
> 16 `max` 5
16
```

ℹ️ 関数定義の時も使える


中置関数を`()`で括ると前置関数になる。

```
> 5 == 3
False
> (==) 5 3
False
```


### 命名

* camelCase
  * PascalCaseにはそもそもできない (❓)
* アポストロフィ`'`が付く場合、その関数は **正格** であることが多い

### 三項演算子

` = if ... then ... else ...`

elseは必須


命名規約
--------

### 変数

camelCase

* 使わない変数は`_`

### 型

PascalCase

### 型変数

camelCase.. ただ基本的に1文字

### 関数

camelCase


エラー
------

`error <メッセージ>`でランタイムエラーを発生させる。

```
> error "hogehoge"
*** Exception: hogehoge
```


リスト
------

`[1, 2, 3]`

### 連結

`[1, 2] ++ [3, 4]`

左側のリストは最後まで走査されてしまうので、結合は **cons演算子** を使った方がよい。

`1:2:[3, 4]`

なお、`[3, 4]`は`3:4:[]`の糖衣構文。


### アクセス

`[1, 2, 3] !! 1`


### 比較

`==`, `>`, `<` などが使える。

### レンジ

範囲指定の簡略表記ができる。

* `[1,2,3,4,5]`は`[1..5]`
* `[1,3,5,7,9]`は`[1,3..9]`
* 要素1の無限リストは`[1,1..]`
* `abcdfeghijklmnopqrstuvwxyz`は`['a','b'..'z']`
* `[5,4,3,2,1]`は`[5,4..1]` (`[5..1]`はダメ)

上限数を指定する場合は後述の`take`を使う。  
無限リストは遅延評価なのでHaskellっぽい。

⚠️浮動小数点は精度の問題でうまくいかないときがある


### 基本的なリスト関数

|   関数    |              意味              |        記載例        |    結果     |
| --------- | ------------------------------ | -------------------- | ----------- |
| head      | 先頭の要素を取得               | head [1..5]          | 1           |
| take      | 先頭から指定数の要素を取得     | take 3 [1..]         | [1,2,3]     |
| init      | 末尾の要素以外を取得           | init [1..5]          | [1,2,3,4]   |
| tail      | 先頭の要素以外を取得           | tail [1..5]          | [2,3,4,5]   |
| drop      | 先頭から指定数の要素以外を取得 | drop 3 [1..5]        | [4,5]       |
| last      | 末尾の要素を取得               | last [1..5]          | 5           |
| length    | 長さを取得                     | length [1..5]        | 5           |
| null      | 空であるか判定                 | null []              | True        |
| reverse   | 逆順を取得                     | reverse [1..5]       | [5,4,3,2,1] |
| maximum   | 最大値を取得                   | maximum [1..5]       | 5           |
| minimum   | 最小値を取得                   | minimum [1..5]       | 1           |
| sum       | 全ての和を取得                 | sum [1..5]           | 15          |
| product   | 全ての積を取得                 | product [1..5]       | 120         |
| elem      | 要素が含まれているかどうか     | elem 3 [1..5]        | True        |
| cycle     | リストを無限に繰り返す         | take 5 $ cycle [1,2] | [1,2,1,2,1] |
| repeat    | 要素を無限に繰り返す           | take 5 $ repeat 2    | [2,2,2,2,2] |
| replicate | 要素を複製する                 | replicate 3 5        | [5,5,5]     |

`elem`は中置で使われることが多い。


### 内包表記

```haskell
> [x*10 | x <- [1..5], x /= 1, x /= 4]
[20,30,50]

> [x*y | x <- [1..5], y <- [1,10,100]]
[1,10,100,2,20,200,3,30,300,4,40,400,5,50,500]
```

`x <- [1..5]`のような部分を**ジェネレータ**と呼ぶ。


タプル
------

`(1, 1.1, 'a')`

* 複数の違う型の要素を1つの値として扱う (ヘテロである)
* サイズが固定

### 取り出し

ペア(要素が2つ)のタプルには以下がある。

* `fst` で1つ目の要素取り出し
* `snd` で2つ目の要素取り出し

### 2つのリストからタプルのリストを作る

`zip`を使う。

```haskell
> zip [1..5] ['a'..'e']
[(1,'a'),(2,'b'),(3,'c'),(4,'d'),(5,'e')]
```

リストの長さが違う場合は短い方にあわせる。  
無限リストとzipするとｶｯｺｲｲ

### 空タプル

`()`は空タプル。Unitと呼ばれている。


型
--

### 型宣言

`関数名 :: 引数の型 -> 戻り値の型`

複数引数がある場合は`->`で繋ぐ

`関数名 :: 引数1の型 -> 引数2の型 -> 引数3の型 -> 戻り値の型`


### 一般的な型

|  型名   |        意味        |          備考          |
| ------- | ------------------ | ---------------------- |
| Int     | 有界な整数         |                        |
| Integer | 有界ではない整数   | 効率的ではない         |
| Float   | 浮動小数点数       | 小数点以下第7桁まで    |
| Double  | 倍精度浮動小数点数 | 小数点以下第15桁まで   |
| Bool    | 真理値型           | True or False          |
| Char    | Unicode文字        | シングルクォートで括る |


### 型変数

* ジェネリクスのようなもの
* 小文字から始まる
* 慣例的に一文字であることが多い (a, bなど)

headの場合

```haskell
> :t head
head :: [a] -> a
```

型変数を用いた関数を**多相的関数**と呼ぶ。


### 型クラス

* 振る舞いを定義するインタフェース
* 型はある型クラスのインスタンスになり得る
* ある型クラスに属する関数 = **その型クラスのメソッド**

`==`の具体例

```haskell
> :t (==)
(==) :: Eq a => a -> a -> Bool
```

* 型クラス`Eq`のインスタンスとなる型`a`の変数を2つ受け取り、`Bool`を返す ということ
* `=>`の前にあるものは**型クラス制約**
* 型クラス制約が複数の場合は `(Eq a, Num b) => a -> b)` のように書く

⚠️型クラスはオブジェクト指向のクラスとは全く関係ない


#### Eq型クラス

| 実装すべき関数 |       型       |     説明     |
| -------------- | -------------- | ------------ |
| ==             | a -> a -> Bool | 等しいか     |
| /=             | a -> a -> Bool | 等しくないか |


#### Ord型クラス

順序づけ

| 実装すべき関数 |         型         |                    説明                     |
| -------------- | ------------------ | ------------------------------------------- |
| compare        | a -> a -> Ordering | 2値の 大きい(GT)/小さい(LT)/等しい(EQ) 判定 |


#### Show型クラス

文字列としての表現

| 実装すべき関数 |     型      | 説明 |
| -------------- | ----------- | ---- |
| show           | a -> String |      |


#### Read型クラス

文字列を受け取り、Readのインスタンスの型の値を返す。

| 実装すべき関数 |     型      | 説明 |
| -------------- | ----------- | ---- |
| read           | String -> a |      |

⚠️型注釈を使って明示的に`a`が何型であるか.. 指定しなければいけないケースもある


#### Enum型クラス

順場に並んだ列挙できる型

| 実装すべき関数 |   型   |      説明      |
| -------------- | ------ | -------------- |
| succ           | a -> a | 連続する次の値 |
| pred           | a -> a | 連続する前の値 |

Char, Int, など


#### Bounded型クラス

上限と下限を持つ

| 実装すべき関数 | 型  |  説明  |
| -------------- | --- | ------ |
| minBound       | a   | 最小値 |
| maxBound       | a   | 最大値 |

❓ 多相定数

#### Num型クラス

実数全て

#### Floating型クラス

浮動小数点

#### Integral型クラス

整数のみ

### 型注釈

`... :: 型`

型を教えてあげる。

```
> read "5"
*** Exception: Prelude.read: no parse
> read "5" :: Int
5
```


パターンマッチ
--------------

全体としては分割代入に近いかもしれない。

上から順番にパターンを試し、一致するパターンの処理が実行される。

```haskell
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)
```

### タプルのパターンマッチ

`OK`
```haskell
addVectors :: (Double, Double) -> (Double, Double) -> (Double, Double)
addVectors a b = (fst a + fst b, snd a + snd b)
```

`GOOD`
```haskell
addVectors :: (Double, Double) -> (Double, Double) -> (Double, Double)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)
```

### リストのパターンマッチ

secondが3のタプルに対してのみfilterし、fstに100をかけた値に変換する。  
関数型の場合、filterとmapがいる処理。

```haskell
> xs = [(1,3),(4,3),(2,4),(5,3),(5,6),(3,1)]
> [a*100 | (a, 3) <- xs]
[100,400,500]
```

headの再実装hd

```haskell
hd :: [a] -> a
hd [] = error "Invalid"
hd (x:_) = x
```

複数変数に束縛する場合は丸カッコで囲まないとシンタックスエラーになる。  
つまり、 `hd x:_ = x` だとダメ。

* `x:_ = [1,2,3]`のような代入はできる
* `(x:[])`や`(x:y:[])`は`[x]`や`[x,y]`とも書ける
  * ただし、`(x:_)`や`(x:y:_)`は角カッコで表現できない
* `++`は使えない

### asパターン

`all@(x:xs)`のようにすると、`all = (x:xs)`とみなして扱える。

```haskell
> duplicateHead :: [a] -> [a]
> duplicateHead all@(x:xs) = x:all
> duplicateHead [3,2,4]
[3,3,2,4]
```

### case式のパターンマッチ

上で登場したこのパターンマッチ..

```haskell
hd :: [a] -> a
hd [] = error "Invalid"
hd (x:_) = x
```

caseを使うとこうなる

```haskell
hd :: [a] -> a
hd xs = case xs of [] -> error "Invalid"
                (x:_) -> x
```

上で登場したパターンマッチとの違いは、関数定義のとき以外も使えること。  
三項演算子みたいなノリで式の途中に出現可能。

```haskell
len :: [a] -> String
len xs = "Length is" ++ case xs of
  [] -> "empty"
  [x] -> "only"
  xs -> "many"
```


ガード
------

* パターンマッチで絞り込まれた後の引数チェック
* パイプ文字で繋ぎ、左辺:真理値式 & 右辺:結果 を書く
  * パイプ = caseのノリ
* 主に範囲を示す場合。値の一致ならパターンマッチでも可能

```haskell
humanKind :: Int -> String
humanKind age
  | age < 35 = "若者"
  | age < 65 = "おっさん"
  | otherwise = "じっちゃん"
```

`otherwise`が無ければ次のパターン(≠ガード)に移る。


where
-----

説明変数代入のようなもの。

```haskell
bmiTell :: Double -> Double -> String
bmiTell weight height
  | bmi < 15.0 = "too low"
  | bmi < 22.5 = "ok"
  | otherwise = "too high"
  where bmi = weight / height^2
```

計算量も減るし可読性も上がるので計算が重複する場合は使おう。

whereのスコープは同一パターン内。別パターンでは解決しない。


let
---

whereと似ているが最初に束縛する。

```haskell
sum3 :: Num a => a -> a -> a -> a
sum3 a b c =
  let ab = a + b
  in ab + c
```

😄whereと違いletは式であるから以下のような表現も可能。

```haskell
> 1 + (let a = 2; b = 3 in a*b)
7
```

😢whereと違いletはガードと併用できない(ガードの中まで束縛できない)  
ガードしたければletを使うこと。内包表記で条件指定するときに便利。

```haskell
calcBmis :: [(Double, Double)] -> [Double]
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h^2, bmi > 25.0]
```


カリー化
--------

* `カリー化関数`: 1引数であり、次の引数を受け取る関数を返す関数
* `部分適用された関数`: 関数を本来より少ない引数で呼び出したときに得られる関数

`max4 = max 4`の場合

* `max`はカリー化関数
* `max4`は部分適用された関数

❓Haskellの関数は全てカリー化関数でもある

### セクションによる中置換数の部分適用

中置換数`+`を部分適用する場合は`(/10)` or `(10/)`のようにカッコで括って片側だけ値を埋める。  
これをセクションという。

```haskell
> f1 = (/10)
> f2 = (10/)
> f1 100
10.0
> f2 100
0.1
```

⚠️`-`だけは注意。`(-4)`はただのマイナス4であるから`(subtract 4)`とする必要がある。

`zipWith`は便利。

```haskell
> :t zipWith
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
> zipWith (*) [1..5] $ cycle [1,-1]
[1,-2,3,-4,5]
```

### 高階関数を使った便利な標準関数一覧

|   関数    |                  意味                  |            記載例            |    結果    |
| --------- | -------------------------------------- | ---------------------------- | ---------- |
| zipWith   | 2つの配列を演算した結果の配列を作る    | zipWith (+) [1,2,3] [4,5,6]  | [5,7,9]    |
| flip      | 最初の2引数が入れ替わった関数を作る    | flip compare 10 5            | LT         |
| map       | 処理を加えた配列を作る                 | map (+3) [10,11,12]          | [13,14,15] |
| filter    | 条件を満たす要素のみの配列を作る       | filter even [10..15]         | [10,12,14] |
| takeWhile | 連続して条件が満たす箇所まで配列を作る | takeWhile even [2,4,7,6,8,9] | [2, 4]     |


ラムダ式
--------

`(\x -> x + 1)`

* `λ`に似た`\`を頭につけて表現
* 普通は全体をカッコで括る
* 複数引数は `(\x y -> x + y)`

3の倍数

```haskell
> filter (\x -> x `mod` 3 == 0) [1..10]
[3,6,9]
```


畳み込み
--------

accumuratorは畳み込みによる途中結果

### 左畳み込み foldl

左から畳み込む。

```haskell
> foldl (-) 0 [1..5]
-15
```

* `((((0 - 1) - 2 ) - 3) - 4) - 5`
  * つまり `0 - 1 - 2 - 3 - 4 - 5` と等価
* `foldl`の第一引数関数の引数は `accumurator, x`の順

### 右畳み込み foldr

右から畳み込む。

```haskell
> foldr (-) 0 [1..5]
3
```

* `5 - (4 - (3 - (2 - (1 - 0))))` と等価
* `foldr`の第一引数関数の引数は `x, accumurator`の順
  * **`foldl`と逆なので注意**
* **右畳み込みは無限リストに対して動作する** というのが最大の強み！
  * filterなどリスト再生成系ではまず考える

### 初期値省略の foldl1 foldr1

⚠️リストが空の場合はエラーになるので注意。リストが空でないことが保証されている場合のみ使うこと

```haskell
> foldl1 (-) [1..5]
-13
```

* `1 - 2 - 3 - 4 - 5`と等価

```haskell
> foldr1 (-) [1..5]
3
```

* `5 - (4 - (3 - (2 - 1)))` と等価
* 初期値は右端の`5`ではなく、左端の`1`

### 正格な畳み込み

畳み込みは遅延評価であるがゆえに完了するまで途中経過をメモリに展開する。  
そのため、対象のリストが巨大だとStack Overflowになる。

```haskell
foldl (+) 0 (replicate 100000000 1)
```

`foldl`の代わりに`Data.List`モジュールの`foldl'`を使うと正格で即時評価できる。

```haskell
import Data.List (foldl')
foldl' (+) 0 (replicate 100000000 1)
```

なお`foldr'`は存在しない。

### scan

`fold`は最終結果のみだが、`scan`は途中経過を含めたリストを返却する。  
`scanl`, `scanr`, `scanl1`, `scanr1`など一通りある。

```haskell
> scanl1 (+) [1..10]
[1,3,6,10,15,21,28,36,45,55]
> scanr1 (+) [1..10]
[55,54,52,49,45,40,34,27,19,10]
```

`scanl`と`scanr`では順序が逆になるので注意。


関数適用演算子
--------------

`$`のこと。  
以下は同じ意味。

```haskell
> sum (filter even [1..10])
30
> sum $ filter even [1..10]
30
```

`(...)`が`$ ...`になると覚える方が簡単かも。  
通常は左結合だけど、`$`が登場した瞬間『おいちょっとまてよ』となるんですな😘


関数合成
--------

`.`のこと。  
以下は同じ意味。

```haskell
> sum $ map (*10) $ filter even [1..10]
300
> sum . map (*10) $ filter even [1..10]
300
```

関数は合成の結果は関数なので、関数適用演算子とは異なり`=`が使える。

```haskell
> method = sum . map (*10) . filter even
> method [1..10]
300
```


ポイントフリースタイル
----------------------

```haskell
summ xs = foldl1 (+) xs
```

この関数は`xs`を両辺から削除しても成立する。  
なぜなら`summ`は`foldl1`を部分適用した関数になるから。

```haskell
summ = foldl1 (+)
```

このような省略スタイルをポイントフリースタイルという。


モジュール
----------

関数、型、型クラスなどが定義されたファイルのこと。

Preludeはデフォルトでインポートされている。

### インポート

ファイルの先頭に書かなければいけない。

`import モジュール名`でインポートする。

```haskell
*Main Lib> import Data.List
*Main Lib Data.List> :t nub
nub :: Eq a => [a] -> [a]
```

一部のみインポートする場合は指定する。

```haskell
> import Data.List (nub, sort)
```

別名インポート

```haskell
> import qualified Data.Map as M
```

⚠️ `Data.Map`が読み込めない..


### Data.List

|    関数    |             意味             |               記載例                |           結果            |
| ---------- | ---------------------------- | ----------------------------------- | ------------------------- |
| nub        | 重複する値をユニークにする   | nub [1,2,3,2,1,3]                   | [1,2,3]                   |
| words      | 文字に分割する               | words "It is a member"              | ["It","is","a","member"]  |
| group      | 隣接要素をグループ化する     | group [2,3,2,2,4,3]                 | [[2],[3],[2,2],[4],[3]]   |
| sort       | ソートする                   | sort [2,3,2,2,4,3]                  | [2,2,2,3,3,4]             |
| tails      | 全てのtailパターンを取得する | tails [1,2,3]                       | [[1,2,3], [2,3], [3], []] |
| isPrefixOf | prefixで始まるか判定する     | isPrefixOf "Mr" "Mr. Tom"           | True                      |
| find       | 初めて条件を満たす要素を返す | find (>3) [2,1,4,2,5]               | Just 4                    |
| findIndex  | 初めて条件を満たす位置を返す | findIndex (>3) [2,1,4,2,5]          | Just 2                    |
| isInfixOf  | 包含されているかを判定する   | isInfixOf [2,3] [1..5]              | True                      |
| lookup     | keyからvalueを検索する       | lookup 2 [(1, "taro"), (2, "jiro")] | Just "jiro"               |

### Data.Char

|    関数    |           意味           |     記載例     | 結果 |
| ---------- | ------------------------ | -------------- | ---- |
| ord        | 文字を対応数値に変換する | ord 'a'        | 97   |
| chr        | 数値を対応文字に変換する | chr 97         | 'a'  |
| digitToInt | 文字を数字に変換する     | digitToInt '6' | 6    |
| isDigit | 数値かどうかを判定する | isDigit '6' | True |

### Data.Map

名前競合するため`import qualified Data.Map as Map`で名前付けるのがよい。  
`:set -package containers`が必要だった。これは❓


`fromList`で連想リストから変換。

```haskell
members :: Map.Map Int String
members = Map.fromList [(1, "tadashi"), (2, "tagayasu"), (3, "seigo")]
```

keyが重複する場合は`fromListWith`を使う。値をどう合体させるかは指定が必要。

```haskell
members :: Map.Map Int String
members = Map.fromListWith (++) $ map (\(k, v) -> (k, [v])) [(1, "tadashi"), (2, "tagayasu"), (1, "seigo")]
```


|  関数  |          意味          |                     記載例                     |                        結果                        |
| ------ | ---------------------- | ---------------------------------------------- | -------------------------------------------------- |
| lookup | keyからvalueを検索する | lookup 2 $ fromList [(1, "taro"), (2, "jiro")] | Just "jiro"                                        |
| insert | 要素を挿入する         | insert 3 "saburo"                              | fromList [(1, "taro"), (2, "jiro"), (3, "saburo")] |
| size   | サイズの取得           | size $ fromList [(1, "taro"), (2, "jiro")]     | 2                                                  |

`insert`などで元の値は変わらないので注意。新しい変数で束縛が必要。


### モジュールの作成

こんな感じで階層化することができる。

```
.
∟src
  ∟Geometry
    ∟Cube.hs
    ∟Cuboid.hs
    ∟Sphere.hs
```

`Cube.hs`はこんな感じ。

```haskell
module Geometry.Cube
  ( volume
  , area
  ) where

import qualified Geometry.Cuboid as Cuboid

volume :: Float -> Float
volume side = Cuboid.volume side side side

area :: Float -> Float
area side = Cuboid.area side side side
```


オリジナルの型/型クラス
-----------------------

### 型定義

`data`キーワードを使う。

```haskell
data Human = Man Int String Int | Woman Int String
```

* プロンプトに値を表示させるには`deriving (Show)`が必要

### 値コンストラクタ

上記の`Man`と`Woman`は値コンストラクタ。  
型コンストラクタは型引数を受け取る。

パターンマッチもできる。

```haskell
getAge :: Human -> Int
getAge (Man _ _ age) = age
getAge (Woman _ _) = -1
```

値コンストラクタはマッチに必ず必要なので、忘れてタプル(`(x y)`)にしないこと。

### レコード構文

辞書っぽい感じ。

```haskell
data Human
  = Man { id   :: Int
        , name :: String
        , age  :: Int }
  | Woman { id   :: Int
          , name :: String }
```

インスタンスの作り方は2通り

```haskell
Man {id=1, age=32, name="tagayasu"}
Man 1 "tagayasu" 32
```

フィールド名に一致した関数がgetterとして自動生成される

```haskell
> name $ Woman 1 "hanako"
"hanako"
```

### 型コンストラクタ

型引数をとって新しい型を作る。

※ 型引数は`data Maybe a = Nothing | Just a`の`a`
