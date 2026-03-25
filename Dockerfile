# 第一阶段：构建前端代码 (使用 Node 镜像)
FROM node:18 AS build-stage
WORKDIR /app
# 拷贝所有源代码到容器内
COPY . .
# 安装依赖并打包
RUN npm install
RUN npm run build

# 第二阶段：部署静态文件 (使用 Nginx 镜像)
FROM nginx:alpine
# 从上面的 build-stage 提取编译好的 dist 目录，放到 nginx 的目录下
COPY --from=build-stage /app/dist/ /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]