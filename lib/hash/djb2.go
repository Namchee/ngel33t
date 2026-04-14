package hash

// DJB2 hashing algorithm
// A pretty good hashing algorithm, but it's simple and fast!
func DJB2(s string) uint32 {
	// Any large prime number
	var hash uint32 = 5381

	for i := 0; i < len(s); i++ {
		// hash * 33 + char
		// Using bitwise (hash << 5) + hash is the idiomatic DJB2 way
		hash = ((hash << 5) + hash) + uint32(s[i])
	}

	return hash
}
