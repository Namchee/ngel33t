package main

func toHex(num int) string {
	if num == 0 {
		return "0"
	}

	n := uint32(num)

	mp := map[uint32]byte{
		0:  '0',
		1:  '1',
		2:  '2',
		3:  '3',
		4:  '4',
		5:  '5',
		6:  '6',
		7:  '7',
		8:  '8',
		9:  '9',
		10: 'a',
		11: 'b',
		12: 'c',
		13: 'd',
		14: 'e',
		15: 'f',
	}
	temp := []byte{}

	mask := 0b1111

	for n > 0 {
		val := n & uint32(mask)
		ch := mp[val]

		temp = append([]byte{ch}, temp...)

		n >>= 4
	}

	return string(temp)
}
