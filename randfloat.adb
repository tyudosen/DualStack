With Ada.Text_IO; Use Ada.Text_IO;
Package body RandFloat is
package IntIO is new Ada.Text_IO.Integer_IO(Integer);
use IntIO;
  --x: integer;--:= 737;  -- seed
  function next_float(x: in out integer) return float is
    n: integer;
    
  begin
    --put("Seed the rand gen");
    --new_line;
    x := x*29+37;
    n := x;
    x := x mod 1001;
    return  float(n mod 101) / 100.0;
  end next_float;
end RandFloat;