#!/bin/bash
set -e

# ===== 配置 =====
REPO_URL="https://github.com/guowenju/1panel-appstore.git"
TMP_DIR="/tmp/1panel-appstore"
TARGET_DIR="/opt/1panel/resource/apps/local"

# ===== 颜色 =====
GREEN="\033[1;32m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"

log() {
  echo -e "${BLUE}▶${RESET} $1"
}

success() {
  echo -e "${GREEN}✔${RESET} $1"
}

warn() {
  echo -e "${YELLOW}⚠${RESET} $1"
}

error() {
  echo -e "${RED}✖${RESET} $1"
}

# ===== 开始 =====
echo -e "${GREEN}========== 1Panel AppStore 同步开始 ==========${RESET}"

log "清理临时目录：$TMP_DIR"
rm -rf "$TMP_DIR"
success "临时目录已清理"

log "克隆仓库：$REPO_URL"
git clone --depth=1 "$REPO_URL" "$TMP_DIR"
success "仓库克隆完成"

log "清空目标目录：$TARGET_DIR"
if [[ -d "$TARGET_DIR" && "$TARGET_DIR" != "/" ]]; then
  rm -rf "${TARGET_DIR:?}"/*
else
  error "目标目录不存在或非法，已中止"
  exit 1
fi
success "目标目录已清空"

log "复制应用文件到本地目录"
cp -a "$TMP_DIR/apps/." "$TARGET_DIR/"
success "应用同步完成"
rm -rf "$TMP_DIR"

echo -e "${GREEN}========== 🎉 同步完成，一切顺利 ==========${RESET}"
