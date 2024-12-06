// Write a function that returns the reference to the longer string
// without any new allocations
pub fn longer_wish<'a>(s1: &'a str, s2: &'a str) -> Option<&'a str> {
    let trimmed_s1 = s1.trim().chars().count();
    let trimmed_s2 = s2.trim().chars().count();

    if trimmed_s1 > trimmed_s2 {
        return Some(s1);
    } else if trimmed_s2 > trimmed_s1 {
        return Some(s2);
    } else {
        return None;
    }
}
