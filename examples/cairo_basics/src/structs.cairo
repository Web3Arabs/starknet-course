// تقوم هذه بالسماح للهيكل في إستدعائه بداخل الدوال او نسخه
#[derive(Drop, Copy)]
// قم بتعريف الهيكل الخاص بالموظفين الذي يجمع بين ثلاثة أنواع من البيانات
struct Employee {
    name: felt252,
    age: u32,
    salary: u32,
}

fn main() {
    // نقوم بتخزين بيانات الموظف في المتغير حسب الأنواع التي حددناها في الهيكل
    let employee: Employee = Employee { name: 'ali', age: 20, salary: 5000 };

    // طباعة إسم الموظف
    println!("{}", employee.name);
    // طباعة عمر الموظف
    println!("{}", employee.age);
    // طباعة راتب الموظف
    println!("{}", employee.salary);
}
