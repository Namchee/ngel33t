package main

import "slices"

type UF struct {
	parent []int
}

func NewUF(len int) UF {
	parent := make([]int, len)
	for i := 0; i < len; i++ {
		parent[i] = i
	}

	return UF{
		parent: parent,
	}
}

func (u *UF) Find(x int) int {
	if u.parent[x] != x {
		u.parent[x] = u.Find(u.parent[x])
	}

	return u.parent[x]
}

func (u *UF) Union(a, b int) {
	rootA := u.Find(a)
	rootB := u.Find(b)

	if rootA != rootB {
		u.parent[rootB] = rootA
	}
}

func smallestStringWithSwaps(s string, pairs [][]int) string {
	uf := NewUF(len(s))

	for _, pair := range pairs {
		uf.Union(pair[0], pair[1])
	}

	mp := map[int][]byte{}
	for i := 0; i < len(s); i++ {
		mp[uf.Find(i)] = append(mp[uf.Find(i)], s[i])
	}

	for k := range mp {
		slices.Sort(mp[k])
	}

	container := make([]byte, len(s))

	for i := 0; i < len(s); i++ {
		container[i] = mp[uf.Find(i)][0]
		mp[uf.Find(i)] = mp[uf.Find(i)][1:]
	}

	return string(container)
}
