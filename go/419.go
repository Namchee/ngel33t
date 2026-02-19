package main

func traverse(r int, c int, board [][]byte) {
	if r < 0 || c < 0 || r >= len(board) || c >= len(board[r]) || board[r][c] == '.' {
		return
	}

	board[r][c] = '.'
	traverse(r-1, c, board)
	traverse(r+1, c, board)
	traverse(r, c-1, board)
	traverse(r, c+1, board)

}

func countBattleships(board [][]byte) int {
	result := 0

	for i := 0; i < len(board); i++ {
		for j := 0; j < len(board[i]); j++ {
			if board[i][j] == 'X' {
				result++
				traverse(i, j, board)
			}
		}
	}

	return result
}
