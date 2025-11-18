# 构建阶段：使用官方Go镜像编译应用
FROM golang:1.23.7-alpine AS builder
WORKDIR /app
# 复制依赖文件
COPY go.mod go.sum ./
# 设置 Go 代理
ENV GOPROXY=https://goproxy.cn,direct
# 下载依赖
RUN go mod download
# 复制源代码
COPY . .
# 编译应用（静态链接，确保容器内无需额外依赖）
RUN CGO_ENABLED=0 GOOS=linux go build -o web_server .

# 运行阶段：使用轻量级Alpine镜像
FROM alpine:3.20
WORKDIR /root/
# 从构建阶段复制编译好的二进制文件
COPY --from=builder /app/web_server .
# 暴露应用端口（gin默认8080）
EXPOSE 8080
# 启动应用
CMD ["./web_server"]
