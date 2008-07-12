/* awn.vapi generated by vapigen, do not modify. */

[CCode (cprefix = "Awn", lower_case_cprefix = "awn_")]
namespace Awn {
	[CCode (cprefix = "ROUND_", cheader_filename = "libawn/awn-cairo-utils.h")]
	public enum CairoRoundCorners {
		NONE,
		TOP_LEFT,
		TOP_RIGHT,
		BOTTOM_RIGHT,
		BOTTOM_LEFT,
		TOP,
		BOTTOM,
		LEFT,
		RIGHT,
		ALL
	}
	[CCode (cprefix = "AWN_CONFIG_CLIENT_", cheader_filename = "libawn/awn-config-client.h")]
	public enum ConfigBackend {
		GCONF,
		GKEYFILE
	}
	[CCode (cprefix = "AWN_CONFIG_CLIENT_LIST_TYPE_", cheader_filename = "libawn/awn-config-client.h")]
	public enum ConfigListType {
		BOOL,
		FLOAT,
		INT,
		STRING
	}
	[CCode (cprefix = "AWN_CONFIG_VALUE_TYPE_", cheader_filename = "libawn/awn-config-client.h")]
	public enum ConfigValueType {
		NULL,
		BOOL,
		FLOAT,
		INT,
		STRING,
		LIST_BOOL,
		LIST_FLOAT,
		LIST_INT,
		LIST_STRING
	}
	[CCode (cprefix = "AWN_EFFECT_", cheader_filename = "libawn/awn-effects.h")]
	public enum Effect {
		NONE,
		OPENING,
		LAUNCHING,
		HOVER,
		ATTENTION,
		CLOSING,
		DESATURATE
	}
	[CCode (cprefix = "AWN_EFFECT_PRIORITY_", cheader_filename = "libawn/awn-effects.h")]
	public enum EffectPriority {
		HIGHEST,
		HIGH,
		ABOVE_NORMAL,
		NORMAL,
		BELOW_NORMAL,
		LOW,
		LOWEST
	}
	[CCode (cprefix = "AWN_EFFECT_", cheader_filename = "libawn/awn-effects.h")]
	public enum EffectSequence {
		DIR_NONE,
		DIR_STOP,
		DIR_DOWN,
		DIR_UP,
		DIR_LEFT,
		DIR_RIGHT,
		SQUISH_DOWN,
		SQUISH_DOWN2,
		SQUISH_UP,
		SQUISH_UP2,
		TURN_1,
		TURN_2,
		TURN_3,
		TURN_4,
		SPOTLIGHT_ON,
		SPOTLIGHT_TREMBLE_UP,
		SPOTLIGHT_TREMBLE_DOWN,
		SPOTLIGHT_OFF
	}
	[CCode (cprefix = "AWN_ORIENTATION_", cheader_filename = "libawn/awn-defines.h")]
	public enum Orientation {
		BOTTOM,
		TOP,
		RIGHT,
		LEFT
	}
	[CCode (cprefix = "AWN_VFS_MONITOR_EVENT_", cheader_filename = "libawn/awn-vfs.h")]
	public enum VfsMonitorEvent {
		CHANGED,
		CREATED,
		DELETED
	}
	[CCode (cprefix = "AWN_VFS_MONITOR_", cheader_filename = "libawn/awn-vfs.h")]
	public enum VfsMonitorType {
		FILE,
		DIRECTORY
	}
	[Compact]
	[CCode (cheader_filename = "libawn/awn-cairo-utils.h")]
	public class Color {
		public float red;
		public float green;
		public float blue;
		public float alpha;
	}
	[Compact]
	[CCode (cheader_filename = "libawn/awn-config-client.h")]
	public class ConfigClientNotifyEntry {
		public weak Awn.ConfigClient client;
		public weak string group;
		public weak string key;
		public weak Awn.ConfigClientValue value;
	}
	[Compact]
	[CCode (copy_function = "awn_desktop_item_copy", cheader_filename = "libawn/awn-desktop-item.h")]
	public class DesktopItem {
		public weak Awn.DesktopItem copy ();
		public bool exists ();
		public weak string get_exec ();
		public weak string get_filename ();
		public weak string get_icon (Gtk.IconTheme icon_theme);
		public weak string get_item_type ();
		public weak string get_localestring (string key);
		public weak string get_name ();
		public weak string get_string (string key);
		public int launch (GLib.SList documents) throws GLib.Error;
		public DesktopItem (string filename);
		public void save (string new_filename) throws GLib.Error;
		public void set_exec (string exec);
		public void set_icon (string icon);
		public void set_item_type (string item_type);
		public void set_localestring (string key, string locale, string value);
		public void set_name (string name);
		public void set_string (string key, string value);
	}
	[Compact]
	[CCode (cheader_filename = "libawn/awn-effects.h")]
	public class Effects {
		public weak GLib.Object self;
		public weak Gtk.Widget focus_window;
		public weak Awn.Settings settings;
		public weak Awn.Title title;
		public weak Awn.TitleCallback get_title;
		public weak GLib.List effect_queue;
		public int icon_width;
		public int icon_height;
		public int window_width;
		public int window_height;
		public bool effect_lock;
		public Awn.Effect current_effect;
		public Awn.EffectSequence direction;
		public int count;
		public double x_offset;
		public double y_offset;
		public double curve_offset;
		public int delta_width;
		public int delta_height;
		public Gtk.Allocation clip_region;
		public double rotate_degrees;
		public float alpha;
		public float spotlight_alpha;
		public float saturation;
		public float glow_amount;
		public int icon_depth;
		public int icon_depth_direction;
		public bool hover;
		public bool clip;
		public bool flip;
		public bool spotlight;
		public uint enter_notify;
		public uint leave_notify;
		public uint timer_id;
		public weak Cairo.Context icon_ctx;
		public weak Cairo.Context reflect_ctx;
		public weak Awn.EffectsOp op_list;
		public void* pad1;
		public void* pad2;
		public void* pad3;
		public void* pad4;
		public void finalize ();
		public static void init (GLib.Object obj, Awn.Effects fx);
		public void set_title (Awn.Title title, Awn.TitleCallback title_func);
	}
	[Compact]
	[CCode (cheader_filename = "libawn/awn-effects.h")]
	public class EffectsOp {
		public weak Awn.EffectsOpfn fn;
		public void* data;
	}
	[Compact]
	[CCode (cheader_filename = "libawn/awn-settings.h")]
	public class Settings {
		public weak Gtk.IconTheme icon_theme;
		public weak Gtk.Widget bar;
		public weak Gtk.Widget window;
		public weak Gtk.Widget title;
		public weak Gtk.Widget appman;
		public weak Gtk.Widget hot;
		public int task_width;
		public Gdk.Rectangle monitor;
		public bool force_monitor;
		public int monitor_height;
		public int monitor_width;
		public bool panel_mode;
		public bool auto_hide;
		public bool hidden;
		public bool hiding;
		public int auto_hide_delay;
		public bool keep_below;
		public int bar_height;
		public int bar_angle;
		public float bar_pos;
		public bool no_bar_resize_ani;
		public bool rounded_corners;
		public float corner_radius;
		public bool render_pattern;
		public bool expand_bar;
		public weak string pattern_uri;
		public float pattern_alpha;
		public weak Awn.Color g_step_1;
		public weak Awn.Color g_step_2;
		public weak Awn.Color g_histep_1;
		public weak Awn.Color g_histep_2;
		public weak Awn.Color border_color;
		public weak Awn.Color hilight_color;
		public bool show_separator;
		public weak Awn.Color sep_color;
		public bool show_all_windows;
		public weak GLib.SList launchers;
		public bool use_png;
		public weak string active_png;
		public weak Awn.Color arrow_color;
		public int arrow_offset;
		public bool tasks_have_arrows;
		public bool name_change_notify;
		public bool alpha_effect;
		public int icon_effect;
		public float icon_alpha;
		public float reflection_alpha_mult;
		public int frame_rate;
		public bool icon_depth_on;
		public int icon_offset;
		public weak Awn.Color text_color;
		public weak Awn.Color shadow_color;
		public weak Awn.Color background;
		public weak string font_face;
		public bool btest;
		public float ftest;
		public weak string stest;
		public weak Awn.Color ctest;
		public weak GLib.SList ltest;
		public int bar_width;
		public float curviness;
		public float curves_symmetry;
		public Settings ();
	}
	[Compact]
	[CCode (cheader_filename = "libawn/awn-vfs.h")]
	public class VfsMonitor {
		public static weak Awn.VfsMonitor add (string path, Awn.VfsMonitorType monitor_type, Awn.VfsMonitorFunc callback);
		public void emit (string path, Awn.VfsMonitorEvent event);
		public void remove ();
	}
	[Compact]
	[CCode (cheader_filename = "libawn/awn-effects.h")]
	public class DrawIconState {
		public int current_height;
		public int current_width;
		public int x1;
		public int y1;
	}
	[Compact]
	[CCode (cheader_filename = "libawn/awn-config-client.h")]
	public class ConfigClient {
		public void clear () throws GLib.Error;
		public void ensure_group (string group);
		public bool entry_exists (string group, string key);
		public bool get_bool (string group, string key) throws GLib.Error;
		public float get_float (string group, string key) throws GLib.Error;
		public int get_int (string group, string key) throws GLib.Error;
		public weak GLib.SList get_list (string group, string key, Awn.ConfigListType list_type) throws GLib.Error;
		public weak string get_string (string group, string key) throws GLib.Error;
		public Awn.ConfigValueType get_value_type (string group, string key) throws GLib.Error;
		public static int key_lock (int fd, int operation);
		public static int key_lock_close (int fd);
		public static int key_lock_open (string group, string key);
		public void load_defaults_from_schema () throws GLib.Error;
		public ConfigClient ();
		public ConfigClient.for_applet (string name, string? uid);
		public void notify_add (string group, string key, Awn.ConfigClientNotifyFunc callback);
		public static Awn.ConfigBackend query_backend ();
		public void set_bool (string group, string key, bool value) throws GLib.Error;
		public void set_float (string group, string key, float value) throws GLib.Error;
		public void set_int (string group, string key, int value) throws GLib.Error;
		public void set_list (string group, string key, Awn.ConfigListType list_type, GLib.SList value) throws GLib.Error;
		public void set_string (string group, string key, string value) throws GLib.Error;
	}
	[CCode (cheader_filename = "libawn/awn-applet.h")]
	public class Applet : Gtk.EventBox, Gtk.Buildable, Atk.Implementor {
		public weak Gtk.Widget create_default_menu ();
		public static weak Gtk.Widget create_pref_item ();
		public uint get_height ();
		public Awn.Orientation get_orientation ();
		public Applet (string uid, int orient, int height);
		[NoWrapper]
		public virtual void deleted (string uid);
		[NoWrapper]
		public virtual void orient_changed (Awn.Orientation oreint);
		[NoWrapper]
		public virtual void plug_embedded ();
		[NoWrapper]
		public virtual void size_changed (int x);
		[NoAccessorMethod]
		public int height { get; set construct; }
		[NoAccessorMethod]
		public int orient { get; set construct; }
		[NoAccessorMethod]
		public string uid { get; set construct; }
		public virtual signal void applet_deleted (string p0);
		public virtual signal void height_changed (int height);
		public virtual signal void orientation_changed (int p0);
	}
	[CCode (cheader_filename = "libawn/awn-applet-dialog.h")]
	public class AppletDialog : Gtk.Window, Gtk.Buildable, Atk.Implementor {
		public AppletDialog (Awn.Applet applet);
		public void position_reset ();
	}
	[CCode (cheader_filename = "libawn/awn-applet-simple.h")]
	public class AppletSimple : Awn.Applet, Gtk.Buildable, Atk.Implementor {
		public void effects_off ();
		public void effects_on ();
		public weak Awn.Effects get_effects ();
		public AppletSimple (string uid, int orient, int height);
		public weak Gdk.Pixbuf set_awn_icon (string applet_name, string uid, string icon_name);
		public weak Gdk.Pixbuf set_awn_icon_state (string state);
		public weak Gdk.Pixbuf set_awn_icons (string applet_name, string uid, string[] states, string[] icon_names);
		public void set_icon (Gdk.Pixbuf pixbuf);
		public void set_icon_context (Cairo.Context cr);
		public void set_temp_icon (Gdk.Pixbuf pixbuf);
		public void set_title (string title_string);
		public void set_title_visibility (bool state);
	}
	[CCode (cheader_filename = "libawn/awn-icons.h")]
	public class Icons : GLib.Object {
		public weak Gdk.Pixbuf get_icon (string state);
		public weak Gdk.Pixbuf get_icon_simple ();
		public Icons ();
		public void set_changed_cb (Awn.IconsChange fn);
		public void set_icon_info (Gtk.Widget applet, string applet_name, string uid, int height, string icon_name);
		public void set_icons_info (Gtk.Widget applet, string applet_name, string uid, int height, string[] states, string[] icon_names);
	}
	[CCode (cheader_filename = "libawn/awn-plug.h")]
	public class Plug : Gtk.Plug, Gtk.Buildable, Atk.Implementor {
		public void @construct (Gdk.NativeWindow socket_id);
		public Plug (Awn.Applet applet);
		public virtual signal void applet_deleted (string uid);
	}
	[CCode (cheader_filename = "libawn/awn-title.h")]
	public class Title : Gtk.Window, Gtk.Buildable, Atk.Implementor {
		public static weak Gtk.Widget get_default ();
		public void hide (Gtk.Widget focus);
		public void show (Gtk.Widget focus, string text);
	}
	[Compact]
	[CCode (cheader_filename = "libawn/awn-config-client.h")]
	public class ConfigClientValue {
		public bool bool_val;
		public float float_val;
		public int int_val;
		public weak string str_val;
		public weak GLib.SList list_val;
	}
	[CCode (cheader_filename = "libawn/awn-applet.h")]
	public static delegate bool AppletInitFunc (Awn.Applet applet);
	[CCode (cheader_filename = "libawn/awn-applet.h")]
	public static delegate weak Awn.Applet AppletInitPFunc (string uid, int orient, int height);
	[CCode (cheader_filename = "libawn/awn-config-client.h")]
	public delegate void ConfigClientNotifyFunc (Awn.ConfigClientNotifyEntry entry);
	[CCode (cheader_filename = "libawn/awn-effects.h")]
	public delegate bool EffectsOpfn (Awn.Effects fx, Awn.DrawIconState ds);
	[CCode (cheader_filename = "libawn/awn-effects.h")]
	public static delegate void EventNotify (GLib.Object p1);
	[CCode (cheader_filename = "libawn/awn-icons.h")]
	public delegate void IconsChange (Awn.Icons fx);
	[CCode (cheader_filename = "libawn/awn-title.h")]
	public static delegate weak string TitleCallback (GLib.Object p1);
	[CCode (cheader_filename = "libawn/awn-vfs.h")]
	public delegate void VfsMonitorFunc (Awn.VfsMonitor monitor, string monitor_path, string event_path, Awn.VfsMonitorEvent event);
	[CCode (cheader_filename = "libawn/awn-defines.h")]
	public const string APPLET_GCONF_PATH;
	[CCode (cheader_filename = "libawn/awn-config-client.h")]
	public const string CONFIG_CLIENT_DEFAULT_GROUP;
	[CCode (cheader_filename = "libawn/awn-defines.h")]
	public const string GCONF_PATH;
	[CCode (cheader_filename = "libawn/awn-defines.h")]
	public const int MAX_HEIGHT;
	[CCode (cheader_filename = "libawn/awn-defines.h")]
	public const int MIN_HEIGHT;
	[CCode (cheader_filename = "libawn/awn-cairo-utils.h")]
	public static void cairo_rounded_rect (Cairo.Context cr, int x0, int y0, int width, int height, double radius, Awn.CairoRoundCorners state);
	[CCode (cheader_filename = "libawn/awn-cairo-utils.h")]
	public static void cairo_string_to_color (string str, Awn.Color color);
	[CCode (cheader_filename = "libawn/awn-effects.h")]
	public static void draw_background (Awn.Effects p1, Cairo.Context p2);
	[CCode (cheader_filename = "libawn/awn-effects.h")]
	public static void draw_foreground (Awn.Effects p1, Cairo.Context p2);
	[CCode (cheader_filename = "libawn/awn-effects.h")]
	public static void draw_icons (Awn.Effects p1, Cairo.Context p2, Gdk.Pixbuf p3, Gdk.Pixbuf p4);
	[CCode (cheader_filename = "libawn/awn-effects.h")]
	public static void draw_icons_cairo (Awn.Effects fx, Cairo.Context cr, Cairo.Context p3, Cairo.Context p4);
	[CCode (cheader_filename = "libawn/awn-effects.h")]
	public static void draw_set_icon_size (Awn.Effects p1, int p2, int p3);
	[CCode (cheader_filename = "libawn/awn-effects.h")]
	public static void draw_set_window_size (Awn.Effects p1, int p2, int p3);
	[CCode (cheader_filename = "libawn/awn-effects.h")]
	public static void effect_start (Awn.Effects fx, Awn.Effect effect);
	[CCode (cheader_filename = "libawn/awn-effects.h")]
	public static void effect_start_ex (Awn.Effects fx, Awn.Effect effect, Awn.EventNotify? start, Awn.EventNotify? stop, int max_loops);
	[CCode (cheader_filename = "libawn/awn-effects.h")]
	public static void effect_stop (Awn.Effects fx, Awn.Effect effect);
	[CCode (cheader_filename = "libawn/awn-settings.h")]
	public static weak Awn.Settings get_settings ();
	[CCode (cname = "main_effect_loop", cheader_filename = "libawn/awn-effects.h")]
	public static void main_effect_loop (Awn.Effects fx);
	[CCode (cheader_filename = "libawn/awn-effects.h")]
	public static void register_effects (GLib.Object obj, Awn.Effects fx);
	[CCode (cheader_filename = "libawn/awn-effects.h")]
	public static void unregister_effects (Awn.Effects fx);
	[CCode (cheader_filename = "libawn/awn-vfs.h")]
	public static weak GLib.SList vfs_get_pathlist_from_string (string paths) throws GLib.Error;
	[CCode (cheader_filename = "libawn/awn-vfs.h")]
	public static void vfs_init ();
}
