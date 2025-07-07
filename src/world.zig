const rl = @import("raylib");
const std = @import("std");

pub const world = struct {
    width: usize,
    height: usize,
    data: []u8, // flat array for 2D data

    pub fn init(alloc: std.mem.Allocator, width: usize, height: usize) !world {
        const total = width * height;
        const data = try alloc.alloc(u8, total);
        for (data) |*cell| cell.* = '.';

        return world{ .width = width, .height = height, .data = data };
    }

    pub fn deinit(self: *world, alloc: std.mem.Allocator) void {
        alloc.free(self.data);
    }

    pub fn at(self: *world, x: usize, y: usize) *u8 {
        return &self.data[y * self.width + x];
    }

    pub fn draw(self: *world) void {
        for (0..gridSize) |y| {
            for (0..gridSize) |x| {
                const ch = world.at(x, y).*;
                var buf: [2]u8 = [_]u8{ ch, 0 };

                rl.drawText(
                    @ptrCast(&buf),
                    @intCast(offsetX + x * cellSize),
                    @intCast(offsetY + y * cellSize),
                    20,
                    .white,
                );
            }
        }
    }
};
