FROM node:20-alpine

WORKDIR /app

RUN node --version 
RUN npm --version 

COPY package*.json . 
COPY packages ./packages 
COPY translations ./translations 

# 创建必要的目录和配置文件 
RUN mkdir -p config && echo '{}' > config/production.json 

RUN npm install 
# 先编译 postgres-query-builder 包 
RUN npm run compile:db 
# 然后编译主应用 
RUN npm run compile 
# 最后执行构建 
RUN npm run build 

EXPOSE 3000 

# 先创建管理员用户，再启动应用
CMD npm run user:create -- --email "admin@example.com" --password "admin123" --name "Admin User" || true && npm start
