CREATE MIGRATION m1azwyppwwtpimxv5pj5cuol3k4qmadaqdcha2odlobamjty2ahp5q
    ONTO m1ctsmjyffktdvg4mdeoyilk6jhag7laz7bvt4tlbuz2efjqr4zlha
{
  ALTER TYPE default::Person {
      CREATE PROPERTY full_name := ((((.first_name ++ ' ') ++ .last_name) IF EXISTS (.last_name) ELSE .first_name));
  };
};
