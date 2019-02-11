#!/bin/sh

dbpath=~/.cache/fcd
dbname=test.db

tnocomp=""
tcomp="sqlite3"
[ ! "$(command -v $tcomp)" ] && tnocomp="$tnocomp $tcomp"
if [ "x$tnocomp" != "x" ]
then
    echo "!!!Not found:${tnocomp}!!!"
    echo "Install${tnocomp} and repeat."
    echo ""
    exit 1
fi

if [ -f ${dbpath}/${dbname} ]; then
	rm -f ${dbpath}/${dbname}
fi

mkdir -pv ${dbpath}

sqlite3 ${dbpath}/${dbname} "create table homedir(
			id INTEGER PRIMARY KEY,
			path VARCHAR(1024),
			dir VARCHAR(128),
			visits INT,
			bookmark INT,
			UNIQUE(path, dir));" && echo "${dbpath}/${dbname} added"
#sqlite3 test.db "insert into homedir values(NULL, '/home/weezel/', 'ohj', 5, 1);" &&
#sqlite3 test.db "insert into homedir values(NULL, '/home/weezel/', 'snapshots', 2, 0);" &&
#sqlite3 test.db "insert into homedir values(NULL, '/home/weezel/', 'torrent', 1, 0);" &&
#sqlite3 test.db "insert into homedir values(NULL, '/home/weezel/', 'security', 3, 1);"

