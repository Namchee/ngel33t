#include <vector>
using namespace std;

class Solution {
public:
    void solve(vector<vector<char>>& board) {
        for (int i = 0; i < board.size(); i++) {
            for (int j = 0; j < board[i].size(); j++) {
                if ((i == 0 || j == 0 || i == board.size() - 1 || j == board[i].size() - 1) && board[i][j] == 'O') {
                    mark(board, i, j);
                }
            }
        }

        for (int i = 0; i < board.size(); i++) {
            for (int j = 0; j < board[i].size(); j++) {
                if (board[i][j] == 'O') {
                    board[i][j] = 'X';
                }
            }
        }

        for (int i = 0; i < board.size(); i++) {
            for (int j = 0; j < board[i].size(); j++) {
                if (board[i][j] == 'B') {
                    board[i][j] = 'O';
                }
            }
        }
    }

private:
    void mark(vector<vector<char>>& board, int x, int y) {
        if (x < 0 || x >= board.size() || y < 0 || y >= board[0].size() || board[x][y] != 'O') {
            return;
        }

        board[x][y] = 'B';

        mark(board, x - 1, y);
        mark(board, x + 1, y);
        mark(board, x, y - 1);
        mark(board, x, y + 1);
    }
};
