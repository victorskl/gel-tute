CREATE MIGRATION m15urwxxqxjiikfhvuk2xyfyg6al25ttk6yl33pqtfr4s6lqqmzfjq
    ONTO m1upm27j65khenshlevptq2ds2ey6ekbswmqgd26kblzdlwyarctjq
{
  ALTER TYPE default::Person {
      ALTER PROPERTY last_name {
          RESET OPTIONALITY;
      };
  };
};
