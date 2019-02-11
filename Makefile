CC=clang
CFLAGS+= -std=c99 -g -Wall -Wextra -pedantic
CFLAGS+= -Wstrict-prototypes -Wmissing-prototypes
CFLAGS+= -Wmissing-declarations
CFLAGS+= -Wshadow -Wpointer-arith -Wcast-qual
CFLAGS+= -Wsign-compare -fdiagnostics-color
SQLITEFLAGS=-L /usr/local/lib -lsqlite3
CURSESFLAGS=-L/usr/lib -lmenu -lcurses
OS=$(shell uname)

ifeq ($(OS), Linux)
	CFLAGS += -I /usr/local/include/linux
	CURSESFLAGS+=-lbsd
endif

ifeq ($(OS), OpenBSD)
	CFLAGS += -I /usr/local/include
endif

.PHONY: all clean

all: spellcheckers dbutils choosewin controller
	${CC} ${CFLAGS} spellcheckers.o dbutils.o \
		choosewin.o controller.o src/fcd.c -o fcd \
		${CURSESFLAGS} ${SQLITEFLAGS}
dbutils:
	${CC} ${CFLAGS} -c src/dbutils.c -o dbutils.o

controller:
	${CC} ${CFLAGS} -c src/controller.c -o controller.o

choosewin:
	${CC} ${CFLAGS} -c src/choosewin.c -o choosewin.o

dirindexer: dbutils
	${CC} ${CFLAGS} dbutils.o -c src/dirindexer.c -o dirindexer.o

spellcheckers:
	${CC} ${CFLAGS} -c src/spellcheck.c -o spellcheckers.o

tests: dbutils dirindexer
	#${CC} ${CFLAGS} src/dbutils.c src/tests.c -o dbutils_test
	#${CC} ${CFLAGS} ${CURSESFLAGS} ${SQLITEFLAGS} src/controller.c src/dbutils.c src/choosewin.c -o controller_test
	#${CC} ${CFLAGS} ${CURSESFLAGS} src/choosewin.c -o choosewin_test
	${CC} ${CFLAGS} ${SQLITEFLAGS} dbutils.o dirindexer.o src/tests.c \
		-o all_tests

scanbuild:
	scan-build -analyze-headers -o result_html \
		-v -enable-checker debug.DumpCallGraph make

clean:
	rm -rf *.o *.core fcd *_test all_tests

