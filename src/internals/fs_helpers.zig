const std = @import("std");
const reaper = @import("../reaper.zig").reaper;
const Allocator = std.mem.Allocator;

/// caller must free
pub fn getControllerConfigPath(allocator: Allocator, controller_name: [*:0]const u8) ![]const u8 {
    const resourcePath = reaper.GetResourcePath();
    const paths = [_][]const u8{ std.mem.sliceTo(resourcePath, 0), "Data", "Perken", "Controllers", std.mem.span(controller_name) };
    const file_path = try std.fs.path.join(allocator, &paths);
    return file_path;
}

/// caller must free
/// get length of file, allocate a buffer on length, and read into it.
pub fn readFile(allocator: Allocator, abs_path: []const u8) ![]u8 {

    // Open the file
    const file = try std.fs.openFileAbsolute(abs_path, .{});
    defer file.close();
    // get length of file and read to end
    const len = try file.getEndPos();
    const buffer = try allocator.alloc(u8, len);
    const read_len = try file.readAll(buffer);
    _ = read_len;
    return buffer;
}
