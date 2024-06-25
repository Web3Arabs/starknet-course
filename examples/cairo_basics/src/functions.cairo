fn main() {
    let value = sum(10, 20);
    println!("The value: {}", value);

    check(8);
}

fn sum(x: u32, y: u32) -> u32 {
    x + y
}

fn check(val: u32) {
    if val >= 10 {
        println!("Big number");
    } else {
        println!("Small number");
    }
}
