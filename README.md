# RailsでX(旧Twitter)クローン実装

<img width="950" alt="スクリーンショット 2023-10-02 18 29 30" src="https://github.com/kazu1212-star/twitter_clone/assets/115007915/93d05d70-c7a1-4ae4-8080-cb7566372817">



## 環境構築
- dockerが必要です。

## setup

```
docker compose build
```

```
docker compose run --rm web bin/setup
```


```
docker compose run --rm web yarn install
```

## run

```
docker compose up
```

http://localhost:3000

## 備考

- Taskのscaffoldが含まれていますが、CIの動作確認用です。
適宜削除いただければと思います。（そのままでも問題ないです）
