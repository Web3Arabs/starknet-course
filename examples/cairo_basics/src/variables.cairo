const ONE_HOUR_IN_SECONDS: u128 = 3600;

fn main () {
    let number_1: u128 = 10;
    println!("Number 1 = {}", number_1);

    let number_2: u256 = 15;
    println!("Number 2 = {}", number_2);

    let message: ByteArray = "Hello World!";
    println!("The message: {}", message);

    let boo: bool = true;
    println!("Boo is {}", boo);

    let mut nums: u128 = 5;
    println!("Before edit the variable: {}", nums);

    nums = 2;
    println!("After edit the variable: {}", nums);
    
    println!("{}", ONE_HOUR_IN_SECONDS);

    let num_1 = 100;
    let boos = true;
}
