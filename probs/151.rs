impl Solution {
    pub fn reverse_words(s: String) -> String {
        let input = s.trim();
        let mut tokens = input.split_whitespace().collect::<Vec<&str> >();

        let len = tokens.len();

        for idx in 0..len / 2 {
            let temp = tokens[idx];

            tokens[idx] = tokens[len - 1 - idx];
            tokens[len - 1 - idx] = temp;
        }

        tokens.join(" ").to_string()
    }
}

// alternative solution

impl Alternative {
    pub fn reverse_words(s: String) -> String {
        s.trim()
            .split_whitespace()
            .into_iter()
            .rev()
            .collect::<Vec<&str> >()
            .join(" ")
    }
}
