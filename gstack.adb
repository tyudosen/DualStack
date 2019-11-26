with Ada.Text_IO; use Ada.Text_IO;
package body gstack is
    stack : entries(1..max); 
    ttop: integer range 0.. max + 1;
    stop: integer range 0..max +1;

    procedure tpush(x: in item) is
    begin
        if ttop < (stop -1) then
            ttop := ttop + 1;
            stack(ttop) := x;
        else
            put("-----------------------------------------------------------------------------------");new_line;
            put("Garagebay Full. Send to Dagobah.");new_line;
            put("-----------------------------------------------------------------------------------");new_line;
        end if;
        --top:= top + 1; s(top):= x;   
    end tpush;

    procedure tpop(x: out item) is
    begin
        if ttop /= 0 then
            x := stack(ttop);
            ttop := ttop -1;
        else
            put("-----------------------------------------------------------------------------------");new_line;
            put("There are no Tie Figthers available for repair."); new_line;
            put("-----------------------------------------------------------------------------------");new_line;
        end if;
    end tpop;

    procedure spush(x: in item) is 
    begin
        if stop > (ttop +1)
        then
            stop := stop -1;
            stack(stop) := x;
        else
            put("-----------------------------------------------------------------------------------");new_line;
            put("Garagebay Full. Send to Dagobah.");new_line;
            put("-----------------------------------------------------------------------------------");new_line;
        end if;
    end spush;
    procedure spop(x: out item) is 
    begin
        if stop < (max +1)
        then
            x := stack(stop);
            stop := stop + 1;
        else
            put("-----------------------------------------------------------------------------------");new_line;
            put("There are no Star Destroyers available for repair.");new_line;
            put("-----------------------------------------------------------------------------------");new_line;
        end if;
    end spop;
    function spaceAvail return Boolean is
    begin
        if ((ttop - 0) + (max - stop) ) > 0
        then
            return False;
        else
            return True;
        end if;
    end spaceAvail;
begin
    ttop := 0; -- Sets Tie fighers to empty.
    stop := max + 1; -- Sets Star Destroyers to empty.
end gstack;