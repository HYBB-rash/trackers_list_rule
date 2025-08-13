# trackers_list_rule

一个将公开的 BitTorrent trackers 列表转换为 Mihomo/Clash 可识别规则集（rule provider）的自动化项目。

- 数据源: `https://cf.trackerslist.com/all.txt`
- 输出文件: `dist/trackers_list_rule.yaml`
- 规则内容: `DOMAIN-SUFFIX` / `IP-CIDR` / `IP-CIDR6`
- 更新频率: GitHub Actions 每小时自动拉取、生成并提交

## 用途

将 BT Tracker 相关的域名与 IP 聚合为一个可订阅的规则集，方便在代理工具中统一路由（例如直连、指定节点或丢弃）。

## 如何使用（Mihomo / Clash.Meta）

你可以直接引用仓库的原始链接，或下载到本地后引用本地路径。

- 在线订阅地址（RAW）:
  `https://raw.githubusercontent.com/HYBB-rash/trackers_list_rule/main/dist/trackers_list_rule.yaml`

在你的配置中加入以下片段（按需调整路径与策略组名称）：

```yaml
rule-providers:
  trackers:
    type: http
    behavior: classical
    path: ./ruleset/trackers_list_rule.yaml
    url: https://raw.githubusercontent.com/HYBB-rash/trackers_list_rule/main/dist/trackers_list_rule.yaml
    interval: 86400

rules:
  - RULE-SET,trackers,Direct   # 或替换为你想要的策略组
```

说明:
- `behavior: classical` 对应本规则文件的结构（`payload:` 列表）。
- `path` 为本地缓存/存放路径，可按个人习惯调整。
- `rules` 中的第三个参数是策略组名称，可设置为 `DIRECT`、`REJECT` 或你的自定义分流组。

## 本地生成（可选）

如需在本地生成最新规则：
- 需要 Python 3.12+ 与依赖 `requests`、`PyYAML`
- 运行 `python src/main.py` 后会在 `dist/trackers_list_rule.yaml` 生成规则文件

## 免责声明

本项目仅做规则聚合与格式转换，不保证任何节点、站点或服务的可用性。使用前请遵循所在地区法律法规与工具使用条款。

