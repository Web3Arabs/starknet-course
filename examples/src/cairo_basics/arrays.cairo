fn main() {
    // تعريف متغير قابل للتعديل يقوم بتخزين مصفوفة جديدة
    let mut arr = ArrayTrait::new();

    // إضافة أربعة قيم للمصفوفة
    arr.append(5);
    arr.append(10);
    arr.append(15);
    arr.append('hi');

    // في المصفوفات يبدأ موقع القيم التي ندخلها من الرقم 0
    // طباعة القيمة الأولى التي موقعها رقم 0
    println!("Index 0: {}", *arr.at(0));
    // طباعة القيمة الثانية التي موقعها رقم 1
    println!("Index 1: {}", *arr.at(1));

    // طباعة حجم المصفوفة
    println!("The len: {}", arr.len());

    // إزالة اول عنصر في المصفوفة
    arr.pop_front().unwrap();
    // إزالة اول عنصر في المصفوفة
    arr.pop_front().unwrap();

    // طباعة القيمة الأولى التي موقعها رقم 0
    println!("Index 0: {}", *arr.at(0));

    // طباعة حجم المصفوفة
    println!("The len: {}", arr.len());
}
