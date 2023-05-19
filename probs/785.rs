use std::collections::VecDeque;

impl Solution {
    pub fn is_bipartite(graph: Vec<Vec<i32>>) -> bool {
        let len = graph.len();
        let mut side = vec![-1; len];

        let mut result = true;

        let mut queue: VecDeque<i32> = VecDeque::new();

        for idx in 0..len {
            if side[idx] == -1 {
                queue.push_back(idx as i32);
                side[idx] = 0;

                while !queue.is_empty() {
                    let next = queue.pop_front().unwrap();

                    for adj in graph[next as usize].iter() {
                        let node = *adj as usize;

                        if side[node] == -1 {
                            side[node] = side[next as usize] ^ 1;
                            queue.push_back(*adj);
                        } else {
                            result &= (side[node] != side[next as usize]);
                        }
                    }
                }
            }
        }

        result
    }
}