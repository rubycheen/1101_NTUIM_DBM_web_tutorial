## Tutorial
##  Backend

補：
.env 內的資訊
修改 main readme 的順序，db,be,fe

### 後端架構
```
|-- backend
    |-- manage.py
    |-- requirements.txt
    |-- .env.example
    |-- .gitignore
    |-- myfilter
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

### Django 指令
```{python}
django-admin startproject backend
python manage.py startapp myfilter
python manage.py makemigrations myfilter
python manage.py migrate
```

### 安裝套件(requirements.txt)
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
- Model metadata is “anything that’s not a field”, such as ordering options (ordering), database table name (db_table), or human-readable singular and plural names (verbose_name and verbose_name_plural). None are required, and adding class Meta to a model is completely optional.

- 常見的 [meta option](https://docs.djangoproject.com/en/3.2/ref/models/options/) 有：
    -  db_table: 對應到資料庫的資料表名稱。（如果想要將現有資料庫自動轉成 Django 模型請見：[官方說明](https://docs.djangoproject.com/en/3.2/howto/legacy-databases/)）
    - ordering: 查詢時預設的排序方式。例如 `ordering = ['business_fare', '-standard_fare']` 就會先升冪排商務車廂票價再降冪排標準車廂票價.
    - abstract: [meta inheritance](abstract = True)

#### Methods 方法
最起碼，在每個模型中，你應該定義標準的Python 類方法[__str__()](https://docs.python.org/3/reference/datamodel.html#object.__str__) ，來為每個物件返回一個人類可讀的字符串。
- A Python “magic method” that returns a string representation of any object. This is what Python and Django will use whenever a model instance needs to be coerced and displayed as a plain string. Most notably, this happens when you display an object in an interactive console or in the admin.
- [get_absolute_url()](https://docs.djangoproject.com/en/3.2/ref/models/instances/#django.db.models.Model.get_absolute_url)
    - This tells Django how to calculate the URL for an object. Django uses this in its admin interface, and any time it needs to figure out a URL for an object.
- [override predefined model methods like save(), deleted.](https://docs.djangoproject.com/en/3.2/topics/db/models/#overriding-predefined-model-methods)




### 視圖 filter/views.py

當 Django 收到一個 HTTP request 時，會首先確認該 request 的 URI 應該對應到哪個 view（如果對應不到，直接回傳 404 Not Found），並把 request 交給它。View 要負責處理這個 request，並回傳一個 HTTP response。

![](./img/django_structure.png)

### 定義資源 filter/urls.py

### 定義資源 filter/serializers.py

### Performing raw SQL queries
- [官方文件](https://docs.djangoproject.com/en/3.2/topics/db/sql/)有大概講到orm與raw sql比較
- 兩種方法執行 raw SQL，看上面官方
- [FAQ: Databases and models](https://docs.djangoproject.com/en/3.2/faq/models/):重要！投影片要統整給大家

- ORM vs SQL
    - SQL 出來是 result set（是 table 還要 select column 之類的），ORM 出來是 object 可以直接用？
