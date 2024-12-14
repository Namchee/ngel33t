use std::fmt::{Display, Formatter};

pub struct KidsGift {
    pub name: String,
}

impl Display for KidsGift {
    fn fmt(&self, f: &mut Formatter) -> Result<(), std::fmt::Error> {
        writeln!(f, "{}", self.name.as_str())
    }
}

pub struct ElvesGift {
    pub name: String,
}

impl Display for ElvesGift {
    fn fmt(&self, f: &mut Formatter) -> Result<(), std::fmt::Error> {
        writeln!(f, "{}", self.name.as_str())
    }
}

pub struct ReindeerGift {
    pub name: String,
}

impl Display for ReindeerGift {
    fn fmt(&self, f: &mut Formatter) -> Result<(), std::fmt::Error> {
        writeln!(f, "{}", self.name.as_str())
    }
}

pub fn display_gift<T: Display>(gift: T) {
    println!("{}", gift);
}

pub fn main() {
    let kids_gift = KidsGift {
        name: "toy car".to_string(),
    };
    let elves_gift = ElvesGift {
        name: "vertical monitor".to_string(),
    };
    let reindeer_gift = ReindeerGift {
        name: "carrot".to_string(),
    };

    display_gift(&kids_gift);
    display_gift(&elves_gift);
    display_gift(&reindeer_gift);
}
