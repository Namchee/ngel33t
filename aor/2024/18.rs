pub struct Sleigh {
    color: String,
    engine: String,
    gift_capacity: u32,
    magical_enhancements: bool,
}

#[derive(Clone)]
pub struct SleighBuilder {
    color: String,
    engine: String,
    gift_capacity: u32,
    magical_enhancements: bool,
}

impl SleighBuilder {
    pub fn new() -> SleighBuilder {
        SleighBuilder{
            color: "red".to_string(),
            engine: "reindeer-powered".to_string(),
            gift_capacity: 100,
            magical_enhancements: false,
        }
    }

    pub fn color(mut self, color: &str) -> SleighBuilder {
        self.color = color.to_string();

        self
    }

    pub fn engine(mut self, engine: &str) -> SleighBuilder {
        self.engine = engine.to_string();

        self
    }

    pub fn gift_capacity(mut self, gift_capacity: u32) -> SleighBuilder {
        self.gift_capacity = gift_capacity;

        self
    }

    pub fn magical_enhancements(mut self) -> SleighBuilder {
        self.magical_enhancements = true;

        self
    }

    pub fn build(self) -> Sleigh {
        Sleigh {
            color: self.color,
            engine: self.engine,
            gift_capacity: self.gift_capacity,
            magical_enhancements: self.magical_enhancements,
        }
    }
}

impl Sleigh {
    pub fn color(&self) -> &str {
        &self.color
    }

    pub fn engine(&self) -> &str {
        &self.engine
    }

    pub fn gift_capacity(&self) -> u32 {
        self.gift_capacity
    }

    pub fn magical_enhancements(&self) -> bool {
        self.magical_enhancements
    }
}

pub fn main() {
    let sleigh = SleighBuilder::new()
        .color("gold")
        .engine("magic")
        .gift_capacity(350)
        .magical_enhancements()
        .build();

    assert_eq!(sleigh.color(), "gold");
    assert_eq!(sleigh.engine(), "magic");
    assert_eq!(sleigh.gift_capacity(), 350);
    assert_eq!(sleigh.magical_enhancements(), true);
}
