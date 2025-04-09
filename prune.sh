#!/bin/bash

echo "警告: このマシンのDockerコンテナ、イメージ、ボリュームすべてに影響します。"
echo "本当に全て削除してディスク容量を確保しますか？ (y/N)"
read -r answer

if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
  echo "中止しました。"
  exit 0
fi

echo "すべてのDockerコンテナを停止中..."
docker stop $(docker ps -aq) 2>/dev/null

echo "すべてのDockerコンテナを削除中..."
docker rm $(docker ps -aq) 2>/dev/null

echo "未使用のDockerボリュームを削除中..."
docker volume prune -f

echo "未使用のDockerリソースを全削除中..."
docker system prune -a -f --volumes

echo "クリーンアップが完了しました。"
