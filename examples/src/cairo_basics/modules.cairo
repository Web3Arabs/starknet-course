mod config {
    pub fn prints() {
        println!("Hello world!");
    }

    pub fn sum(x: u8, y: u8) -> u8 {
        x + y
    }
}

fn main() {
    config::prints();

    let result = config::sum(5, 10);
    println!("{}", result);
}
