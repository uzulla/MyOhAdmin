## proxmox vm's ip list tool

This script lists IP addresses of all VMs in Proxmox.(Only Qemu agent enabled VMs)

### Usage

```bash
cp .env.example .env
vi .env
source .env && ./listip.sh
```

#### with envault (https://github.com/uzulla/envault/)

```
$ envault export -- bash listip.sh
復号化用パスワードを入力してください:
3個の環境変数を設定して指定されたコマンドを実行します: bash listip.sh
Running VMs and their IP addresses:
VMID: 101, Name: xubuntu, IP: 192.168.***.***
VMID: 108, Name: oh, IP: 192.168.***.***
100.***.***.***
```

### Example Output

```
Running VMs and their IP addresses:
VMID: 101, Name: xubuntu, IP: 192.168.***.***
VMID: 108, Name: oh, IP: 192.168.***.***
100.***.***.***
```

### Requirements

- Proxmox VE installed
- qemu-guest-agent installed on VMs

