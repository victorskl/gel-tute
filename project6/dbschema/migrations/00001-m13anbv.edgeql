CREATE MIGRATION m13anbvv4yjy5kbpqs7x66vzg6htj7xuqlqx2nekcij7qcusfj6fgq
    ONTO initial
{
  CREATE FUTURE simple_scoping;
  CREATE TYPE default::Movie {
      CREATE REQUIRED PROPERTY title: std::str;
      CREATE PROPERTY year: std::int64;
  };
  CREATE TYPE default::Person {
      CREATE REQUIRED PROPERTY first_name: std::str;
      CREATE PROPERTY last_name: std::str;
      CREATE PROPERTY full_name := ((((.first_name ++ ' ') ++ .last_name) IF EXISTS (.last_name) ELSE .first_name));
  };
  ALTER TYPE default::Movie {
      CREATE MULTI LINK actors: default::Person;
      CREATE LINK director: default::Person;
  };
};
