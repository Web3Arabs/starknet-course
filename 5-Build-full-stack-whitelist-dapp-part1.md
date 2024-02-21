# بناء عقد ذكي لمشروع Whitelist بإستخدام ادوات Starknet

في هذا الدرس سنقوم ببناء مشروع **Whitelist** على شبكة **Starknet** بإستخدام لغة **Cairo** وأدوات **Scarb** و **Starkli** ومن ثم في الدرس القادم سنقوم بربط العقد الذكي بالواجهة الامامية بإستخدام إطار العمل Next.js.

## المتطلبات الاساسية للبدء في هذا الدرس:

1. انتهيت من تثبيت <a href="/courses/3d88b1a4-ad68-400b-94d3-df89a5f95cfd/lessons/9022a977-02a7-4014-8e11-1ebb7a38be71" target="_blank">بيئة تطوير Starknet</a>.
2. يمكنك التعامل مع <a href="/courses/3d88b1a4-ad68-400b-94d3-df89a5f95cfd/lessons/c8786613-1ab3-4ad4-ab54-456b7ac44337" target="_blank">لغة البرمجة Cairo</a>.
3. يمكنك <a href="/courses/3d88b1a4-ad68-400b-94d3-df89a5f95cfd/lessons/56465070-18f4-4ca6-b80f-2be8a41a3da2" target="_blank">كتابة عقود بواسطة لغة Cairo</a>.

## إعداد المشروع

ستقوم بفتح terminal وإنشاء مجلد بإسم **whitelist_starknet**:

```bash
mkdir whitelist_starknet & cd whitelist_starknet
```

إنشاء مشروع **scarb** عن طريق إدخال هذا الأمر:

```bash
scarb init
```

<img src="https://web3arabs.com/courses/starknet/dapp/create-project.png"/>

## العقد الذكي

من أجل إعداد العقود الذكية وتشغيلها ستقوم اولا بفتح ملف **Scarb.toml** وجعله بهذا الشكل:

```toml
[package]
name = "starknet_whitelist"
version = "0.1.0"

# See more keys and their definitions at https://docs.swmansion.com/scarb/docs/reference/manifest.html

[dependencies]
starknet = "2.3.1"

[cairo]
sierra-replace-ids = true

[[target.starknet-contract]]
```

<img src="https://web3arabs.com/courses/starknet/dapp/scarb-toml.png"/>

الآن سنقوم بإنشاء ملف **whitelist.cairo** في المجلد src وسنقوم بكتابة العقد الذكي في هذا الملف.

فكرة العقد الذكي سنقوم بضم اشخاص الى قائمة بافتراض أن لدينا منتج, و أول 10 اشخاص او اي عدد نقوم بتحديده يستطيع الحصول على المنتج مجاناً.

قم بنسخ كود العقد الذكي التالي الى الملف **whitelist.cairo** ومن ثم قم بمتابعة العقد الذكي اسفل الكود مباشرة:

```rust
use starknet::ContractAddress;

#[starknet::interface]
trait IWhitelist<TContractState> {
  fn add_address_to_whitelist(ref self: TContractState);
  fn check_address(self: @TContractState, address: ContractAddress) -> bool;
  fn get_num_addresses(self: @TContractState) -> u128;
  fn get_max_addresses(self: @TContractState) -> u128;
}

#[starknet::contract]
mod Whitelist {
  use starknet::{ContractAddress, get_caller_address};

  #[storage]
  struct Storage {
    whitelistedAddresses: LegacyMap<ContractAddress, bool>,
    maxWhitelistedAddresses: u128,
    numAddressesWhitelisted: u128,
  }

  #[constructor]
  fn constructor(ref self: ContractState, _maxWhitelistedAddresses: u128) {
    self.maxWhitelistedAddresses.write(_maxWhitelistedAddresses);
  }

  #[abi(embed_v0)]
  impl WhitelistImpl of super::IWhitelist<ContractState> {
    fn add_address_to_whitelist(ref self: ContractState) {
      assert(
        self.whitelistedAddresses.read(get_caller_address()) == false, 
        'Address has already added'
      );
      assert(
        self.numAddressesWhitelisted.read() < self.maxWhitelistedAddresses.read(),
        'Addresses limit reached'
      );

      self.whitelistedAddresses.write(get_caller_address(), true);

      let numAddresses: u128 = self.numAddressesWhitelisted.read();
      self.numAddressesWhitelisted.write(numAddresses + 1);
    }

    fn check_address(self: @ContractState, address: ContractAddress) -> bool {
      self.whitelistedAddresses.read(address)
    }

    fn get_num_addresses(self: @ContractState) -> u128 {
      self.numAddressesWhitelisted.read()
    }

    fn get_max_addresses(self: @ContractState) -> u128 {
      self.maxWhitelistedAddresses.read()
    }
  }
}
```

<img src="https://web3arabs.com/courses/starknet/dapp/whitelist-file.png"/>

**دعونا نقوم بتوضيح كل سطر:**

● **السطر 1:** نقوم باستدعاء **ContractAddress** من **starknet** والتي تعمل كنوع بيانات.
● **السطر 3 - 9:** قمنا بإنشاء واجهة (trait) بإسم **IWhitelist** وقمنا بجمع الدوال فيها والتي هم 4 دوال حيث تسمح لنا الدالة الأولى بإضافة الشخص إلى القائمة (**whitelist**) - والثانية تقوم بالتحقق هل قام الشخص من الإنضمام او لا - والثالثة عدد الأشخاص الذين انضموا إلى whitelist - والرابعة عدد الأشخاص الذين يستطيعون الانضمام كحد أقصى.
● **السطر 11 و 12:** قمنا بالإعلان عن العقد الذكي بإسم **Whitelist**.
● **السطر 13:** قمنا باستدعاء **ContractAddress** و **get_caller_address** من **starknet** - حيث تعمل **ContractAddress** كنوع بيانات وهي **address** - و **get_caller_address** حيث يقوم بجلب ال **address** المتصل بالموقع او العقد أثناء الكتابة (تخزين البيانات).
● **السطر 15 - 20:** نريد تخزين ثلاثة متغيرات في **blockchain** وهم - المتغير **whitelistedAddresses** والذي يقوم بتخزين **mapping** بحيث يقوم بتخزين **عنوان الشخص كمفتاح** والقيمة عبارة عن **bool** والتي تحدد هل انضم (**true**) او لا (**false**) - والمتغير **maxWhitelistedAddresses** الحد الأقصى لعدد الأشخاص المسموح للإنضمام - والمتغير **numAddressesWhitelisted** والتي تحدد عدد الأشخاص الذين انضموا بحيث في كل مرة ينضم شخص ستزداد قيمة **المتغير** بواحد.
● **السطر 22 - 25:** نقوم بالإعلان عن دالة **constructor** التي سنقوم من خلالها بتمرير الحد الأقصى المسموح للإنضمام أثناء نشر العقد الذكي. وكما تلاحظ قمنا بتمرير <span dir="ltr">**_maxWhitelistedAddresses**</span> وكتابة القيمة في المتغير **maxWhitelistedAddresses**.
● **السطر 27 - 28:** قمنا بإنشاء **impl** خارجي بإسم **WhitelistImpl** وقمنا باستدعاء الواجهة **IWhitelist** في **impl** وتمرير حالة العقد (**ContractState**) الى الواجهة ومن ثم قمنا في بناء الأربعة دوال بكل سهولة.
● **السطر 29 - 43:** قمنا ببناء دالة **add_address_to_whitelist** بكل بساطة وقمنا بإضافة شروط بحيث لا يبدأ في تنفيذ الدالة إلا بالتحقق منها اولا عن طريق **assert** - يعبر الشرط الأول بحيث يقوم بالتحقق من أن الشخص الذي يريد الإنضمام لم ينضم من قبل والشرط الثاني يقوم بالتحقق ما إذا كان عدد الأشخاص الذين انضموا إلى **whitelist** أقل من الحد الأقصى. وفي **السطر 39** قمنا بإضافة الشخص الى **whitelist** بحيث العنوان المتصل بالعقد كمفتاح وقيمة **true** هي القيمة التي تعبر عن إنضمام الشخص. وفي **السطر 41** قمنا باستدعاء عدد المنضمين إلى المتغير **numAddresses** من اجل ان نقوم بزيادة واحد في كل مرة ينضم إليها الشخص في **السطر 42**.
● **السطر 45 - 55:** قمنا بإنشاء 3 دوال بحيث في الدالة الاولى تعيد قيمة ما إذا العنوان الذي قمنا بتمرير قد انضم أو لا - والدالة الثانية تقوم بإرجاع عدد الأشخاص الذين انضموا إلى **whitelist** - والدالة الثالثة تقوم بإرجاع الحد الأقصى من عدد الأشخاص الذين يمكنهم الانضمام.

قم بكتابة العقد مرة أخرى من أجل فهم كل ما تم كتابته بكل بساطة.

كما تحدثنا سابقاً الملف الاساسي لقراءة ملفات لغة cairo في المجلد **src** هو الملف **lib.cairo** فلذلك سنقوم باستدعاء ملف **whitelist.cairo** في الملف **lib.cairo** بواسطة الوحدات (**mod**) ومن ثم إدخال إسم الملف:

```rust
mod whitelist;
```

<img src="https://web3arabs.com/courses/starknet/dapp/lib-file.png"/>

## إنشاء RPC API

من أجل البدء في التعامل مع حساب محفظتك ونشر عقدك الذكي فنحن بالحاجة إلى **RPC API** والذي سيعمل كعُقدة (جهاز كمبيوتر).

سنقوم بإستخدام **Infura** للحصول على **API** لشبكة **Starknet** فلذلك قم بإنشاء حساب مباشرة ودعونا نكمل.

بعد ان تكمل من إنشاء حساب ويتم تحويلك إلى لوحة التحكم ستقوم بإنشاء مشروع وإضافة إسم له ومن ثم النقر على **CREATE**:

<img src="https://web3arabs.com/courses/starknet/dapp/infura-create-project.png"/>

بعد إنشاء المشروع سيظهر لك انواع الشبكات التي تريد تشغيلها. ستذهب للأسفل قليلاً وستقوم باختيار شبكة **GOERLI** في **Starknet**:

<img src="https://web3arabs.com/courses/starknet/dapp/infura-select-goerli.png"/>

بعد تحديد الشبكة ستقوم بالنقر على حفظ التعديلات في الأعلى:

<img src="https://web3arabs.com/courses/starknet/dapp/infura-save.png"/>

بعد النقر على حفظ التعديلات سيقوم في إعادتك مباشرة على الصفحة التي تحتوي على الرابط الخاص في مشروعك ستقوم بحفظه في جهازك لاننا سنعود إليه قريباً:

<img src="https://web3arabs.com/courses/starknet/dapp/infura-api.png"/>

## ربط المحفظه في المشروع

من أجل ربط حساب المحفظة في المشروع سنقوم بإنشاء توقيع المحفظة في **keystore** ومن ثم استدعاء بيانات المحفظة بكل سهولة.

ستقوم بإنشاء المجلدات لتخزين بيانات المحفظة في المشروع عن طريق إدخال هذا الامر اولا:

```bash
mkdir -p ./starkli-wallets/deployer
```

وفي أجهزة Mac و Linux:

```bash
mkdir -p ~/.starkli-wallets/deployer
```

<img src="https://web3arabs.com/courses/starknet/dapp/create-wallet-folder.png"/>

الآن سنقوم بإنشاء ملف **keystore** عن طريق تشغيل هذا الأمر:

```bash
starkli signer keystore from-key ./starkli-wallets/deployer/keystore.json
```

وفي أجهزة Mac و Linux:

```bash
starkli signer keystore from-key ~/.starkli-wallets/deployer/keystore.json
```

سيقوم بطلب منك إدخال المفتاح الخاص المتعلق بمحفظتك ستقوم بإدخال ومن ثم ستقوم بإدخال كلمة سر سيقوم بطلبها في كل مرة تريد التعامل مع المحفظة مثل نشر العقد الذكي فلذلك قم بحفظها وسيتم إنشاء ملف **keystore.json** في المجلد **deployer** مباشرة.

<img src="https://web3arabs.com/courses/starknet/dapp/create-keystore.png"/>

الآن سنقوم باستدعاء بيانات حساب المحفظة بكل بساطة عن طريق إدخال هذا الأمر:

```bash
starkli account fetch WALLET_ADDRESS --output ./starkli-wallets/deployer/account.json --rpc RPC_API
```

وفي أجهزة Mac و Linux:

```bash
starkli account fetch WALLET_ADDRESS --output ~/.starkli-wallets/deployer/account.json --rpc RPC_API
```

ستقوم بإستبدال **WALLET_ADDRESS** في عنوان محفظتك العام (الاساسي) واستبدال **RPC_API** في الرابط الذي قمت بإنشائه في الأعلى.

<img src="https://web3arabs.com/courses/starknet/dapp/fetch-account.png"/>

وبهذا الشكل ستلاحظ أنه قد تم إنشاء ملف **account.json** في المجلد **deployer**.

## إعداد بيئة ENV

بعد ان اصبح لدينا جميع بيانات المحفظة في المشروع ورابط **RPC API**, سنقوم بتخزين كل هذا في متغيرات في **env** من اجل أن نتمكن من نشر عقدنا الذكي بكل سهولة بعد ذلك.

في اجهزة Mac و Linux ستقوم بإدخال هذه الأوامر في **terminal**:

```bash
export STARKNET_ACCOUNT=~/.starkli-wallets/deployer/account.json
export STARKNET_KEYSTORE=~/.starkli-wallets/deployer/keystore.json
export STARKNET_RPC=RPC_API_URL
```

وفي أجهزة Windows ستقوم بإدخال هذه الأوامر في **terminal**:

```bash
set STARKNET_ACCOUNT=./starkli-wallets/deployer/account.json
set STARKNET_KEYSTORE=./starkli-wallets/deployer/keystore.json
set STARKNET_RPC=RPC_API_URL
```

ستقوم بإدخال رابط **RPC API** في المتغير **STARKNET_RPC**.

<img src="https://web3arabs.com/courses/starknet/dapp/set-env.png"/>

**ملاحظة:** لا تقوم بإغلاق terminal وفي كل مرة تقوم بإغلاق terminal ستحتاج إلى إضافة هذه مرة اخرى.

## تجميع ونشر العقد الذكي

ستقوم بتجربة العقد الذكي وتجميعه عن طريق إدخال هذا الأمر:

```bash
scarb build
```

<img src="https://web3arabs.com/courses/starknet/dapp/scarb-build.png"/>

ستلاحظ تم إنشاء مجلد **target** وفي داخله مجلد **dev** يحتوي على 2 ملفات.

كما تحدثنا في الدرس السابق من أجل  نشر (**Deploy**) العقد الذكي على الشبكة نحن بالحاجة إلى إرسال الكود إلى الشبكة عن طريق ما يسمى **Declare** ومن ثم إنشاء مثيل له على الشبكة من أجل التفاعل معها عن طريق **Deploy**.

ستقوم بإرسال العقد الذكي إلى الشبكة عن طريق تشغيل هذا الأمر:

```bash
starkli declare target/dev/starknet_whitelist_Whitelist.contract_class.json --compiler-version=2.4.0
```

وفي أجهزة Mac و Linux:

```bash
starkli declare ~/.target/dev/starknet_whitelist_Whitelist.contract_class.json
```

<img src="https://web3arabs.com/courses/starknet/dapp/declare-contract.png"/>

بعد إن قمت بإرسال الكود إلى الشبكة ستقوم بنسخ **Class hash** ومن ثم نشر العقد الذكي على الشبكة عن طريق تشغيل هذا الأمر:

```bash
starkli deploy CLASS_HASH ARG
```

ستقوم بإستبدال **CLASS_HASH** في **class hash** الذي تم إنشاؤه أثناء إرسال العقد الذكي إلى الشبكة. وبالنسبة إلى **ARG** ستقوم باستبدالها بالقيم التي تريد تمريرها في العقد الذكي. وبما أننا في العقد الذكي قمنا بتمرير المتغير <span dir="ltr">**_maxWhitelistedAddresses**</span> سنقوم بتمرير قيمة لهذا المتغير.

<img src="https://web3arabs.com/courses/starknet/dapp/deploy-contract.png"/>

كما تلاحظ قمنا بتمرير قيمة 10 في المتغير <span dir="ltr">**_maxWhitelistedAddresses**</span> الذي قمنا بتعريفه في الدالة **constructor**.

ستقوم بنسخ عنوان العقد الذكي الخاص بك وستذهب إلى <a href="testnet.starkscan.co" target="_blank">testnet.starkscan.co</a> وستقوم بوضع عنوان العقد الذكي في شريط البحث وسيتم فتحه مباشرة.

## الوصول إلى ABI

بعد إن قمت بفتح العقد الذكي الخاص بك على <a href="testnet.starkscan.co" target="_blank">testnet.starkscan.co</a>:

<img src="https://web3arabs.com/courses/starknet/dapp/starkscan-contarct.png"/>

ستقوم بالنقر على **Class Code/History**:

<img src="https://web3arabs.com/courses/starknet/dapp/starkscan-abi.png"/>

ستقوم الآن بنسخ **ABI** عن طريق النقر على الزر **Copy API Code** وستعود إلى المشروع الخاص بك وستقوم بإنشاء ملف بإسم **abi.json** وستقوم بإضافة كل ما نسخته إلى الملف:

<img src="https://web3arabs.com/courses/starknet/dapp/abi-file.png"/>

سنقوم بإستخدام الملف في الدرس القادم أثناء التفاعل مع العقد الذكي في الواجهة الأمامية.

كما هو الحال دائمًا، إذا كانت لديك أي أسئلة أو شعرت بالتعثر أو أردت فقط أن تقول مرحبًا، فقم بالإنضمام على <a href="https://t.me/Web3ArabsDAO" target="_blank">Telegram</a> او <a href="https://discord.gg/ykgUvqMc4Q" target="_blank">Discord</a> وسنكون أكثر من سعداء لمساعدتك!
