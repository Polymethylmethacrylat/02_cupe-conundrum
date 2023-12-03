const std = @import("std");
const testing = std.testing;
const print = std.debug.print;

pub fn main() !void {}

const key = .{
    .red = @as(usize, 12),
    .green = @as(usize, 13),
    .blue = @as(usize, 14),
};

test "simple test" {
    const file =
        \\Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        \\Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        \\Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        \\Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        \\Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    ;

    var line: usize = 0;
    var num: ?usize = null;
    var sum: usize = 0;
    var count = .{
        .red = @as(usize, 0),
        .green = @as(usize, 0),
        .blue = @as(usize, 0),
    };
    var data = false;

    for (file) |c| {
        if (c == '\n') {
            inline for (@typeInfo(@Type(count)).Struct.fields) |field| {
                if (@field(count, field.name) > @field(key, field.name))
                    break;
            } else sum += line;
            line += 1;
            num = null;
            count = .{ .red = 0, .green = 0, .blue = 0 };
            data = false;
            continue;
        }
        if (c == ':') {
            data = true;
            continue;
        }
        if (!data) {
            continue;
        }
    }
}
