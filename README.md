# Deploy laravel project trên Google Cloud App Engine 2024 

## Bước 1: Tạo một dự án mới

## Bước 2: Bật Google App Engine API, Cloud SQL API, Cloud SQL Admin API

## Bước 3: Tạo một Cloud SQL, lấy thông tin về kết nối để sử dụng cho bước 4

## Bước 4: Chuẩn bị một repository Laravel
- Đảm bảo `app.yaml` đã điều chỉnh `DB_HOST`, `DB_USERNAME`, `DB_PASSWORD` theo đúng kết nối tới Cloud SQL.
- Đảm bảo project Laravel có quyền truy cập đọc/ghi storage trên máy ảo (composer.json)
```sh
"scripts":
    "post-deploy-cmd": [
            "php artisan cache:clear",
            "chmod -R 755 bootstrap\/cache"
        ]
```

## Bước 5: Cài đặt Google Cloud Console (nếu chưa có)
- Đảm bảo đã kết nối tới dự án

```sh
gcloud config set project <projectID>
```
## Bước 6: Chuẩn bị một công cụ kết nối (ở đây sử dụng công cụ cloud SQL proxy)

```sh
cloud-sql-proxy.x64 "<db_instance_connect>" --address=127.0.0.1 --port=3306
```
- Thực hiện việc config để dự án laravel trên local có thể kết nối tới Cloud SQL
## Bước 7: Thực hiện các lệnh trên terminal

```sh
php artisan migrate (tạo DB)
php artisan db:seed (seed DB (nếu cần))
```
## Bước 8: Deploy ứng dụng 

```sh
gcloud app deploy
```
