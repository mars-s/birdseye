const std = @import("std");
const rl = @import("raylib");
const Vector2 = rl.Vector2;

const Actor = struct {
    name: []const u8,
    position: Vector2,
};

// Game state structure
const GameState = struct {
    screenWidth: i32,
    screenHeight: i32,
};

// Initialize game resources and state
fn onLoad() !GameState {
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "raylib-zig [core] example - basic window");
    rl.setTargetFPS(120);

    return GameState{
        .screenWidth = screenWidth,
        .screenHeight = screenHeight,
    };
}

// Update and render game frame
fn update(state: *GameState) void {
    state;
    // Process game logic
    const mousePosition = rl.getMousePosition();
    const x: i32 = @intFromFloat(mousePosition.x);
    const y: i32 = @intFromFloat(mousePosition.y);

    // Render
    rl.beginDrawing();
    defer rl.endDrawing();

    rl.clearBackground(.black);
    rl.drawCircle(x, y, 100, rl.Color.init(100, 100, 100, 255));
    rl.drawText("Congrats! You created your first window!", 190, 200, 20, .light_gray);
}

// Main game entry point
pub fn main() anyerror!void {
    var state = try onLoad();
    defer rl.closeWindow();

    // Game loop
    while (!rl.windowShouldClose()) {
        update(&state);
    }
}

// Helper function for controls (to be implemented)
fn loadControls() !void {
    // load wasd controls for the player
}
