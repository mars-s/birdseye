const rl = @import("raylib");
const std = @import("std");

const Vector2 = rl.Vector2;
const Actor = struct { name: [:0]u8, position: Vector2 };

pub fn main() anyerror!void {
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "Hewooo!!~");
    defer rl.closeWindow();
    rl.setTargetFPS(120);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();
        rl.clearBackground(.black);
    }
}
