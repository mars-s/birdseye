const std = @import("std");
const rl = @import("raylib");
const Vector2 = rl.Vector2;

const MULT: f32 = 100.0; // Multiplier for movement speed, can be adjusted

const Actor = struct { name: [:0]const u8, position: Vector2, sprite: rl.Texture2D };

fn loadControls(actor: *Actor) !void {
    if (rl.isKeyDown(.d)) actor.position.x += 2.0 * MULT * rl.getFrameTime();
    if (rl.isKeyDown(.a)) actor.position.x -= 2.0 * MULT * rl.getFrameTime();
    if (rl.isKeyDown(.w)) actor.position.y -= 2.0 * MULT * rl.getFrameTime(); // Note: Y-axis is inverted in screen coordinates
    if (rl.isKeyDown(.s)) actor.position.y += 2.0 * MULT * rl.getFrameTime(); // Down increases Y
}

pub fn main() anyerror!void {
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "BirdsEye Engine");
    defer rl.closeWindow();
    rl.setTargetFPS(120);

    // Create player outside the game loop
    var p1 = Actor{ .name = "Player", .position = Vector2{ .x = 400.0, .y = 225.0 }, .sprite = try rl.loadTexture("assets/Soldier.png") };

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();
        rl.clearBackground(.black);

        try loadControls(&p1);

        // Calculate centered position for sprite rendering
        const spriteWidth = 160.0;
        const spriteHeight = 160.0;
        const destRect = rl.Rectangle{
            .x = p1.position.x - spriteWidth / 2.0, // Center horizontally
            .y = p1.position.y - spriteHeight / 2.0, // Center vertically
            .width = spriteWidth,
            .height = spriteHeight,
        };

        // Source rectangle for the sprite (the part of the texture to use)
        const sourceRect = rl.Rectangle{ .x = 0, .y = 0, .width = 90, .height = 90 };

        // Origin point of the texture (for rotation)
        const origin = Vector2{ .x = 0.0, .y = 0.0 };

        // Draw the sprite at player's position
        rl.drawTexturePro(p1.sprite, sourceRect, destRect, origin, 0.0, .white);

        // Draw player name above the sprite
        rl.drawText(p1.name, @intFromFloat(p1.position.x - 30), @intFromFloat(p1.position.y - spriteHeight / 2 - 25), 20, .white);
    }
}
