const rl = @import("raylib");
const std = @import("std");

const Vector2 = rl.Vector2;
const Actor = struct { name: [:0]u8, position: Vector2 };

const World = struct {
    width: usize,
    height: usize,
    data: []u8, // flat array for 2D data

    pub fn init(alloc: std.mem.Allocator, width: usize, height: usize) !World {
        const total = width * height;
        const data = try alloc.alloc(u8, total);
        for (data) |*cell| cell.* = '.';

        return World{ .width = width, .height = height, .data = data };
    }

    pub fn deinit(self: *World, alloc: std.mem.Allocator) void {
        alloc.free(self.data);
    }

    pub fn at(self: *World, x: usize, y: usize) *u8 {
        return &self.data[y * self.width + x];
    }
};

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "Hewooo!!~");
    defer rl.closeWindow();
    rl.setTargetFPS(60);

    const gridSize = 10;
    const cellSize = 20;
    const offsetX = 50;
    const offsetY = 50;

    var world = try World.init(allocator, gridSize, gridSize);
    defer world.deinit(allocator);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();
        rl.clearBackground(.black);

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
}
