// Trie
// Or known as prefix tree
// Real world example: autocomplete
public class Trie {
    static final int ALPHABET_SIZE = 26;

    static class TrieNode {
        TrieNode[] children = new TrieNode[ALPHABET_SIZE];

        boolean isWord;

        TrieNode() {
            isWord = false;

            for (int i = 0; i < children.length; i++) {
                children[i] = null;
            }
        }
    }

    TrieNode root;

    public Trie() {
        this.root = new TrieNode();
    }

    // Insert a string to the Trie
    // Time complexity: O(n), where n is key length
    // Space complexity: O(n)
    public void insert(String key) {
        TrieNode crawler = this.root;

        for (int level = 0; level < key.length(); level++) {
            int idx = key.charAt(level) - 'a';
            if (crawler.children[idx] == null) {
                crawler.children[idx] = new TrieNode();
            }

            crawler = crawler.children[idx];
        }

        crawler.isWord = true;
    }

    // Search a key in the trie
    // Time complexity: O(n), where n is key length
    public boolean search(String key) {
        TrieNode crawler = new TrieNode();

        for (int level = 0; level < key.length(); level++) {
            int idx = key.charAt(level) - 'a';
            if (crawler.children[idx] == null) {
                return false;
            }

            crawler = crawler.children[idx];
        }

        return crawler.isWord;
    }
}