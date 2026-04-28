package main

import "slices"

type Trie struct {
	children []*Trie
	words    []string
}

func NewTrie() *Trie {
	return &Trie{
		children: make([]*Trie, 26),
		words:    []string{},
	}
}

func (t *Trie) Insert(word string) {
	curr := t

	for _, c := range word {
		if curr.children[c-'a'] == nil {
			curr.children[c-'a'] = NewTrie()
		}

		curr.children[c-'a'].words = append(curr.children[c-'a'].words, word)

		curr = curr.children[c-'a']
	}
}

func (t *Trie) Find(word string) []string {
	curr := t

	for _, c := range word {
		if curr.children[c-'a'] == nil {
			return []string{}
		}

		curr = curr.children[c-'a']
	}

	return curr.words
}

func min(a, b int) int {
	if a > b {
		return b
	}

	return a
}

func suggestedProducts(products []string, searchWord string) [][]string {
	slices.Sort(products)

	trie := NewTrie()

	for _, p := range products {
		trie.Insert(p)
	}

	curr := trie

	result := [][]string{}
	for _, c := range searchWord {
		if curr == nil || curr.children[c-'a'] == nil {
			result = append(result, []string{})
			curr = nil
			continue
		}

		curr = curr.children[c-'a']
		words := curr.words

		limit := min(3, len(words))
		result = append(result, words[:limit])
	}

	return result
}
