# [AutoHotkey] FAQ


特定キーをsendできない
----------------------

バッククォートは予約語なので特殊.

|        キー        |        sendの書き方         |
| ------------------ | --------------------------- |
| ^ (ハット)         | `{^}` or `{vkDEsc00D}`      |
| ` (バッククォート) | バッククォートを2連続で書く |


特定のキーに割り当てできない
----------------------------

|    キー    |   書き方   |
| ---------- | ---------- |
| : (コロン) | `$SC028::`  |
| 無変換     | `$vk1C::`  |
| Ctrl       | `$Ctrl::`  |
| Space      | `$Space::` |
| ESC        | `$ESC::`   |
| Enter      | `$Enter::` |
| TAB        | `$TAB::`   |