# 架構設計

![Wordpress 架構](assets/example.png)

## 討論題

上面是部落格系統的示意圖，各元件的作用如下:

1. Nginx: reverse proxy 到後端 wordpress
2. Wordpress: 執行部落格系統
3. MySQL: 儲存部落格的文章資訊
4. Fluentd: 可以讀取指定路徑下的 Log 工具

請嘗試用這兩天學到的 Kubernetes 物件來設計上面所示之服務架構

1. 畫圖表示會用到哪些 Kubernetes 物件來實現架構
2. 為什麼如此設計的原因
3. 有哪些地方需要考慮