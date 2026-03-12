package main

func findAllRecipes(recipes []string, ingredients [][]string, supplies []string) []string {
	deg := map[string]int{}
	ans := []string{}
	q := []string{}

	adj := map[string][]string{}

	for _, supply := range supplies {
		q = append(q, supply)
	}

	for idx, recipe := range recipes {
		deg[recipe] = len(ingredients[idx])

		for _, ingredient := range ingredients[idx] {
			adj[ingredient] = append(adj[ingredient], recipe)
		}
	}

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]

		for _, req := range adj[curr] {
			deg[req]--

			if deg[req] == 0 {
				ans = append(ans, req)
				q = append(q, req)
			}
		}
	}

	return ans
}
