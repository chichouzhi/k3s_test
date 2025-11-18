package main

import (
	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

	// 定义根路径路由
	r.GET("/", func(c *gin.Context) {
		c.String(200, "Hello world!")
	})

	// 启动服务器，监听 8080 端口
	r.Run()
}
