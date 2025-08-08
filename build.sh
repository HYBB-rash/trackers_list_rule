
#!/usr/bin/env bash
set -euo pipefail

# ─── 确定脚本自身所在目录 ───────────────────────────────
# 这样就算从任意位置调用，路径也会正确指向项目根
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ─── 激活虚拟环境 ───────────────────────────────────────
# 如果你的 venv 文件夹不叫 venv，请修改下面这行
source "$SCRIPT_DIR/.venv/bin/activate"

# ─── 进入项目根目录（可选） ───────────────────────────
cd "$SCRIPT_DIR"

# ─── 执行 Python 主程序 ─────────────────────────────────
python src/main.py

# ─── 4. 检查是否有 Git 改动，然后提交并推送 ─────────────
# 确保脚本所在目录就是你的 Git 仓库根目录
if [[ -n "$(git status --porcelain)" ]]; then
  branch="$(git rev-parse --abbrev-ref HEAD)"
  git add -A
  git commit -m "Auto-update: $(date '+%Y-%m-%d %H:%M:%S')"
  git push origin "$branch"
else
  echo "No changes to commit."
fi