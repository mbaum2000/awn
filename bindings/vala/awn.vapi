/* awn.vapi generated by vapigen, do not modify. */

[CCode (cprefix = "Awn", lower_case_cprefix = "awn_")]
namespace Awn {
	[CCode (cprefix = "AwnCairo", lower_case_cprefix = "awn_cairo_")]
	namespace CairoUtils {
		[CCode (cheader_filename = "libawn/libawn.h")]
		public static void pattern_add_color_stop_color (Cairo.Pattern pattern, double offset, DesktopAgnostic.Color color);
		[CCode (cheader_filename = "libawn/libawn.h")]
		public static void pattern_add_color_stop_color_with_alpha_multiplier (Cairo.Pattern pattern, double offset, DesktopAgnostic.Color color, double multiplier);
		[CCode (cheader_filename = "libawn/libawn.h")]
		public static void rounded_rect (Cairo.Context cr, double x0, double y0, double width, double height, double radius, Awn.CairoRoundCorners state);
		[CCode (cheader_filename = "libawn/libawn.h")]
		public static void rounded_rect_shadow (Cairo.Context cr, double rx0, double ry0, double width, double height, double radius, Awn.CairoRoundCorners state, double shadow_radius, double shadow_alpha);
		[CCode (cheader_filename = "libawn/libawn.h")]
		public static void set_source_color (Cairo.Context cr, DesktopAgnostic.Color color);
		[CCode (cheader_filename = "libawn/libawn.h")]
		public static void set_source_color_with_alpha_multiplier (Cairo.Context cr, DesktopAgnostic.Color color, double multiplier);
		[CCode (cheader_filename = "libawn/libawn.h")]
		public static void set_source_color_with_multipliers (Cairo.Context cr, DesktopAgnostic.Color color, double color_multiplier, double alpha_multiplier);
	}
	[CCode (cprefix = "AwnConfig", lower_case_cprefix = "awn_config_")]
	namespace Config {
		[CCode (cheader_filename = "libawn/libawn.h")]
		public static void free ();
		[CCode (cheader_filename = "libawn/libawn.h")]
		public static unowned DesktopAgnostic.Config.Client get_default (int panel_id) throws GLib.Error;
		[CCode (cheader_filename = "libawn/libawn.h")]
		public static unowned DesktopAgnostic.Config.Client get_default_for_applet (Awn.Applet applet) throws GLib.Error;
		[CCode (cheader_filename = "libawn/libawn.h")]
		public static unowned DesktopAgnostic.Config.Client get_default_for_applet_by_info (string name, string uid) throws GLib.Error;
	}
	[CCode (cprefix = "AwnUtils", lower_case_cprefix = "awn_utils_")]
	namespace Utils {
		[CCode (cheader_filename = "libawn/awn-utils.h")]
		public static void ensure_transparent_bg (Gtk.Widget widget);
		[CCode (cheader_filename = "libawn/awn-utils.h")]
		public static float get_offset_modifier_by_path_type (Awn.PathType path_type, Gtk.PositionType position, float offset_modifier, int pos_x, int pos_y, int width, int height);
		[CCode (cheader_filename = "libawn/awn-utils.h")]
		public static GLib.ValueArray gslist_to_gvaluearray (GLib.SList list);
		[CCode (cheader_filename = "libawn/awn-utils.h")]
		public static void make_transparent_bg (Gtk.Widget widget);
		[CCode (cheader_filename = "libawn/awn-utils.h")]
		public static void show_menu_images (Gtk.Menu menu);
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class Alignment : Gtk.Alignment, Atk.Implementor, Gtk.Buildable {
		[CCode (type = "GtkWidget*", has_construct_function = false)]
		public Alignment.for_applet (Awn.Applet applet);
		public int get_offset_modifier ();
		public void set_offset_modifier (int modifier);
		[NoAccessorMethod]
		public Awn.Applet applet { owned get; set; }
		public int offset_modifier { get; set construct; }
		[NoAccessorMethod]
		public float scale { get; set; }
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class Applet : Gtk.Plug, Atk.Implementor, Gtk.Buildable {
		[CCode (has_construct_function = false)]
		public Applet (string canonical_name, string uid, int panel_id);
		public unowned Gtk.Widget create_about_item (string copyright, Awn.AppletLicense license, string version, string? comments, string? website, string? website_label, string? icon_name, string? translator_credits, [CCode (array_length = false)] string[]? authors, [CCode (array_length = false)] string[]? artists, [CCode (array_length = false)] string[]? documenters);
		public unowned Gtk.Widget create_about_item_simple (string copyright, Awn.AppletLicense license, string version);
		public unowned Gtk.Widget create_default_menu ();
		public static unowned Gtk.Widget create_pref_item ();
		[NoWrapper]
		public virtual void deleted (string uid);
		public Gdk.NativeWindow docklet_request (int min_size, bool shrink, bool expand);
		public Awn.AppletFlags get_behavior ();
		public unowned string get_canonical_name ();
		public int get_offset ();
		public int get_offset_at (int x, int y);
		public Awn.PathType get_path_type ();
		public Gtk.PositionType get_pos_type ();
		public int get_size ();
		public unowned string get_uid ();
		public uint inhibit_autohide (string reason);
		[NoWrapper]
		public virtual void panel_configure (Gdk.EventConfigure event);
		public void set_behavior (Awn.AppletFlags flags);
		public void set_offset (int offset);
		public void set_path_type (Awn.PathType path);
		public void set_pos_type (Gtk.PositionType position);
		public void set_size (int size);
		public void set_uid (string uid);
		public void uninhibit_autohide (uint cookie);
		public string canonical_name { get; construct; }
		[NoAccessorMethod]
		public string display_name { owned get; set; }
		[NoAccessorMethod]
		public int max_size { get; set; }
		public int offset { get; set; }
		[NoAccessorMethod]
		public float offset_modifier { get; set; }
		[NoAccessorMethod]
		public int panel_id { get; construct; }
		[NoAccessorMethod]
		public int64 panel_xid { get; }
		public int path_type { get; set construct; }
		[NoAccessorMethod]
		public Gtk.PositionType position { get; set; }
		[NoAccessorMethod]
		public bool quit_on_delete { get; set; }
		[NoAccessorMethod]
		public bool show_all_on_embed { get; set; }
		public int size { get; set; }
		public string uid { get; set construct; }
		public virtual signal void applet_deleted (string p0);
		public virtual signal void flags_changed (int flags);
		public virtual signal void menu_creation (Gtk.Menu menu);
		public virtual signal void offset_changed (int offset);
		public virtual signal void origin_changed (Gdk.Rectangle rect);
		public virtual signal void panel_configure_event (Gdk.Event p0);
		public virtual signal void position_changed (Gtk.PositionType position);
		public virtual signal void size_changed (int size);
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class AppletSimple : Awn.Applet, Atk.Implementor, Gtk.Buildable, Awn.Overlayable {
		[CCode (type = "GtkWidget*", has_construct_function = false)]
		public AppletSimple (string canonical_name, string uid, int panel_id);
		public unowned Gtk.Widget get_icon ();
		public unowned string get_message ();
		public float get_progress ();
		public unowned string get_tooltip_text ();
		public void set_effect (Awn.Effect effect);
		public void set_icon_context (Cairo.Context cr);
		public void set_icon_info (string[] states, string[] icon_names);
		public void set_icon_name (string icon_name);
		public void set_icon_pixbuf (Gdk.Pixbuf pixbuf);
		public void set_icon_state (string state);
		public void set_icon_surface (Cairo.Surface surface);
		public void set_message (string message);
		public void set_progress (float progress);
		public void set_tooltip_text (string text);
		public virtual signal void clicked ();
		public virtual signal void context_menu_popup (Gdk.EventButton event);
		public virtual signal void long_press ();
		public virtual signal void middle_clicked ();
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class Box : Gtk.Box, Gtk.Orientable, Atk.Implementor, Gtk.Buildable {
		[CCode (type = "GtkWidget*", has_construct_function = false)]
		public Box (Gtk.Orientation orient);
		public void set_orientation (Gtk.Orientation orient);
		public void set_orientation_from_pos_type (Gtk.PositionType pos_type);
		[NoAccessorMethod]
		public Gtk.Orientation orientation { get; set; }
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class Dialog : Gtk.Window, Atk.Implementor, Gtk.Buildable {
		[CCode (type = "GtkWidget*", has_construct_function = false)]
		public Dialog ();
		[CCode (type = "GtkWidget*", has_construct_function = false)]
		public Dialog.for_widget (Gtk.Widget widget);
		[CCode (type = "GtkWidget*", has_construct_function = false)]
		public Dialog.for_widget_with_applet (Gtk.Widget widget, Awn.Applet applet);
		public void set_padding (int padding);
		[NoAccessorMethod]
		public Gtk.Widget anchor { set; }
		[NoAccessorMethod]
		public Awn.Applet anchor_applet { set; }
		[NoAccessorMethod]
		public bool anchored { get; set construct; }
		[NoAccessorMethod]
		public DesktopAgnostic.Color border { owned get; set construct; }
		[NoAccessorMethod]
		public DesktopAgnostic.Color dialog_bg { owned get; set construct; }
		[NoAccessorMethod]
		public bool effects_hilight { get; set construct; }
		[NoAccessorMethod]
		public bool hide_on_esc { get; set construct; }
		[NoAccessorMethod]
		public bool hide_on_unfocus { get; set construct; }
		[NoAccessorMethod]
		public DesktopAgnostic.Color hilight { owned get; set construct; }
		[NoAccessorMethod]
		public Gtk.PositionType position { get; set construct; }
		[NoAccessorMethod]
		public DesktopAgnostic.Color title_bg { owned get; set construct; }
		[NoAccessorMethod]
		public int window_offset { get; set construct; }
		[NoAccessorMethod]
		public int window_padding { get; set construct; }
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class Effects : GLib.Object {
		public GLib.Quark arrow_icon;
		public GLib.Quark custom_active_icon;
		public bool do_reflection;
		public bool is_active;
		public weak string label;
		public float refl_alpha;
		public int refl_offset;
		public uint set_effects;
		public GLib.Quark spotlight_icon;
		public weak Cairo.Context virtual_ctx;
		public weak Cairo.Context window_ctx;
		public void add_overlay (Awn.Overlay overlay);
		public unowned Cairo.Context cairo_create ();
		public unowned Cairo.Context cairo_create_clipped (Gdk.EventExpose event);
		public void cairo_destroy ();
		public void emit_anim_end (Awn.Effect effect);
		public void emit_anim_start (Awn.Effect effect);
		[CCode (has_construct_function = false)]
		public Effects.for_widget (Gtk.Widget widget);
		public unowned GLib.List get_overlays ();
		public void main_effect_loop ();
		public void redraw ();
		public void remove_overlay (Awn.Overlay overlay);
		public void set_icon_size (int width, int height, bool requestSize);
		public void start (Awn.Effect effect);
		public void start_ex (Awn.Effect effect, int max_loops, bool signal_start, bool signal_end);
		public void stop (Awn.Effect effect);
		[NoAccessorMethod]
		public bool active { get; set construct; }
		[NoAccessorMethod]
		public string arrow_png { owned get; set construct; }
		[NoAccessorMethod]
		public int arrows_count { get; set construct; }
		[NoAccessorMethod]
		public int border_clip { get; set construct; }
		[NoAccessorMethod]
		public string custom_active_png { owned get; set construct; }
		[NoAccessorMethod]
		public bool depressed { get; set construct; }
		[NoAccessorMethod]
		public int effects { get; set construct; }
		[NoAccessorMethod]
		public float icon_alpha { get; set construct; }
		[NoAccessorMethod]
		public int icon_offset { get; set construct; }
		[NoAccessorMethod]
		public bool indirect_paint { get; set construct; }
		[NoAccessorMethod]
		public bool make_shadow { get; set construct; }
		[NoAccessorMethod]
		public bool no_clear { get; set construct; }
		[NoAccessorMethod]
		public Gtk.PositionType position { get; set construct; }
		[NoAccessorMethod]
		public float progress { get; set construct; }
		[NoAccessorMethod]
		public float reflection_alpha { get; set construct; }
		[NoAccessorMethod]
		public int reflection_offset { get; set construct; }
		[NoAccessorMethod]
		public bool reflection_visible { get; set construct; }
		[NoAccessorMethod]
		public string spotlight_png { owned get; set construct; }
		[NoAccessorMethod]
		public Gtk.Widget widget { owned get; set; }
		public virtual signal void animation_end (Awn.Effect effect);
		public virtual signal void animation_start (Awn.Effect effect);
	}
	[Compact]
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class EffectsOp {
		public void* data;
		public weak Awn.EffectsOpfn fn;
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class Icon : Gtk.DrawingArea, Atk.Implementor, Gtk.Buildable, Awn.Overlayable {
		[CCode (type = "GtkWidget*", has_construct_function = false)]
		public Icon ();
		public bool get_hover_effects ();
		public int get_indicator_count ();
		public bool get_is_active ();
		public int get_offset ();
		public Gtk.PositionType get_pos_type ();
		public unowned Awn.Tooltip get_tooltip ();
		public unowned string get_tooltip_text ();
		[NoWrapper]
		public virtual void icon_padding0 ();
		[NoWrapper]
		public virtual void icon_padding1 ();
		[NoWrapper]
		public virtual void icon_padding2 ();
		[NoWrapper]
		public virtual void icon_padding3 ();
		public void set_custom_paint (int width, int height);
		public void set_effect (Awn.Effect effect);
		public void set_from_context (Cairo.Context ctx);
		public void set_from_pixbuf (Gdk.Pixbuf pixbuf);
		public void set_from_surface (Cairo.Surface surface);
		public void set_hover_effects (bool enable);
		public void set_indicator_count (int count);
		public void set_is_active (bool is_active);
		public void set_offset (int offset);
		public void set_pos_type (Gtk.PositionType position);
		public void set_tooltip_text (string text);
		[NoAccessorMethod]
		public bool bind_effects { get; construct; }
		[NoAccessorMethod]
		public int icon_height { get; set; }
		[NoAccessorMethod]
		public int icon_width { get; set; }
		[NoAccessorMethod]
		public int long_press_timeout { get; set construct; }
		public virtual signal void clicked ();
		public virtual signal void context_menu_popup (Gdk.EventButton event);
		public virtual signal void long_press ();
		public virtual signal void middle_clicked ();
		public virtual signal void size_changed ();
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class IconBox : Awn.Box, Gtk.Orientable, Atk.Implementor, Gtk.Buildable {
		[CCode (type = "GtkWidget*", has_construct_function = false)]
		public IconBox ();
		[CCode (type = "GtkWidget*", has_construct_function = false)]
		public IconBox.for_applet (Awn.Applet applet);
		public void set_offset (int offset);
		public void set_pos_type (Gtk.PositionType position);
		public Awn.Applet applet { construct; }
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class Image : Gtk.Image, Atk.Implementor, Gtk.Buildable, Awn.Overlayable {
		[CCode (has_construct_function = false)]
		public Image ();
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class Label : Gtk.Label, Atk.Implementor, Gtk.Buildable {
		[CCode (has_construct_function = false)]
		public Label ();
		[NoAccessorMethod]
		public int font_mode { get; set; }
		[NoAccessorMethod]
		public DesktopAgnostic.Color text_color { owned get; set; }
		[NoAccessorMethod]
		public DesktopAgnostic.Color text_outline_color { owned get; set; }
		[NoAccessorMethod]
		public double text_outline_width { get; set; }
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class Overlay : GLib.InitiallyUnowned {
		[CCode (has_construct_function = false)]
		public Overlay ();
		public bool get_apply_effects ();
		public bool get_use_source_op ();
		public void move_to (Cairo.Context cr, int icon_width, int icon_height, int overlay_width, int overlay_height, Awn.OverlayCoord coord_req);
		public virtual void render (Gtk.Widget widget, Cairo.Context cr, int width, int height);
		public void set_apply_effects (bool value);
		public void set_use_source_op (bool value);
		[NoAccessorMethod]
		public bool active { get; set construct; }
		[NoAccessorMethod]
		public int align { get; set construct; }
		public bool apply_effects { get; set; }
		[NoAccessorMethod]
		public Gdk.Gravity gravity { get; set construct; }
		public bool use_source_op { get; set; }
		[NoAccessorMethod]
		public double x_adj { get; set construct; }
		[NoAccessorMethod]
		public double x_override { get; set construct; }
		[NoAccessorMethod]
		public double y_adj { get; set construct; }
		[NoAccessorMethod]
		public double y_override { get; set construct; }
	}
	[Compact]
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class OverlayCoord {
		public double x;
		public double y;
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class OverlayPixbuf : Awn.Overlay {
		[CCode (has_construct_function = false)]
		public OverlayPixbuf ();
		[CCode (has_construct_function = false)]
		public OverlayPixbuf.with_pixbuf (Gdk.Pixbuf pixbuf);
		[NoAccessorMethod]
		public double alpha { get; set construct; }
		[NoAccessorMethod]
		public Gdk.Pixbuf pixbuf { owned get; set construct; }
		[NoAccessorMethod]
		public double scale { get; set construct; }
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class OverlayPixbufFile : Awn.OverlayPixbuf {
		[CCode (has_construct_function = false)]
		public OverlayPixbufFile (string file_name);
		[NoAccessorMethod]
		public string file_name { owned get; set construct; }
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public abstract class OverlayProgress : Awn.Overlay {
		[CCode (has_construct_function = false)]
		public OverlayProgress ();
		[NoAccessorMethod]
		public double percent_complete { get; set construct; }
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class OverlayProgressCircle : Awn.OverlayProgress {
		[CCode (has_construct_function = false)]
		public OverlayProgressCircle ();
		[NoAccessorMethod]
		public DesktopAgnostic.Color background_color { owned get; set construct; }
		[NoAccessorMethod]
		public DesktopAgnostic.Color foreground_color { owned get; set construct; }
		[NoAccessorMethod]
		public DesktopAgnostic.Color outline_color { owned get; set construct; }
		[NoAccessorMethod]
		public double scale { get; set construct; }
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class OverlayText : Awn.Overlay {
		[CCode (has_construct_function = false)]
		public OverlayText ();
		public void get_size (Gtk.Widget widget, string text, int size, int width, int height);
		[NoAccessorMethod]
		public int font_mode { get; set; }
		[NoAccessorMethod]
		public double font_sizing { get; set construct; }
		[NoAccessorMethod]
		public string text { owned get; set construct; }
		[NoAccessorMethod]
		public DesktopAgnostic.Color text_color { owned get; set; }
		[NoAccessorMethod]
		public string text_color_astr { owned get; set; }
		[NoAccessorMethod]
		public DesktopAgnostic.Color text_outline_color { owned get; set; }
		[NoAccessorMethod]
		public string text_outline_color_astr { owned get; set; }
		[NoAccessorMethod]
		public double text_outline_width { get; set; }
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class OverlayThemedIcon : Awn.Overlay {
		[CCode (has_construct_function = false)]
		public OverlayThemedIcon (Awn.ThemedIcon icon, string icon_name, string state);
		[NoAccessorMethod]
		public double alpha { get; set construct; }
		[NoAccessorMethod]
		public Awn.ThemedIcon icon { owned get; set construct; }
		[NoAccessorMethod]
		public string icon_name { owned get; set construct; }
		[NoAccessorMethod]
		public string icon_state { owned get; set construct; }
		[NoAccessorMethod]
		public double scale { get; set construct; }
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class OverlayThrobber : Awn.Overlay {
		[CCode (type = "GtkWidget*", has_construct_function = false)]
		public OverlayThrobber (Gtk.Widget icon);
		[NoAccessorMethod]
		public Gtk.Widget icon { owned get; set construct; }
		[NoAccessorMethod]
		public double scale { get; set construct; }
		[NoAccessorMethod]
		public uint timeout { get; set construct; }
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class ThemedIcon : Awn.Icon, Atk.Implementor, Gtk.Buildable, Awn.Overlayable {
		[CCode (type = "GtkWidget*", has_construct_function = false)]
		public ThemedIcon ();
		public void clear_icons (int scope);
		public void clear_info ();
		public unowned Gtk.Widget create_custom_icon_item (string icon_name);
		public unowned Gtk.Widget create_remove_custom_icon_item (string icon_name);
		public static void drag_data_received (Gtk.Widget widget, Gdk.DragContext context, int x, int y, Gtk.SelectionData selection_data, uint info, uint evt_time);
		public unowned Gtk.IconTheme get_awn_theme ();
		public unowned string get_default_theme_name ();
		public unowned Gdk.Pixbuf get_icon_at_size (uint size, string state);
		public int get_size ();
		public unowned string get_state ();
		public void override_gtk_theme (string theme_name);
		public void preload_icon (string state, int size);
		public void set_applet_info (string applet_name, string uid);
		public void set_info (string applet_name, string uid, string[] states, string[] icon_names);
		public void set_info_append (string state, string icon_name);
		public void set_info_simple (string applet_name, string uid, string icon_name);
		public void set_size (int size);
		public void set_state (string state);
		[NoAccessorMethod]
		public string applet_name { owned get; set construct; }
		[NoAccessorMethod]
		public bool drag_and_drop { get; set construct; }
		[NoAccessorMethod]
		public Gdk.PixbufRotation rotate { get; set construct; }
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public class Tooltip : Gtk.Window, Atk.Implementor, Gtk.Buildable {
		[CCode (type = "GtkWidget*", has_construct_function = false)]
		public Tooltip.for_widget (Gtk.Widget widget);
		public int get_delay ();
		public unowned string get_text ();
		public void set_background_color (DesktopAgnostic.Color bg_color);
		public void set_delay (int msecs);
		public void set_focus_widget (Gtk.Widget widget);
		public void set_font_color (DesktopAgnostic.Color font_color);
		public void set_font_name (string font_name);
		public void set_position_hint (Gtk.PositionType position, int size);
		public void set_text (string text);
		public void update_position ();
		public int delay { get; set construct; }
		[NoAccessorMethod]
		public Gtk.Widget focus_widget { owned get; set; }
		[NoAccessorMethod]
		public int offset { get; set construct; }
		[NoAccessorMethod]
		public bool smart_behavior { get; set construct; }
		[NoAccessorMethod]
		public bool toggle_on_click { get; set construct; }
		[NoAccessorMethod]
		public DesktopAgnostic.Color tooltip_bg_color { owned get; set construct; }
		[NoAccessorMethod]
		public DesktopAgnostic.Color tooltip_font_color { owned get; set construct; }
		[NoAccessorMethod]
		public string tooltip_font_name { owned get; set construct; }
	}
	[CCode (cheader_filename = "libawn/libawn.h")]
	public interface Overlayable {
		public void add_overlay (Awn.Overlay overlay);
		public abstract unowned Awn.Effects get_effects ();
		public unowned GLib.List get_overlays ();
		public void remove_overlay (Awn.Overlay overlay);
	}
	[CCode (cprefix = "AWN_APPLET_", has_type_id = "0", cheader_filename = "libawn/libawn.h")]
	public enum AppletFlags {
		FLAGS_NONE,
		EXPAND_MINOR,
		EXPAND_MAJOR,
		IS_EXPANDER,
		IS_SEPARATOR,
		HAS_SHAPE_MASK
	}
	[CCode (cprefix = "AWN_APPLET_LICENSE_", has_type_id = "0", cheader_filename = "libawn/libawn.h")]
	public enum AppletLicense {
		GPLV2,
		GPLV3,
		LGPLV2_1,
		LGPLV3
	}
	[CCode (cprefix = "ROUND_", has_type_id = "0", cheader_filename = "libawn/libawn.h")]
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
	[CCode (cprefix = "AWN_EFFECT_", has_type_id = "0", cheader_filename = "libawn/libawn.h")]
	public enum Effect {
		NONE,
		OPENING,
		CLOSING,
		HOVER,
		LAUNCHING,
		ATTENTION,
		DESATURATE
	}
	[CCode (cprefix = "AWN_OVERLAY_ALIGN_", has_type_id = "0", cheader_filename = "libawn/libawn.h")]
	public enum OverlayAlign {
		CENTRE,
		LEFT,
		RIGHT
	}
	[CCode (cprefix = "AWN_PATH_", has_type_id = "0", cheader_filename = "libawn/libawn.h")]
	public enum PathType {
		LINEAR,
		ELLIPSE,
		LAST
	}
	[CCode (cheader_filename = "libawn/libawn.h", has_target = false)]
	public delegate bool AppletInitFunc (Awn.Applet applet);
	[CCode (cheader_filename = "libawn/libawn.h", has_target = false)]
	public delegate unowned Awn.Applet AppletInitPFunc (string canonical_name, string uid, int panel_id);
	[CCode (cheader_filename = "libawn/libawn.h")]
	public delegate bool EffectsOpfn (Awn.Effects fx, Gtk.Allocation alloc);
	[CCode (cheader_filename = "libawn/libawn.h")]
	public const int MAX_HEIGHT;
	[CCode (cheader_filename = "libawn/libawn.h")]
	public const int MIN_HEIGHT;
	[CCode (cheader_filename = "libawn/libawn.h")]
	public const int PANEL_ID_DEFAULT;
}
