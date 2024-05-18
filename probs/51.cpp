#include <vector>
#include <string>
using namespace std;

class Solution {
public:
    vector<vector<string>> solveNQueens(int n) {
        vector<vector<string> > result;
        vector<int> board(n, 0);

        backtrack(0, n, board, result);

        return result;
    }

private:
    void backtrack(int row, int limit, vector<int>& board, vector<vector<string> >& result) {
        if (row == limit) {
            vector<string> b;

            for (int i = 0; i < limit; i++) {
                string str(limit, '.');
                str[board[i]] = 'Q';

                b.push_back(str);
            }

            result.push_back(b);
        } else {
            for (int col = 0; col < limit; col++) {
                if (can_place(row, col, board)) {
                    board[row] = col;
                    backtrack(row + 1, limit, board, result);
                }
            }
        }
    }

    bool can_place(int row, int col, vector<int>& board) {
        for (int prev = 0; prev < row; prev++) {
            if (board[prev] == col || abs(board[prev] - col) == abs(prev - row)) {
                return false;
            }
        }

        return true;
    }
};
