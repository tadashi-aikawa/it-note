# [Vim] Performance


プロファイリング
----------------

以下の記事を参照。

{{link("https://blog.mamansoft.net/2018/03/31/investigate-why-vim-moves-slow/")}}

手順だけ抜き出すと以下。

```vim
"ログ出力先とプロファイリング対象を決める
:profile start profile.log
:profile func *
:profile file *

･･･測定したい動作を実施する･･･

"測定を終了する
:profile pause
:noautocmd qall!
```
