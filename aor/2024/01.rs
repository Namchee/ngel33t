pub fn main() {
    let gift_message = String::from("Merry Christmas! Enjoy your gift!");
    // Currently, `gift_message` is owned by `main`, so we have to clone it
    attach_message_to_present(gift_message.clone());

    println!("{}", gift_message);
}

pub fn attach_message_to_present(message: String) {
    println!("The present now has this message: {}", message);
}
