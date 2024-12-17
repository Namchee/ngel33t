// Ensure all relevant items are marked with `pub` keyword
const CHRISTMAS_EMOJIS: [char; 4] = ['🎅', '🤶', '🎄', '🎁'];

pub trait Mask {
    fn anonymize_email(&self) -> String;
}

impl Mask for String {
    fn anonymize_email(&self) -> String {
        let tokens: Vec<&str> = self.split("@").collect();
        let mut anonymized: String = "".to_string();

        for idx in 0..tokens[0].len() {
            anonymized += &CHRISTMAS_EMOJIS[idx % CHRISTMAS_EMOJIS.len()].to_string();
        }

        if tokens.len() == 1 {
            return anonymized;
        }

        anonymized + "@" + tokens[1]
    }
}

pub fn main() {
    let emails = vec![
        "rudolph.therapysessions@northpole.com".to_string(),
        "elfhr.complaint@northpole.urgent".to_string(),
        "santas.rage.management@christmaschaos.noel".to_string(),
        "overtimepay.never@elfexploitation.workshop".to_string(),
        "mrs.claus.divorce.lawyer@northpole.legal".to_string(),
        "reindeer.workers.comp@antler.insurance".to_string(),
        "naughty.list.revenge@santasecrets.com".to_string(),
        "workshop.ptsd.support@elves.anonymous".to_string(),
        "performance.anxiety@santa.breakdown".to_string(),
        "existential.crisis@northpole.void".to_string(),
    ];

    for email in emails {
        let anonymized_email = email.anonymize_email(); // This is the API that Santa wants!
        println!("Original: {} -> Anonymized: {}", email, anonymized_email);
    }
}
