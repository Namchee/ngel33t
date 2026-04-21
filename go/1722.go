package main

type UnionFind struct {
	parent []int
	rank   []int
}

func New(len int) UnionFind {
	parent := make([]int, len)
	rank := make([]int, len)
	for i := 0; i < len; i++ {
		parent[i] = i
		rank[i] = 0
	}

	return UnionFind{
		parent: parent,
		rank:   rank,
	}
}

func (u *UnionFind) find(x int) int {
	if u.parent[x] != x {
		u.parent[x] = u.find(u.parent[x])
	}

	return u.parent[x]
}

func (u *UnionFind) union(a, b int) {
	parentA := u.find(a)
	parentB := u.find(b)

	if parentA != parentB {
		if u.rank[parentA] > u.rank[parentB] {
			u.parent[parentB] = parentA
		} else if u.rank[parentA] < u.rank[parentB] {
			u.parent[parentA] = parentB
		} else {
			u.parent[parentB] = parentA
			u.rank[parentA]++
		}
	}
}

func minimumHammingDistance(source []int, target []int, allowedSwaps [][]int) int {
	n := len(source)
	uf := New(n)

	for _, swap := range allowedSwaps {
		uf.union(swap[0], swap[1])
	}

	mp := map[int]map[int]int{}
	for i := 0; i < n; i++ {
		root := uf.find(i)

		if mp[root] == nil {
			mp[root] = make(map[int]int)
		}

		mp[root][source[i]]++
	}

	result := 0
	for i := 0; i < n; i++ {
		root := uf.find(i)
		freq := mp[root]

		if count, ok := freq[target[i]]; ok && count > 0 {
			freq[target[i]]--
		} else {
			result++
		}
	}

	return result
}
