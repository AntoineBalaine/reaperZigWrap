const std = @import("std");
const UserSettings = @import("userPrefs.zig").UserSettings;
const reaper = @import("../reaper.zig").reaper;
const ctr = @import("c1.zig");
const Mode = ctr.Mode;
const ActionId = ctr.ActionId;
const Btns = ctr.Btns;
const controller = ctr.controller;
const Track = @import("track.zig").Track;

const State = @This();

/// State has to be called from control_surface.zig
/// Flow is : main.zig -> register Csurf -> Csurf forwards calls to control_surface.zig -> control_surface updates state
Track: ?Track = null,
actionIds: std.AutoHashMap(c_int, ActionId),
allocator: std.mem.Allocator,
controller: std.EnumArray(Mode, Btns) = controller,
controller_dir: []const u8,
mode: Mode = .fx_ctrl,
track: ?Track = null,
user_settings: UserSettings,

pub fn init(allocator: std.mem.Allocator, controller_dir: []const u8, user_settings: UserSettings) !State {
    var self: State = .{
        .actionIds = std.AutoHashMap(c_int, ActionId).init(allocator),
        .allocator = allocator,
        .controller_dir = controller_dir,
        .user_settings = user_settings,
    };

    errdefer {
        self.actionIds.deinit();
    }
    try registerButtonActions(&self, allocator);
    return self;
}

pub fn deinit(self: *State, allocator: std.mem.Allocator) !void {
    allocator.free(self.controller_dir);
    self.actionIds.deinit();
}

///there's 1 realearn instance per module,
///so query the three instances
///and store them.
///@return number|nil index
fn getRealearnInstance() ?u8 {
    const master = reaper.GetMasterTrack(0);
    const inst = controller.c1;

    for (inst.modules) |module| {
        const idx = reaper.TrackFX_AddByName(master, module, true, 1);
        if (idx == -1) {
            reaper.MB("failed to load realearn instance", "Couldn't load the realearn instance", 2);
            return null;
        }
        if (module.idx == null or module.idx != idx) {
            module.idx = reaper.TrackFX_GetByName(master, module, false);
        }
    }
}
pub fn handleNewTrack(self: *State, trackid: reaper.MediaTrack) void {
    // get realearn instances
    // update track
    // validate channel strip
    // load channel strip
    // load matching preset into realearn

    if (self.track != null) {
        var tr = self.track.?;
        tr.deinit(self.allocator);
    }
    const new_track: Track = Track.init(trackid);
    self.track = new_track;
    @panic("new_track logic not implemented yet");
}

/// register the controller’s buttons as actions in reaper’s actions list
/// and load them into state.actionIds’ map.
///
/// If the registrations fail, return the error.
/// It’s expected that the state catch the error, so that the program doesn’t crash.
fn registerButtonActions(self: *State, allocator: std.mem.Allocator) !void {
    for (std.enums.values(ActionId)) |action_id| {
        const btn_name = @tagName(action_id);
        const id_str = try std.fmt.allocPrintZ(allocator, "{s}{s}", .{ "_PRKN_", btn_name });
        defer allocator.free(id_str);
        const name_str = try std.fmt.allocPrintZ(allocator, "{s}{s}", .{ "perken controller: ", btn_name });
        defer allocator.free(name_str);
        const btn_action = reaper.custom_action_register_t{
            //
            .section = 0,
            .id_str = id_str,
            .name = name_str,
        };
        const id = reaper.plugin_register("custom_action", @constCast(@ptrCast(&btn_action)));
        self.actionIds.put(id, action_id) catch {};
    }
    return;
}

pub fn hookCommand(self: *State, id: c_int) bool {
    const btn_name = self.actionIds.get(id) orelse return false;
    const cur_mode = controller.get(self.mode);
    const callback = cur_mode.get(btn_name);
    if (callback != null) {
        // callback();
        std.debug.print("found action\n", .{});
    } else {
        std.debug.print("UNFOUND action\n", .{});
    }

    return true;
}
pub fn csurfCB(self: *State) void {
    _ = self; // autofix
    std.debug.print("CALLBACK\n", .{});
}
