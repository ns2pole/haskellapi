# Servant　×　Haskell
# first-project
# 参考サイト
# https://qiita.com/sand/items/fea7c294dd7835692ff7
# https://qiita.com/sand/items/16a6ef431a8376e7cbaa
# 実行手順
# 0.cd Program/haskell_exercise/first-project
# 1.stack build  
# 2.stack exec first-project-exe (何も反応しないが立ち上がっている)
# 3.curl http://localhost:8081/point http://localhost:8081/isaac etc..
# curl -X POST http://localhost:8090/doublePoint -H "Content-Type: application/json" -d '{"a": 3, "b": 5}' etc..

# コードを書く
# localで動く
# localでangularから動く
# centosにhaskellを送る→build→buildしたものをmacに送る→gitにpush→vpsでgitでpull→executeファイルを/usr/local/binに移動→execute
# docker cp ~/Program/haskell_exercise/first-project d502e9d8db1a:/app/
# rm -rf .stack-work/ (コンテナ内)
# stack --allow-different-user build
# docker cp d502e9d8db1a:/app/first-project/.stack-work ~/Program/haskell_exercise/first-project 


