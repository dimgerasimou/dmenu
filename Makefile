# dmenu - dynamic menu
# See LICENSE file for copyright and license details.

include src/config.mk

SRC = drw dmenu util stest
OBJ = $(addsuffix .o,  $(addprefix obj/, $(SRC)))

all: dmenu stest

options:
	@echo dmenu build options:
	@echo "CFLAGS   = $(CFLAGS)"
	@echo "LDFLAGS  = $(LDFLAGS)"
	@echo "CC       = $(CC)"

$(OBJ): src/arg.h src/config.h src/config.mk src/drw.h
	mkdir -p obj
	$(CC) -o $@ -c $(CFLAGS) src/$(basename $(notdir $@)).c

dmenu: obj/dmenu.o obj/drw.o obj/util.o
	mkdir -p bin
	$(CC) -o bin/$@ obj/dmenu.o obj/drw.o obj/util.o $(LDFLAGS)

stest: obj/stest.o
	$(CC) -o bin/$@ obj/stest.o $(LDFLAGS)

clean:
	rm -f dmenu-$(VERSION).tar.gz
	rm -rf bin/ obj/

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f bin/dmenu src/dmenu_path src/dmenu_run bin/stest $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenu
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenu_path
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenu_run
	chmod 755 $(DESTDIR)$(PREFIX)/bin/stest
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < src/dmenu.1 > $(DESTDIR)$(MANPREFIX)/man1/dmenu.1
	sed "s/VERSION/$(VERSION)/g" < src/stest.1 > $(DESTDIR)$(MANPREFIX)/man1/stest.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/dmenu.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/stest.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dmenu\
		$(DESTDIR)$(PREFIX)/bin/dmenu_path\
		$(DESTDIR)$(PREFIX)/bin/dmenu_run\
		$(DESTDIR)$(PREFIX)/bin/stest\
		$(DESTDIR)$(MANPREFIX)/man1/dmenu.1\
		$(DESTDIR)$(MANPREFIX)/man1/stest.1

.PHONY: all options clean install uninstall
