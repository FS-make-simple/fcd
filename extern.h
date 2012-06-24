#ifndef _EXTERN_H_
#define _EXTERN_H_

#include <sys/dirent.h>
#include <sys/param.h>

#define MAX_HITS 256
#define MAX_CHOICESIZE (MAXPATHLEN + MAXNAMLEN)

struct diritem {
	char	path[MAXPATHLEN];
	char	dname[MAXNAMLEN];
};

long int	directories_added;
long int	directories_total;

int dflag;	/* Maximum difference between words for spellcheck */

#endif
