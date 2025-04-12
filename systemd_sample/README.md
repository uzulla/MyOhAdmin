# systemd_sample

このディレクトリには、OpenHands を systemd サービスとして登録・管理するためのサンプルファイルが含まれています。

**OpenHands自体には認証機構はないので、公開サーバーではつかってはいけません**

## ファイル一覧

- `openhands.service`  
  OpenHands サービスの systemd ユニットファイル例です。  
  サービスの起動・停止・自動再起動などの設定が記述されています。

- `ln_systemd.sh`  
  `openhands.service` を `/etc/systemd/system/` にシンボリックリンクし、`systemctl daemon-reload` を実行するスクリプトです。

## 使い方

1. `openhands.service` のパスや環境変数（`WorkingDirectory` や `OPENHANDS_INSTANCE_ID` など）を自身の環境に合わせて必要に応じて編集してください。
2. `ln_systemd.sh` を実行して systemd にサービスを登録します。
   ```sh
   ./ln_systemd.sh
   ```
3. サービスの起動・停止・自動起動設定などは通常の systemd サービスと同様に行えます。
   ```sh
   sudo systemctl enable openhands
   sudo systemctl start openhands
   sudo systemctl stop openhands
   ```