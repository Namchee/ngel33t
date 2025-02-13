const std = @import("std");

fn solution(board: [][9]u8) bool {
    var table = [_]bool{false} ** 9;

    // row check
    for (board) |rows| {
        @memset(&table, false);

        for (rows) |el| {
            if (el != '.') {
                const idx = el - '1';

                if (table[idx]) {
                    return false;
                }

                table[idx] = true;
            }
        }
    }

    // column check
    for (0..board[0].len) |col| {
        @memset(&table, false);

        for (0..board.len) |row| {
            const el = board[row][col];

            if (el != '.') {
                const idx = el - '1';

                if (table[idx]) {
                    return false;
                }

                table[idx] = true;
            }
        }
    }

    var row: usize = 0;
    var col: usize = 0;

    // group check
    while (row < board.len) : (row += 3) {
        while (col < board[row].len) : (col += 3) {
            @memset(&table, false);

            for (0..3) |rowInc| {
                for (0..3) |colInc| {
                    const el = board[row + rowInc][col + colInc];

                    if (el != '.') {
                        const idx = el - '1';

                        if (table[idx]) {
                            return false;
                        }

                        table[idx] = true;
                    }
                }
            }
        }
    }

    return true;
}

const expect = std.testing.expect;

test "test case #1" {
    var input = [_][9]u8{
        .{ '5', '3', '.', '.', '7', '.', '.', '.', '.' },
        .{ '6', '.', '.', '1', '9', '5', '.', '.', '.' },
        .{ '.', '9', '8', '.', '.', '.', '.', '6', '.' },
        .{ '8', '.', '.', '.', '6', '.', '.', '.', '3' },
        .{ '4', '.', '.', '8', '.', '3', '.', '.', '1' },
        .{ '7', '.', '.', '.', '2', '.', '.', '.', '6' },
        .{ '.', '6', '.', '.', '.', '.', '2', '8', '.' },
        .{ '.', '.', '.', '4', '1', '9', '.', '.', '5' },
        .{ '.', '.', '.', '.', '8', '.', '.', '7', '9' },
    };

    const sol = solution(&input);

    try expect(sol);
}

test "test case #2" {
    var input = [_][9]u8{
        .{ '8', '3', '.', '.', '7', '.', '.', '.', '.' },
        .{ '6', '.', '.', '1', '9', '5', '.', '.', '.' },
        .{ '.', '9', '8', '.', '.', '.', '.', '6', '.' },
        .{ '8', '.', '.', '.', '6', '.', '.', '.', '3' },
        .{ '4', '.', '.', '8', '.', '3', '.', '.', '1' },
        .{ '7', '.', '.', '.', '2', '.', '.', '.', '6' },
        .{ '.', '6', '.', '.', '.', '.', '2', '8', '.' },
        .{ '.', '.', '.', '4', '1', '9', '.', '.', '5' },
        .{ '.', '.', '.', '.', '8', '.', '.', '7', '9' },
    };

    const sol = solution(&input);

    try expect(!sol);
}
