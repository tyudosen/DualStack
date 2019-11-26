package randfloat  is   --Generates a uniformly distributed random real
  function next_float(x: in out integer) return float;  -- between 0.0 <= next <= 1.0.
end randfloat;