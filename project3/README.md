# project3

How does gel data migration look alike?

```shell
gel project init
gel project info
```

```shell
diff ../project2/dbschema/default.gel dbschema/default.gel
```

```shell
gel migration create
gel migrate
gel migration status
```

## Make Changes

```shell
diff ../project2/dbschema/default.gel dbschema/default.gel
4c4
<     required property last_name -> str;
---
>     property last_name -> str;
```

```shell
gel migration status
Detected differences between database schema and schema source, in particular:
    ALTER TYPE default::Person {
        ALTER PROPERTY last_name {
            RESET OPTIONALITY;
        };
    };
gel error: Some migrations are missing.
  Use `gel migration create`.
```

```shell
gel migration create
did you make property 'last_name' of object type 'default::Person' optional? [y,n,l,c,b,s,q,?]
> y
Created dbschema/migrations/00002-m15urwx.edgeql, id: m15urwxxqxjiikfhvuk2xyfyg6al25ttk6yl33pqtfr4s6lqqmzfjq
```

```shell
gel migrate
Applying m15urwxxqxjiikfhvuk2xyfyg6al25ttk6yl33pqtfr4s6lqqmzfjq (00002-m15urwx.edgeql)
... parsed
... applied
```

```shell
gel migration status
Database is up to date. Last migration: m15urwxxqxjiikfhvuk2xyfyg6al25ttk6yl33pqtfr4s6lqqmzfjq.
```
