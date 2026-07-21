# Helium++

Helium++ 是面向 Windows 版 Helium 的 `version.dll` 注入项目。把生成的 `version.dll` 放到 Helium 实际浏览器入口 `chrome.exe` 同目录后，它会随 Helium 启动加载，并增强标签页、快捷键、便携化、命令行参数和策略相关行为。

本项目基于 Chrome++ Next 修改，适配 Chromium 内核的 [Helium](https://github.com/imputnet/helium) 浏览器。

## 项目简介

- 面向 Windows 下的 Helium。
- 通过将 `version.dll` 放在 Helium 的 `chrome.exe` 同目录的方式工作。
- 重点是增强浏览器原生行为，而不是做额外 UI 外壳或扩展。
- 优先处理扩展难以实现、或外部工具不容易解决的能力。

## 安装

- 请将 `version.dll` 放在 Helium 的 `chrome.exe` 同一目录。
- 如需自定义配置，请将 `chrome++.ini` 放在同一目录。
- 本项目面向便携式 Helium 部署场景。
- 如果 `version.dll` 没有被正确加载，可以尝试 [setdll](https://github.com/Bush2021/setdll/)。

## 功能概览

### 标签页与书签行为

- 双击关闭标签页。
- 右键关闭标签页，按住 `Shift` 保留原始菜单。
- 保留最后一个标签页，避免关闭整个浏览器窗口。
- 鼠标悬停标签栏时滚轮切换标签页。
- 按住右键时滚轮切换标签页。
- 鼠标在标签页上停留后自动激活该标签页。
- 将地址栏输入内容或书签在新标签页中打开。
- 通过 `new_tab_disable` 和 `new_tab_disable_name` 控制新标签页判定。

### 快捷键与按键映射

- 配置老板键以隐藏和恢复 Helium 窗口，并随之静音与恢复静音。
- 配置网页翻译快捷键。
- 通过 `keymapping` 将按键映射到其它快捷键或 Chromium 命令 ID。

### 便携化与启动行为

- 通过 `data_dir` 和 `cache_dir` 控制便携化数据路径。
- 通过 `command_line` 追加 Chromium 启动参数。
- 通过 `launch_on_startup` 和 `launch_on_exit` 在启动或退出时执行程序或命令。

### 浏览器环境控制

- 通过 `ignore_policies` 忽略企业策略。
- 仅在 Helium++ 自身导致启动崩溃时再考虑启用 `win32k` 兜底选项。
- 通过 `suppress_false_upgrade_notification` 抑制便携版上的错误升级提示。
- `show_password` 等其它公开选项以 [`src/chrome++.ini`](src/chrome++.ini) 为准。

## 配置说明

完整公开配置请参见 [`src/chrome++.ini`](src/chrome++.ini)。

## 构建

### 本地 x64 构建

先安装带 C++ 工具链的 Visual Studio / Visual Studio Build Tools，再安装
[xmake](https://xmake.io/)。在仓库根目录执行：

```powershell
xmake f -m release -a x64 --toolchain=clang-cl --yes
xmake
```

Release 构建会输出 `build/release/version.dll`。发布包只包含该 DLL；
`chrome++.ini` 请继续保留现有文件，或在首次安装时从 `src/chrome++.ini` 单独创建，更新不应覆盖已有配置。

### 上传源码到 GitHub

```powershell
git status
git add .
git commit -m "描述本次修改"
git push origin main
```

### 通过 GitHub Actions 打包

进入 GitHub 仓库的 **Actions** 页面，运行 **Build** workflow。

- 手动运行 `workflow_dispatch` 可生成构建 artifact。
- 当前只构建 x64 架构。
- artifact 中只包含 x64 的 `version.dll`。请保留现有 `chrome++.ini`，首次安装时可从 `src/chrome++.ini` 单独创建。

### 通过 GitHub Actions 发布 Release

运行 **Release** workflow。它只构建 x64，并发布一个 `.7z` 包，包内只包含：

- `version.dll`

发布包不会替换 `chrome++.ini`；请使用 Helium 的 `chrome.exe` 同目录中已有的配置文件。

支持两种发布方式：

```powershell
# 使用 GitHub CLI 手动触发
gh workflow run Release --repo cwxsss/helium_plus --ref main -f version=1.17.0 -f prerelease=false
```

```powershell
# 推送 tag 触发
git tag 1.17.0
git push origin 1.17.0
```

发布资产名称为 `Helium++_v<version>_x64.7z`。

## 许可

本仓库沿用 GPL-3.0 许可。上游 Chrome++ 项目 1.5.4 及以前版本使用 MIT 许可，版权属于 [Shuax](https://github.com/shuax/)；1.6.0 及以后版本使用 GPL-3.0。
