const std = @import("std");
const rl = @import("raylib");
const Vector2 = rl.Vector2;

const Actor = struct {
    name: []const u8,
    position: Vector2,
};

fn loadControls() !void {
    // load wasd controls for the player
}

pub fn main() anyerror!void {
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "raylib-zig [core] example - basic window");
    defer rl.closeWindow();
    rl.setTargetFPS(120);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();
        rl.clearBackground(.black);

        const mousePosition = rl.getMousePosition();
        const x: i32 = @intFromFloat(mousePosition.x);
        const y: i32 = @intFromFloat(mousePosition.y);

        rl.drawCircle(x, y, 100, rl.Color.init(100, 100, 100, 255));
        rl.drawText("Congrats! You created your first window!", 190, 200, 20, .light_gray);
    }
}
