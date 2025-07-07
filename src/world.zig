const rl = @import("raylib");
const std = @import("std");
const t_actor = @import("main.zig");

pub const world = struct {
    width: usize,
    height: usize,
    data: []u8, // flat array for 2D data - stores symbols/IDs
    actors: std.ArrayList(t_actor.Actor), // separate array for actual actors
    const cellSize = 20;
    const offsetX = 50;
    const offsetY = 50;

    pub fn init(alloc: std.mem.Allocator, width: usize, height: usize) !world {
        const total = width * height;
        const data = try alloc.alloc(u8, total);
        for (data) |*cell| cell.* = '.';

        return world{
            .width = width,
            .height = height,
            .data = data,
            .actors = std.ArrayList(t_actor.Actor).init(alloc),
        };
    }

    pub fn deinit(self: *world, alloc: std.mem.Allocator) void {
        alloc.free(self.data);
        self.actors.deinit();
    }

    pub fn at(self: *world, x: usize, y: usize) *u8 {
        return &self.data[y * self.width + x];
    }

    pub fn draw(self: *world) void {
        for (0..self.height) |y| {
            for (0..self.width) |x| {
                const ch = self.at(x, y).*;
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

    pub fn placeActor(self: *world, x: u8, y: u8, actor: t_actor.Actor, symbol: u8) !void {
        try self.actors.append(actor);
        self.at(x, y).* = symbol;
    }
};
