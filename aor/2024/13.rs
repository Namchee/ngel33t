// Import the necessary modules
use std::error::Error;
use std::fmt;

#[derive(Debug)]
pub enum ParseError {
    // 1. Add variants here (read description)
    NoName,
    NoGoodDeeds,
    NoBadDeeds,
    InvalidGoodDeeds,
    InvalidBadDeeds,
}

// 2. Implement the Error trait for ParseError

impl fmt::Display for ParseError {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        match self {
            ParseError::NoName => write!(f, "Name field is missing"),
            ParseError::NoGoodDeeds => write!(f, "Good deeds field is missing"),
            ParseError::NoBadDeeds => write!(f, "Bad deeds field is missing"),
            ParseError::InvalidGoodDeeds => write!(f, "Good deeds value is invalid"),
            ParseError::InvalidBadDeeds => write!(f, "Bad deeds value is invalid"),
        }
    }
}

impl Error for ParseError {}

#[derive(Debug)]
pub struct Kid {
    pub name: String,
    pub niceness: Niceness,
}

impl Kid {
    pub fn new(name: String, good_deeds: u32, bad_deeds: u32) -> Kid {
        let niceness = if Self::is_nice(good_deeds, bad_deeds) {
            Niceness::Nice(good_deeds)
        } else {
            Niceness::Naughty
        };

        Kid { name, niceness }
    }

    pub fn parse_row(csv_row: &str) -> Result<Kid, ParseError> {
        // 3. Update the code to return meaningful errors
        let mut fields = csv_row.split(',');
        let name = fields.next().ok_or(ParseError::NoName)?.to_string();
        if name.is_empty() {
            return Err(ParseError::NoName);
        }
        let good_deeds = fields
            .next()
            .filter(|f| !f.is_empty())
            .ok_or(ParseError::NoGoodDeeds)?
            .parse::<u32>()
            .map_err(|_| ParseError::InvalidGoodDeeds)?;
        let bad_deeds = fields
            .next()
            .filter(|f| !f.is_empty())
            .ok_or(ParseError::NoBadDeeds)?
            .parse::<u32>()
            .map_err(|_| ParseError::InvalidBadDeeds)?;

        Ok(Kid::new(name, good_deeds, bad_deeds))
    }

    pub fn is_nice(good_deeds: u32, bad_deeds: u32) -> bool {
        if good_deeds == 0 && bad_deeds == 0 {
            return false;
        }

        let good_deeds = good_deeds as f32 * GOOD_WEIGHT;
        let bad_deeds = bad_deeds as f32 * BAD_WEIGHT;

        let ratio = good_deeds / (good_deeds + bad_deeds);

        ratio >= 0.75
    }
}

pub const GOOD_WEIGHT: f32 = 1.0;
pub const BAD_WEIGHT: f32 = 2.0;

#[derive(Debug, PartialEq)]
pub enum Niceness {
    Nice(u32),
    Naughty,
}
