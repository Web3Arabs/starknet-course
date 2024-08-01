// تقوم هذه بالسماح للهيكل في إستدعائه بداخل الدوال او نسخه
#[derive(Drop, Copy)]
// قم بتعريف الهيكل الخاص بالاشخاص الذي يجمع بين اربعة أنواع من البيانات
struct Person {
    name: felt252,
    email: felt252,
    age: u32,
    year_join: u32, 
}

fn main() {
    // نقوم بتخزين بيانات الشخص في المتغير حسب الأنواع التي حددناها في الهيكل
    let per: Person = Person { name: 'Ali', email: 'ali@gmail.com', age: 20, year_join: 2023 };

    // إليها per إستدعاء الدالة وإدخال بيانات المتغير
    print_person(per);
    
    // year_birthday إنشاء متغير يقوم تخزين السنة من الدالة
    let year: u32 = year_birthday(per);
    // طباعة سنة ميلاد الشخص
    println!("The year birthday: {}", year);
}

// تقوم بطباعة جميع بيانات الشخص Person بإستقبال قيمة نوعها الهيكل print_person تقوم الدالة 
fn print_person(val: Person) {
    println!("name: {}", val.name);
    println!("email: {}", val.email);
    println!("age: {}", val.age);
    println!("year_join: {}", val.year_join);
}

// Person بإستقبال قيمة نوعها الهيكل year_birthday تقوم الدالة
// وظيفة الدالة إرجاع قيمة عددية وهي ناتج سنة إنضمام الشخص طرح عمره
fn year_birthday(val: Person) -> u32 {
    val.year_join - val.age
}
