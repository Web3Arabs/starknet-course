# إعداد بيئة تطوير Starknet على جهازك

بعد أن عرفنا الكثير حول StarkNet يمكننا القفز باتجاه عالم StarkNet المثير للإهتمام بدًأ من إعداد بيئة التطوير حتى بناء المشاريع.

## ما هي بيئة التطوير؟

من اجل تشغيل الاكواد الخاصة بناء والمشاريع ونشر العقود الذكية نحتاج إلى بيئة تطوير تساعدنا في فعل كل هذا ونحتاج إلى إعدادها في اجهزتنا!

خلال هذه الدورة ستحتاج إلى تثبيت أداة **Scarb** من أجل إنشاء المشاريع وترجمة لغة **Cairo** والعقود الذكية, وأداة **Starkli** من أجل التعامل مع **StarkNet** مباشرة ونشر العقود الذكي, بالإضافة إلى محفظة لتمثيل حسابك في StarkNet. لا داعي للقلق سنقوم بشرح كل هذا بشكل بسيط للغاية خلال هذا الدرس.

## تثبيت اداة Scarb

تثبيت اداة **scarb** في اجهزة Linux و MacOS يختلف عن تثبيتها في Windows فلذلك قم بإستخدام الأوامر المناسبة لنظامك التي سنقوم بإضافتها هنا.

### مستخدمين أنظمة Linux و MacOS

**خطوات التثبيت:**

1- ستقوم بفتح terminal وتشغيل هذا الأمر

```bash
curl --proto '=https' --tlsv1.2 -sSf https://docs.swmansion.com/scarb/install.sh | sh
```

2- قم بإعادة فتح **terminal** وقم بتشغيل الأمر التالي للتحقق من التثبيت

```bash
scarb --version
```

سيقوم بإظهار إصدار كل من scarb و cairo وإلخ…

### مستخدمين نظام Windows

**خطوات التثبيت:**

1- ستقوم اولاً بتحميل المجلد الذي يحتوي على تبعيات scarb من هنا: <a href="https://docs.swmansion.com/scarb/download.html#precompiled-packages" target="_blank">https://docs.swmansion.com/scarb/download.html#precompiled-packages</a>

<img src="https://web3arabs.com/courses/starknet/scarb-windows.png"/>

2- ستقوم بفك ضغط المجلد وستقوم بنسخ المجلدات التي في الداخل bin و doc.

3- ستقوم بفتح **القرص C** - وستقوم بإنشاء مجلد بإسم **scarb** ومن ثم ستقوم بلصق المجلدات التي قمت بنسخها في الخطوة 2 بداخل المجلد الجديد.

5- لقد انتهينا من الجزء الأصعب! قم بفتح cmd او terminal وستقوم بتشغيل هذا الأمر:

```bash
setx PATH "C:\scarb\bin"
```

6- ستقوم الآن بفتح **cmd** او **termnal** من جديد من أجل التحقق من اكتمال تثبيت الأداة على جهازك. قم بتشغيل هذا الأمر:

```bash
scarb --version
```

سيقوم بإظهار إصدار كل من scarb و cairo وإلخ…

<img src="https://web3arabs.com/courses/starknet/scarb-version.png"/>

عمل رائع!

## تثبيت اداة Starkli

كما هو الحال, تثبيت اداة starkli في اجهزة Linux و MacOS يختلف عن تثبيتها في Windows فلذلك قم بإستخدام الأوامر المناسبة لنظامك التي سنقوم بإضافتها هنا.

### مستخدمين أنظمة Linux و MacOS

1- يمكنك تثبيت بيئة Starkli باستخدام Starkliup بمساعدة الأمر التالي. ستقوم بفتح terminal وتشغيل هذا الأمر:

```bash
curl https://get.starkli.sh | sh
```

2- - قم بإعادة فتح terminal وقم بتشغيل الأمر التالي من أجل تثبيت starkli:

```bash
starkliup
```

3- قم بإعادة فتح terminal وقم بتشغيل الأمر التالي للتحقق من التثبيت

```bash
starkli --version
```

### مستخدمين نظام Windows

سنقوم بتثبيت **starkli** عن طريق **cargo** لكونها أسهل الطرق.

1- اولاً قم بتثبيت لغة rust على نظامك من أجل تشغيل cargo يمكنك <a href="https://www.youtube.com/watch?v=92HoSWgsx-4&t=3s" trget="_blank">متابعة هذا الفيديو</a> ومن ثم يمكنك إكمال الخطوات التالية.

2- ستقوم الآن بفتح cmd او terminal من أجل تثبيت **starkli** عن طريق تشغيل هذا الأمر:

```bash
cargo install --locked --git https://github.com/xJonathanLEI/starkli
```

3- ستقوم بإعادة فتح cmd او terminal وتشغيل الأمر التالي:

```bash
starkli --version
```

<img src="https://web3arabs.com/courses/starknet/starkli-version.png"/>

إنه يعمل! قم بتجربة تشغيل scarb مرة اخرى. في حال لم تستطيع تثبيت اي من الادوات التاليه قم بطرح مشكلتك على <a href="https://discord.gg/ykgUvqMc4Q" target="_blank">Discord</a> أو <a href="https://t.me/Web3ArabsDAO" target="_blank">Telegram</a>.

## إعداد محفظة ArgentX

إنها واحدة من المحافظ الأكثر شعبية والمجانية على Starknet.

يمكنك إضافتها بسهولة باستخدام ملحق المتصفح. ما عليك سوى <a href="https://chromewebstore.google.com/detail/argent-x/dlcobpjiigpikoobohmabehhmhfoodbb" target="_blank">الانتقال إلى هذا الرابط</a> ثم إضافتها إلى المتصفح الخاص بك.

<img src="https://web3arabs.com/courses/starknet/argent-ex.png"/>

بمجرد إضافة ملحق **ArgentX** إلى المتصفح، ستتم إعادة توجيهك إلى صفحة جديدة. انقر فوق إنشاء محفظة جديدة، وإقبل الشروط والأحكام، ثم قم بإضافة كلمة المرور الخاصة بك. وسيتم إنشاء محفظتك بكل سهولة.

<img src="https://web3arabs.com/courses/starknet/argent-ex2.png"/>

الآن، سيبدو حساب **ArgentX** الخاص بك مشابهًا كما هو موضح أدناه.

<img src="https://web3arabs.com/courses/starknet/argent-ex3.png"/>

## جمع بعض عملات الإختبار

الآن، حان الوقت للحصول على بعض العملات الاختبارية، حتى نتمكن من نشر عقودنا على Starknet.

**فيما يلي دليل بسيط خطوة بخطوة:**

● قم بفتح محفظتك على ArgentX. <br/>
● قم بتغيير الشبكة إلى Testnet، والتي عادة ما تكون موجودة في الزاوية اليمنى العليا. سيطلب منك إنشاء حساب على testnet. لذلك، بعد الإنشاء، سيتم تعيين شبكتك على Testnet.

<img src="https://web3arabs.com/courses/starknet/argent-ex4.png"/>

انتقل إلى <a href="https://web3arabs.com/faucets/starknet-goerli" target="_blank">https://web3arabs.com/faucets/starknet-goerli</a> باستخدام متصفح الويب الخاص بك. سوف يساعدك هذا الصنبور بالحصول على بعض عملات الإختبار في حساب Testnet الخاص بك - قم بتوصيل محفظتك بالصنبور وإنقر على الزر **إرسال**.

<img src="https://web3arabs.com/courses/starknet/goerli.png"/>

الآن، كل ما عليك فعله هو الانتظار حتى تكتمل المعاملة. تحقق من محفظتك بعد لحظات، سترى ما لا يقل عن 0.001 تم إضافته إلى محفظتك.

## نشر الحساب كعقد على الشبكة

بعد أن حصلنا على بعض من العملات الإختبارية سنقوم بنشر الحساب على الشبكة كعقد ذكي.

قم بفتح محفظة **Argent X** ومن ثم النقر على زر الإعدادات في الجزء الأيمن بالأعلى. ومن ثم النقر على الحساب:

<img src="https://web3arabs.com/courses/starknet/argent-account.png"/>

ستقوم الآن بالنقر على الزر **Deploy account** من أجل نشر الحساب على الشبكة كعقد ذكي:

<img src="https://web3arabs.com/courses/starknet/argent-deploy-account.png"/>

فقط قم بالنقر على **Confirm** للتأكيد وسيقوم بنشر الحساب على الشبكة مباشرة:

<img src="https://web3arabs.com/courses/starknet/argent-confirm-account.png"/>

## طريقة إظهار المفتاح الخاص

من أجل استدعاء المفتاح الخاص بالحساب ستقوم بالنقر على زر الإعدادات وبعدها النقر على حسابك ومن ثم النقر على زر Export private key:

<img src="https://web3arabs.com/courses/starknet/argent-account2.png"/>

لا تقوم بمشاركة المفتاح الخاص مع أي أحد على الإطلاق. سنقوم باستخدامه اثناء نشر العقود الذكية في الدروس القادمة.

## ما قمنا بشرحه

في هذا الدرس قمنا بتوضيح طريقة إعداد البيئة الإفتراضية للبدء في البناء على StarkNet بالإضافة إلى طريقة الحصول على العملات الإختبارية ومن ثم نشر حساب المحفظة الخاص بك على الشبكة كعقد ذكي وطريقة إظهار المفتاح الخاص المتعلق بمحفظتك.

كما هو الحال دائمًا، إذا كانت لديك أي أسئلة أو شعرت بالتعثر أو أردت فقط أن تقول مرحبًا، فقم بالإنضمام على <a href="https://t.me/Web3ArabsDAO" target="_blank">Telegram</a> او <a href="https://discord.gg/ykgUvqMc4Q" target="_blank">Discord</a> وسنكون أكثر من سعداء لمساعدتك!
