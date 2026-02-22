package tree

type TrieNode struct {
	Exist    bool
	Children map[rune]*TrieNode
}

type Trie struct {
	Root *TrieNode
}

func initTrie() *Trie {
	return &Trie{Root: &TrieNode{
		Children: make(map[rune]*TrieNode),
	}}
}

func (t *Trie) insert(word string) {
	curr := t.Root

	for _, ch := range word {
		if curr.Children[ch] == nil {
			curr.Children[ch] = &TrieNode{
				Children: make(map[rune]*TrieNode),
			}
		}

		curr = curr.Children[ch]
	}

	curr.Exist = true
}

func (t *Trie) search(word string) bool {
	curr := t.Root

	for _, ch := range word {
		node, ok := curr.Children[ch]
		if !ok {
			return false
		}

		curr = node
	}

	return curr.Exist
}

func (t *Trie) hasPrefix(word string) bool {
	curr := t.Root

	for _, ch := range word {
		node, ok := curr.Children[ch]
		if !ok {
			return false
		}

		curr = node
	}

	return true
}
