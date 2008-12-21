/*
 *  Copyright (C) 2007 Neil Jagdish Patel <njpatel@gmail.com>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA.
 *
 *  Author : Neil Jagdish Patel <njpatel@gmail.com>
 *
 *  Notes : Contains functions allowing Awn to get a icon from XOrg using the
 *          xid. Please note that all icon reading code  has been lifted from
 *	    libwnck (XUtils.c), so track bugfixes in libwnck.
*/

#include "config.h"
#include "awn-x.h"
#include "xutils.h"

#include <X11/Xlib.h>
#include <X11/Xatom.h>
#include <gdk/gdk.h>
#include <gdk/gdkx.h>
#include <string.h>


static int num = 0;
void
awn_x_set_strut (GtkWindow * window)
{
  int x = 0;
  int y = 0;
  int width = 0;
  int height = 0;

  if (!num)
    g_print ("%s needs to be updated for orientation support", G_STRLOC);
  num++;
  return;

  gtk_window_get_size (window, &width, &height);
  gtk_window_get_position (window, &x, &y);

  xutils_set_strut ((GTK_WIDGET (window)->window),
		    (height) / 2, x, x + width);
  num++;
  if (num == 20)
  {
    num = 0;
  }
}

