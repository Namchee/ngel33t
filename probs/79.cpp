#include <vector>
#include <unordered_map>
#include <string>
using namespace std;

class Solution {
public:
    bool exist(vector<vector<char>>& board, string word) {
        bool result = false;

        unordered_map<char, int> mp;
        for (int i = 0; i < board.size(); i++) {
            for (int j = 0; j < board[i].size(); j++) {
                mp[board[i][j]]++;
            }
        }

        for (char c: word) {
            if (mp[c] == 0) {
                return false;
            }
        }

        for (int i = 0; i < board.size() && !result; i++) {
            for (int j = 0; j < board[i].size() && !result; j++) {
                if (board[i][j] == word[0]) {
                    result = visit(board, word, 0, i, j); 
                }
            }
        }

        return result;
    }

private:
    bool visit(
        vector<vector<char>>& board,
        string word,
        int k,
        int i,
        int j
    ) {
        if (k == word.length()) {
            return true;
        }

        if (i < 0 || j < 0 || i >= board.size() || j >= board[i].size() || board[i][j] != word[k]) {
            return false;
        }

        // blank it
        char temp = board[i][j];
        board[i][j] = '\0';
        bool res = visit(board, word, k + 1, i + 1, j);
        res |= visit(board, word, k + 1, i - 1, j);
        res |= visit(board, word, k + 1, i, j - 1);
        res |= visit(board, word, k + 1, i, j + 1);

        board[i][j] = temp;

        return res;
    }
};
