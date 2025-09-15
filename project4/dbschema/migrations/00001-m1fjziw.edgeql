CREATE MIGRATION m1fjziwwsls5ac6ogkhtdt3vtun6j4t26i6dtbdd3ldh2uhpucpnba
    ONTO initial
{
  CREATE FUTURE simple_scoping;
  CREATE TYPE default::Person {
      CREATE REQUIRED PROPERTY first_name: std::str;
      CREATE REQUIRED PROPERTY last_name: std::str;
  };
  CREATE TYPE default::Movie {
      CREATE MULTI LINK actors: default::Person;
      CREATE LINK director: default::Person;
      CREATE REQUIRED PROPERTY title: std::str;
      CREATE PROPERTY year: std::int64;
  };
};
