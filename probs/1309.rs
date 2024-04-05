use std::collections::HashMap;

impl Solution {
    pub fn freq_alphabets(s: String) -> String {
        let mut temp: String = "".to_string();
        let mut result: String = "".to_string();
        let small_map = HashMap::from([
            ("1", "a"),
            ("2", "b"),
            ("3", "c"),
            ("4", "d"),
            ("5", "e"),
            ("6", "f"),
            ("7", "g"),
            ("8", "h"),
            ("9", "i"),
        ]);
        let big_map = HashMap::from([
            ("10#", "j"),
            ("11#", "k"),
            ("12#", "l"),
            ("13#", "m"),
            ("14#", "n"),
            ("15#", "o"),
            ("16#", "p"),
            ("17#", "q"),
            ("18#", "r"),
            ("19#", "s"),
            ("20#", "t"),
            ("21#", "u"),
            ("22#", "v"),
            ("23#", "w"),
            ("24#", "x"),
            ("25#", "y"),
            ("26#", "z"),
        ]);
        
        for ch in s.chars().rev() {
            temp.insert(0, ch);
            if let Some(val) = small_map.get(&temp.as_str()) {
                result = format!("{}{}", val, result);
                temp = "".to_string();
            }
            if let Some(val) = big_map.get(&temp.as_str()) {
                result = format!("{}{}", val, result);
                temp = "".to_string();
            }
        }

        if let Some(val) = small_map.get(&temp.as_str()) {
            result = format!("{}{}", val, result);
            temp = "".to_string();
        }
        if let Some(val) = big_map.get(&temp.as_str()) {
            result = format!("{}{}", val, result);
            temp = "".to_string();
        }

        return result;
    }
}
