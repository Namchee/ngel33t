package main

type RDSU map[rune]rune

func (ds RDSU) findParent(c rune) rune {
	if _, exists := ds[c]; !exists {
		ds[c] = c
		return c
	}

	if c == ds[c] {
		return ds[c]
	}

	ds[c] = ds.findParent(ds[c])

	return ds[c]
}

func (ds RDSU) union(a rune, b rune) {
	parentA := ds.findParent(a)
	parentB := ds.findParent(b)

	if parentA != parentB {
		if parentA < parentB {
			ds[parentB] = parentA
		} else {
			ds[parentA] = parentB
		}
	}
}

func smallestEquivalentString(s1 string, s2 string, baseStr string) string {
	mp := RDSU{}

	for _, ch := range s1 {
		mp[ch] = ch
	}

	for _, ch := range s2 {
		mp[ch] = ch
	}

	for i := 0; i < len(s1); i++ {
		a := rune(s1[i])
		b := rune(s2[i])

		mp.union(a, b)
	}

	result := []rune{}

	for _, ch := range baseStr {
		result = append(result, mp.findParent(ch))
	}

	return string(result)
}
