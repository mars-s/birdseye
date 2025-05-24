const std = @import("std");
const rl = @import("raylib");
const Vector2 = rl.Vector2;

const MULT: f32 = 70.0; // Multiplier for movement speed, can be adjusted

const Actor = struct {
    name: [:0]const u8,
    position: Vector2,
};

fn loadControls(actor: *Actor) !void {
    if (rl.isKeyDown(.right)) actor.position.x += 2.0 * MULT * rl.getFrameTime();
    if (rl.isKeyDown(.left)) actor.position.x -= 2.0 * MULT * rl.getFrameTime();
    if (rl.isKeyDown(.up)) actor.position.y -= 2.0 * MULT * rl.getFrameTime(); // Note: Y-axis is inverted in screen coordinates
    if (rl.isKeyDown(.down)) actor.position.y += 2.0 * MULT * rl.getFrameTime(); // Down increases Y
}

pub fn main() anyerror!void {
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "BirdsEye Engine");
    defer rl.closeWindow();
    rl.setTargetFPS(120);

    // Create player outside the game loop
    var p1 = Actor{
        .name = "Player",
        .position = Vector2{ .x = 400.0, .y = 225.0 },
    };

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();
        rl.clearBackground(.black);

        try loadControls(&p1);
        rl.drawText(p1.name, @intFromFloat(p1.position.x), @intFromFloat(p1.position.y), 20, .white);
    }
}
