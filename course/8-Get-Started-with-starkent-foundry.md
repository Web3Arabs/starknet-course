# دليل المستخدم لـ **Starknet Foundry**

**Starknet Foundry** هي مجموعة أدوات متكاملة لتطوير العقود الذكية على شبكة Starknet، تهدف إلى تسهيل عملية بناء واختبار ونشر هذه العقود.

## المتطلبات الأساسية

قبل البدء في استخدام **Starknet Foundry**، تأكد من توافر المتطلبات التالية:

- **Scarb**
- **Universal-Sierra-Compiler**
- **Rust** (الإصدار 1.80.1 أو أعلى)

يجب أن تكون جميع الأدوات مثبتة ومضافة إلى متغير البيئة `PATH`.

> **ملاحظة:** يتم تثبيت **Universal-Sierra-Compiler** تلقائيًا عند استخدام `snfoundryup` أو `asdf`. يمكنك أيضًا إنشاء متغير البيئة `UNIVERSAL_SIERRA_COMPILER` لجعلها متاحة لـ `snforge`.

## التثبيت باستخدام **snfoundryup**

`snfoundryup` هو المثبت الرسمي لمجموعة أدوات **Starknet Foundry**.

لتثبيته، نفذ الأمر التالي في الطرفية:

```
curl -L https://raw.githubusercontent.com/foundry-rs/starknet-foundry/master/scripts/install.sh | sh
```

للتحقق من نجاح التثبيت، يمكنك تنفيذ الأوامر التالية:

```
snforge --version
sncast --version
```

## التثبيت باستخدام **asdf**

لإضافة **Starknet Foundry** كإضافة لـ asdf، استخدم الأوامر التالية:

```
asdf plugin add starknet-foundry
```

لتثبيت أحدث إصدار، نفذ:

```
asdf install starknet-foundry latest
```

للحصول على مزيد من المعلومات، يمكنك مراجعة الوثائق الخاصة بـ asdf.

## التثبيت على نظام **Windows**

حتى الآن، يتطلب تثبيت **Starknet Foundry** على Windows خطوات يدوية، لكننا سنبقيها بسيطة:

1. قم بتنزيل الأرشيف المناسب لمعماريات وحدة المعالجة المركزية الخاصة بك.
2. قم بفك ضغط الأرشيف إلى موقع ترغب في تثبيت **Starknet Foundry** فيه. يمكنك استخدام مسار مثل:
   ```
   %LOCALAPPDATA%\Programs\snfoundry
   ```
3. أضف مسار مجلد `snfoundry\bin` إلى متغير البيئة `PATH`.
4. تحقق من التثبيت بتشغيل الأوامر التالية في نافذة طرفية جديدة:
   ```
   snforge --version
   sncast --version
   ```

## تحديث **Universal-Sierra-Compiler**

إذا كنت بحاجة إلى تحديث **Universal-Sierra-Compiler** يدويًا (على سبيل المثال، عند إصدار نسخة جديدة)، يمكنك استخدام الأمر التالي:

```
curl -L https://raw.githubusercontent.com/software-mansion/universal-sierra-compiler/master/scripts/install.sh | sh
```

## بناء **Starknet Foundry** من الشيفرة المصدرية

إذا واجهتك أي مشاكل في تثبيت **Starknet Foundry** عبر التعليمات المذكورة، يمكنك محاولة بناءه من الشيفرة المصدرية كما يلي:

1. قم بإعداد بيئة تطوير مناسبة.
2. نفذ الأمر التالي:
   ```
   cd starknet-foundry && cargo build --release
   ```
   سيؤدي ذلك إلى إنشاء دليل `target`.
3. انقل دليل `target` إلى الموقع الذي تريده، مثل:
   ```
   ~/.starknet-foundry
   ```
4. تأكد من إضافة `DESIRED_LOCATION/target/release/` إلى متغير البيئة `PATH`.
