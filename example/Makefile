# pp4ml - a m4 based preprocessor for ocaml      -*- mode: makefile-gmake -*-
# Copyright (C) 2013 -- M E Leypold
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# 


OCAML-INIT = # export OPAMROOT=~/.app/opam; eval "$$(opam config env)";
OCAMLFIND  = $(OCAML-INIT) ocamlfind
export PATH := $(PWD)/..:$(PATH)

all: p3 p2
	OCAMLRUNPARAM=b ./$<

p%: p%.ml
	$(OCAMLFIND) ocamlc -I .. -pp 'pp4ml' -g EasyTest.cmo -o $@ $<

clean:
	rm -f p? *.cmo *.cmi
