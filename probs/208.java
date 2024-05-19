class Trie {
    class Vertex {
        Vertex[] children;
        boolean isWord;

        private Vertex() {
            this.children = new Vertex[26];
        }
    }

    Vertex root;

    public Trie() {
        this.root = new Vertex();
    }
    
    public void insert(String word) {
        Vertex curr = this.root;

        for (char c: word.toCharArray()) {
            if (curr.children[c - 'a'] == null) {
                curr.children[c - 'a'] = new Vertex();
            }

            curr = curr.children[c - 'a'];
        }

        curr.isWord = true;
    }
    
    public boolean search(String word) {
        Vertex curr = this.root;

        for (char c: word.toCharArray()) {
            if (curr.children[c - 'a'] == null) {
                return false;
            }

            curr = curr.children[c - 'a'];
        }

        return curr.isWord;
    }
    
    public boolean startsWith(String prefix) {
        Vertex curr = this.root;

        for (char c: prefix.toCharArray()) {
            if (curr.children[c - 'a'] == null) {
                return false;
            }

            curr = curr.children[c - 'a'];
        }

        return true;
    }
}
