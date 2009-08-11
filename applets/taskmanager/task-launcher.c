/*
 * Copyright (C) 2008 Neil Jagdish Patel <njpatel@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as 
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Authored by Neil Jagdish Patel <njpatel@gmail.com>
 *             Hannes Verschore <hv1989@gmail.com>
 *             Rodney Cryderman <rcryderman@gmail.com>
 */

#include <stdio.h>
#include <string.h>

#include <gtk/gtk.h>
#include <gdk/gdkx.h>

#include <libwnck/libwnck.h>
#include <glib/gi18n.h>

#include <libdesktop-agnostic/fdo.h>
#undef G_DISABLE_SINGLE_INCLUDES
#include <glibtop/procargs.h>
#include <glibtop/procuid.h>

#include <libawn/libawn.h>

#include "task-launcher.h"
#include "task-window.h"

#include "task-settings.h"
#include "xutils.h"
#include "util.h"

G_DEFINE_TYPE (TaskLauncher, task_launcher, TASK_TYPE_ITEM)

#define TASK_LAUNCHER_GET_PRIVATE(obj) (G_TYPE_INSTANCE_GET_PRIVATE ((obj),\
  TASK_TYPE_LAUNCHER, \
  TaskLauncherPrivate))

struct _TaskLauncherPrivate
{
  gchar *path;
  DesktopAgnosticFDODesktopEntry *entry;

  const gchar *name;
  const gchar *exec;
  const gchar *icon_name;
  GPid   pid;
  glong timestamp;
  
  GtkWidget     *menu;
  
  gchar         *special_id;    /*AKA OpenOffice ***** */
};

enum
{
  PROP_0,
  PROP_DESKTOP_FILE
};

//#define DEBUG 1

/* Forwards */
static const gchar * _get_name        (TaskItem       *item);
static GdkPixbuf   * _get_icon        (TaskItem       *item);
static gboolean      _is_visible      (TaskItem       *item);
static void          _left_click      (TaskItem       *item,
                                       GdkEventButton *event);
static GtkWidget *   _right_click     (TaskItem       *item,
                                       GdkEventButton *event);
static void          _middle_click     (TaskItem       *item,
                                       GdkEventButton *event);
static guint         _match           (TaskItem       *item,
                                       TaskItem       *item_to_match);
static void         _name_change      (TaskItem *item, 
                                       const gchar *name);

static void   task_launcher_set_desktop_file (TaskLauncher *launcher,
                                              const gchar  *path);

/* GObject stuff */
static void
task_launcher_get_property (GObject    *object,
                            guint       prop_id,
                            GValue     *value,
                            GParamSpec *pspec)
{
  TaskLauncher *launcher = TASK_LAUNCHER (object);

  switch (prop_id)
  {
    case PROP_DESKTOP_FILE:
      g_value_set_string (value, launcher->priv->path); 
      break;
    
    default:
      G_OBJECT_WARN_INVALID_PROPERTY_ID (object, prop_id, pspec);
  }
}

static void
task_launcher_set_property (GObject      *object,
                          guint         prop_id,
                          const GValue *value,
                          GParamSpec   *pspec)
{
  TaskLauncher *launcher = TASK_LAUNCHER (object);

  switch (prop_id)
  {
    case PROP_DESKTOP_FILE:
      task_launcher_set_desktop_file (launcher, g_value_get_string (value));
      break;

    default:
      G_OBJECT_WARN_INVALID_PROPERTY_ID (object, prop_id, pspec);
  }
}

static void
task_launcher_dispose (GObject *object)
{ 
  G_OBJECT_CLASS (task_launcher_parent_class)->dispose (object);
}

static void
task_launcher_finalize (GObject *object)
{ 
  TaskLauncher *launcher = TASK_LAUNCHER (object);

  g_free (launcher->priv->special_id);
  
  G_OBJECT_CLASS (task_launcher_parent_class)->finalize (object);
}

static void
task_launcher_class_init (TaskLauncherClass *klass)
{
  GParamSpec   *pspec;
  GObjectClass  *obj_class = G_OBJECT_CLASS (klass);
  TaskItemClass *item_class = TASK_ITEM_CLASS (klass);

  obj_class->set_property = task_launcher_set_property;
  obj_class->get_property = task_launcher_get_property;
  obj_class->finalize = task_launcher_finalize;
  obj_class->dispose = task_launcher_dispose;

  /* We implement the necessary funtions for a normal window */
  item_class->get_name         = _get_name;
  item_class->get_icon         = _get_icon;
  item_class->is_visible       = _is_visible;
  item_class->match            = _match;
  item_class->left_click       = _left_click;
  item_class->right_click      = _right_click;
  item_class->middle_click      = _middle_click; 
  item_class->name_change       = _name_change;

  /* Install properties */
  pspec = g_param_spec_string ("desktopfile",
                               "DesktopFile",
                               "Desktop File Path",
                               NULL,
                               G_PARAM_READWRITE);
  g_object_class_install_property (obj_class, PROP_DESKTOP_FILE, pspec);

  g_type_class_add_private (obj_class, sizeof (TaskLauncherPrivate));
}

static void
task_launcher_init (TaskLauncher *launcher)
{
  TaskLauncherPrivate *priv;
  	
  priv = launcher->priv = TASK_LAUNCHER_GET_PRIVATE (launcher);
  
  priv->path = NULL;
  priv->entry = NULL;
}

TaskItem * 
task_launcher_new_for_desktop_file (const gchar *path)
{
  TaskItem *item = NULL;

  if (!g_file_test (path, G_FILE_TEST_EXISTS))
    return NULL;

  item = g_object_new (TASK_TYPE_LAUNCHER,
                       "desktopfile", path,
                       NULL);

  return item;
}

const gchar   * 
task_launcher_get_desktop_path     (TaskLauncher *launcher)
{
  g_return_val_if_fail (TASK_IS_LAUNCHER (launcher), NULL);

  return launcher->priv->path;
}

static void
task_launcher_set_desktop_file (TaskLauncher *launcher, const gchar *path)
{
  TaskLauncherPrivate *priv;
  DesktopAgnosticVFSFile *file;
  GError *error = NULL;
  GdkPixbuf *pixbuf;
  gchar * exec_key;
  gchar * needle;
  
  g_return_if_fail (TASK_IS_LAUNCHER (launcher));
  priv = launcher->priv;

  priv->path = g_strdup (path);

  file = desktop_agnostic_vfs_file_new_for_path (path, &error);

  if (error)
  {
    g_critical ("Error when trying to load the launcher: %s", error->message);
    g_error_free (error);
    return;
  }

  if (file == NULL || !desktop_agnostic_vfs_file_exists (file))
  {
    g_critical ("File not found: '%s'", path);
    return;
  }

  priv->entry = desktop_agnostic_fdo_desktop_entry_new_for_file (file, &error);

  if (error)
  {
    g_critical ("Error when trying to load the launcher: %s", error->message);
    g_error_free (error);
    return;
  }

  if (priv->entry == NULL)
  {
    return;
  }

  priv->special_id = get_special_id_from_desktop(priv->entry);
  priv->name = desktop_agnostic_fdo_desktop_entry_get_name (priv->entry);

  exec_key = g_strstrip (desktop_agnostic_fdo_desktop_entry_get_string (priv->entry, "Exec"));
  
  /*do we have have any % chars? if so... then find the first one , 
   and truncate
   
   There is an open question if we should remove any of other command line 
   args... for now leaving things alone as long as their is no %
   */
  needle = strchr (exec_key,'%');
  if (needle)
  {
          *needle = '\0';
          g_strstrip (exec_key);
  }
  g_strstrip (exec_key);
  priv->exec = exec_key;
  
  priv->icon_name = desktop_agnostic_fdo_desktop_entry_get_icon (priv->entry);

  task_item_emit_name_changed (TASK_ITEM (launcher), priv->name);
  pixbuf = _get_icon (TASK_ITEM (launcher));
  task_item_emit_icon_changed (TASK_ITEM (launcher), pixbuf);
  g_object_unref (pixbuf);
  task_item_emit_visible_changed (TASK_ITEM (launcher), TRUE);
#ifdef DEBUG
  g_debug ("LAUNCHER: %s", priv->name);
#endif
}

/*
 * Implemented functions for a standard window without a launcher
 */
static const gchar * 
_get_name (TaskItem *item)
{
  return TASK_LAUNCHER (item)->priv->name;
}

static GdkPixbuf * 
_get_icon (TaskItem *item)
{
  TaskLauncherPrivate *priv = TASK_LAUNCHER (item)->priv;
  TaskSettings *s = task_settings_get_default ();
  GError *error = NULL;
  GdkPixbuf *pixbuf = NULL;

  if (g_path_is_absolute (priv->icon_name))
  {
    pixbuf = gdk_pixbuf_new_from_file_at_scale (priv->icon_name,
                                                s->panel_size, s->panel_size,
                                                TRUE, &error);
  }
  else
  {
    GtkIconTheme *icon_theme = gtk_icon_theme_get_default ();

    pixbuf = gtk_icon_theme_load_icon (icon_theme, priv->icon_name,
                                       s->panel_size, 0, &error);
  }
  if (error)
  {
    g_warning ("The launcher '%s' could not load the icon '%s': %s",
               priv->path, priv->icon_name, error->message);
    g_error_free (error);
    return NULL;
  }
  return pixbuf;
}

static gboolean
_is_visible (TaskItem *item)
{
  return TRUE;
}

/**
 * Match the launcher with the provided window. 
 * The higher the number it returns the more it matches the window.
 * 100 = definitly matches
 * 0 = doesn't match
 */

/*
FIXME,  ugly.
*/
static guint   
_match (TaskItem *item,
        TaskItem *item_to_match)
{
  TaskLauncherPrivate *priv;
  TaskLauncher *launcher;
  TaskWindow   *window;
  gchar   *res_name = NULL;
  gchar   *class_name = NULL;
  gchar   *res_name_lower = NULL;
  gchar   *class_name_lower = NULL;  
  gint     pid;
  glibtop_proc_args buf;
  gchar   *cmd = NULL;
  gchar   *full_cmd = NULL;
  gchar   *search_result= NULL;
  glibtop_proc_uid buf_proc_uid;
  glibtop_proc_uid ppid_buf_proc_uid;  
  glong   timestamp;
  GTimeVal timeval;
  gchar * id = NULL;
  gint    result = 0;
    
  g_return_val_if_fail (TASK_IS_LAUNCHER(item), 0);

  if (!TASK_IS_WINDOW (item_to_match)) 
  {
    return 0;
  }

  launcher = TASK_LAUNCHER (item);
  priv = launcher->priv;
  timestamp = priv->timestamp;
  priv->timestamp = 0;
  window = TASK_WINDOW (item_to_match);

  pid = task_window_get_pid(window);
  glibtop_get_proc_uid (&buf_proc_uid,pid);
  glibtop_get_proc_uid (&ppid_buf_proc_uid,buf_proc_uid.ppid);  
  g_get_current_time (&timeval);
  cmd = glibtop_get_proc_args (&buf,pid,1024);
  full_cmd = get_full_cmd_from_pid (pid);
  
  task_window_get_wm_class(window, &res_name, &class_name);  
  if (res_name)
  {
    res_name_lower = g_utf8_strdown (res_name, -1);
  }
  if (class_name)
  {
    class_name_lower = g_utf8_strdown (class_name, -1);
  }
#ifdef DEBUG
  g_debug ("res name lower = %s", res_name_lower);
  g_debug ("class name lower = %s",class_name_lower);
  g_debug ("cmd = %s",cmd);
  g_debug ("fullcmd = %s",full_cmd);
  g_debug ("exec = %s",priv->exec);
#endif
  id = get_special_id_from_window_data (full_cmd, res_name,class_name,task_window_get_name (window));

  
  /* 
   the open office clause follows 
   If either the launcher or the window is special cased then that is the 
   only comparision that will be done.  It's either a match or not on that 
   basis.
   */
  
  if (priv->special_id && id)
  {
    if (g_strcmp0 (priv->special_id,id) == 0)
    {
      result = 100;
      goto  finished;
    }
  }
  
  if (priv->special_id || id)
  {
    goto finished;  /* result is initialized to 0*/
  }
  
  /*
   Did the pid last launched from the launcher match the pid of the window?
   Note that if each launch starts a new process then those will get matched up
   in the TaskIcon match functions for older windows
   */
#ifdef DEBUG
  g_debug ("window pid = %d, launch pid = %d",pid,priv->pid);
#endif  
  if ( pid && (priv->pid == pid))
  {
    result = 95;
    goto finished;
  } 
  
  /*
   Check the parent PID also
   */
#ifdef DEBUG
  g_debug ("ppid of window pid = %d, launch pid = %d",buf_proc_uid.ppid,priv->pid);
#endif    
  if (pid && buf_proc_uid.ppid)
  {
    if ( buf_proc_uid.ppid == priv->pid)
    {
      result = 92;
      goto finished;
    }
  }
#ifdef DEBUG
  g_debug ("ppid of parent pid = %d, launch pid = %d",ppid_buf_proc_uid.ppid,priv->pid);
#endif    
  if (pid && buf_proc_uid.ppid && ppid_buf_proc_uid.ppid)
  {
    if ( ppid_buf_proc_uid.ppid == priv->pid)
    {
      result = 91;
      goto finished;
    }
  }

  /*
   Does the command line of the process match exec exactly? 
   Not likely but damn likely to be the correct match if it does
   Note that this will only match a case where there are _no_ arguments.
   full_cmd contains the arg list.
   */
  if (cmd)
  {
    if (g_strcmp0 (cmd, priv->exec)==0)
    {
      result = 90;
      goto finished;
    }
  }
  
  /* 
   Now try resource name, which should (hopefully) be 99% of the cases.
   See if the resouce name is the exec and check if the exec is in the resource
   name.
   */

  if (res_name_lower)
  {
    if ( strlen(res_name_lower) && priv->exec)
    {
      if ( g_strstr_len (priv->exec, strlen (priv->exec), res_name_lower) ||
           g_strstr_len (res_name_lower, strlen (res_name_lower), priv->exec))
      {
        result = 70;
        goto finished;
      }
    }
  }

  /* 
   Try a class_name to exec line match. Same theory as res_name
   */
  if (class_name_lower)
  {
    if (strlen(class_name_lower) && priv->exec)
    {
      if (g_strstr_len (priv->exec, strlen (priv->exec), class_name_lower))
      {
        result = 50;
        goto finished;
      }
    }
  }

  /*
   Is does priv->exec match the end of cmd?
   */
  if (cmd)
  {
    search_result = g_strrstr (cmd, priv->exec);
    if (search_result && 
        ((search_result + strlen(priv->exec)) == (cmd + strlen(cmd))))
    {
      result = 20;
      goto finished;
    }
  }

  /*
   Dubious... thus the rating of 1.
   Let's see how it works in practice
   This may work well enough with some additional fuzzy heuristics.
   */
  if ( timestamp)
  {
    /* was this launcher used in the last 10 seconds?*/
    if (timeval.tv_sec - timestamp < 10)
    {
      /* is the launcher pid set?*/
      if (priv->pid)
      {
        gchar *name = desktop_agnostic_fdo_desktop_entry_get_name (priv->entry);
        GStrv tokens = g_strsplit (name, " ",-1);
        if (tokens && tokens[0] && (strlen (tokens[0])>5) )
        {
          gchar * lower = g_utf8_strdown (tokens[0],-1);          
          if ( g_strstr_len (res_name_lower, -1, lower) )
          {
            g_free (lower);              
            g_strfreev (tokens);
            g_free (name);
            result = 1;
            goto finished;
          }
          g_free (lower);          
        }
        g_strfreev (tokens);
        g_free (name);
      }
    }
  }

finished:
  
  g_free (res_name);
  g_free (class_name);
  g_free (res_name_lower);
  g_free (class_name_lower);
  g_free (cmd);
  g_free (full_cmd);
  g_free (id);
  return result;
}

static void
_left_click (TaskItem *item, GdkEventButton *event)
{
  TaskLauncherPrivate *priv;
  TaskLauncher *launcher;
  GError *error = NULL;
  GTimeVal timeval;
  
  g_return_if_fail (TASK_IS_LAUNCHER (item));
  
  launcher = TASK_LAUNCHER (item);
  priv = launcher->priv;

  priv->pid = 
    desktop_agnostic_fdo_desktop_entry_launch (priv->entry,
                                               0, NULL, &error);
  g_get_current_time (&timeval);
  priv->timestamp = timeval.tv_sec;

#ifdef DEBUG  
  g_debug ("%s: current time = %ld",__func__,timeval.tv_sec);  
  g_debug ("%s: launch pid = %d",__func__,priv->pid);
#endif
  if (error)
  {
    g_warning ("Unable to launch %s: %s", 
               task_item_get_name (item),
               error->message);
    g_error_free (error);
  }
}

static GtkWidget *
_right_click (TaskItem *item, GdkEventButton *event)
{
  TaskLauncherPrivate *priv;
  TaskLauncher *launcher;
  GtkWidget *menu_item;
  
  g_return_val_if_fail (TASK_IS_LAUNCHER (item),NULL);
  
  launcher = TASK_LAUNCHER (item);
  priv = launcher->priv;

  if (!priv->menu)
  {
    priv->menu = gtk_menu_new ();

    menu_item = gtk_separator_menu_item_new();
    gtk_widget_show_all(menu_item);
    gtk_menu_shell_prepend(GTK_MENU_SHELL(priv->menu), menu_item);

    menu_item = awn_applet_create_pref_item();
    gtk_menu_shell_prepend(GTK_MENU_SHELL(priv->menu), menu_item);

    menu_item = gtk_separator_menu_item_new();
    gtk_widget_show(menu_item);
    gtk_menu_shell_append(GTK_MENU_SHELL(priv->menu), menu_item);
    
    menu_item = gtk_image_menu_item_new_from_stock (GTK_STOCK_EXECUTE, NULL);
    gtk_menu_shell_append (GTK_MENU_SHELL (priv->menu), menu_item);
    gtk_widget_show (menu_item);
        
  }
  gtk_menu_popup (GTK_MENU (priv->menu), NULL, NULL, 
                  NULL, NULL, event->button, event->time);
  return priv->menu;
}

static void 
_middle_click (TaskItem *item, GdkEventButton *event)
{
  TaskLauncherPrivate *priv;
  TaskLauncher *launcher;
  GError *error = NULL;
  
  g_return_if_fail (TASK_IS_LAUNCHER (item));
  
  launcher = TASK_LAUNCHER (item);
  priv = launcher->priv;

  priv->pid = desktop_agnostic_fdo_desktop_entry_launch (priv->entry, 0,
                                                         NULL, &error);

  if (error)
  {
    g_warning ("Unable to launch %s: %s", priv->name, error->message);
    g_error_free (error);
  }
}


/*
 * Public functions
 */

void 
task_launcher_launch_with_data (TaskLauncher *launcher,
                                GSList       *list)
{
  GError *error = NULL;
  
  g_return_if_fail (TASK_IS_LAUNCHER (launcher));

  launcher->priv->pid =
    desktop_agnostic_fdo_desktop_entry_launch (launcher->priv->entry,
                                               0, list, &error);

  if (error)
  {
    g_warning ("Unable to launch %s: %s", 
               launcher->priv->name,
               error->message);
    g_error_free (error);
  }
}

static void 
_name_change (TaskItem *item, const gchar *name)
{
  g_return_if_fail (TASK_IS_LAUNCHER (item));
  gchar * tmp;

  tmp = g_strdup_printf (_("Launch %s"),name);
  TASK_ITEM_CLASS (task_launcher_parent_class)->name_change (item, tmp);  
  g_free (tmp);
}
