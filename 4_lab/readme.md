# НИЯУ МИФИ. ИИКС. Лабораторная работа №4. Соколов Александр, Б20-505. 2023.

## Запуск PostgreSQL

```bash
docker run -ti -p5432:5432 -e POSTGRES_PASSWORD=12345 postgres
```

## Загрузка данных в PostgreSQL

```
pgloader sqlite:///$(pwd)/gnomic.db pgsql://postgres:12345@localhost/postgres
2023-05-25T14:37:58.013334+03:00 LOG pgloader version "3.6.0c0ea23"
2023-05-25T14:37:58.013334+03:00 LOG Data errors in '/tmp/pgloader/'
2023-05-25T14:37:58.063335+03:00 LOG Migrating from #<SQLITE-CONNECTION sqlite:///home/sarkoxedaf/Working/university/db3sem/gnomic.db {1005C26BC3}>
2023-05-25T14:37:58.063335+03:00 LOG Migrating into #<PGSQL-CONNECTION pgsql://postgres@localhost:5432/postgres {1005E30683}>
2023-05-25T14:37:58.336674+03:00 LOG report summary reset
             table name     errors       rows      bytes      total time
-----------------------  ---------  ---------  ---------  --------------
                  fetch          0          0                     0.000s
        fetch meta data          0          9                     0.023s
         Create Schemas          0          0                     0.003s
       Create SQL Types          0          0                     0.003s
          Create tables          0         18                     0.023s
         Set Table OIDs          0          9                     0.007s
-----------------------  ---------  ---------  ---------  --------------
                  games          0          9     0.3 kB          0.043s
                players          0         10     0.1 kB          0.040s
             developers          0         10     0.1 kB          0.060s
                  sales          0         12     0.3 kB          0.060s
              platforms          0          2     0.0 kB          0.060s
           developed_by          0         19     0.1 kB          0.083s
            officerooms          0          4     0.0 kB          0.000s
                 genres          0          5     0.1 kB          0.003s
                ratings          0          3     0.0 kB          0.023s
-----------------------  ---------  ---------  ---------  --------------
COPY Threads Completion          0          4                     0.083s
 Index Build Completion          0          0                     0.000s
        Reset Sequences          0          0                     0.030s
           Primary Keys          0          0                     0.000s
    Create Foreign Keys          0          0                     0.000s
        Create Triggers          0          0                     0.000s
       Install Comments          0          0                     0.000s
-----------------------  ---------  ---------  ---------  --------------
      Total import time          ✓         74     1.0 kB          0.113s
```

## Запуск запросов на PostgreSQL

```
postgres=# select id, title from games where title like '%d%';
 id |          title
----+-------------------------
  3 | Grand Auto Wash
  7 | Coldline Moscow
  9 | TrackIndifference: Park
(3 rows)
```

```
postgres=# select * from games;
 id |            title            | release_date | genre_id | platform_id
----+-----------------------------+--------------+----------+-------------
  1 | GREY SOULS III              |   1684958023 |        2 |           1
  2 | factor.io 2                 |   1684958050 |        3 |           1
  3 | Grand Auto Wash             |   1684958122 |        4 |           2
  4 | AMONG THEM                  |   1684951323 |        5 |           1
  5 | Pro Strike: Local Defensive |   1684958723 |        4 |           1
  6 | Green Life Sin              |   1684959123 |        4 |           2
  7 | Coldline Moscow             |   1684968023 |        5 |           1
  9 | TrackIndifference: Park     |   1685958023 |        1 |           2
 10 | SteamPunk 1387              |   1684959000 |        4 |           1
(9 rows)
```

```
postgres=# select title from games order by release_date;
            title
-----------------------------
 AMONG THEM
 GREY SOULS III
 factor.io 2
 Grand Auto Wash
 Pro Strike: Local Defensive
 SteamPunk 1387
 Green Life Sin
 Coldline Moscow
 TrackIndifference: Park
(9 rows)
```

Первая ошибка: в postgres нельзя использовать `==`, необходимо `=`

```
postgres=# select count(*) from games where genre_id = 4;
 count
-------
     4
(1 row)
```

```
postgres=# select title from games where release_date = (select min(release_date) from games);
   title
------------
 AMONG THEM
(1 row)
```

```
postgres=# select avg(release_date) from games;
         avg
---------------------
 1685069823.33333333
(1 row)
```

```
postgres=# select id, title from games where release_date < 1684959000 and genre_id = 4;
 id |            title
----+-----------------------------
  3 | Grand Auto Wash
  5 | Pro Strike: Local Defensive
(2 rows)
```

```
postgres=# select id, title from games where genre_id < platform_id;
 id |          title
----+-------------------------
  9 | TrackIndifference: Park
(1 row)
```

```
postgres=# select games.title, developed_by.developer_id from games join developed_by on developed_by.game_id = games.id;
            title            | developer_id
-----------------------------+--------------
 GREY SOULS III              |            2
 GREY SOULS III              |            1
 factor.io 2                 |            2
 factor.io 2                 |            3
 factor.io 2                 |            1
 Grand Auto Wash             |            3
 Grand Auto Wash             |            4
 AMONG THEM                  |            5
 AMONG THEM                  |            6
 Pro Strike: Local Defensive |            7
 Pro Strike: Local Defensive |            8
 Pro Strike: Local Defensive |            9
 Green Life Sin              |            7
 Green Life Sin              |            8
 Green Life Sin              |            9
 Coldline Moscow             |            8
 Coldline Moscow             |            9
 TrackIndifference: Park     |           10
(18 rows)
```

```
postgres=# select games.title, developers.name from games join developed_by on developed_by.game_id = games.id join developers on developed_by.developer_id = developers.id;
            title            |    name
-----------------------------+------------
 GREY SOULS III              | abobus778
 factor.io 2                 | abobus778
 GREY SOULS III              | abobus69
 factor.io 2                 | abobus69
 factor.io 2                 | abobus228
 Grand Auto Wash             | abobus228
 Grand Auto Wash             | abobus1337
 AMONG THEM                  | ponpon10
 AMONG THEM                  | ponpon12
 Pro Strike: Local Defensive | anna
 Green Life Sin              | anna
 Pro Strike: Local Defensive | konstantin
 Coldline Moscow             | konstantin
 Green Life Sin              | konstantin
 Green Life Sin              | VITALYA
 Pro Strike: Local Defensive | VITALYA
 Coldline Moscow             | VITALYA
 TrackIndifference: Park     | tima
(18 rows)
```

Очередная ошибка:
```
postgres=# select COUNT(developers.id), officerooms.room_name from developers join officerooms on developers.office_room_id = officerooms.id group by officerooms.id;
ERROR:  column "officerooms.room_name" must appear in the GROUP BY clause or be used in an aggregate function
LINE 1: select COUNT(developers.id), officerooms.room_name from deve...
```

Нельзя выбирать в агрегированном запросе и не группировать - исправим:

```
postgres=# select COUNT(developers.id), officerooms.room_name from developers join officerooms on developers.office_room_id = officerooms.id group by officerooms.room_name;
 count | room_name
-------+-----------
     4 | garbage
     2 | silver
     4 | bronze
(3 rows)
```


Такая же ошибка:

```
postgres=# select AVG(ratings.rating), games.id, games.title from games join ratings on games.id = ratings.game_id group by games.id;
ERROR:  column "games.title" must appear in the GROUP BY clause or be used in an aggregate function
LINE 1: select AVG(ratings.rating), games.id, games.title from games...
````

Исправляем:

```
postgres=# select AVG(ratings.rating), games.title from games join ratings on games.id = ratings.game_id group by games.title;
          avg           |            title
------------------------+-----------------------------
     5.0000000000000000 | AMONG THEM
 0.00000000000000000000 | Pro Strike: Local Defensive
    10.0000000000000000 | Grand Auto Wash
(3 rows)
```

```
postgres=# SELECT title, release_date FROM games
WHERE genre_id IN (SELECT id FROM genres WHERE name = 'survival')
AND platform_id IN (SELECT id FROM platforms WHERE name = 'pc');
     title      | release_date
----------------+--------------
 GREY SOULS III |   1684958023
(1 row)
```

Эта ошибка встречается и дальше, но упоминаться подробно больше не будет.

```
postgres=# SELECT players.username, COUNT(sales.id) as purchases, SUM(sales.price) as total_spent
FROM players
JOIN sales ON players.id = sales.player_id
GROUP BY players.username
ORDER BY total_spent DESC
LIMIT 10;
  username  | purchases | total_spent
------------+-----------+-------------
 mirrro     |         1 |      100000
 zimich     |         2 |        3000
 vega       |         1 |        2002
 nigg       |         2 |         130
 ivanos     |         1 |         103
 ne bakunin |         1 |         100
 vorusha    |         1 |         100
 minishuk   |         1 |          78
 koxed      |         1 |          30
 anzan      |         1 |           2
(10 rows)
```

```
postgres=# SELECT games.title, AVG(ratings.rating) as rating
FROM games
LEFT JOIN ratings ON games.id = ratings.game_id
GROUP BY games.title
ORDER BY rating DESC;
            title            |         rating
-----------------------------+------------------------
 factor.io 2                 |
 Coldline Moscow             |
 GREY SOULS III              |
 SteamPunk 1387              |
 TrackIndifference: Park     |
 Green Life Sin              |
 Grand Auto Wash             |    10.0000000000000000
 AMONG THEM                  |     5.0000000000000000
 Pro Strike: Local Defensive | 0.00000000000000000000
(9 rows)
```

```
postgres=# SELECT genres.name, COUNT(sales.id) as total_sales, SUM(sales.price) as total_revenue
FROM genres
JOIN games ON genres.id = games.genre_id
JOIN sales ON games.id = sales.game_id
GROUP BY genres.name;
    name     | total_sales | total_revenue
-------------+-------------+---------------
 survival    |           1 |          1000
 manufacture |           2 |          4002
 rasists     |           1 |            78
 open world  |           5 |        100301
 ubivalka    |           3 |           164
(5 rows)
```
