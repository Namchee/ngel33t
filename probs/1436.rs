use std::collections::HashMap;

impl Solution {
    pub fn dest_city(paths: Vec<Vec<String>>) -> String {
        let mut out = HashMap::new();

        for pair in paths.iter() {
            let a = &pair[0];
            let b = &pair[1];

            if out.contains_key(a) {
                out.insert(a, out[a] + 1);
            } else {
                out.insert(a, 1);
            }

            if !out.contains_key(b) {
                out.insert(b, 0);
            }
        }

        for (c, num) in out.iter() {
            if *num == 0 {
                return c.to_string();
            }
        }

        "".to_string()
    }
}
