generic
   -- low: integer; --lowerbound of stack
    --up: integer; -- upperbound of stack
    max: integer;
    type item is private; -- type of stack

package gstack is
    procedure tpush(x: in item);
    procedure tpop(x: out item);
    procedure spush(x: in item);
    procedure spop(x: out item);
    function spaceAvail return Boolean;
private
    type entries is array( integer range <>) of item;
    
end gstack;


