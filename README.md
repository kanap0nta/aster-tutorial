# aster-tutorial

Docker environment for aster network tutorial  
Docker 上で Astar ネットワークチュートリアルを行うための環境  

## Prerequisites

- Visual Studio Code に Remote Development の拡張機能が入っていること
- Docker が動作する環境であること

## Working Directory

``` bash
cd test_project/
```

## Build

``` bash
forge build --contracts ./src/Contract.sol --extra-output-files ewasm evm.assembly metadata
```

## Test

``` bash
forge test --contracts ./test/Contract.t.sol
```

## Run aster collator

``` bash
astar-collator --port 30333 --ws-port 9944 --rpc-port 9933 --rpc-cors all --alice --dev
```

## Send token 

デプロイ時にガス代がかかるため、ガス代をデバッグアカウントから送金するため下記を行う  

EVM から Native のアドレスを取得する  
ただし、前提条件として、アドレスに一度でも ASTR を送金したことがあること  
（変換する方法はほかにもあるかも・・・）  

[ここ](https://astar.subscan.io/account/)にアクセスし、検索欄に自身の Metamask のアドレスを入力  
鍵アイコン横のアイコンにカーソルを合わせると `Substrate:xxxxx` がポップアップとして表示されるので、そのポップアップをクリックし、Native のアドレスコピーする

[ここ](https://polkadot.js.org/apps/?rpc=ws%3A%2F%2F127.0.0.1%3A9944#/explorer)にアクセスし、`Accounts` -> `送信` で、任意のデバッグ用アカウントから、先ほどコピーした Native アドレス宛てに、送れるだけトークンを送信する

## Deploy contract

``` bash
forge create --rpc-url http://127.0.0.1:9933 --private-key <Metamask secret key> src/Contract.sol:Contract
```

※Metamask の秘密鍵は、`アカウントの詳細` -> `秘密鍵のエクスポート` -> パスワード入力 で表示されるものを使用  

成功すると下記のように表示されるので、`Deployed to` の部分を控えておく

``` result
Compiler run successful
Deployer: 0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Deployed to: 0xYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY
Transaction hash: 0xZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
```

## Call contract function

### Estimate

store 関数実行時のガス代がいくらか確認したい場合、下記を実行

``` bash
cast estimate <Deployed to Address> "store(uint256)" 3 --rpc-url http://127.0.0.1:9933 --private-key <Metamask secret key>
```

### Send

store 関数を実行したい場合、下記を実行

``` bash
cast send <Deployed to Address> "store(uint256)" 3 --rpc-url http://127.0.0.1:9933 --private-key <Metamask secret key>
```

### Call

retrieve 関数を実行し、結果を取得したい場合、下記を実行

``` bash
cast call <Deployed to Address> "retrieve()" --rpc-url http://127.0.0.1:9933
```

## Build clean

``` bash
forge clean
```

## References

- [ASTAR Network のチュートリアルをやる](https://zenn.dev/polonity/articles/72d51231165905)
- [[Astar] Using Foundry](https://medium.com/coinmonks/astar-using-foundry-74aac10bcd02)
- [Foundry Book](https://book.getfoundry.sh/)
