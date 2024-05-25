#include <vector>
#include <string>
using namespace std;

class Trie {
public:
    Trie* children[26];
    bool isWord;

    Trie() {
        isWord = false;
        for (int i = 0; i < 26; i++) {
            children[i] = (Trie*)nullptr;
        }
    }

    void insert(const string& word) {
        Trie* curr = this;

        for (char c: word) {
            if (curr->children[c - 'a'] == nullptr) {
                curr->children[c - 'a'] = new Trie();
            }

            curr = curr->children[c - 'a'];
        }

        curr->isWord = true;
    }

    bool search(const string& word) {
        Trie* curr = this;

        for (char c: word) {
            if (curr->children[c - 'a'] == nullptr) {
                return false;
            }

            curr->children[c - 'a'];
        }

        return curr->isWord;
    }
};

class Solution {
public:
    vector<string> wordBreak(string s, vector<string>& wordDict) {
        n = s.length();
        for (string word: wordDict) {
            root->insert(word);
        }

        table.resize(n + 1);
        return traverse(s, 0);
    }

private:
    Trie* root = new Trie();
    vector<vector<string> > table;
    int n;

    vector<string> traverse(const string& s, int start) {
        if (start == n) {
            return { "" };
        }

        if (!table[start].empty()) {
            return table[start];
        }

        vector<string> ans;
        Trie* node = root;
        string prefix = "";

        for (int i = start; i < n; i++) {
            int idx = s[i] - 'a';
            if (node->children[idx] == nullptr) {
                break;
            }

            node = node->children[idx];
            prefix += s[i];

            if (node->isWord) {
                vector<string> rest = traverse(s, i + 1);
                for (string str: rest) {
                    ans.push_back(prefix + (str.empty() ? "" : " ") + str);
                }
            }
        }

        return table[start] = ans;
    }
};
