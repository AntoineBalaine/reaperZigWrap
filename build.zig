// zig build-lib -dynamic -O ReleaseFast -femit-bin=reaper_zig.so hello_world.zig -lc
// or use
// zig build --verbose && mv zig-out/lib/reaper_zig.so ~/.config/REAPER/UserPlugins/ && reaper
// sudo zig build --verbose && mv zig-out/lib/reaper_zig.dylib ~/Library/Application\ Support/REAPER/UserPlugins
const std = @import("std");
const builtin = @import("builtin");
const tests = @import("build_tests.zig");
pub const Dependencies = struct {
    ini: *std.Build.Dependency,
};

pub fn build(b: *std.Build) !void {
    // Create a library target
    const target = b.standardTargetOptions(.{});

    const lib = b.addSharedLibrary(.{ .name = "reaper_zig", .root_source_file = b.path("src/hello_world.zig"), .target = target, .optimize = .Debug });

    const root = b.path("./src/");
    lib.addIncludePath(root);

    var client_install: *std.Build.Step.InstallArtifact = undefined;

    // create the file, call the resgen shell script, and then proceed with the rest
    // WDL/snwell/swell_resgen.php resource.rc generates resource.rc_mac_dlg and .rc_mac_menu
    // which must be compiled and linked into the executable
    // touch src/csurf/resource.rc && ./WDL/swell/swell_resgen.sh src/csurf/resource.rc
    var file = std.fs.cwd().createFile("src/csurf/resource.rc", .{ .exclusive = true }) catch |e|
        switch (e) {
        error.PathAlreadyExists => null,
        else => return e,
    };
    if (file != null) file.?.close();
    const php_cmd = b.addSystemCommand(&[_][]const u8{"bash"});
    php_cmd.addFileArg(b.path("./WDL/swell/swell_resgen.sh"));
    php_cmd.addArg("src/csurf/resource.rc");
    php_cmd.expectExitCode(0);

    const cpp_cmd = b.addSystemCommand(&[_][]const u8{ "gcc", "-o" });
    cpp_cmd.step.dependOn(&php_cmd.step);

    const cpp_lib = cpp_cmd.addOutputFileArg("control_surface.o");

    if (target.result.isDarwin()) {
        lib.root_module.linkFramework("AppKit", .{});
        cpp_cmd.addArgs(&.{"WDL/swell/swell-modstub.mm"});
        client_install = b.addInstallArtifact(lib, .{ .dest_sub_path = "reaper_zig.dylib" });
    } else {
        cpp_cmd.addArgs(&.{"WDL/swell/swell-modstub-generic.cpp"});
        client_install = b.addInstallArtifact(lib, .{ .dest_sub_path = "reaper_zig.so" });
    }

    cpp_cmd.addArgs(&.{ "src/csurf/control_surface.cpp", "src/csurf/control_surface_wrapper.cpp", "-fPIC", "-O2", "-std=c++14", "-shared", "-IWDL/WDL", "-DSWELL_PROVIDED_BY_APP" });
    lib.addObjectFile(cpp_lib);
    lib.linkLibC();

    b.getInstallStep().dependOn(&client_install.step);

    // add dependencies: ini parser, etc.
    const ini = b.dependency("ini", .{ .target = target, .optimize = .Debug });
    lib.root_module.addImport("ini", ini.module("ini"));

    _ = tests.addTests(b, target, Dependencies{ .ini = ini });
    // Default step for building
    const step = b.step("default", "Build reaper_zig.so");
    step.dependOn(&lib.step);
}
