# project4

<!-- TOC -->
* [project4](#project4)
  * [Init](#init)
  * [Primitives](#primitives)
    * [Literals](#literals)
    * [Types](#types)
    * [Set](#set)
  * [Migration](#migration)
  * [Query](#query)
    * [Insert](#insert)
    * [Select](#select)
    * [Delete](#delete)
<!-- TOC -->

## Init

```shell
gel project init
```

```shell
gel
Gel 6.10+b1cf2e4 (repl 7.4.0+bb0c441)
Type \help for help, \quit to quit.
project4:main>
```

## Primitives

### Literals

```shell
project4:main> select 1;
project4:main> select <uuid>'a5ea6360-75bd-4c20-b69c-8f317b0d2857';
project4:main> select uuid_generate_v1mc();
project4:main> select <datetime>'1999-03-31T15:17:00Z';
project4:main> select <duration>'5 hours 4 minutes 3 seconds';
project4:main> select ['hello', 'world'];
project4:main> select ('Apple', 7, true);
project4:main> select <json>5;
project4:main> select <json>"a string";
project4:main> select <json>["this", "is", "an", "array"];
project4:main> select <json>("unnamed tuple", 2);
project4:main> select <json>(name := "named tuple", count := 2);
project4:main> select to_json('{"a": 2, "b": 5}');
```

### Types

```shell
project4:main> select <uuid>'89381587-705d-458f-b837-860822e1b219';
project4:main> select <tuple<str, float64, bigint>>(1, 2, 3);
project4:main> select <array<str>>[1, 2, 3];
project4:main> select <bigint>10;
project4:main> select <str>10;
project4:main> select <int16>42;
project4:main> select <datetime>'1999-03-31T15:17:00Z';
```

### Set

```shell
project4:main> select 1 + 1;
project4:main> select distinct {1, 2, 2, 3};
project4:main> select count({'aaa', 'bbb'});
project4:main> select sum({1, 2, 3});
project4:main> select min({1, 2, 3});
project4:main> select max({1, 2, 3});
project4:main> select count(<str>{});
project4:main> select <str>{} ++ 'ccc';
project4:main> select {'aaa', 'bbb'} ++ {'ccc', 'ddd'};
project4:main> select str_split({"hello world", "hi again"}, " ");
project4:main> select {1, 2, 3} ^ 2;
project4:main> select str_upper({'aaa', 'bbb'});
project4:main> \q
```

## Migration

<details>
  <summary>Click to see details</summary>

```shell
cat dbschema/default.gel
module default {
  type Person {
    required property first_name -> str;
    required property last_name -> str;
  }

  type Movie {
    required property title -> str;
    property year -> int64; # the year of release
    link director -> Person;
    multi link actors -> Person;
  }
}
```

```shell
gel migration create
gel migrate
gel migration status
```

```shell
cat dbschema/default.gel
module default {
  type Person {
    required property first_name -> str;
    property last_name -> str;
  }

  type Movie {
    required property title -> str;
    property year -> int64; # the year of release
    link director -> Person;
    multi link actors -> Person;
  }
}
```

```shell
gel migration create
gel migrate
gel migration status
```

```shell
cat dbschema/default.gel
module default {
  type Person {
    required property first_name -> str;
    property last_name -> str;

    property full_name :=
      .first_name ++ ' ' ++ .last_name
      if exists .last_name
      else .first_name;
  }

  type Movie {
    required property title -> str;
    property year -> int64; # the year of release
    link director -> Person;
    multi link actors -> Person;
  }
}
```

```shell
gel migration create
gel migrate
gel migration status
```
</details>

## Query

```shell
gel query --help
```

### Insert

```shell
gel query 'insert Person { first_name := "P1" }'
{"id": "3fd9342c-91e9-11f0-a4e3-b773e025cc52"}

gel query 'insert Person { first_name := "P2" }'
{"id": "4cf45ba0-91e9-11f0-a4e3-df065ac234dd"}

gel query 'insert Person { first_name := "P3" }'
{"id": "52fcdab8-91e9-11f0-a4e3-2305d7a88533"}
```

### Select

```shell
gel query 'select Person'
{"id": "3fd9342c-91e9-11f0-a4e3-b773e025cc52"}
{"id": "4cf45ba0-91e9-11f0-a4e3-df065ac234dd"}
{"id": "52fcdab8-91e9-11f0-a4e3-2305d7a88533"}
```

### Delete

```shell
gel
```

```shell
project4:main> \lt
project4:main> select Person;
project4:main> select count(Person);
project4:main> select Person filter .id = <uuid>'3fd9342c-91e9-11f0-a4e3-b773e025cc52';
project4:main> delete Person filter .id = <uuid>'3fd9342c-91e9-11f0-a4e3-b773e025cc52';
project4:main> delete Person filter .id = <uuid>'4cf45ba0-91e9-11f0-a4e3-df065ac234dd';
project4:main> delete Person filter .id = <uuid>'52fcdab8-91e9-11f0-a4e3-2305d7a88533';
project4:main> \q
```

```shell
gel instance destroy -I project4 --force
```
