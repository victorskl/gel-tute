# project6

_This is the same as scripted version in [project5](../project5). But, instead working with gel [REPL](https://docs.geldata.com/resources/cheatsheets/repl) shell._

```shell
gel project init
gel migration create
gel migrate
gel migration status
```

```shell
gel
Gel 6.10+b1cf2e4 (repl 7.4.0+bb0c441)
Type \help for help, \quit to quit.
```

```shell

project6:main> \lt
┌─────────────────┬──────────────────────────────┐
│ Name            │ Extending                    │
├─────────────────┼──────────────────────────────┤
│ default::Movie  │ std::BaseObject, std::Object │
│ default::Person │ std::BaseObject, std::Object │
└─────────────────┴──────────────────────────────┘
```

```shell
project6:main> insert Person {
    first_name := 'Denis',
    last_name := 'Villeneuve',
};
{default::Person {id: f95bd88a-91f0-11f0-8954-9394c8a44cc8}}
```

```shell
project6:main> with director_id := <uuid>$director_id
insert Movie {
  title := 'Blade Runnr 2049', # typo is intentional 🙃
  year := 2017,
  director := (
    select Person
    filter .id = director_id
  ),
  actors := {
    (insert Person {
      first_name := 'Harrison',
      last_name := 'Ford',
    }),
    (insert Person {
      first_name := 'Ana',
      last_name := 'de Armas',
    }),
  }
};
Parameter <uuid>$director_id: f95bd88a-91f0-11f0-8954-9394c8a44cc8
{default::Movie {id: 97b8c330-91f1-11f0-be0e-37c1090eff12}}
```

```shell
project6:main> update Movie
filter .title = 'Blade Runnr 2049'
set {
  title := "Blade Runner 2049",
  actors += (
    insert Person {
      first_name := "Ryan",
      last_name := "Gosling"
    }
  )
};

{default::Movie {id: 97b8c330-91f1-11f0-be0e-37c1090eff12}}
```

```shell
project6:main> insert Movie { title := "Dune" };
{default::Movie {id: ff5817a2-91f1-11f0-b202-1facbec008b2}}
```

```shell
project6:main> insert Movie {
  title := "Arrival",
  year := 2016
};
{default::Movie {id: 18101d12-91f2-11f0-b202-8b4e43080f66}}
```

```shell
project6:main> select Movie;
{default::Movie {id: 97b8c330-91f1-11f0-be0e-37c1090eff12}, default::Movie {id: ff5817a2-91f1-11f0-b202-1facbec008b2}, default::Movie {id: 18101d12-91f2-11f0-b202-8b4e43080f66}}
```

```shell
project6:main> select Movie {
    title,
    year
};

{default::Movie {title: 'Blade Runner 2049', year: 2017}, default::Movie {title: 'Dune', year: {}}, default::Movie {title: 'Arrival', year: 2016}}
```

```shell
project6:main> select Movie {
    title,
    year
}
filter .title = "Blade Runner 2049";
{default::Movie {title: 'Blade Runner 2049', year: 2017}}
```

```shell
project6:main> select Movie {
    title,
    year,
    director: {
        first_name,
        last_name
    },
    actors: {
        first_name,
        last_name
    }
}
filter .title = "Blade Runner 2049";
{
  default::Movie {
    title: 'Blade Runner 2049',
    year: 2017,
    director: default::Person {first_name: 'Denis', last_name: 'Villeneuve'},
    actors: {default::Person {first_name: 'Harrison', last_name: 'Ford'}, default::Person {first_name: 'Ana', last_name: 'de Armas'}, default::Person {first_name: 'Ryan', last_name: 'Gosling'}},
  },
}
```

```shell
project6:main> insert Person {
   first_name := 'Jason',
   last_name := 'Momoa'
};
{default::Person {id: ef0bda54-91f2-11f0-b8b3-fbf1b62648e4}}
```

```shell
project6:main> insert Person {
   first_name := 'Oscar',
   last_name := 'Isaac'
};
{default::Person {id: f3462944-91f2-11f0-b8b3-537f9382c86e}}
```

```shell
project6:main> insert Person { first_name := 'Zendaya'};
{default::Person {id: f789e860-91f2-11f0-b8b3-bbac15a8096c}}
```

```shell
project6:main> select Person {
  full_name :=
   .first_name ++ ' ' ++ .last_name
   if exists .last_name
   else .first_name
};
{default::Person {full_name: 'Denis Villeneuve'}, default::Person {full_name: 'Harrison Ford'}, default::Person {full_name: 'Ana de Armas'}, default::Person {full_name: 'Ryan Gosling'}, default::Person {full_name: 'Jason Momoa'}, default::Person {full_name: 'Oscar Isaac'}, default::Person {full_name: 'Zendaya'}}
```

```shell
project6:main> select Person {
  full_name
};
{default::Person {full_name: 'Denis Villeneuve'}, default::Person {full_name: 'Harrison Ford'}, default::Person {full_name: 'Ana de Armas'}, default::Person {full_name: 'Ryan Gosling'}, default::Person {full_name: 'Jason Momoa'}, default::Person {full_name: 'Oscar Isaac'}, default::Person {full_name: 'Zendaya'}}
```

```shell
project6:main> \q
```

```shell
gel instance destroy -I project6 --force
```
