---
description: ドキュメンテーションビルダーDocsifyについて
---

# [Docsify] Top

{{ page.meta.description }}


Docsifyについて
---------------

{{link("https://docsify.js.org/#/")}}


index.htmlの雛形
----------------

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>TODO: ドキュメントタイトル</title>
    <link rel="icon" href="favicon.ico" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="description" content="Description" />
    <meta
      name="viewport"
      content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
    />
    <link rel="stylesheet" href="//unpkg.com/docsify/lib/themes/vue.css" />
  </head>
  <body>
    <div id="app"></div>
    <script>
      window.$docsify = {
        name: 'TODO: プロダクトタイトル',
        repo: 'TODO: GitHubへのリンク',
        homepage: 'index.md',
        loadSidebar: true,
        relativePath: true,
        subMaxLevel: 2,
      };
    </script>
    <script src="//unpkg.com/docsify/lib/docsify.min.js"></script>
    <script src="//unpkg.com/docsify/lib/plugins/search.min.js"></script>
    <script src="//unpkg.com/docsify/lib/plugins/zoom-image.min.js"></script>
    <script src="//unpkg.com/docsify/lib/plugins/emoji.min.js"></script>
  </body>
</html>
```