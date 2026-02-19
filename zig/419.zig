const std = @import("std");

fn traverse(r: usize, c: usize, board: [][]u8) void {
    if (r < 0 or c < 0 or r >= board.len or c >= board[r].len or board[r][c] == '.') {
        return;
    }

    board[r][c] = '.';

    if (r > 0) {
        traverse(r - 1, c, board);
    }

    traverse(r + 1, c, board);

    if (c > 0) {
        traverse(r, c - 1, board);
    }

    traverse(r, c + 1, board);
}

fn solution(board: [][]u8) u32 {
    var result: u32 = 0;

    for (0..board.len) |i| {
        for (0..board[i].len) |j| {
            if (board[i][j] == 'X') {
                result += 1;
                traverse(i, j, board);
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
