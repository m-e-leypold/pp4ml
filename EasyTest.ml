(* * pp4ml - a m4 based preprocessor for ocaml                    -*- mode: tuareg -*-
     Copyright (C) 2013 -- M E Leypold

     This program is free software: you can redistribute it and/or
     modify it under the terms of the GNU General Public License as
     published by the Free Software Foundation, either version 3 of
     the License, or (at your option) any later version.

     This program is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
     General Public License for more details.

     You should have received a copy of the GNU General Public License
     along with this program.  If not, see
     <http://www.gnu.org/licenses/>.  
 *)

module Descriptor = struct

    type t = {  name : string;
		mutable procedure : unit -> unit
	     }

    let create name = { name = name; procedure = fun () -> (); }
    let update d p  = { d with procedure = p; }
				   
  end

let create    (l: Descriptor.t list ref) name   = begin l := (Descriptor.create name)::(!l) end
let define    (l: Descriptor.t list ref) p = begin l := (Descriptor.update (List.hd !l) p)::List.tl(!l) end
let (:=) f x = (f x)
  
exception Expectation_failed
	  	    
let expect ~file ~line ~lexeme thunk =
  if  thunk () then ()
  else begin
      print_newline ();
      print_string file;
      print_string ":";
      print_int line;
      print_string ": *** Expectation failed: ";
      print_string lexeme;
      print_string ". ***";
      raise Expectation_failed
    end
    
;;

let run l =
  let rec loop l passed failed =
    match l with
    | hd::tl ->
       let open Descriptor in begin
	   print_string "Testing: " ;		  
	   print_string hd.name;
	   print_string " ... " ;

	   let (passed',failed') =
	     begin 
	       try 
		 hd.procedure ();
		 print_string "OK." ;
		 print_newline ();
		 (hd::passed,failed)
	       with
	       | Expectation_failed -> begin
		   print_newline (); print_string "FAILED: ";print_string hd.name; print_string "."; print_newline (); print_newline ();
		   (passed,hd::failed)
		 end
	       | ex -> print_string " FAILED "; print_string " - unexpected exception: ";
		       print_string (Printexc.to_string ex);
		       print_string ".";
		       print_newline ();
		       Printexc.print_backtrace stdout;
		       print_newline ();				      
		       (passed,hd::failed)
	     end
	   in 
	   loop tl passed' failed'

	 end
    | [] -> (passed,failed)
  in
  print_string "=> ";
  print_int (List.length l);
  print_string " tests to be run.";
  print_newline ();
  print_newline ();
  let (passed, failed) = loop l [] []
  in
  begin
  let report msg l =
    let len = List.length l in
    if len>0 then begin
	print_string msg; print_string ": ";
	let open Descriptor in	
	let rec loop l =
	  match l with
	    hd::[] -> print_string hd.name; print_string " "
	  | []     -> ()
	  | hd::tl -> print_string hd.name; print_string ", "; loop tl
	in
	loop l; print_string "("; print_int (List.length l); print_string " tests)."; print_newline ();
      end
  in
  print_newline ();
  report "PASSED" passed;
  let (n_passed, n_failed) = ((List.length passed),(List.length failed))
  in 
  if (n_failed>0) then
    report "FAILED" failed;  
    let n_total     = n_failed + n_passed in
    let percentage  = n_passed * 100 / n_total in
    begin
      print_string "-------";
      print_newline ();
      print_string "STATS : ";
      print_int n_passed;
      print_string "/";
      print_int n_total;
      print_string " => ";
      print_int percentage;
      print_string " % passed.";
      print_newline ();
    end
  end;
  (failed == [])
;;


module Types = struct
    module Int = struct   
	let equals = (==)
	let print  = print_int		       
	let (==) x y = begin
	    if (equals x y) then true
	    else begin
		print_newline ();
		print_string "=> Comparison failed: not ( ";
		print x; print_string " == "; print y;
		print_string " ).";
		false
	      end
	  end
      end
  end		
;;



