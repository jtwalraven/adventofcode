with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Indefinite_Hashed_Maps;

procedure Day1 is
   subtype Digit is Natural range 0..9;

   procedure Part1 is
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
      Put_Line("Part 1: " & Sum'Img);
      Close(F);
   end Part1;

   procedure Part2 is
      F : File_Type;
      Line : String(1..100);
      Last_Position : Natural;
      Found_First_Digit : Boolean;
      First_Digit : Digit;
      Last_Digit : Digit;
      Word : String := "";
      Sum : Integer;

      type OptionalDigit is record
         HasValue : Boolean := False;
         Value : Digit;
      end record;

      type WordDigit is (Zero, One, Two, Three, Four, Five, Six, Seven, Eight, Nine);

      function WordToDigit(Word : in String) return OptionalDigit is
      begin
         return (
                 HasValue => True,
                 Value => (
                           case WordDigit'Value(Word) is
                              when Zero => 0,
                              when One => 1,
                              when Two => 2,
                              when Three => 3,
                              when Four => 4,
                              when Five => 5,
                              when Six => 6,
                              when Seven => 7,
                              when Eight => 8,
                              when Nine => 9
                          )
                );
      exception
         when Constraint_Error =>
            return (HasValue => False, Value => 0);

      end WordToDigit;

      procedure HandleDigit(I : in Natural) is
      begin
         if not Found_First_Digit then
            First_Digit := Character'Pos(Line(I)) - Character'Pos('0');
            Found_First_Digit := True;
         end if;
         Last_Digit := Character'Pos(Line(I)) - Character'Pos('0');
      end HandleDigit;

      procedure HandleWord(I : in Natural) is
         Converted_Digit: OptionalDigit;
         MinWordDigit : constant := 3;
         MaxWordDigit : constant := 5;
      begin
         for J in (I + 3)..Integer'Min((I + 5), Last_Position) loop
            Converted_Digit := WordToDigit(Line(i..j));
            if Converted_Digit.HasValue then
               Last_Digit := Converted_Digit.Value;
               if not Found_First_Digit then
                  First_Digit := Last_Digit;
                  Found_First_Digit := True;
               end if;
            end if;
         end loop;
      end HandleWord;

   begin
      Sum := 0;
      Open(F, In_File, "day1-input.txt");
      while not End_Of_File(F) loop
         Get_Line(F, Line, Last_Position);

         First_Digit := 0;
         Last_Digit := 0;
         Found_First_Digit := False;
         for I in Line'First..Last_Position loop
            if Line(I) in '0'..'9' then
               HandleDigit(I);
            else
               HandleWord(I);
            end if;
         end loop;
         Sum := Sum + (First_Digit * 10) + Last_Digit;
      end loop;
      Put_Line("Part 2: " & Sum'Img);
      Close(F);
   end Part2;

begin
   Part1;
   Part2;
end Day1;
