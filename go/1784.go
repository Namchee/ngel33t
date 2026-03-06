package main

func checkOnesSegment(s string) bool {
	flag := true

	for _, ch := range s {
		if ch == '1' {
			if !flag {
				return false
			}
		} else {
			flag = false
		}
	}

	return true
}
