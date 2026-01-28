# Copper Fever 

**Copper Fever** is a lightweight, zone-aware World of Warcraft addon designed to help players track currencies, resources, and reputations dynamically based on their current geographic location. 

Instead of searching through the complex currency tab or reputation pane, Copper Fever automatically surfaces the most relevant data for your current adventure.

---

## Key Features

* **Zone-Aware Tracking**: Automatically detects your current Map ID and displays relevant currencies and faction progress for that specific area.
* **All The Things (ATT) Integration**: Built-in support to import and sync data from the *All The Things* addon, providing a massive expansion to your tracking database.
* **Expansion Filtering**: Data is organized by expansion (from Classic to The War Within), keeping the UI clean and contextual.
* **Modern UI**: A draggable, customizable main frame with a dedicated configuration panel built for the modern WoW interface.
* **Performance & Security**: Includes a security auditing layer and rate-limiting for API calls to ensure a smooth, "taint-free" gaming experience.
* **Full Localization**: Native support for both English (`enUS`) and Simplified Chinese (`zhCN`).

## Installation

1.  Download the repository as a ZIP file.
2.  Extract the contents into your World of Warcraft AddOns directory:
    * `_retail_/Interface/AddOns/CopperFever`
3.  Ensure the folder name is exactly `CopperFever` to match the `.toc` definition.

## Slash Commands

| Command | Description |
| :--- | :--- |
| `/cf` | Toggle the visibility of the main display window. |
| `/cf config` | Open the settings and configuration panel. |
| `/cf att` | Manually trigger data import from *All The Things*. |
| `/cf refresh` | Force a data refresh for the current zone. |
| `/cf help` | Show the list of all available commands. |

---

**铜币狂热 (Copper Fever)** 是一款轻量化的《魔兽世界》插件。它能根据玩家当前所处的地理位置，动态追踪相关的货币、资源和声望进度。

你不再需要频繁翻阅冗长的货币列表或声望面板，本插件会自动为你呈现当前区域最核心的资源信息。

### 核心功能

* **区域感应追踪**：自动识别当前地图 ID，实时显示与该区域关联的货币和阵营进度。
* **ATT 集成**：支持从 *All The Things* 插件无缝导入数据，极大扩展你的追踪数据库。
* **资料片过滤**：数据按资料片（从经典旧世到地心之战）有序分类，确保界面简洁且契合当前环境。
* **现代化 UI**：拥有可自定义、可拖拽的主界面，以及专为新版 UI 设计的配置面板。
* **安全与性能**：内置安全审计模块和 API 调用速率限制，确保插件运行流畅，不产生“界面污染 (Taint)”。
* **本地化支持**：完整支持英文 (`enUS`) 和简体中文 (`zhCN`)。

### 安装方法

1.  下载本项目仓库的 ZIP 压缩包。
2.  解压并将文件夹放入你的魔兽世界插件目录：
    * `_retail_/Interface/AddOns/CopperFever`
3.  请确保文件夹名称准确为 `CopperFever`。

### 常用命令

| 命令 | 描述 |
| :--- | :--- |
| `/cf` | 切换主窗口的显示与隐藏。 |
| `/cf config` | 打开插件设置面板。 |
| `/cf att` | 从 *All The Things* 导入关联数据。 |
| `/cf refresh` | 强制刷新当前区域数据。 |
| `/cf help` | 查看所有可用的命令列表。 |

---
**Author**: David W Zhang  
**Version**: 1.0.0