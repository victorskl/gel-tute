# project2

```shell
gel project init
gel project info
gel instance list
gel list branches
gel describe schema
```

```shell
gel migration status
Detected differences between database schema and schema source, in particular:
    CREATE FUTURE simple_scoping;
gel error: Some migrations are missing.
  Use `gel migration create`.
```

```shell
diff ../project1/dbschema/default.gel dbschema/default.gel
1a2,17
>   type Person {
>     required property first_name -> str;
>     required property last_name -> str;
>
>     property full_name :=
>       .first_name ++ ' ' ++ .last_name
>       if exists .last_name
>       else .first_name;
>   }
>
>   type Movie {
>     required property title -> str;
>     property year -> int64; # the year of release
>     link director -> Person;
>     multi link actors -> Person;
>   }
```

```shell
gel migration create
Created dbschema/migrations/00001-m1upm27.edgeql, id: m1upm27j65khenshlevptq2ds2ey6ekbswmqgd26kblzdlwyarctjq
```

```shell
gel migration status
gel error: Database is empty, while 1 migrations have been found in the filesystem.
  Run `gel migrate` to apply.
```

```shell
gel migrate
Applying m1upm27j65khenshlevptq2ds2ey6ekbswmqgd26kblzdlwyarctjq (00001-m1upm27.edgeql)
... parsed
... applied
```

```shell
gel migration status
Database is up to date. Last migration: m1upm27j65khenshlevptq2ds2ey6ekbswmqgd26kblzdlwyarctjq.
```

```shell
gel describe schema
using future simple_scoping;
module default {
    type Movie {
        multi link actors: default::Person;
        link director: default::Person;
        required property title: std::str;
        property year: std::int64;
    };
    type Person {
        required property first_name: std::str;
        property full_name := ((((.first_name ++ ' ') ++ .last_name) if EXISTS (.last_name) else .first_name));
        required property last_name: std::str;
    };
};
```

```shell
gel list types
┌─────────────────┬──────────────────────────────┐
│ Name            │ Extending                    │
├─────────────────┼──────────────────────────────┤
│ default::Movie  │ std::BaseObject, std::Object │
│ default::Person │ std::BaseObject, std::Object │
└─────────────────┴──────────────────────────────┘
```

```shell
gel ui
```

```shell
gel instance destroy -I project2 --force
```
