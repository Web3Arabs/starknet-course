````markdown
<div dir="rtl">

# دليل المستخدم لـ Starknet Foundry

Starknet Foundry هي أداة قوية لتطوير العقود الذكية على شبكة Starknet. توفر مجموعة من الأدوات لبناء واختبار ونشر العقود الذكية بسهولة.

## المتطلبات

قبل البدء، تأكد من تثبيت المتطلبات التالية:

- **Scarb**
- **Universal-Sierra-Compiler**
- **Rust** (الإصدار 1.80.1 أو أعلى)

تأكد من أن جميع الأدوات مثبتة ومضافة إلى متغير البيئة `PATH`.

> **ملاحظة:** سيتم تثبيت Universal-Sierra-Compiler تلقائيًا إذا استخدمت `snfoundryup` أو `asdf`. يمكنك أيضًا إنشاء متغير البيئة `UNIVERSAL_SIERRA_COMPILER` ليكون مرئيًا لـ `snforge`.

## التثبيت باستخدام snfoundryup

`snfoundryup` هو مثبت مجموعة أدوات Starknet Foundry.

لتثبيته، قم بتنفيذ الأمر التالي:

```
curl -L https://raw.githubusercontent.com/foundry-rs/starknet-foundry/master/scripts/install.sh | sh
```
````

اتبع التعليمات، ثم نفذ:

```
snfoundryup
```

لتحقق من أن Starknet Foundry تم تثبيتها بشكل صحيح، قم بتنفيذ الأوامر التالية:

```
snforge --version
sncast --version
```

## التثبيت باستخدام asdf

أضف الإضافة الخاصة بـ Starknet Foundry إلى asdf:

```
asdf plugin add starknet-foundry
```

لتثبيت أحدث إصدار:

```
asdf install starknet-foundry latest
```

يمكنك مراجعة دليل asdf لمزيد من التفاصيل.

## التثبيت على نظام Windows

في الوقت الحالي، يتطلب تثبيت Starknet Foundry على Windows التثبيت اليدوي، ولكن الخطوات اللازمة هي الحد الأدنى:

1. قم بتحميل الأرشيف المطلق الذي يتناسب مع معمارية وحدة المعالجة المركزية الخاصة بك.
2. قم بفك ضغط الأرشيف إلى موقع حيث تريد تثبيت Starknet Foundry. يكفي وجود مجلد باسم `snfoundry` في دليل `%LOCALAPPDATA%\Programs`:
   ```
   %LOCALAPPDATA%\Programs\snfoundry
   ```
3. أضف مسار مجلد `snfoundry\bin` إلى متغير البيئة `PATH`.
4. تحقق من التثبيت بتنفيذ الأوامر التالية في جلسة طرفية جديدة:
   ```
   snforge --version
   sncast --version
   ```

## تحديث Universal-Sierra-Compiler

إذا كنت ترغب في تحديث USC يدويًا (على سبيل المثال، عند إصدار نسخة جديدة من Sierra)، يمكنك القيام بذلك عن طريق تنفيذ الأمر التالي:

```bash
curl -L https://raw.githubusercontent.com/software-mansion/universal-sierra-compiler/master/scripts/install.sh | sh
```

## كيفية بناء Starknet Foundry من الشيفرة المصدرية

إذا كنت غير قادر على تثبيت Starknet Foundry باستخدام التعليمات أعلاه، يمكنك محاولة بناءه من الشيفرة المصدرية كالتالي:

1. قم بإعداد بيئة تطوير.
2. نفذ الأمر التالي:
   ```
   cd starknet-foundry && cargo build --release
   ```
   سيؤدي ذلك إلى إنشاء دليل `target`.
3. انقل دليل `target` إلى الموقع المطلوب (مثل `~/.starknet-foundry`).
4. أضف `DESIRED_LOCATION/target/release/` إلى متغير البيئة `PATH`.

</div>
```

### ملاحظات:
