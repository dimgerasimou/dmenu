# dmenu - dynamic menu
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw dmenu util stest dmenu_appmenu
OBJ = $(addsuffix .o,  $(addprefix obj/, $(SRC)))

all: dmenu stest dmenu_appmenu

options:
	@echo dmenu build options:
	@echo "CFLAGS   = $(CFLAGS)"
	@echo "LDFLAGS  = $(LDFLAGS)"
	@echo "CC       = $(CC)"

$(OBJ): arg.h config.h config.mk drw.h
	mkdir -p obj
	$(CC) -o $@ -c $(CFLAGS) $(basename $(notdir $@)).c

dmenu: obj/dmenu.o obj/drw.o obj/util.o
	mkdir -p bin
	$(CC) -o bin/$@ obj/dmenu.o obj/drw.o obj/util.o $(LDFLAGS)

stest: obj/stest.o
	$(CC) -o bin/$@ obj/stest.o $(LDFLAGS)

dmenu_appmenu: obj/dmenu_appmenu.o
	$(CC) -o bin/$@ obj/dmenu_appmenu.o

clean:
	rm -f dmenu-$(VERSION).tar.gz
	rm -rf bin/ obj/

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f bin/dmenu bin/stest bin/dmenu_appmenu dmenu_path dmenu_run $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenu
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenu_path
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenu_run
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenu_appmenu
	chmod 755 $(DESTDIR)$(PREFIX)/bin/stest
	mkdir -p  $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < dmenu.1 > $(DESTDIR)$(MANPREFIX)/man1/dmenu.1
	sed "s/VERSION/$(VERSION)/g" < stest.1 > $(DESTDIR)$(MANPREFIX)/man1/stest.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/dmenu.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/stest.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dmenu\
		$(DESTDIR)$(PREFIX)/bin/dmenu_path\
		$(DESTDIR)$(PREFIX)/bin/dmenu_run\
		$(DESTDIR)$(PREFIX)/bin/dmenu_appmenu\
		$(DESTDIR)$(PREFIX)/bin/stest\
		$(DESTDIR)$(MANPREFIX)/man1/dmenu.1\
		$(DESTDIR)$(MANPREFIX)/man1/stest.1

.PHONY: all options clean install uninstall
