package main

func generateString(str1 string, str2 string) string {
	n := len(str1)
	m := len(str2)

	s := make([]byte, n+m-1)
	for i := 0; i < n+m-1; i++ {
		s[i] = 'a'
	}

	fixed := make([]bool, n+m-1)

	for i := 0; i < n; i++ {
		if str1[i] == 'T' {
			for j := i; j < i+m; j++ {
				if fixed[j] && s[j] != str2[j-i] {
					return ""
				} else {
					s[j] = str2[j-i]
					fixed[j] = true
				}
			}
		}
	}

	for i := 0; i < n; i++ {
		if str1[i] == 'F' {
			flag := false
			idx := -1
			for j := i + m - 1; j >= i && !flag; j-- {
				if str2[j-i] != s[j] {
					flag = true
					break
				}

				if idx == -1 && !fixed[j] {
					idx = j
				}
			}

			if flag {
				continue
			}

			if idx == -1 {
				return ""
			}

			s[idx] = 'b'
		}
	}

	return string(s)
}
