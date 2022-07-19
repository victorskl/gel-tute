# docker-edgedb

REF:
- https://hub.docker.com/r/edgedb/edgedb
- https://github.com/edgedb/edgedb-docker
- https://www.edgedb.com/docs/guides/deployment/docker

```
docker compose pull

mkdir -p data
docker compose up -d

docker compose logs -f edgedb
docker compose ps
```

## CLI

```
brew tap edgedb/tap
brew install edgedb-cli
```

```
edgedb --help-connect
edgedb --tls-ca-file ./data/edbtlscert.pem -H localhost -u edgedb --password
edgedb> \h
edgedb> \l
edgedb> \lm
edgedb> \s
edgedb> \q
```

### Linking Remote Instance

> NOTE: THIS STEP IS MANDATORY.

_... Consider Edgedb is running in Remote. In this case docker compose stack._

```
edgedb instance link --help
edgedb instance link --trust-tls-cert edgedb
edgedb -I edgedb --password
edgedb> \h
edgedb> \q
```

```
vi ~/Library/Application\ Support/edgedb/credentials/edgedb.json
(Add "password" : "edgedb")

edgedb instance status -I edgedb
up

edgedb instance list
┌────────┬────────┬────────────────┬─────────────┬────────┐
│ Kind   │ Name   │ Port           │ Version     │ Status │
├────────┼────────┼────────────────┼─────────────┼────────┤
│ remote │ edgedb │ localhost:5656 │ 1.4+ffe1237 │ up     │
└────────┴────────┴────────────────┴─────────────┴────────┘
```

## EdgeQL

```
edgedb migration status
Database is up to date. Last migration: m1j2tcgnrsl5satp7n3sfg3jsqekkcmhvtuswwkjajtu334fbzus4a.

edgedb describe schema
module default {
    type Movie {
        multi link actors -> default::Person;
        link director -> default::Person;
        required property title -> std::str;
        property year -> std::int64;
    };
    type Person {
        required property first_name -> std::str;
        required property last_name -> std::str;
    };
};

edgedb list databases
edgedb

edgedb list types
┌─────────────────┬──────────────────────────────┐
│ Name            │ Extending                    │
├─────────────────┼──────────────────────────────┤
│ default::Movie  │ std::BaseObject, std::Object │
│ default::Person │ std::BaseObject, std::Object │
└─────────────────┴──────────────────────────────┘
```

### Literals

```
edgedb
EdgeDB 1.4+ffe1237 (repl 1.2.1+b0f579b)
Type \help for help, \quit to quit.
edgedb>

edgedb> select <uuid>'a5ea6360-75bd-4c20-b69c-8f317b0d2857';
edgedb> select uuid_generate_v1mc();
edgedb> select <datetime>'1999-03-31T15:17:00Z';
edgedb> select <duration>'5 hours 4 minutes 3 seconds';
edgedb> select ['hello', 'world'];
edgedb> select ('Apple', 7, true);
edgedb> select <json>5;
edgedb> select <json>"a string";
edgedb> select <json>["this", "is", "an", "array"];
edgedb> select <json>("unnamed tuple", 2);
edgedb> select <json>(name := "named tuple", count := 2);
edgedb> select to_json('{"a": 2, "b": 5}');
```

### Types

```
edgedb> select <uuid>'89381587-705d-458f-b837-860822e1b219'; 
edgedb> select <tuple<str, float64, bigint>>(1, 2, 3);
edgedb> select <array<str>>[1, 2, 3];
edgedb> select <bigint>10;
edgedb> select <str>10;
edgedb> select <int16>42;
edgedb> select <datetime>'1999-03-31T15:17:00Z';
```

### Set

```
edgedb> select 1 + 1;
edgedb> select distinct {1, 2, 2, 3};
edgedb> select count({'aaa', 'bbb'});
edgedb> select sum({1, 2, 3});
edgedb> select min({1, 2, 3});
edgedb> select max({1, 2, 3});
edgedb> select count(<str>{});
edgedb> select <str>{} ++ 'ccc';
edgedb> select {'aaa', 'bbb'} ++ {'ccc', 'ddd'};
edgedb> select str_split({"hello world", "hi again"}, " ");
edgedb> select {1, 2, 3} ^ 2;
edgedb> select str_upper({'aaa', 'bbb'});
edgedb> \q
```

### Insert

```
edgedb query 'insert Person { first_name := "P1" }'
{"id": "8737352a-0746-11ed-858b-ffbc30831d13"}

edgedb query 'insert Person { first_name := "P2" }'
{"id": "8977401e-0746-11ed-ba12-a32d7b1d77f3"}

edgedb query 'insert Person { first_name := "P3" }'
{"id": "8e6aac14-0746-11ed-ba12-fbbcd3177515"}
```

### Select

```
edgedb query 'select Person'
{"id": "8737352a-0746-11ed-858b-ffbc30831d13"}
{"id": "8977401e-0746-11ed-ba12-a32d7b1d77f3"}
{"id": "8e6aac14-0746-11ed-ba12-fbbcd3177515"}
```

### Delete

```
edgedb
EdgeDB 1.4+ffe1237 (repl 1.2.1+b0f579b)
Type \help for help, \quit to quit.

edgedb> select Person;
{default::Person {id: 8737352a-0746-11ed-858b-ffbc30831d13}, default::Person {id: 8977401e-0746-11ed-ba12-a32d7b1d77f3}, default::Person {id: 8e6aac14-0746-11ed-ba12-fbbcd3177515}}

edgedb> delete Person filter .id = <uuid>'8737352a-0746-11ed-858b-ffbc30831d13';
edgedb> delete Person filter .id = <uuid>'8977401e-0746-11ed-ba12-a32d7b1d77f3';
edgedb> delete Person filter .id = <uuid>'8e6aac14-0746-11ed-ba12-fbbcd3177515';

edgedb> \q
```

### Scripts

```
edgedb query -f script/insert.edgeql
{"id": "e7024c02-074a-11ed-8848-270da854e96e"}
{"id": "e71cdedc-074a-11ed-8848-8f316c96b5e9"}
{"id": "e71cdedc-074a-11ed-8848-8f316c96b5e9"}
{"id": "e7383510-074a-11ed-8848-1f3e49213147"}
{"id": "e73f9576-074a-11ed-8848-9bccdc3d4084"}
{"id": "e745c522-074a-11ed-8848-ab3e53ecfb87"}
{"id": "e746c0ee-074a-11ed-8848-8fed43973407"}
{"id": "e74ca428-074a-11ed-8848-bbaf29871a01"}
```

```
edgedb query -f script/select_movie.edgeql
{"title": "Blade Runner 2049", "year": 2017}
{"title": "Dune", "year": null}
{"title": "Arrival", "year": 2016}
```

```
edgedb query -f script/select_person.edgeql
{"first_name": "Denis", "last_name": "Villeneuve"}
{"first_name": "Harrison", "last_name": "Ford"}
{"first_name": "Ana", "last_name": "de Armas"}
{"first_name": "Ryan", "last_name": "Gosling"}
{"first_name": "Jason", "last_name": "Momoa"}
{"first_name": "Oscar", "last_name": "Isaac"}
{"first_name": "Zendaya", "last_name": null}
```

```
edgedb query -f script/select_link.edgeql
{"actors": [{"first_name": "Harrison", "last_name": "Ford"}, {"first_name": "Ana", "last_name": "de Armas"}, {"first_name": "Ryan", "last_name": "Gosling"}], "director": {"first_name": "Denis", "last_name": "Villeneuve"}, "title": "Blade Runner 2049", "year": 2017}
{"actors": [], "director": null, "title": "Dune", "year": null}
{"actors": [], "director": null, "title": "Arrival", "year": 2016}
```

### Re-spin

```
docker compose ps
docker compose down
rm -rf data
mkdir -p data
docker compose up -d
```
