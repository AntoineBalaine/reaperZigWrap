const std = @import("std");
const reaper = @import("../reaper.zig").reaper;
const fs_helpers = @import("fs_helpers.zig");
const Allocator = std.mem.Allocator;
const ini = @import("ini");

pub const UserSettings = struct {
    show_start_up_message: bool = true,
    ///  -- should the UI display?
    show_feedback_window: bool = true,
    ///  -- show plugin UI when tweaking corresponding knob.
    show_plugin_ui: bool = true,
    manual_routing: bool = false,

    pub fn init(allocator: Allocator, cntrlrPth: []const u8) UserSettings {
        var userSettings = UserSettings{};

        const paths = [_][]const u8{ cntrlrPth, "resources", "preferences.ini" };
        const controller_path = std.fs.path.join(allocator, &paths) catch {
            return userSettings;
        };
        defer allocator.free(controller_path);

        loadUserPrefs(allocator, controller_path, &userSettings) catch {};
        return userSettings;
    }
};

/// read config:
/// find the reaper resource path
/// append the /Data/Perken/C1 folder
/// read the controller config INI file
/// get the controller rfxChain
/// read the fx prefs INI file
fn loadUserPrefs(allocator: Allocator, userPrefsPath: []const u8, userSettings: *UserSettings) !void {
    const file = try std.fs.cwd().openFile(userPrefsPath, .{});
    defer file.close();

    var parser = ini.parse(allocator, file.reader());
    defer parser.deinit();

    while (try parser.next()) |record| {
        switch (record) {
            .property => |kv| {
                const Case = std.meta.FieldEnum(UserSettings);
                const case = std.meta.stringToEnum(Case, kv.key) orelse continue;
                switch (case) {
                    .show_start_up_message => userSettings.show_start_up_message = std.mem.eql(u8, @tagName(case), "true"),
                    .show_feedback_window => userSettings.show_feedback_window = std.mem.eql(u8, @tagName(case), "true"),
                    .show_plugin_ui => userSettings.show_plugin_ui = std.mem.eql(u8, @tagName(case), "true"),
                }
            },
            .section => {},
            .enumeration => {},
        }
    }
}

test "userPrefs" {
    const allocator = std.testing.allocator;
    const userPrefsPath = "resources/preferences.ini";
    const userPrefs = try allocator.create(UserSettings);
    defer allocator.destroy(userPrefs);
    userPrefs.* = UserSettings{};
    try loadUserPrefs(allocator, userPrefsPath, userPrefs);
    try std.testing.expectEqual(userPrefs.show_start_up_message, false);
    try std.testing.expectEqual(userPrefs.show_start_up_message, false);
    try std.testing.expectEqual(userPrefs.show_plugin_ui, false);
}

test "controller prefs" {
    const ref =
        \\\[CONFIG]
        \\\name=Console1
        \\\channelStripPath=c1_chain.RfxChain
        \\\[MODULES]
        \\\module0=c1_Eq.json
        \\\module1=c1_Comp.json
        \\\module2=c1_Gate.json
        \\\[MODES]
        \\\mode0=fx_control
        \\\mode1=fx_select
        \\\mode3=settings
    ;
    _ = ref;
}
