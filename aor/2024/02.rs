pub fn main() {
    let gift_message = String::from("Merry Christmas! Enjoy your gift!");
    // to avoid cloning, we can pass references instead
    attach_message_to_present(&gift_message);

    println!("{}", gift_message);
}

pub fn attach_message_to_present(message: &String) {
    println!("The present now has this message: {}", message);
}
