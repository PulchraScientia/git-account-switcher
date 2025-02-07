#!/bin/bash

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Git Account Switcher 설치를 시작합니다 ===${NC}"

# 1. 디렉토리 생성 및 스크립트 복사
INSTALL_DIR="$HOME/git-tools"
echo -e "\n${YELLOW}1. 설치 디렉토리 생성 중...${NC}"
mkdir -p "$INSTALL_DIR"
cp scripts/git-switch.sh "$INSTALL_DIR/git-account-switch.sh"
chmod +x "$INSTALL_DIR/git-account-switch.sh"

# 2. 환경변수 설정
echo -e "\n${YELLOW}2. 환경변수 설정 중...${NC}"
SHELL_RC="$HOME/.zshrc"
if [ -f "$HOME/.bashrc" ]; then
    SHELL_RC="$HOME/.bashrc"
fi

if ! grep -q "git-tools" "$SHELL_RC"; then
    echo "" >> "$SHELL_RC"
    echo "# Git Account Switcher" >> "$SHELL_RC"
    echo "export PATH=\$PATH:$INSTALL_DIR" >> "$SHELL_RC"
    echo "alias gswitch='$INSTALL_DIR/git-account-switch.sh'" >> "$SHELL_RC"
fi

# 3. SSH 설정
echo -e "\n${YELLOW}3. GitHub 계정 설정${NC}"
read -p "GitHub 계정을 설정하시겠습니까? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    bash scripts/setup-config.sh
fi

echo -e "\n${GREEN}설치가 완료되었습니다!${NC}"
echo -e "다음 명령어로 새로운 셸을 시작하거나 설정을 로드하세요:"
echo -e "${YELLOW}source $SHELL_RC${NC}"
echo -e "\n사용 방법:"
echo -e "1. gswitch public USERNAME REPO-NAME"
echo -e "2. gswitch samsung USERNAME REPO-NAME"