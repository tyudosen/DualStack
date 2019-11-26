with RandFloat; use RandFloat;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Calendar; use Ada.Calendar;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;
with Ada.Calendar.Time_zones; use Ada.Calendar.Time_zones;
with Unchecked_Conversion;
with gstack;

procedure ArrivalForRepair is
   package FloatIO is new Ada.Text_IO.Float_IO(float);
   use FloatIO;
   package IntIO is new Ada.Text_IO.Integer_IO(Integer);
   use IntIO;
   package Fix_IO is new Ada.Text_IO.Fixed_IO(DAY_DURATION); 
   use Fix_IO;

   function intToChar is new Unchecked_Conversion(Integer, Character);
   charStar, charTie : Character := 'A';
   intStar, intTie : Integer := 64;

   subtype getChar is Character range 'A'..'Z';
	lastCharOfTie, lastCharOfStar : getChar := getChar'First;

   type vehicle is
		(Star_Destroyer, Tie_Fighter);
	package vechileIO is new Ada.Text_IO.Enumeration_IO(vehicle);

	type vName is
		(Tie, Star);
	package nameIO is new Ada.Text_IO.Enumeration_IO(vName);

   -- Maintainance bay record
    type garageBay is record
        vehicleType : vehicle;
        vehicleName: String(1..5);
        time2Fix: integer;
        startTime: Time;
        finishTime: Time;
		--elapsedTime: DAY_DURATION;
    end record;
	a : garageBay;
 
 -- Function to determine if the arriving planes are Star or Tie
   function StarOrTie(x: in out integer) return garageBay is
      randNum: float;
	  z,b,c,d : garageBay;
     e : Time := Clock;

	  --seed: integer;
   begin
	  
      randNum := next_float(x);  -- 0.0 <= randNumm <= 1.0.

      if randNum <= 0.25 then
		z := (vehicleType => Tie_Fighter, vehicleName => "Tie  ",  time2Fix => 0, startTime => e, finishTime => e);
        return a; -- return tie
      elsif randNum <= 0.5 then
		b := (vehicleType => Tie_Fighter, vehicleName => "Tie  ", time2Fix => 0, startTime => e, finishTime => e);
        return b; -- return tie
      elsif randNum <= 0.75 then
	  	c := (vehicleType => Tie_Fighter, vehicleName => "Tie  ", time2Fix => 0, startTime => e, finishTime => e);
        return c; -- return tie
      else
	  	d := (vehicleType => Star_Destroyer, vehicleName => "Star ", time2Fix => 0, startTime => e, finishTime => e);
        return d; -- return stsr
      end if;

    end StarOrTie;
	


   -- Determine the number of new arrivals for Step 1 in the lab.
   -- Either 1, 2, 3 or 4 uniformly distributed on each call.
   function NumberNewArrivals(x: in out integer) return Integer is
      randNum: float;
   begin
      randNum := next_float(x);  -- 0.0 <= randNumm <= 1.0.

      if randNum <= 0.25 then
         return 1; -- return tie
      elsif randNum <= 0.5 then
         return 2; -- return tie
      elsif
         randNum <= 0.75 then
         return 3; -- return tie
      else
         return 4; -- return stsr
      end if;

    end NumberNewArrivals;

    Start,Finish, elapsed, secondus : DAY_DURATION;
    StartTime, ArrivTime, departTime, ElapsTime : Time := clock; 
   -- Procedure to get start time
   
   --function startTime return DAY_DURATION is
     -- Year,Month,Day : INTEGER;
      --Start : DAY_DURATION;
      --Time_And_Date  : TIME;
   --begin
      --Time_And_Date := Clock; -- gets system time
      --Split(Time_And_Date,Year, Month,Day,Start);
      --return Start; -- gets start time ( stores it in seconds in the variable Start)
   --end startTime;

   -- Procedure to get finish time
   
   function finishTime return DAY_DURATION is
      Year,Month,Day : INTEGER;
      Finish : DAY_DURATION;
      Time_And_Date  : TIME;
   begin
      Time_And_Date := Clock; -- gets system time
      Split(Time_And_Date,Year, Month,Day,Finish);
      return Finish; -- gets start time ( stores it in seconds in the variable Start)
   end finishTime;

  
    numberArrivals,seed,upperbound,starKnt,tieKnt, dagobah, repairStar, repairTie: Integer := 0;
    decision: garageBay;
    ET: DAY_DURATION;

    



begin
-- Get upperbound of the stack.
   put("Enter The Maximum Number Of Vehicles Allowed In The Garagebay:"); new_line;
	get(upperbound);
	
	declare
   -- Instantiate the generic package for type garageBay.
	package genericS is new gstack(upperbound, garageBay);
	use genericS;
	begin
   -- Lab Step 0. write start time to service log.
      --start := startTime;
      --finish := finishTime;
      --elapsed := finish - start;
   	--ET := elapsed;
      startTime := clock;
		put(Image(startTime, Time_Zone => -5*60) ); put(" Garagebay is open "); 
      new_line;



      -- Seed the random number generator appropriately.
      put("Seed the random number generator:"); new_line;
      get(seed);
      put("-----------------------------------------------------------------------------------");new_line;
      -- do the operations
      --numberArrivals := 3; -- Assuming 3 vehicles at open.
      Loop
         numberArrivals := NumberNewArrivals(seed);
         put("Number of Arrivals: ");new_line;put(numberArrivals,0);new_line;
         put("-----------------------------------------------------------------------------------");new_line;
         for j in 1..numberArrivals 
         loop
            
            --Determine if the arrival is a Tie Fighter or a Star Destroyer.
            --Prepare the maintenance record and place it in the appropriate queue.
            decision := StarOrTie(seed);
			   if decision.vehicleType = Star_Destroyer 
			   then
               intStar := intStar + 1;
               if intStar = 91 then
                  intStar := 65;
               end if; 
               charStar := intToChar(intStar);
               decision.vehicleName(1..4) := "Star";
				   decision.vehicleName(5) := charStar;
				   decision.time2Fix := 7;
               ArrivTime := clock;
               decision.startTime := ArrivTime;
               
               spush(decision);
               ---
                --if dagobah > 0 then
               --put("Dagobah Count: ");put(dagobah);new_line;
               --put("-----------------------------------------------------------------------------------");new_line;
            --end if;
               ---
               starKnt := starKnt +1;
               --put("Number of Arrivals: ");put(numberArrivals);new_line;
               put(Image(startTime, Time_Zone => -5*60) );put(":");new_line;
               put(decision.vehicleName & " Arrived");new_line(2);
              -- put("-----------------------------------------------------------------------------------");new_line;
			   else 
                intTie := intTie + 1;
               if intTie = 91 then
                  intTie := 65;
               end if; 
               charTie := intToChar(intTie);
				   decision.vehicleName(4) := charTie;
				   decision.time2Fix := 3;
               ArrivTime := clock;
               decision.startTime := ArrivTime;
               departTime := clock;
               decision.finishTime := departTime;
               tpush(decision);
               --
               
            
               --
               tieKnt := tieKnt + 1;
               put(Image(startTime, Time_Zone => -5*60) );put(":");new_line;
               put(decision.vehicleName & " Arrived");new_line(2);
			   end if;
            if tieKnt + starKnt > 20 then
               dagobah := dagobah + 1;
            end if;
            if dagobah > 0 then
                  put("Dagobah Count: ");put(dagobah);new_line;
                  put("-----------------------------------------------------------------------------------");new_line;
                end if;
		   end loop;
       
      
      
  
         --Lab Step 2.
         if starKnt > 0 then 
            spop(decision); starKnt := starKnt - 1;repairStar:= repairStar+ 1;
            delay 3.0;
            put("-----------------------------------------------------------------------------------");new_line;
            
            put("Vehicle Type: ");put(vehicle'image(decision.vehicleType));new_line;
            put("Vehicle Name: " & decision.vehicleName);new_line;
            put("Time to Fix: ");put(decision.time2Fix,0);new_line;
            put("Start Time: ");put(Image(decision.startTime, Time_Zone => -5*60) );new_line;
            departTime := clock;
            --finishTime := departTime;
            put("Finish Time: ");put(Image(departTime, Time_Zone => -5*60 ));new_line;
            put("-----------------------------------------------------------------------------------");new_line;
            --if dagobah > 0 then
              -- put("Dagobah Count: ");put(dagobah);new_line;
            --end if;
            
         elsif starKnt = 0  then --and tieKnt > 0
            tpop(decision); tieKnt := tieKnt - 1;repairTie := repairTie + 1;
            delay 1.00;
            put("-----------------------------------------------------------------------------------");new_line;
            put("Vehicle Type: ");put(vehicle'image(decision.vehicleType));new_line;
            --put("Vehicle Name: " & decision.vehicleName);new_line;
            put("Vehicle Name: " & decision.vehicleName);new_line;
            put("Time to Fix: ");put(decision.time2Fix,0);new_line;
            put("Start Time: ");put(Image(decision.startTime, Time_Zone => -5*60) );new_line;
            departTime := clock;
            --finishTime := departTime;
            put("Finish Time: ");put(Image(departTime, Time_Zone => -5*60));new_line;
            --put("Start Time: ");put(Image(decision.startTime, Time_Zone => -5*60) );new_line;
            put("-----------------------------------------------------------------------------------");new_line;
            
            
         end if;


         -- do the operations.
  
         --Lab Step 3.
          -- do the operations.
  
         --Lab Step 4.
          -- do the operations, prepare for the vext repair operations.
         if dagobah >= 5 then
            put("Total Time Elpased: ");put(Duration'image(Clock - startTime));put(" Seconds");new_line;
            put("No of Vehicles Repaired: ");put(repairStar + repairTie);put(" Vehicles");new_line;
            --put("No of Vehicles Repaired: ");put(repairStar + repairTie);put(" Vehicles");new_line;
            put("No of Star Destroyers Repaired: ");put(repairStar);new_line;
            put("No of Tie Fighters Repaired: ");put(repairTie);new_line;

            exit;
         end if;
         delay 2.0;
      end loop;  
  
     -- Lab Step 5
      --Five vehicles rejected.
      --Calculate and print results
  end;
end ArrivalForRepair;