FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 复制依赖文件
COPY pyproject.toml uv.lock ./

# 安装uv
RUN pip install uv

# 安装Python依赖
RUN uv sync --frozen --no-dev

# 复制项目代码
COPY . .

# 创建临时目录
RUN mkdir -p /app/temp-files

# 暴露端口
EXPOSE 8000 8001

# 默认命令（会被docker-compose覆盖）
CMD ["python", "-m", "web.api.query_service"]
