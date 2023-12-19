with Ada.Text_IO; use Ada.Text_IO;

procedure Day1 is
begin

	procedure Part1 is
		subtype Digit is Integer range 0..9;
		F : File_Type;
		Line : String(1..100);
		Last_Position : Natural;
		Found_First_Digit : Boolean;
		First_Digit : Digit;
		Last_Digit: Digit;
		Sum : Integer;
	begin
	   Sum := 0;
	   Open(F, In_File, "day1-input.txt");
	   while not End_Of_File(F) loop
	      Get_Line(F, Line, Last_Position);
	      
	      First_Digit := 0;
	      Last_Digit := 0;
	      Found_First_Digit := False;
	      for C of Line(1..Last_Position) loop
		      if C in '0'..'9' then
			      if not Found_First_Digit then
				      First_Digit := Character'Pos(C) - Character'Pos('0');
				      Found_First_Digit := True;
			      end if;
			      Last_Digit := Character'Pos(C) - Character'Pos('0');
		      end if;
	      end loop;
	      Sum := Sum + (First_Digit * 10) + Last_Digit;
	   end loop;
	   Put_Line(Sum'Img);
	   Close(F);
	end Part1;
end Day1;
