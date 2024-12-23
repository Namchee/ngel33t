use std::collections::HashMap;

pub struct SantaList {
    pub records: HashMap<String, bool>,
}

impl SantaList {
    pub fn new() -> Self {
        Self {
            records: HashMap::new(),
        }
    }

    pub fn add(&mut self, key: &str, value: bool) {
        self.records.insert(key.to_string(), value);
    }

    pub fn remove(&mut self, key: &str) {
        self.records.remove(key);
    }

    pub fn get(&self, key: &str) -> Option<bool> {
        match self.records.get(key) {
            Some(val) => Some(*val),
            None => None,
        }
    }

    pub fn count(&self) -> (usize, usize) {
        let mut nice: usize = 0;
        let mut naughty: usize = 0;
        
        for (_, val) in self.records.iter() {
            if *val {
                nice += 1;
            } else {
                naughty += 1;
            }
        }

        (nice, naughty)
    }

    pub fn list_by_behavior(&self, condition: bool) -> Vec<String> {
        let mut result: Vec<String> = vec![];

        for (key, val) in self.records.iter() {
            if *val == condition {
                result.push(key.to_string());
            }
        }

        result
    }
}

pub fn main() {
    let mut santa_list = SantaList::new();

    santa_list.add("Alice", true);
    santa_list.add("Bob", false);
    santa_list.add("Charlie", true);

    if let Some(behavior) = santa_list.get("Alice") {
        println!(
            "Alice is on the {} list.",
            if behavior { "Nice" } else { "Naughty" }
        );
    }

    let (nice, naughty) = santa_list.count();
    println!(
        "Santa's list contains {} nice and {} naughty children.",
        nice, naughty
    );

    let nice_list = santa_list.list_by_behavior(true);
    println!("Nice children: {:?}", nice_list);

    let naughty_list = santa_list.list_by_behavior(false);
    println!("Naughty children: {:?}", naughty_list);

    santa_list.remove("Bob");
    let (nice, naughty) = santa_list.count();
    println!(
        "After removing Bob, Santa's list contains {} nice and {} naughty children.",
        nice, naughty
    );
}
