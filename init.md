### Init

This is only needed upon the very first time whereas the `./dbschema` directory is blank and, project descriptor `edgedb.toml` is absent.

```
edgedb info
EdgeDB uses the following local paths:
┌───────────────┬───────────────────────────────────────────────────────┐
│ Cache         │ /Users/abcde/Library/Caches/edgedb/                   │
│ Config        │ /Users/abcde/Library/Application Support/edgedb/      │
│ Custom Binary │ /usr/local/bin/edgedb                                 │
│ Data          │ /Users/abcde/Library/Application Support/edgedb/data/ │
│ Service       │ /Users/abcde/Library/LaunchAgents/                    │
└───────────────┴───────────────────────────────────────────────────────┘
```

```
edgedb project init
No `edgedb.toml` found in `/Users/abcde/Projects/github/docker-edgedb` or above
Do you want to initialize a new project? [Y/n]
> Y
Specify the name of EdgeDB instance to use with this project [default: docker_edgedb]:
> edgedb
Do you want to use existing instance "edgedb" for the project? [y/n]
> y
Applying migrations...
Everything is up to date. Revision initial
Project linked
To connect to edgedb, run `edgedb`

edgedb project info
┌───────────────┬────────────────────────────────────────────┐
│ Instance name │ edgedb                                     │
│ Project root  │ /Users/abcde/Projects/github/docker-edgedb │
└───────────────┴────────────────────────────────────────────┘
```

```
edgedb list databases
edgedb

edgedb describe schema
module default{};

edgedb migration status
Detected differences between the database schema and the schema source, in particular:
    CREATE TYPE default::Person {
        CREATE REQUIRED PROPERTY first_name -> std::str;
        CREATE REQUIRED PROPERTY last_name -> std::str;
    };
edgedb error: Some migrations are missing.
  Use `edgedb migration create`.

edgedb migration create

edgedb migration status
edgedb error: Database is empty. While there are 1 migrations on the filesystem.
  Run `edgedb migrate` to apply.

edgedb migrate
Applied m13nabibq23bzg35acwxj5vc22thafyniyoahtgq2vlzie6oafpl7a (00001.edgeql)
Note: adding first migration disables DDL. More info: https://edgedb.com/p/bare_ddl

edgedb migration status
Database is up to date. Last migration: m13nabibq23bzg35acwxj5vc22thafyniyoahtgq2vlzie6oafpl7a.

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

edgedb list types
┌─────────────────┬──────────────────────────────┐
│ Name            │ Extending                    │
├─────────────────┼──────────────────────────────┤
│ default::Movie  │ std::BaseObject, std::Object │
│ default::Person │ std::BaseObject, std::Object │
└─────────────────┴──────────────────────────────┘
```
