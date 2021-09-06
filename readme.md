# 使用說明

## Backend 
```shell
cd backend
python3 -m venv tutorial-env #建立虛擬環境 #-m: module-name
source tutorial-env/bin/activate #啟動虛擬環境 for mac
tutorial-env\Scripts\activate.bat #啟動虛擬環境 for windows
```

成功的話，command prompt 前面應該會多出 `(tutorial-env)` 的字樣，代表已經進入這個虛擬環境。如果未來你想退出這個虛擬環境，可以輸入 deactivate。接著輸入所需套件，需要的套件與版本已定義在 `requirements.txt`，因此僅需要需入一行指令。

```shell
pip install -r requirements.txt
```

安裝完套件後複製 `.env.example` 的內容到 `.env`。

>`.env`裡存的是環境變數，裡面通常會放一些機密資訊（如 `SECRET_KEY`、資料庫資訊等），這種檔案通常不會傳上版本控制系統（如 Github），但此為教學專案為了方便講解就上傳了XDD

```shell
cp .env.example .env
```

最後一步，啟動 server。

```shell
python manage.py runserver
```


## Frontend
```shell
cd frontend
yarn start
```

## Database

下載 [PostgreSQL 13](https://www.postgresql.org/download/) 以及 [pdAdmin](https://www.pgadmin.org/)(GUI介面)

* [Postgres setup on MacOS](https://www.youtube.com/watch?v=EZAa0LSxPPU)
* [匯入/匯出現有資料庫 by pdAdmin](https://www.youtube.com/watch?v=C30q5i1e9KE)


# API
- **討論文件**：[連結](https://hackmd.io/_vPVxhaGRT6TIeWEMzvgWA)
- **API endpoint**: http://127.0.0.1:8000/api
- **三個接口**
    >GET /stations

    >POST /timetable/search

    >POST /ticket/search
