CREATE MIGRATION m1ctsmjyffktdvg4mdeoyilk6jhag7laz7bvt4tlbuz2efjqr4zlha
    ONTO m1fjziwwsls5ac6ogkhtdt3vtun6j4t26i6dtbdd3ldh2uhpucpnba
{
  ALTER TYPE default::Person {
      ALTER PROPERTY last_name {
          RESET OPTIONALITY;
      };
  };
};
