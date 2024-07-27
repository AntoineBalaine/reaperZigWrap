const std = @import("std");
const config = @import("config.zig");
const ModulesList = config.ModulesList;
const ini = @import("ini");

// Trk only carries action buttons, so no need to map them
const Trk = enum {
    Tr_ext_sidechain,
    Tr_order,
    Tr_pg_dn,
    Tr_pg_up,
    Tr_tr1,
    Tr_tr10,
    Tr_tr11,
    Tr_tr12,
    Tr_tr13,
    Tr_tr14,
    Tr_tr15,
    Tr_tr16,
    Tr_tr17,
    Tr_tr18,
    Tr_tr19,
    Tr_tr2,
    Tr_tr20,
    Tr_tr3,
    Tr_tr4,
    Tr_tr5,
    Tr_tr6,
    Tr_tr7,
    Tr_tr8,
    Tr_tr9,
    Tr_tr_copy,
    Tr_tr_grp,
};

const Comp = struct {
    Comp_Attack: u8,
    Comp_DryWet: u8,
    Comp_Ratio: u8,
    Comp_Release: u8,
    Comp_Thresh: u8,
    Comp_comp: u8,
    // Comp_Mtr : u8,
    pub fn init() Comp {
        return .{
            .Comp_Attack = 0,
            .Comp_DryWet = 0,
            .Comp_Ratio = 0,
            .Comp_Release = 0,
            .Comp_Thresh = 0,
            .Comp_comp = 0,
        };
    }
};
const Eq = struct {
    Eq_HiFrq: u8,
    Eq_HiGain: u8,
    Eq_HiMidFrq: u8,
    Eq_HiMidGain: u8,
    Eq_HiMidQ: u8,
    Eq_LoFrq: u8,
    Eq_LoGain: u8,
    Eq_LoMidFrq: u8,
    Eq_LoMidGain: u8,
    Eq_LoMidQ: u8,
    Eq_eq: u8,
    Eq_hp_shape: u8,
    Eq_lp_shape: u8,
    pub fn init() Eq {
        return .{
            .Eq_HiFrq = 0,
            .Eq_HiGain = 0,
            .Eq_HiMidFrq = 0,
            .Eq_HiMidGain = 0,
            .Eq_HiMidQ = 0,
            .Eq_LoFrq = 0,
            .Eq_LoGain = 0,
            .Eq_LoMidFrq = 0,
            .Eq_LoMidGain = 0,
            .Eq_LoMidQ = 0,
            .Eq_eq = 0,
            .Eq_hp_shape = 0,
            .Eq_lp_shape = 0,
        };
    }
};
const Inpt = struct {
    // Inpt_MtrLft : u8,
    // Inpt_MtrRgt : u8,
    Inpt_Gain: u8,
    Inpt_HiCut: u8,
    Inpt_LoCut: u8,
    Inpt_disp_mode: u8,
    Inpt_disp_on: u8,
    Inpt_filt_to_comp: u8,
    Inpt_phase_inv: u8,
    Inpt_preset: u8,
    pub fn init() Inpt {
        return .{
            .Inpt_Gain = 0,
            .Inpt_HiCut = 0,
            .Inpt_LoCut = 0,
            .Inpt_disp_mode = 0,
            .Inpt_disp_on = 0,
            .Inpt_filt_to_comp = 0,
            .Inpt_phase_inv = 0,
            .Inpt_preset = 0,
        };
    }
};
const Outpt = struct {
    Out_Drive: u8,
    Out_DriveChar: u8,
    // Out_MtrLft : u8,
    // Out_MtrRgt : u8,
    Out_Pan: u8,
    Out_Vol: u8,
    // Out_mute : u8,
    // Out_solo : u8,
    pub fn init() Outpt {
        return .{
            .Out_Drive = 0,
            .Out_DriveChar = 0,
            .Out_Pan = 0,
            .Out_Vol = 0,
        };
    }
};
const Shp = struct {
    Shp_Gate: u8,
    Shp_GateRelease: u8,
    Shp_Punch: u8,
    Shp_hard_gate: u8,
    Shp_shape: u8,
    Shp_sustain: u8,
    pub fn init() Shp {
        return .{
            .Shp_Gate = 0,
            .Shp_GateRelease = 0,
            .Shp_Punch = 0,
            .Shp_hard_gate = 0,
            .Shp_shape = 0,
            .Shp_sustain = 0,
        };
    }
};

// FIXME: is there anyway the mapping portion of the tuple could be a pointer?
// should it be a pointer?
// upon selecting new track, the mapping is looked-up in the config.
// if found, it ought to be copied.
// else, it ought to be found read from fs, stored in config, and copied as well.
// Is the copy going to be costing a lot?
/// FxMap associates an Fx index with a module map
pub const FxMap = struct {
    COMP: ?std.meta.Tuple(&.{ u8, ?Comp }),
    EQ: ?std.meta.Tuple(&.{ u8, ?Eq }),
    INPUT: ?std.meta.Tuple(&.{ u8, ?Inpt }),
    OUTPT: ?std.meta.Tuple(&.{ u8, ?Outpt }),
    GATE: ?std.meta.Tuple(&.{ u8, ?Shp }),
    // Trk: std.meta.Tuple(&.{ u8, Trk }),
    pub fn init() FxMap {
        return .{
            .COMP = null,
            .EQ = null,
            .INPUT = null,
            .OUTPT = null,
            .GATE = null,
        };
    }
};

const TaggedMapping = union(ModulesList) {
    INPUT: ?Inpt,
    GATE: ?Shp,
    EQ: ?Eq,
    COMP: ?Comp,
    OUTPT: ?Outpt,
};

const MapStore = @This();

COMP: std.StringHashMapUnmanaged(Comp),
EQ: std.StringHashMapUnmanaged(Eq),
INPUT: std.StringHashMapUnmanaged(Inpt),
OUTPT: std.StringHashMapUnmanaged(Outpt),
GATE: std.StringHashMapUnmanaged(Shp),
controller_dir: *const []const u8,
allocator: std.mem.Allocator,
// TRK: std.StringHashMap(Trk),
pub fn init(allocator: std.mem.Allocator, defaults: *std.EnumArray(ModulesList, [:0]const u8), controller_dir: *const []const u8) MapStore {
    var self: MapStore = .{
        .COMP = std.StringHashMapUnmanaged(Comp){},
        .EQ = std.StringHashMapUnmanaged(Eq){},
        .INPUT = std.StringHashMapUnmanaged(Inpt){},
        .OUTPT = std.StringHashMapUnmanaged(Outpt){},
        .GATE = std.StringHashMapUnmanaged(Shp){},
        .controller_dir = controller_dir,
        .allocator = allocator,
    };
    // find the mappings for the defaults
    var iterator = defaults.iterator();
    while (iterator.next()) |module| {
        const fxName = module.value;
        const mapping = self.getMap(fxName.*, module.key, controller_dir) catch {
            continue;
        };
        switch (mapping) {
            .COMP => |opt| if (opt) |v| self.COMP.put(self.allocator, fxName.*, v) catch {},
            .EQ => |opt| if (opt) |v| self.EQ.put(self.allocator, fxName.*, v) catch {},
            .INPUT => |opt| if (opt) |v| self.INPUT.put(self.allocator, fxName.*, v) catch {},
            .OUTPT => |opt| if (opt) |v| self.OUTPT.put(self.allocator, fxName.*, v) catch {},
            .GATE => |opt| if (opt) |v| self.GATE.put(self.allocator, fxName.*, v) catch {},
        }
    }
    return self;
}

// FIXME: not sure if I need to do any freeing here.
pub fn deinit(self: *MapStore) void {
    _ = self; // autofix
    // don't de-init the allocator here.
    // don't de-init the controller_dir here
    // don't de-init the hashmaps, they're un-managed?
    // for (std.meta.fields(@TypeOf(self))) |field| {
    //     const map = @field(self, field.name);
    //     if (!std.mem.eql(field.name, "controller_dir") and !std.mem.eql(field.name, "allocator")) {
    //         var iterator = map.iterator();
    //         while (iterator.next()) |entry| {
    //             self.allocator.free(entry);
    //         }
    //     }
    // }
}

pub fn get(self: *MapStore, module: ModulesList, fxName: [:0]const u8) TaggedMapping {
    return switch (module) {
        .COMP => if (self.COMP.get(fxName)) |v| TaggedMapping{ .COMP = v } else self.getMap(fxName, module, self.controller_dir) catch TaggedMapping{ .COMP = null },
        .EQ => if (self.EQ.get(fxName)) |v| TaggedMapping{ .EQ = v } else self.getMap(fxName, module, self.controller_dir) catch TaggedMapping{ .EQ = null },
        .INPUT => if (self.INPUT.get(fxName)) |v| TaggedMapping{ .INPUT = v } else self.getMap(fxName, module, self.controller_dir) catch TaggedMapping{ .INPUT = null },
        .OUTPT => if (self.OUTPT.get(fxName)) |v| TaggedMapping{ .OUTPT = v } else self.getMap(fxName, module, self.controller_dir) catch TaggedMapping{ .OUTPT = null },
        .GATE => if (self.GATE.get(fxName)) |v| TaggedMapping{ .GATE = v } else self.getMap(fxName, module, self.controller_dir) catch TaggedMapping{ .GATE = null },
    };
}

// FIXME: GETMAP should take care of storing into the map. This shouldn't be done by the init function
fn getMap(self: *MapStore, fxName: [:0]const u8, module: ModulesList, controller_dir: *const []const u8) !TaggedMapping {
    var buf: [std.fs.MAX_PATH_BYTES]u8 = undefined;
    const subdir = @tagName(module);
    const elements = [_][]const u8{ controller_dir.*, subdir, fxName };
    var pos: usize = 0;
    for (elements, 0..) |element, idx| {
        @memcpy(buf[pos..], subdir);
        pos += element.len;
        if (idx != elements.len - 1) { // not last in list
            @memcpy(buf[pos..], &[_]u8{@as(u8, @intCast(std.fs.path.sep))});
            pos += 1;
        }
    }
    const filePath = buf[0..pos];

    const file = try std.fs.openFileAbsolute(filePath, .{});
    defer file.close();
    var parser = ini.parse(self.allocator, file.reader());
    defer parser.deinit();

    const mapping: TaggedMapping = switch (module) {
        .COMP => {
            const comp = Comp.init();
            _ = try readToU8Struct(&comp, &parser);
            return TaggedMapping{ .COMP = comp };
        },
        .EQ => {
            var eq = Eq.init();
            _ = try readToU8Struct(&eq, &parser);
            return TaggedMapping{ .EQ = eq };
        },
        .INPUT => {
            var inpt: Inpt = Inpt.init();
            _ = try readToU8Struct(&inpt, &parser);
            return TaggedMapping{ .INPUT = inpt };
        },
        .OUTPT => {
            var outpt: Outpt = Outpt.init();
            _ = try readToU8Struct(&outpt, &parser);
            return TaggedMapping{ .OUTPT = outpt };
        },
        .GATE => {
            var shp: Shp = Shp.init();
            _ = try readToU8Struct(&shp, &parser);
            return TaggedMapping{ .GATE = shp };
        },
    };
    return mapping;
}

fn readToU8Struct(ret_struct: anytype, parser: anytype) !@TypeOf(ret_struct) {
    const T = @TypeOf(ret_struct.*);
    std.debug.assert(@typeInfo(T) == .Struct);

    while (try parser.*.next()) |record| {
        switch (record) {
            .property => |kv| {
                inline for (std.meta.fields(T)) |ns_info| {
                    if (std.mem.eql(u8, ns_info.name, kv.key)) {
                        if (@TypeOf(@field(ret_struct, ns_info.name)) == u8) {
                            var field = &@field(ret_struct, ns_info.name);
                            var parsed = try std.fmt.parseInt(u8, kv.value, 10);
                            field = &parsed;
                        }
                    }
                }
            },
            .section => {},
            .enumeration => {},
        }
    }
    return ret_struct;
}

test readToU8Struct {
    const expect = std.testing.expect;
    const allocator = std.testing.allocator;
    const ExampleStruct = struct {
        repositoryformatversion: u8,
    };
    const example =
        \\ 	repositoryformatversion = 0
    ;
    var fbs = std.io.fixedBufferStream(example);
    var parser = ini.parse(std.testing.allocator, fbs.reader());
    defer parser.deinit();

    const ret_str = ExampleStruct{
        .repositoryformatversion = 0,
    };
    const result = try readToU8Struct(&ret_str, &parser, allocator);
    try expect(result.repositoryformatversion == 0);
}
