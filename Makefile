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

all: EasyTest.cmo EasyTest.cmi

OCAML-INIT = # export OPAMROOT=~/.app/opam; eval "$$(opam config env)";
OCAMLFIND  = $(OCAML-INIT) ocamlfind

%.cmo: %.ml
	$(OCAMLFIND) ocamlc -g -c $< 
%.cmi: %.cmo
	touch $@


clean:
	rm -f *.cmo *.cmi *~
	rm -rf STAGE

prefix      ?= /usr/local
DEST        ?= $(PWD)/STAGE
bindir      ?= $(prefix)/bin
libdir      ?= $(prefix)/lib
sharedir    ?= $(prefix)/share

ocaml-libdir ?= $(libdir)/ocaml
pp4ml-libdir ?= $(sharedir)/pp4ml

install:
	rm -rf STAGE
	install -d $(DEST)$(bindir) $(DEST)$(ocaml-libdir) $(DEST)$(pp4ml-libdir)
	install *.cmo *.cmi $(DEST)$(ocaml-libdir)
	install *.m4  $(DEST)$(pp4ml-libdir)
	install pp4ml $(DEST)$(bindir)


SCRIPTS-DIR = $(CURDIR)
APP-NAME    = $(notdir $(CURDIR))

$(HOME)/.scripts/$(APP-NAME):
	cd $(@D) ; ln -s $(SCRIPTS-DIR) "$(@F)"

$(HOME)/.scripts/89-$(APP-NAME): $(HOME)/.scripts/$(APP-NAME)
	cd $(@D) ; ln -s "$(<F)" "$(@F)"

labnet-install: $(HOME)/.scripts/89-$(APP-NAME)


