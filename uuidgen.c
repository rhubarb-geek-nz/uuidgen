/**************************************************************************
 *
 *  Copyright 2021, Roger Brown
 *
 *  This file is part of rhubarb-geek-nz/uuidgen.
 *
 *  This program is free software: you can redistribute it and/or modify it
 *  under the terms of the GNU General Public License as published by the
 *  Free Software Foundation, either version 3 of the License, or (at your
 *  option) any later version.
 * 
 *  This program is distributed in the hope that it will be useful, but WITHOUT
 *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 *  more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>
 *
 */

#include <stdio.h>
#include <uuid.h>

int main(int argc,char **argv)
{
	uuid_t guid;
	uint32_t status=1;
	char *str=NULL;

	if (argc>1) return 1;

	uuid_create(&guid,&status);

	if (status) return 2;

	uuid_to_string(&guid,&str,&status);

	if (status) return 3;

	if (!str) return 4;

	if (printf("%s\n",str)<0) return 5;

	return 0;
}
