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

pub const Mode = enum {
    fx_ctrl,
    fx_sel,
};

pub const ActionId = enum {
    disp_on,
    disp_mode,
    shift,
    filt_to_comp,
    phase_inv,
    preset,
    pg_up,
    pg_dn,
    tr1,
    tr2,
    tr3,
    tr4,
    tr5,
    tr6,
    tr7,
    tr8,
    tr9,
    tr10,
    tr11,
    tr12,
    tr13,
    tr14,
    tr15,
    tr16,
    tr17,
    tr18,
    tr19,
    tr20,
    shape,
    hard_gate,
    eq,
    hp_shape,
    lp_shape,
    comp,
    tr_grp,
    tr_copy,
    order,
    ext_sidechain,
    solo,
    mute,
};

pub const Btns = std.EnumArray(ActionId, ?*const fn () void);

pub const controller = std.EnumArray(Mode, Btns).init(.{
    .fx_ctrl = Btns.init(.{
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
    }),
    .fx_sel = Btns.init(.{
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
    }),
});
