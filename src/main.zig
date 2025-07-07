const rl = @import("raylib");
const std = @import("std");

// project imports
const world_struct = @import("world.zig");

const Vector2 = rl.Vector2;
pub const Actor = struct { name: [:0]const u8, char: u8 };

const Config = struct {
    const SCREEN_WIDTH = 800;
    const SCREEN_HEIGHT = 450;
    const FPS = 120;
    const GRID_SIZE = 10;
    const CELL_SIZE = 20;
    const OFFSET_X = 50;
    const OFFSET_Y = 50;
};

fn initWindow() void {
    rl.initWindow(Config.SCREEN_WIDTH, Config.SCREEN_HEIGHT, "Hewooo!!~");
    rl.setTargetFPS(Config.FPS);
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    initWindow();
    defer rl.closeWindow();

    var world = try world_struct.world.init(allocator, Config.GRID_SIZE, Config.GRID_SIZE);
    defer world.deinit(allocator);

    const avi = Actor{ .name = "Avi", .char = '@' };

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.black);

        try world.placeActor(5, 5, avi, avi.char);
        world.draw();
    }
}
