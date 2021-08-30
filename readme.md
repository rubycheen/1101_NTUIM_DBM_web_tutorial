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


## Tutorial
##  Backend

### 後端架構
```
|-- backend
    |-- manage.py
    |-- env
    |-- filter
    |   |-- __init__.py
    |   |-- admin.py
    |   |-- apps.py
    |   |-- models.py
    |   |-- serializers.py
    |   |-- tests.py
    |   |-- urls.py
    |   |-- views.py
    |-- THSR
    |   |-- __init__.py
    |   |-- asgi.py
    |   |-- settings.py
    |   |-- urls.py
    |   |-- wsgi.py
```

### 安裝套件
- `django`: python web 應用框架
- `djangorestframework`:  Django 方便建立 REST API 功能的工具組。
- `psycopg2`: python module for PostgreSQL
- `python-decouple`: 將 config 和 code 分開的好用工具。
- `dj-database-url`: configure "DATABASE_URL" environment variable
- `django-cors-headers`: 允許前端port3000的請求

> Q. 可以不用 djangorestframework 嗎？ A. 可以。

> Django 本身也可以做 API，純用 Django 來做的話得自己處理 csrf 問題、資料驗證問題、身份驗證問題、權限問題等等的。用 djangorestframework 的好處是，他把 API 的處理流程，也就是上面提到的這些都歸納為一個 pattern、一個統一的處理流程，只要把該填的、該客製化的部份填上去，一個 API 就完成了。


### 模型定義 filter/models.py
```
class Fare(models.Model):
    # Fields
    fare_id = models.AutoField(primary_key=True)
    origin_station = models.ForeignKey('Station', on_delete=models.CASCADE, related_name='origin')
    destination_station = models.ForeignKey('Station', on_delete=models.CASCADE, related_name='destination')
    business_fare = models.FloatField()
    standard_fare = models.FloatField()
    non_reserved_fare = models.FloatField()
    
    # Metadata
    class Meta:
        db_table = 'fare'
    
    # Methods
    def __str__(self):
        return '{start}2{end}_fare'.format(start=origin_station, end=destination_station)
```

#### Field 欄位
設定欄位資料類型、參數、限制式等等。命名習慣為小寫加底線。

#### 常見欄位資料類型
`CharField`, `TextField`, `IntegerField`, `DateField`, `DateTimeField`, `EmailField`, `FileField`, `ImageField`, `AutoField`, `ForeignKey`, `ManyToManyField` ... 
[官方文件](https://docs.djangoproject.com/en/3.2/ref/models/fields/#field-types)

#### 常見欄位參數
- default :該欄位的默認值。
- null : 如為 `True`，即允許 Django 於資料庫該欄位寫入 `NULL`（但欄位型態如為 CharField 則會寫入空字串）。預設值是 `False`。
- blank: 如為 `True`，即允許該欄位的值允許空白。
- on_delete: `ForeignKey` 及 `ManyToManyField` 資料型態用到。代表的是當相關聯的類別被刪除之後，這些關聯到別人的資料要怎麼被處理。例如：`CASCADE` 表示相關聯的 key 被刪掉該欄位也要被刪掉（當此車站不見其關聯的費用也要刪掉）。
- related_name: `ForeignKey` 及 `ManyToManyField` 資料型態用到。Django 會自動創建一個反向關係，此名稱為從相關對像到這個對象的關係的名稱。不要反向關係就將該值設為`+`。
- ...(略)
[官方文件](https://docs.djangoproject.com/en/3.2/ref/models/fields/#field-options)

#### Metadata 元數據
Metadata 的意思是「描述其他數據的數據（data about data）」。常見的 meta option 有：
-  db_table: 對應到資料庫的資料表名稱。（如果想要將現有資料庫自動轉成 Django 模型請見：[官方說明](https://docs.djangoproject.com/en/3.2/howto/legacy-databases/)）
- ordering: 查詢時預設的排序方式。例如 `ordering = ['business_fare', '-standard_fare']` 就會先升冪排商務車廂票價再降冪排標準車廂票價.
[官方文件](https://docs.djangoproject.com/en/3.2/ref/models/options/)

#### Methods 方法
最起碼，在每個模型中，你應該定義標準的Python 類方法[__str__()](https://docs.python.org/3/reference/datamodel.html#object.__str__) ，來為每個物件返回一個人類可讀的字符串。這是 Python 用來把物件轉換成 str 的 hook；因為做網站時，常常需要把東西變成字串，所以這會很方便。


### 視圖 filter/views.py

當 Django 收到一個 HTTP request 時，會首先確認該 request 的 URI 應該對應到哪個 view（如果對應不到，直接回傳 404 Not Found），並把 request 交給它。View 要負責處理這個 request，並回傳一個 HTTP response。

![](./img/django_structure.png)

### 定義資源 filter/urls.py

### 定義資源 filter/serializers.py