## Backend 
```shell
cd backend
source env/bin/activate #啟動虛擬環境(已裝好套件)
python manage.py runserver #啟用後端server
```


**API endpoint**: http://127.0.0.1:8000/api

**三個接口**

>GET /stations

>POST /timetable/search

>POST /ticket/search


## Database

下載 [PostgreSQL 13](https://www.postgresql.org/download/) 以及 [pdAdmin](https://www.pgadmin.org/)(GUI介面)

* [Postgres setup on MacOS](https://www.youtube.com/watch?v=EZAa0LSxPPU)
* [匯入/匯出現有資料庫 by pdAdmin](https://www.youtube.com/watch?v=C30q5i1e9KE)