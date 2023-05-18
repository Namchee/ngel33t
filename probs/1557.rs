impl Solution {
    pub fn find_smallest_set_of_vertices(
        n: i32,
        edges: Vec<Vec<i32>>
    ) -> Vec<i32> {
        let mut ins = vec![0; n as usize];

        for pair in edges.iter() {
            let to = pair[1] as usize;

            ins[to] += 1;
        }

        let mut result = Vec::new();

        for (idx, val) in ins.iter().enumerate() {
            if *val == 0 {
                result.push(idx as i32);
            }
        }

        result
    }
}