const std = @import("std");

fn solution(board: [][]u8) u32 {
    var result: u32 = 0;

    for (0..board.len) |i| {
        for (0..board[i].len) |j| {
            if (board[i][j] == 'X') {
                const top = i > 0 and board[i - 1][j] == 'X';
                const left = j > 0 and board[i][j - 1] == 'X';
                if (!top and !left) result += 1;
            }
        }
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    var row0 = [_]u8{ 'X', '.', '.', 'X' };
    var row1 = [_]u8{ '.', '.', '.', 'X' };
    var row2 = [_]u8{ '.', '.', '.', 'X' };
    var board = [_][]u8{ &row0, &row1, &row2 };

    try expect(solution(&board) == 2);
}

test "test case #2" {
    var row0 = [_]u8{'.'};
    var board = [_][]u8{&row0};

    try expect(solution(&board) == 0);
}
