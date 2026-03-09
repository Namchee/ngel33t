package main

func numberOfStableArrays2(zero int, one int, limit int) int {
	table0 := make([][]int, zero+1)
	table1 := make([][]int, zero+1)

	for i := 0; i <= zero; i++ {
		table0[i] = make([]int, one+1)
		table1[i] = make([]int, one+1)
	}

	for i := 1; i <= min(zero, limit); i++ {
		table0[i][0] = 1
	}

	for j := 1; j <= min(one, limit); j++ {
		table1[0][j] = 1
	}

	for i := 1; i <= zero; i++ {
		for j := 1; j <= one; j++ {
			val0 := (table0[i-1][j] + table1[i-1][j]) % MOD

			if i-limit-1 >= 0 {
				val0 -= table1[i-limit-1][j]
			}

			table0[i][j] = (val0%MOD + MOD) % MOD

			val1 := (table0[i][j-1] + table1[i][j-1]) % MOD

			if j-limit-1 >= 0 {
				val1 -= table0[i][j-limit-1]
			}

			table1[i][j] = (val1%MOD + MOD) % MOD
		}
	}

	return (table0[zero][one] + table1[zero][one]) % MOD
}
