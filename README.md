# 前言

此repo用作于探讨用R做商品网页爬虫的可能性，请勿用作商业用途。`find_bag_utils.R`中使用到了一个Hermes picotin的url仅做示例。

# 项目目标

此项目最初目标仅为使用代码替代手动刷新页面查看目标商品（类）的存在，并提供邮件提醒，为上班党带来福音。项目目标会随时间改变，请在PR中同时更改项目目标。

# Using `renv`

为保持使用相同的环境，请在编程过程使用`renv` workflow，详情见下
When using `renv` to manage dependencies for your deployments, it's sometimes desirable to have separate `renv` libraries for each deployment, as this will allow you to have separate versions of packages (eg. v1.0 on production, v1.1 on staging).

To set-up deployment-specific `renv` libraries:

1. Use `renv::init(project = "fancy_app/")` to initialize an `renv` library under `deployments/fancy_app`
2. Whenever you want to manage this deployment, use `renv::activate(project = "fancy_app/")` to activate this deployment's `renv` library.
3. After activation, all subsequent `renv` function calls (eg. `renv::install`, `renv::snapshot`, `renv::restore`) will now default to this library.

# 目前代码存在的问题

1. 一旦出现了一个目标商品，while loop将无法进行，只能等待目标商品消失才能继续爬取。解决方案：加入exclusion_list把已经出现的目标物品从link_list中移除
2. 访问host单一，容易被网站察觉。
3. 需要泛化的function来定义目标商品

# 沟通

如有任何建议请大家通过Issues沟通，请各位大佬随意创建PR并tag我为reviewer。请将勿将任何代码merge到main branch，谢谢！
