const rl = @import("raylib");
const std = @import("std");
const world_struct = @import("world.zig");

const Vector2 = rl.Vector2;
const Actor = struct { name: [:0]u8, position: Vector2 };

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

    var world = try world_struct.world.init(allocator, gridSize, gridSize);
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
