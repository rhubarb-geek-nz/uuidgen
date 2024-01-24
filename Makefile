#
#  Copyright 2021, Roger Brown
#
#  This file is part of rhubarb-geek-nz/uuidgen.
#
#  This program is free software: you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by the
#  Free Software Foundation, either version 3 of the License, or (at your
#  option) any later version.
# 
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>
#

all: uuidgen

clean:
	rm -rf uuidgen meta root uuidgen-1.0.*.tgz uuidgen-src-1.0.*.tgz 

uuidgen: uuidgen.c
	$(CC) $(CFLAGS) uuidgen.c -o $@

install: uuidgen uuidgen.1
	mkdir -p $(DESTDIR)/bin $(DESTDIR)/man/man1
	install -o 0 -g 0 -m 0755 uuidgen $(DESTDIR)/bin/uuidgen
	install -o 0 -g 0 -m 0644 uuidgen.1 $(DESTDIR)/man/man1/uuidgen.1

uninstall:
	rm -rf $(DESTDIR)/bin/uuidgen $(DESTDIR)/man/man1/uuidgen.1

dist: uuidgen uuidgen.1
	rm -rf root meta
	mkdir -p root/usr/local/bin root/usr/local/man/man1 meta
	cp uuidgen root/usr/local/bin
	cp uuidgen.1 root/usr/local/man/man1
	find root | xargs ls -ld
	echo @bin usr/local/bin/uuidgen > meta/CONTENTS
	echo @man usr/local/man/man1/uuidgen.1 >> meta/CONTENTS
	echo Simple UUID generator > meta/DESC
	pkg_create -A $$(uname -p) -d meta/DESC -D "COMMENT=UUID generator" -D MAINTAINER=rhubarb-geek-nz@users.sourceforge.net -D FULLPKGPATH=misc/uuidgen -D FTP=yes -f meta/CONTENTS -B $$(pwd)/root -p / uuidgen-1.0.$$(echo $$(git log --oneline uuidgen.c | wc -l)).tgz
	rm -rf root meta

srctar:
	tar cvfz uuidgen-src-1.0.$$(echo $$(git log --oneline uuidgen.c | wc -l)).tgz Makefile *.c *.1
