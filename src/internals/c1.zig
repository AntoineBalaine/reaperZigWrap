const std = @import("std");

const actions = struct {
    pub fn selectTrackOnPage(trackNumber: u8) void {
        _ = trackNumber;
    }
    pub fn cycleControllerMode() void {} // go to next controller mode
    pub fn cycleFxReorder() void {}
    pub fn cycleGateMode() void {}
    pub fn cycleHPShape() void {}
    pub fn cycleLPShape() void {}
    pub fn focus_next_page() void {}
    pub fn focus_prev_page() void {}
    pub fn toggleCmp() void {}
    pub fn toggleDisplay() void {}
    pub fn toggleEQ() void {}
    pub fn toggleShape() void {}
    pub fn toggleSelectedTrackPhase() void {}
    pub fn toggleShift() void {}
    pub fn trackMute() void {}
    pub fn trackSolo() void {}
    pub fn prefs_showStartUpMessage() void {}
    pub fn prefs_showFeedbackWindow() void {}
    pub fn prefs_showPluginUi() void {}
    pub fn prefs_save() void {}
    pub fn sel_dispEqOpts() void {}
    pub fn sel_dispShpOpts() void {}
    pub fn sel_dispCmpOpts() void {}
    pub fn sel_dispGateOpts() void {}
    pub fn sel_slot(slotId: u8) void {
        _ = slotId;
    }
};
// const truthyAndFalsy = std.ComptimeStringMap(bool, .{ .{ "true", true }, .{ "false", false }, .{ "1", true }, .{ "0", false } });

// fn genMap(T: type, allocator: std.mem.Allocator) !std.StaticStringMap {
//     if (@typeInfo(T) != .Struct) {
//         @compileError("genMap requires a struct.");
//     }
//     const arr = std.ArrayList(.{
//         []const u8,
//     }).init(allocator);
//     inline for (std.meta.fields(T)) |field| {
//         const field_name = field.name;
//         arr.append(.{ field_name, @field(T, field_name) });
//     }
//     return std.StaticStringMap(Btns).initComptime(arr.items);
// }

// const map = std.StaticStringMap(Btns).initComptime(.{
//     .{ "disp_on", Btns.disp_on },
//     .{ "disp_mode", Btns.disp_mode },
//     .{ "shift", Btns.shift },
//     .{ "filt_to_comp", Btns.filt_to_comp },
//     .{ "phase_inv", Btns.phase_inv },
//     .{ "preset", Btns.preset },
//     .{ "pg_up", Btns.pg_up },
//     .{ "pg_dn", Btns.pg_dn },
//     .{ "tr1", Btns.tr1 },
//     .{ "tr2", Btns.tr2 },
//     .{ "tr3", Btns.tr3 },
//     .{ "tr4", Btns.tr4 },
//     .{ "tr5", Btns.tr5 },
//     .{ "tr6", Btns.tr6 },
//     .{ "tr7", Btns.tr7 },
//     .{ "tr8", Btns.tr8 },
//     .{ "tr9", Btns.tr9 },
//     .{ "tr10", Btns.tr10 },
//     .{ "tr11", Btns.tr11 },
//     .{ "tr12", Btns.tr12 },
//     .{ "tr13", Btns.tr13 },
//     .{ "tr14", Btns.tr14 },
//     .{ "tr15", Btns.tr15 },
//     .{ "tr16", Btns.tr16 },
//     .{ "tr17", Btns.tr17 },
//     .{ "tr18", Btns.tr18 },
//     .{ "tr19", Btns.tr19 },
//     .{ "tr20", Btns.tr20 },
//     .{ "shape", Btns.shape },
//     .{ "hard_gate", Btns.hard_gate },
//     .{ "eq", Btns.eq },
//     .{ "hp_shape", Btns.hp_shape },
//     .{ "lp_shape", Btns.lp_shape },
//     .{ "comp", Btns.comp },
//     .{ "tr_grp", Btns.tr_grp },
//     .{ "tr_copy", Btns.tr_copy },
//     .{ "order", Btns.order },
//     .{ "ext_sidechain", Btns.ext_sidechain },
//     .{ "solo", Btns.solo },
//     .{ "mute", Btns.mute },
// });

const Btns = struct {
    disp_on: ?*const fn () void,
    disp_mode: ?*const fn () void,
    shift: ?*const fn () void,
    filt_to_comp: ?*const fn () void,
    phase_inv: ?*const fn () void,
    preset: ?*const fn () void,
    pg_up: ?*const fn () void,
    pg_dn: ?*const fn () void,
    tr1: ?*const fn () void,
    tr2: ?*const fn () void,
    tr3: ?*const fn () void,
    tr4: ?*const fn () void,
    tr5: ?*const fn () void,
    tr6: ?*const fn () void,
    tr7: ?*const fn () void,
    tr8: ?*const fn () void,
    tr9: ?*const fn () void,
    tr10: ?*const fn () void,
    tr11: ?*const fn () void,
    tr12: ?*const fn () void,
    tr13: ?*const fn () void,
    tr14: ?*const fn () void,
    tr15: ?*const fn () void,
    tr16: ?*const fn () void,
    tr17: ?*const fn () void,
    tr18: ?*const fn () void,
    tr19: ?*const fn () void,
    tr20: ?*const fn () void,
    shape: ?*const fn () void,
    hard_gate: ?*const fn () void,
    eq: ?*const fn () void,
    hp_shape: ?*const fn () void,
    lp_shape: ?*const fn () void,
    comp: ?*const fn () void,
    tr_grp: ?*const fn () void,
    tr_copy: ?*const fn () void,
    order: ?*const fn () void,
    ext_sidechain: ?*const fn () void,
    solo: ?*const fn () void,
    mute: ?*const fn () void,
};
const CTRLR = struct {
    fx_ctrl: Btns,
    fx_selection_display: Btns,
};

pub const c1 = CTRLR{
    .fx_ctrl = Btns{
        .disp_on = actions.toggleDisplay,
        .disp_mode = actions.cycleControllerMode,
        .shift = actions.toggleShift,
        .filt_to_comp = null,
        .phase_inv = actions.toggleSelectedTrackPhase,
        .preset = null,
        .pg_up = null,
        .pg_dn = null,
        .tr1 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(1);
            }
        }.action,
        .tr2 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(2);
            }
        }.action,
        .tr3 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(3);
            }
        }.action,
        .tr4 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(4);
            }
        }.action,
        .tr5 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(5);
            }
        }.action,
        .tr6 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(6);
            }
        }.action,
        .tr7 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(7);
            }
        }.action,
        .tr8 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(8);
            }
        }.action,
        .tr9 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(9);
            }
        }.action,
        .tr10 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(10);
            }
        }.action,
        .tr11 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(11);
            }
        }.action,
        .tr12 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(12);
            }
        }.action,
        .tr13 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(13);
            }
        }.action,
        .tr14 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(14);
            }
        }.action,
        .tr15 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(15);
            }
        }.action,
        .tr16 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(16);
            }
        }.action,
        .tr17 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(17);
            }
        }.action,
        .tr18 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(18);
            }
        }.action,
        .tr19 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(19);
            }
        }.action,
        .tr20 = struct {
            pub fn action() void {
                return actions.selectTrackOnPage(20);
            }
        }.action,
        .shape = actions.toggleShape,
        .hard_gate = actions.cycleGateMode,
        .eq = actions.toggleEQ,
        .hp_shape = actions.cycleHPShape,
        .lp_shape = actions.cycleLPShape,
        .comp = actions.toggleCmp,
        .tr_grp = null,
        .tr_copy = null,
        .order = actions.cycleFxReorder,
        .ext_sidechain = null,
        .solo = actions.trackSolo,
        .mute = actions.trackMute,
    },
    .fx_selection_display = .{
        .disp_on = null,
        .disp_mode = actions.cycleControllerMode,
        .shift = null,
        .filt_to_comp = null,
        .phase_inv = null,
        .preset = null,
        .pg_up = null,
        .pg_dn = null,
        .tr1 = struct {
            pub fn action() void {
                actions.sel_slot(1);
            }
        }.action,
        .tr2 = struct {
            pub fn action() void {
                actions.sel_slot(2);
            }
        }.action,
        .tr3 = struct {
            pub fn action() void {
                actions.sel_slot(3);
            }
        }.action,
        .tr4 = struct {
            pub fn action() void {
                actions.sel_slot(4);
            }
        }.action,
        .tr5 = struct {
            pub fn action() void {
                actions.sel_slot(5);
            }
        }.action,
        .tr6 = struct {
            pub fn action() void {
                actions.sel_slot(6);
            }
        }.action,
        .tr7 = struct {
            pub fn action() void {
                actions.sel_slot(7);
            }
        }.action,
        .tr8 = struct {
            pub fn action() void {
                actions.sel_slot(8);
            }
        }.action,
        .tr9 = struct {
            pub fn action() void {
                actions.sel_slot(9);
            }
        }.action,
        .tr10 = struct {
            pub fn action() void {
                actions.sel_slot(10);
            }
        }.action,
        .tr11 = struct {
            pub fn action() void {
                actions.sel_slot(11);
            }
        }.action,
        .tr12 = struct {
            pub fn action() void {
                actions.sel_slot(12);
            }
        }.action,
        .tr13 = struct {
            pub fn action() void {
                actions.sel_slot(13);
            }
        }.action,
        .tr14 = struct {
            pub fn action() void {
                actions.sel_slot(14);
            }
        }.action,
        .tr15 = struct {
            pub fn action() void {
                actions.sel_slot(15);
            }
        }.action,
        .tr16 = struct {
            pub fn action() void {
                actions.sel_slot(16);
            }
        }.action,
        .tr17 = struct {
            pub fn action() void {
                actions.sel_slot(17);
            }
        }.action,
        .tr18 = struct {
            pub fn action() void {
                actions.sel_slot(18);
            }
        }.action,
        .tr19 = struct {
            pub fn action() void {
                actions.sel_slot(19);
            }
        }.action,
        .tr20 = struct {
            pub fn action() void {
                actions.sel_slot(20);
            }
        }.action,
        .shape = actions.sel_dispShpOpts,
        .hard_gate = null,
        .eq = actions.sel_dispEqOpts,
        .hp_shape = null,
        .lp_shape = null,
        .comp = actions.sel_dispCmpOpts,
        .tr_grp = null,
        .tr_copy = null,
        .order = null,
        .ext_sidechain = null,
        .solo = null,
        .mute = null,
    },
};

test "re-use callbacks in struct" {
    const dummy_actions = struct {
        pub fn do_smth(prm: u8) u8 {
            return prm;
        }
    };
    const my_struct = .{
        .tr1 = struct {
            pub fn action() u8 {
                return dummy_actions.do_smth(1);
            }
        }.action,
    };
    try std.testing.expectEqual(my_struct.tr1(), 1);
}

test "check method types" {
    const t = c1.fx_ctrl.shape.?.*;
    const info = @typeInfo(@TypeOf(t));
    try std.testing.expect(info == .Fn);
}
