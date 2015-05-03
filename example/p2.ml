(* * pp4ml - a m4 based preprocessor for ocaml                    -*- mode: tuareg -*-
     Copyright (C) 2013 -- M E Leypold

     This program is free software: you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation, either version 3 of the License, or
     (at your option) any later version.

     This program is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.

     You should have received a copy of the GNU General Public License
     along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *)


let TEST(scanner) =
  begin
    let x = 5 in Expect( Int.(x == (2+3)) );
    raise Not_found	  
  end;;
  
let TEST(parser) = begin
    Expect( Int.(7 == (2+4)) );
  end;;

exception Foo
  
let TEST(parser2) = begin
    Expect( Int.(7 == (3+4)) );    
    Expect_raises( raise Not_found, Not_found );    
  end;;


