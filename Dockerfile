# pull app từ hub docker

FROM --platform=linux/amd64 nginx

WORKDIR /usr/share/nginx/html

# copy tất cả source ngang cấp với Dockerfile vào thư mục chỉ định ở container
COPY . .

EXPOSE 80
