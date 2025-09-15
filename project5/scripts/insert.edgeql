insert Person {
    first_name := 'Denis',
    last_name := 'Villeneuve',
};

# with director_id := <uuid>$director_id
insert Movie {
  title := 'Blade Runnr 2049', # typo is intentional 🙃
  year := 2017,
  director := assert_single((
    select Person
    # filter .id = director_id
    filter .first_name = 'Denis'
  )),
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

update Movie
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

insert Movie { title := "Dune" };

insert Movie {
  title := "Arrival",
  year := 2016
};

insert Person {
   first_name := 'Jason',
   last_name := 'Momoa'
};

insert Person {
   first_name := 'Oscar',
   last_name := 'Isaac'
};

insert Person { first_name := 'Zendaya'};
