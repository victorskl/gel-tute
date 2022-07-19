# Quickstart

> THIS IS SCRIPTED IN `/script/insert.edgeql`

https://www.edgedb.com/docs/guides/quickstart#insert-data

```
edgedb
EdgeDB 1.4+ffe1237 (repl 1.2.1+b0f579b)
Type \help for help, \quit to quit.

edgedb> \lt
┌─────────────────┬──────────────────────────────┐
│ Name            │ Extending                    │
├─────────────────┼──────────────────────────────┤
│ default::Movie  │ std::BaseObject, std::Object │
│ default::Person │ std::BaseObject, std::Object │
└─────────────────┴──────────────────────────────┘

edgedb> insert Person {
.......     first_name := 'Denis',
.......     last_name := 'Villeneuve',
....... };
{default::Person {id: bccb00a2-0739-11ed-b6db-bb9e51f105fc}}

edgedb> with director_id := <uuid>$director_id
....... insert Movie {
.......   title := 'Blade Runnr 2049', # typo is intentional 🙃
.......   year := 2017,
.......   director := (
.......     select Person
.......     filter .id = director_id
.......   ),
.......   actors := {
.......     (insert Person {
.......       first_name := 'Harrison',
.......       last_name := 'Ford',
.......     }),
.......     (insert Person {
.......       first_name := 'Ana',
.......       last_name := 'de Armas',
.......     }),
.......   }
....... };
Parameter <uuid>$director_id: bccb00a2-0739-11ed-b6db-bb9e51f105fc
{default::Movie {id: bd45b5b2-073a-11ed-a1dc-d3e6e90f43cf}}

edgedb> update Movie
....... filter .title = 'Blade Runnr 2049'
....... set {
.......   title := "Blade Runner 2049",
.......   actors += (
.......     insert Person {
.......       first_name := "Ryan",
.......       last_name := "Gosling"
.......     }
.......   )
....... };
{default::Movie {id: bd45b5b2-073a-11ed-a1dc-d3e6e90f43cf}}

edgedb> insert Movie { title := "Dune" };
{default::Movie {id: 09c76624-073b-11ed-9ce4-a78d83577f73}}

edgedb> insert Movie {
.......   title := "Arrival",
.......   year := 2016
....... };
{default::Movie {id: 121afbd8-073b-11ed-9ce4-370e2f10c264}}

edgedb> select Movie;
{default::Movie {id: bd45b5b2-073a-11ed-a1dc-d3e6e90f43cf}, default::Movie {id: 09c76624-073b-11ed-9ce4-a78d83577f73}, default::Movie {id: 121afbd8-073b-11ed-9ce4-370e2f10c264}}

edgedb> select Movie {
.......     title,
.......     year
....... };
{default::Movie {title: 'Blade Runner 2049', year: 2017}, default::Movie {title: 'Dune', year: {}}, default::Movie {title: 'Arrival', year: 2016}}

edgedb> select Movie {
.......     title,
.......     year
....... }
....... filter .title = "Blade Runner 2049";
{default::Movie {title: 'Blade Runner 2049', year: 2017}}

edgedb> select Movie {
.......     title,
.......     year,
.......     director: {
.......         first_name,
.......         last_name
.......     },
.......     actors: {
.......         first_name,
.......         last_name
.......     }
....... }
....... filter .title = "Blade Runner 2049";
{
  default::Movie {
    title: 'Blade Runner 2049',
    year: 2017,
    director: default::Person {first_name: 'Denis', last_name: 'Villeneuve'},
    actors: {default::Person {first_name: 'Harrison', last_name: 'Ford'}, default::Person {first_name: 'Ana', last_name: 'de Armas'}, default::Person {first_name: 'Ryan', last_name: 'Gosling'}},
  },
}
```

```
edgedb> insert Person {
.......    first_name := 'Jason',
.......    last_name := 'Momoa'
....... };
{default::Person {id: 5e9ef4e0-073c-11ed-a231-d3d1dfc677b4}}

edgedb> insert Person {
.......    first_name := 'Oscar',
.......    last_name := 'Isaac'
....... };
{default::Person {id: 6189d706-073c-11ed-a231-232bf39a01bd}}

edgedb> insert Person { first_name := 'Zendaya'};
edgedb error: MissingRequiredError: missing value for required property 'last_name' of object type 'default::Person'

edgedb> \q
```

```
edgedb migration create
did you make property 'last_name' of object type 'default::Person' optional? [y,n,l,c,b,s,q,?]
> y
Created dbschema/migrations/00002.edgeql, id: m1ajja2pdgzlgrtmfip7pd62u6lkw2hjd52mkeaofzwspjhada5yiq

edgedb migrate
Applied m1ajja2pdgzlgrtmfip7pd62u6lkw2hjd52mkeaofzwspjhada5yiq (00002.edgeql)
```

```
edgedb
EdgeDB 1.4+ffe1237 (repl 1.2.1+b0f579b)
Type \help for help, \quit to quit.

edgedb> insert Person {
.......   first_name := 'Zendaya'
....... };
{default::Person {id: e2396664-073c-11ed-a0d1-1b58904b4403}}
```

```
edgedb> select Person {
.......   full_name :=
.......    .first_name ++ ' ' ++ .last_name
.......    if exists .last_name
.......    else .first_name
....... };
{
  default::Person {full_name: 'Denis Villeneuve'},
  default::Person {full_name: 'Harrison Ford'},
  default::Person {full_name: 'Ana de Armas'},
  default::Person {full_name: 'Ryan Gosling'},
  default::Person {full_name: 'Jason Momoa'},
  default::Person {full_name: 'Oscar Isaac'},
  default::Person {full_name: 'Zendaya'},
}

edgedb> \q
```

```
edgedb migration create
did you create property 'full_name' of object type 'default::Person'? [y,n,l,c,b,s,q,?]
> y
Created dbschema/migrations/00003.edgeql, id: m1j2tcgnrsl5satp7n3sfg3jsqekkcmhvtuswwkjajtu334fbzus4a

edgedb migrate
Applied m1j2tcgnrsl5satp7n3sfg3jsqekkcmhvtuswwkjajtu334fbzus4a (00003.edgeql)
```

```
edgedb
EdgeDB 1.4+ffe1237 (repl 1.2.1+b0f579b)
Type \help for help, \quit to quit.

edgedb> select Person {
.......   full_name
....... };
{
  default::Person {full_name: 'Denis Villeneuve'},
  default::Person {full_name: 'Harrison Ford'},
  default::Person {full_name: 'Ana de Armas'},
  default::Person {full_name: 'Ryan Gosling'},
  default::Person {full_name: 'Jason Momoa'},
  default::Person {full_name: 'Oscar Isaac'},
  default::Person {full_name: 'Zendaya'},
}

edgedb> \q
```
