#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 <github-type> <github-account> <repository-name>"
    echo "github-type: public 또는 samsung"
    exit 1
fi

TYPE=$1
ACCOUNT=$2
REPO=$3

# GitHub 타입에 따른 설정
case $TYPE in
    "public")
        GIT_HOST="github.com"
        GIT_EMAIL="${ACCOUNT}@users.noreply.github.com"
        GIT_SSH="git@github.com-${ACCOUNT}"
        ;;
    "samsung")
        GIT_HOST="github.ecodesamsung.com"
        GIT_EMAIL="${ACCOUNT}@samsung.com"
        GIT_SSH="git@${GIT_HOST}"
        ;;
    *)
        echo "잘못된 GitHub 타입입니다. public 또는 samsung을 선택하세요."
        exit 1
        ;;
esac

# 계정 전환
echo "=== Git 계정 전환 ==="
git config user.name "${ACCOUNT}"
git config user.email "${GIT_EMAIL}"
git remote set-url origin "${GIT_SSH}:${ACCOUNT}/${REPO}.git"

# 현재 설정 표시
echo "현재 Git 설정:"
echo "User name: $(git config user.name)"
echo "User email: $(git config user.email)"
echo "Remote URL: $(git remote get-url origin)"
echo "==========================="