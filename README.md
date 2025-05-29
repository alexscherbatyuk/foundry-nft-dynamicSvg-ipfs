## Dynamic NFT vs Classic NFT (IPFS)

**BasicNft represents a classic IPFS-based NFT, while MoodNft is a dynamic on-chain SVG NFT.**

## Usage

### Install

```shell
$ make install
```

### Build

```shell
$ make build
```

### Test

```shell
$ make test
```

### Format

```shell
$ make fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy
#### Deploy BasicNft to anvil

```shell
$ make deploy-anvil
```

#### Deploy BasicNft to sepolia
```shell
$ make deploy-sepolia
```

#### Deploy MoodNft to anvil
```shell
$ make deploy-mood-anvil
```

#### Deploy MoodNft to sepolia
```shell
$ make deploy-mood-sepolia
```

### Interaction
#### Mint BasicNft on anvil
```shell
$ make mint-nft-anvil
```

#### Mint BasicNft on sepolia
```shell
$ make mint-nft-sepolia
```

#### Mint MoodNft on anvil
```shell
$ make mint-mood-anvil
```

#### Mint MoodNft on sepolia
```shell
$ make mint-mood-sepolia
```

<div style="display: flex; gap: 20px; align-items: center;">
<img src="img/0-blue.png" width="100" height="100" alt="Classic PNG IPFS"/>
<img src="data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSI1MCAxMCAxMDAgMTAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAiIGhlaWdodD0iMTAwIiA+CiAgPCEtLSBIZWFkIC0tPgogIDxwYXRoCiAgICBkPSJNNzAgNzAgUTgwIDMwIDExMCA0MCBRMTQwIDMwIDE0MCA3MCBRMTMwIDkwIDExMCA5NSBROTAgOTUgNzAgNzAgWiIKICAgIGZpbGw9IiM5MGE0YWUiCiAgICBzdHJva2U9IiMzNDQ5NWUiCiAgICBzdHJva2Utd2lkdGg9IjMiCiAgLz4KICAKICA8IS0tIEVhcnMgLS0+CiAgPHBvbHlnb24gcG9pbnRzPSI3NSw1MCA4NSwxNSA5NSw1MCIgZmlsbD0iIzM0NDk1ZSIgLz4KICA8cG9seWdvbiBwb2ludHM9IjEyNSw1MCAxMzUsMTUgMTQ1LDUwIiBmaWxsPSIjMzQ0OTVlIiAvPgogIAogIDwhLS0gSGFwcHkgRXllcyAtLT4KICA8Y2lyY2xlIGN4PSI5NSIgY3k9IjY4IiByPSI1IiBmaWxsPSJibGFjayIgLz4KICA8Y2lyY2xlIGN4PSIxMjUiIGN5PSI2OCIgcj0iNSIgZmlsbD0iYmxhY2siIC8+CiAgCiAgPCEtLSBOb3NlIC0tPgogIDxjaXJjbGUgY3g9IjExMCIgY3k9IjkwIiByPSI0IiBmaWxsPSJibGFjayIgLz4KICAKICA8IS0tIEhhcHB5IE1vdXRoICh1cHdhcmQgY3VydmUpIC0tPgogIDxwYXRoIGQ9Ik0xMDAgOTUgUTExMCAxMTAgMTIwIDk1IiBzdHJva2U9IiMzNDQ5NWUiIHN0cm9rZS13aWR0aD0iMyIgZmlsbD0ibm9uZSIgLz4KPC9zdmc+" width="100" height="100" alt="Happy SVG" />

<img src="data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSI1MCAxMCAxMDAgMTAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAiIGhlaWdodD0iMTAwIiA+CiAgPCEtLSBIZWFkIC0tPgogIDxwYXRoCiAgICBkPSJNNzAgNzAgUTgwIDMwIDExMCA0MCBRMTQwIDMwIDE0MCA3MCBRMTMwIDkwIDExMCA5NSBROTAgOTUgNzAgNzAgWiIKICAgIGZpbGw9IiM5MGE0YWUiCiAgICBzdHJva2U9IiMzNDQ5NWUiCiAgICBzdHJva2Utd2lkdGg9IjMiCiAgLz4KICAKICA8IS0tIEVhcnMgLS0+CiAgPHBvbHlnb24gcG9pbnRzPSI3NSw1MCA4NSwxNSA5NSw1MCIgZmlsbD0iIzM0NDk1ZSIgLz4KICA8cG9seWdvbiBwb2ludHM9IjEyNSw1MCAxMzUsMTUgMTQ1LDUwIiBmaWxsPSIjMzQ0OTVlIiAvPgogIAogIDwhLS0gU2FkIEV5ZXMgKGVsbGlwdGljYWwsIHNsaWdodGx5IHRpbHRlZCBkb3dud2FyZCkgLS0+CiAgPGVsbGlwc2UgY3g9Ijk1IiBjeT0iNzIiIHJ4PSI1IiByeT0iMy41IiBmaWxsPSJibGFjayIgdHJhbnNmb3JtPSJyb3RhdGUoLTE1IDk1IDcyKSIgLz4KICA8ZWxsaXBzZSBjeD0iMTI1IiBjeT0iNzIiIHJ4PSI1IiByeT0iMy41IiBmaWxsPSJibGFjayIgdHJhbnNmb3JtPSJyb3RhdGUoMTUgMTI1IDcyKSIgLz4KICAKICA8IS0tIE5vc2UgLS0+CiAgPGNpcmNsZSBjeD0iMTEwIiBjeT0iOTAiIHI9IjQiIGZpbGw9ImJsYWNrIiAvPgogIAogIDwhLS0gU2FkIE1vdXRoIChkb3dud2FyZCBjdXJ2ZSkgLS0+CiAgPHBhdGggZD0iTTEwMCAxMDUgUTExMCA5NSAxMjAgMTA1IiBzdHJva2U9IiMzNDQ5NWUiIHN0cm9rZS13aWR0aD0iMyIgZmlsbD0ibm9uZSIgLz4KPC9zdmc+" width="100" height="100" alt="Sad SVG" />

</div>
