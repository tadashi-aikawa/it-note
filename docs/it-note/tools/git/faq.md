# [Git] FAQ


改行コードに関するもの
----------------------

### `warning: LF will be replaced by CRLF in`

gitのconfigで`core.autoCRLF`が`true`になっていないか確認する。

```
$ git config --global core.autoCRLF
```

`true`になっていたら`false`にする。

```
$ git config --global core.autoCRLF false
```

{{refer("https://normalblog.net/system/lf_replaced_crlf/")}}


### 改行コードを強制したい

autocrlf設定によって変わってしまう改行コードを抑制したい場合。

`.gitattributes`に設定する。

`例`
```
* text=auto

*.bat  text eol=crlf
*.vbs  text eol=crlf
*.sh   text eol=lf
*.txt  -text
```

* `text`属性を付けるとautocrlfによって自動で改行変換する
* `text eol=..`で改行コードを指定すると、必ずその改行コードに変換する
* `-text`で`text`属性を外すと改行変換しない

{{refer("https://qiita.com/nacam403/items/23511637335fc221bba2")}}

### git diffの行末に『^M』が表示される

`color.ui = auto`のときにCR改行が含まれると表示されてしまう。  
`core.whitespace = cr-at-eol`を設定すると表示されなくなる。

```
git config --global core.whitespace cr-at-eol
```

{{refer("https://git-scm.com/book/ja/v2/Git-%E3%81%AE%E3%82%AB%E3%82%B9%E3%82%BF%E3%83%9E%E3%82%A4%E3%82%BA-Git-%E3%81%AE%E8%A8%AD%E5%AE%9A#_code_core_whitespace_code")}}
{{refer("https://happyquality.com/2011/09/22/1327.htm")}}


ブランチとタグが同じ名前になってしまいエラーが出る
--------------------------------------------------

```
src refspec <tag_name> matches more than one.
```

```
タグを消したい場合
git push origin :refs/tags/<tag_name>
```

```
ブランチを消したい場合
git push origin :refs/heads/<branch_name>
```

{{refer("https://qiita.com/koara-local/items/e36bc172a3c36eb67b4f")}}


競合を解消したい
----------------

### 1. 内容を1つにマージする

好きなエディタでファイルをマージする。

一方で完全に上書きしたい場合は以下のコマンドを使える。競合が激しいときはこっちの方がいいかも。

```bash
# 現在のブランチを優先
git checkout --ours <files...>
# マージするブランチを優先
git checkout --theirs <files...>
```

### 2. 変更点をコミット

`add`を忘れやすいので注意。

```bash
git add <files...>
git commit
```

メッセージは自動で生成してくれる。

{{refer("https://qiita.com/wataling/items/f7d82b84d5f5f248bc53")}}


GitHubにpushすると画像ファイルが不正になる
------------------------------------------

画像ファイルがテキストと判断され、改行コードと一致するバイナリが自動変換されていないか確認する.  
`git add`で改行コード変換メッセージが出たら要注意.

`.gitattributes`に`* text eol=lf`のような記載がある場合は以下のように定義を追加する.

```
*.png binary
*.jpg binary
*.gif binary
```

※ 他にもバイナリとみなしたいものは列挙が必要


git-lfsの対象に特定ディレクトリ配下指定したい
---------------------------------------------

`.gitattribute`にblob表現で指定する。

```
dir/**/* filter=lfs diff=lfs merge=lfs -text
```
