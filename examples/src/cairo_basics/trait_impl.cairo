#[derive(Drop, Copy)]
struct Person {
    name: felt252,
    email: felt252,
    age: u32,
    year_join: u32, 
}

trait IPerson {
    fn year_birthday(self: Person) -> u32;
    fn edit_year_join(ref self: Person, newYear: u32);
}

impl PersonImpl of IPerson {
    fn year_birthday(self: Person) -> u32 {
        self.year_join - self.age
    }

    fn edit_year_join(ref self: Person, newYear: u32) {
        self.year_join = newYear;
    }
}

fn main() {
    let mut per = Person { name: 'Ali', email: 'ali@gmail.com', age: 20, year_join: 2020 };

    println!("Year join: {}", per.year_join);

    let year: u32 = per.year_birthday();
    println!("The year birthday: {}", year);

    per.edit_year_join(2024);
    println!("Year join: {}", per.year_join);
}
