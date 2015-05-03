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


let TEST(foo) = begin

    let five = 5 in
    let doubletwo = 2*2 in
    
    Expect( Int.( five = doubletwo ))
end;;

let TEST(bar) = begin

    let four = 4 in
    let doubletwo = 2*2 in
    
    Expect( Int.( four = doubletwo ))
end;;

  
