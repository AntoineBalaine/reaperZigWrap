// zig build-lib -dynamic -O ReleaseFast -femit-bin=reaper_zig.so hello_world.zig

const std = @import("std");
const ImGui = @import("reaper_imgui.zig");
const Reaper = @import("reaper.zig");
const reaper = Reaper.reaper;
const control_surface = @import("csurf/control_surface.zig");
const Allocator = std.mem.Allocator;
const ControllerConfig = @import("internals/ControllerConfigLoader.zig");
const appInit = @import("internals/init.zig");

const plugin_name = "Hello, Zig!";
var action_id: c_int = undefined;
var init_action_id: c_int = undefined;

var ctx: ImGui.ContextPtr = null;
var click_count: u32 = 0;
var text = std.mem.zeroes([255:0]u8);

var gpa_int = std.heap.GeneralPurposeAllocator(.{}){};
const gpa = gpa_int.allocator();

fn loop() !void {
    if (ctx == null) {
        try ImGui.init(reaper.plugin_getapi);
        ctx = try ImGui.CreateContext(.{plugin_name});
    }

    try ImGui.SetNextWindowSize(.{ ctx, 400, 80, ImGui.Cond_FirstUseEver });

    var open: bool = true;
    if (try ImGui.Begin(.{ ctx, plugin_name, &open })) {
        if (try ImGui.Button(.{ ctx, "Click me!" }))
            click_count +%= 1;

        if (click_count & 1 != 0) {
            try ImGui.SameLine(.{ctx});
            try ImGui.Text(.{ ctx, "\\o/" });
        }

        _ = try ImGui.InputText(.{ ctx, "text input", &text, text.len });
        try ImGui.End(.{ctx});
    }

    if (!open)
        reset();
}

fn init() void {
    _ = reaper.plugin_register("timer", @constCast(@ptrCast(&onTimer)));
}

fn reset() void {
    _ = reaper.plugin_register("-timer", @constCast(@ptrCast(&onTimer)));
    ctx = null;
}

fn onTimer() callconv(.C) void {
    loop() catch {
        reset();
        _ = reaper.ShowMessageBox(ImGui.last_error.?, plugin_name, 0);
    };
}

fn onCommand(sec: *reaper.KbdSectionInfo, command: c_int, val: c_int, val2hw: c_int, relmode: c_int, hwnd: reaper.HWND) callconv(.C) c_char {
    _ = .{ sec, val, val2hw, relmode, hwnd };

    if (command == action_id) {
        if (ctx == null) init() else reset();
        return 1;
    }

    return 0;
}

fn onInitCommand(sec: *reaper.KbdSectionInfo, command: c_int, val: c_int, val2hw: c_int, relmode: c_int, hwnd: reaper.HWND) callconv(.C) c_char {
    _ = .{ sec, val, val2hw, relmode, hwnd };
    std.debug.print("{any}\n", .{init_action_id});

    if (command == init_action_id) {
        appInit.init(gpa) catch |err| {
            switch (err) {
                appInit.InitError.RealearnNotInstalled => {
                    _ = reaper.MB("Realearn not found. Please install realearn using reapack", "Error", 0);
                    return 0;
                },
                else => {
                    return 0;
                },
            }
        };
        return 1;
    }

    return 0;
}
// to implement the csurf interface, you'd probably want to do that from C++ instead of Zig to not have to deal with ABI headaches...
// eg. the C++ csurf implementation just forwarding the calls to extern "C" functions implemented in Zig

export fn ReaperPluginEntry(instance: reaper.HINSTANCE, rec: ?*reaper.plugin_info_t) c_int {
    _ = instance;

    if (rec == null) {
        return 0; // cleanup here
    } else if (!reaper.init(rec.?)) {
        return 0;
    }

    reaper.ShowConsoleMsg("Hello, Zig!\n");
    // Define the opaque struct to represent IReaperControlSurface
    const myCsurf = control_surface.init();
    if (myCsurf == null) {
        std.debug.print("Failed to create fake csurf\n", .{});
        return 0;
    }
    appInit.init(gpa) catch |err| {
        switch (err) {
            appInit.InitError.RealearnNotInstalled => {
                std.debug.print("Realearn not found. Please install realearn using reapack", .{});
            },
            else => {
                std.debug.print("other err\n", .{});
            },
        }
    };
    std.debug.print("registering\n", .{});
    _ = reaper.plugin_register("csurf_inst", myCsurf.?);

    const action = reaper.custom_action_register_t{ .section = 0, .id_str = "REAIMGUI_ZIG", .name = "ReaImGui Zig example" };
    action_id = reaper.plugin_register("custom_action", @constCast(@ptrCast(&action)));
    _ = reaper.plugin_register("hookcommand2", @constCast(@ptrCast(&onCommand)));

    const init_action = reaper.custom_action_register_t{ .section = 0, .id_str = "ZIG_INIT", .name = "zig init" };
    init_action_id = reaper.plugin_register("custom_action", @constCast(@ptrCast(&init_action)));
    _ = reaper.plugin_register("hookcommand2", @constCast(@ptrCast(&onInitCommand)));
    std.debug.print("actions registered: {d} {d}\n", .{ action_id, init_action_id });
    return 1;
}

test {
    std.testing.refAllDecls(@This());
}
