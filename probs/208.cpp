#include <string>
using namespace std;

class Vertex {
public:
    Vertex* children[26];
    bool isWord;
};

class Trie {
public:
    Trie() {
        root = new Vertex();
    }
    
    void insert(string word) {
        Vertex* curr = root;

        for (char c: word) {
            if (curr->children[c - 'a'] == nullptr) {
                curr->children[c - 'a'] = new Vertex();
            }

            curr = curr->children[c - 'a'];
        }

        curr->isWord = true;
    }
    
    bool search(string word) {
        Vertex* curr = root;

        for (char c: word) {
            if (curr->children[c - 'a'] == nullptr) {
                return false;
            }

            curr = curr->children[c - 'a'];
        }

        return curr->isWord;
    }
    
    bool startsWith(string prefix) {
        Vertex* curr = root;

        for (char c: prefix) {
            if (curr->children[c - 'a'] == nullptr) {
                return false;
            }

            curr = curr->children[c - 'a'];
        }

        return true;
    }

private:
    Vertex* root;
};

/**
 * Your Trie object will be instantiated and called as such:
 * Trie* obj = new Trie();
 * obj->insert(word);
 * bool param_2 = obj->search(word);
 * bool param_3 = obj->startsWith(prefix);
 */
