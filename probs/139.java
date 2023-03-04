import java.util.List;

class Solution {
    public boolean wordBreak(String s, List<String> wordDict) {
        Trie trie = new Trie();

        for (String ss : wordDict) {
            trie.insert(ss);
        }

        int len = s.length();

        boolean[] ways = new boolean[len + 1];
        ways[len] = true;

        for (int i = len - 1; i >= 0; i--) {
            ways[i] = trie.find(s.substring(i));

            for (int j = len; j > i; j--) {
                ways[i] = ways[j] && trie.find(s.substring(i, j));
                if (ways[i]) {
                    break;
                }
            }
        }

        return ways[0];
    }
}

class Trie {
    static final int ALPHABET_SIZE = 26;

    static class TrieNode {
        TrieNode[] children;
        boolean isWord;

        TrieNode() {
            this.children = new TrieNode[ALPHABET_SIZE];
            for (int idx = 0; idx < ALPHABET_SIZE; idx++) {
                this.children[idx] = null;
            }

            this.isWord = false;
        }
    }

    TrieNode root;

    public Trie() {
        this.root = new TrieNode();
    }

    public void insert(String str) {
        TrieNode curr = this.root;

        for (int level = 0; level < str.length(); level++) {
            int idx = str.charAt(level) - 'a';
            if (curr.children[idx] == null) {
                curr.children[idx] = new TrieNode();
            }

            curr = curr.children[idx];
        }

        curr.isWord = true;
    }

    public boolean find(String str) {
        TrieNode curr = this.root;

        for (int level = 0; level < str.length(); level++) {
            int idx = str.charAt(level) - 'a';
            if (curr.children[idx] == null) {
                return false;
            }

            curr = curr.children[idx];
        }

        return curr.isWord;
    }
}