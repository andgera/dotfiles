/*
 * utime.c - display system uptime
 * Copyright (C) 2022 Andrey G-w <andgera@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 */

#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <fcntl.h>
#include <unistd.h>

#define BAD_OPEN_MESSAGE					\
"Error: /proc must be mounted\n"				\
"  To mount /proc at boot you need an /etc/fstab line like:\n"	\
"      proc   /proc   proc    defaults\n"			\
"  In the meantime, run \"mount proc /proc -t proc\"\n"

#define UPTIME_FILE  "/proc/uptime"
static int uptime_fd = -1;

#define FILE_TO_BUF(filename, fd) do{				\
    static int local_n;						\
    if (fd == -1 && (fd = open(filename, O_RDONLY)) == -1) {	\
	fputs(BAD_OPEN_MESSAGE, stderr);			\
	fflush(NULL);						\
	_exit(102);						\
    }								\
    lseek(fd, 0L, SEEK_SET);					\
    if ((local_n = read(fd, buf, sizeof buf - 1)) < 0) {	\
	perror(filename);					\
	fflush(NULL);						\
	_exit(103);						\
    }								\
    buf[local_n] = '\0';					\
}while(0)

int main (int argc, char *argv[]) {

	static char buf[256];
	double up, idle;
	int days, hours, mins;
	int opt;

	FILE_TO_BUF(UPTIME_FILE,uptime_fd);
	if (sscanf(buf, "%lf %lf", &up, &idle) < 2) {
	fputs("bad data in " UPTIME_FILE "\n", stderr);
	return 0;
	}

	days = up / 86400;
	hours = (up / 3600) - (days * 24);
	mins = (up / 60) - (days * 1440) - (hours * 60);

	if (argc == 1) {
		printf("%d days, %02d:%02d:%02d idle: %d\n",
			days, hours, mins, (int)up % 60, (int)(idle / 3600));
	return EXIT_SUCCESS;
	}

	while ((opt = getopt(argc, argv, "ch")) != -1) {
		switch (opt) {
		case 'c':
			printf("\033[0;33m%d days, \033[0;36m%02d:%02d:%02d \033[0;32midle: %d \033[0;m \n",
					days, hours, mins, (int)up % 60, (int)(idle / 3600));
			return EXIT_SUCCESS;
		case 'h':
			puts("This program shows the uptime of the system based on data from the file /proc/uptime");
			return EXIT_SUCCESS;
		default:
			printf("Usage: %s options:\n\t\t -c (Color)\n\t\t -h (Info messages)\n", argv[0]);
			exit(EXIT_FAILURE);
		}
	}
	if (optind != argc)
		printf("%d days, %02d:%02d:%02d idle: %d\n",
			days, hours, mins, (int)up % 60, (int)(idle / 3600));

return EXIT_SUCCESS;
}
