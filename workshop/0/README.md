# Container Image

1. Wordpress: https://hub.docker.com/_/wordpress
    * HTTP Service (80 port)
2. MySQL: https://hub.docker.com/_/mysql
    * Database (3306 port)

# 作業要求

利用 Pod 建立一個簡易部落格系統，其中包含有 2 個容器 `Wordpress` 與 `MySQL` (此次作業無需考慮 DB 狀態是否會消失，第二週作業會實作)

1. 將兩個容器放置於一個 Pod 內，並且 Wordpress 可以連結到 MySQL 來提供部落格服務
    * 兩個 container image 可以從上面 Dockerhub 連結取得
    * 需要用到的`環境變數`可在上面連結的網頁下方說明欄內找到
    * Multiple containers in one pod，可參考投影片 P62

2. 為兩個容器增加以下設定
    * resource requests/limits
    * liveness probes、readiness probes
        * 請思考這兩個服務可以用什麼方式檢測是否存活
        * 當容器檢測失敗後要能被自動 restart 
        * 當 MySQL 失效時 wordpress 要能停止接收新請求

NOTE: 你無需設定容器的 command 與 args 參數，官方 image 已經事先設定好 entrypoint

3. 為 Pod 增加以下設定
    * 能夠描述該 Pod 的 labels
    * 適當的 restartPolicy

4. 當 Pod YAML 寫好後，你應該要能夠使用 port-forward 看到 wordpress 畫面

# 作業提示

![](assets/clues.png)

# 繳交方式

請至 https://github.com/srcmesh-workshop/kubernetes-adoption-hands-on 開 Pull requests 繳交作業

1. Pod 的 YAML 檔
2. 上面步驟 4 port-forward 的瀏覽器畫面截圖
3. 簡單文件說明你的想法與這樣寫的原因，可以用 YAML comment 取代

