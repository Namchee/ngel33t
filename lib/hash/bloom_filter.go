package hash

import (
	"hash/fnv"
	"math"
)

// BloomFilter is a data structure
// that helps you find whether an element definitely doesn't exist
// or might exist.
//
// The main advantage of BloomFilter is how space-efficient it is
// compared to traditional key-value cache.
type BloomFilter struct {
	m    uint64 // Number of bit array
	k    uint64 // Number of hashing function
	bits []byte
}

// expectedN = number of expected elements
// falsePositiveRate = how inaccurate would you like this thing to be?
func NewBloomFilter(expectedN uint64, falsePositiveRate float64) *BloomFilter {
	m, k := estimateParameters(expectedN, falsePositiveRate)
	if m == 0 || k == 0 {
		panic("Invalid parameters for Bloom Filter")
	}

	return NewBloomFilterWithMK(m, k)
}

// m = - (n * ln(p)) / (ln(2))^2
// k = (m / n) * ln(2)
func estimateParameters(n uint64, p float64) (m uint64, k uint64) {
	if n == 0 || p <= 0 || p >= 1 {
		return 1000, 10
	}
	mFloat := -(float64(n) * math.Log(p)) / (math.Ln2 * math.Ln2)
	kFloat := (mFloat / float64(n)) * math.Ln2

	m = uint64(math.Ceil(mFloat))
	k = uint64(math.Ceil(kFloat))

	if k < 1 {
		k = 1
	}
	return
}

func NewBloomFilterWithMK(m, k uint64) *BloomFilter {
	if m == 0 || k == 0 {
		panic("Invalid parameters for Bloom filter: m or k is zero")
	}
	numBytes := (m + 7) / 8

	return &BloomFilter{
		m:    m,
		k:    k,
		bits: make([]byte, numBytes),
	}
}

func (bf *BloomFilter) getHashes(data []byte) []uint64 {
	hashes := make([]uint64, bf.k)

	h1 := fnv.New64()
	h1.Write(data)
	hash1Val := h1.Sum64()

	h2 := fnv.New64a()
	h2.Write(data)
	hash2Val := h2.Sum64()

	for i := uint64(0); i < bf.k; i++ {
		if hash2Val == 0 && i > 0 {
			hash2Val = 1
		}

		hashes[i] = (hash1Val + i*hash2Val) % bf.m
	}

	return hashes
}

func (bf *BloomFilter) Add(data []byte) {
	hashes := bf.getHashes(data)
	for _, h := range hashes {
		idx := h / 8
		offset := h % 8
		bf.bits[idx] |= (1 << offset)
	}
}

func (bf *BloomFilter) MightContain(data []byte) bool {
	hashes := bf.getHashes(data)

	for _, h := range hashes {
		byteIndex := h / 8
		bitOffset := h % 8
		if (bf.bits[byteIndex] & (1 << bitOffset)) == 0 {
			return false
		}
	}

	return true
}

func (bf *BloomFilter) Reset() {
	for i := range bf.bits {
		bf.bits[i] = 0
	}
}
