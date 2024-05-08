# بناء الواجهة الأمامية لمشروع Whitelist بواسطة Nextjs

بعد ان انتهينا من كتابة عقدنا الذكي وتجربته بشكل كامل واختباره يمكننا الان رؤيته يعمل على الواجهة الامامية (Front-end).

## المتطلبات الاساسية للبدء في هذا الدرس:

1. انتهيت من قراءة درس <a href="https://web3arabs.com/courses/3d88b1a4-ad68-400b-94d3-df89a5f95cfd/lessons/66915c5e-6a7e-433c-a5ee-b072009342d1" target="_blank">**بناء عقد ذكي لمشروع Whitelist**</a>
2. يمكنك التعامل مع لغة البرمجة **JavaScript**.
3. يمكنك التعامل مع <a href="https://web3arabs.com/courses/d64bee08-2e38-4ad5-958e-5ab6c42ebb41/lessons/bb49c32a-911f-4a71-b6e5-3c5f5f981360" target="_blank">**مكتبة React/Nextjs**</a>.

في هذا الدرس سنقوم بإستخدام إطار العمل Next.js و TailwindCSS من اجل بناء واجهة الموقع.

قم بتشغيل هذا الامر في مجلد المشروع **starknet_whitelist**:

```bash
npx create-next-app@latest frontend
```

<img src="https://web3arabs.com/courses/starknet/dapp/create-next.png"/>

سنحتاج الان الى تثبيت **starknet.js** و **get-starknet** والتي ستساعدنا في التعامل مع العقد الذكي وإرسال المعاملات وربط المحفظة بالموقع. قم بكتابة هذا على **terminal**:

**ملاحظة:** تأكد من تشغيل هذا الأمر في المجلد **frontend** المتعلق بمشروع Next.js.

```bash
npm install starknet get-starknet
```

ستذهب الى مجلد **app** وستقوم بفتح الملف **globals.css** وستبقي هذه الاوامر في الملف:

```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

<img src="https://web3arabs.com/courses/starknet/dapp/globals-css.png"/>

الان اذهب الى الملف **page.js** في المجلد **app** وقم بلصق هذا الكود ومتابعة الشرح من التعليقات المتواجدة اعلى كل سطر.

```jsx
"use client"
import { useState, useEffect } from 'react'
// الخاص بالعقد الذكي الذي قمنا بحفظه في نهاية الدرس السابق ABI إستدعاء
import contractAbi from '../../abi.json'
// والتي تعمل على ربط المحفظة get-starknet من المكتبة connect إستدعاء دالة
import { connect } from 'get-starknet'
// الذي يعمل للتفاعل والعمل على العقد الذكي Contract الذي يعمل كمُزود وProvider إستدعاء
import { Contract, Provider } from 'starknet'

export default function Home() {
  // ستقوم بوضع عنوان عقدك الذكي هنا من اجل استخدامه لاحقاً
  const contractAddress = "add_contract_address_here"
  // الذي قمنا بإنشائه سابقاً هنا RPC API ستقوم بوضع رابط
  const RPC_API = "add_infura_rpc_api_url_here"

  // ستقوم بتخزين عنوان المحفظة التي ستتصل بالتطبيق
  const [account, setAccount] = useState(null)
  // تخزين التحقق من اتصال المحفظة
  const [walletConnected, setWalletConnected] = useState(false)
  // او لا whitelist تخزين التحقق ما إذا كان المستخدم انضم إلى
  const [joinedWhitelist, setJoinedWhitelist] = useState(false)
  // سنقوم بإستخدامها من اجل الحالات التي بالحاجة الى إنتظار
  const [loading, setLoading] = useState(false)
  // Whitelist تخزين عدد الذي انضموا إلى
  const [numberOfWhitelisted, setNumberOfWhitelisted] = useState(0)
  // تخزين اقصى عدد الأشخاص الذين يمكنهم الإنضمام
  const [maxNumberOfWhitelisted, setMaxNumberOfWhitelisted] = useState(0)

  // تعمل هذه الوظيفة على مراقبة اتصال المحفظة بالتطبيق بشكل مستمر
  const connectWallet = async () => {
    // بربط التطبيق بالمحفظة connect تقوم دالة
    const connection = await connect()

    // إضافة شرط بالتحقق من إنتهاء ربط المحفظة بنجاح
    if (connection && connection.isConnected) {
      // تخزين عنوان محفظة المتصل بالتطبيق
      setAccount(connection.account)
      setWalletConnected(true)
    }
  }

  // تقوم الدالة بإستدعاء العدد الأقصى للاشخاص الذين يمكنهم الإنضمام
  const getMaxNumberOfWhitelisted = async () => {
    try {
      // من اجل التفاعل مع العقد الذكي وقراءة البيانات من البلوكتشين Provider يتم إستخدام
      const provider = new Provider({ rpc: { nodeUrl: RPC_API } })
      // Provider والعنوان والمُزود ABI قمنا بإستدعاء العقد الذكي الخاص بنا عن طريق إدخال
      const mycontract = new Contract(contractAbi, contractAddress, provider)
      // get_max_addresses إستدعاء القيمة من الدالة
      const num = await mycontract.get_max_addresses()
      // تخزين القيمة
      setMaxNumberOfWhitelisted(num.toString())
    } catch (err) {
      // يقوم بطباعة اي مشكلة قد تحدث اثناء تشغيل الدالة
      alert(err.message)
    }
  }

  // Whitelist تقوم الدالة بإستدعاء عدد الأشخص الذي انضموا إلى
  const getNumberOfWhitelisted = async () => {
    try {
      // من اجل التفاعل مع العقد الذكي وقراءة البيانات من البلوكتشين Provider يتم إستخدام
      const provider = new Provider({ rpc: { nodeUrl: RPC_API } })
      // Provider والعنوان والمُزود ABI قمنا بإستدعاء العقد الذكي الخاص بنا عن طريق إدخال
      const mycontract = new Contract(contractAbi, contractAddress, provider)
      // get_num_addresses إستدعاء القيمة من الدالة
      const num = await mycontract.get_num_addresses()
      // تخزين القيمة
      setNumberOfWhitelisted(num.toString())
    } catch (err) {
      // يقوم بطباعة اي مشكلة قد تحدث اثناء تشغيل الدالة
      alert(err.message)
    }
  }

  const checkIfAddressInWhitelist = async () => {
    try {
      // من اجل التفاعل مع العقد الذكي وقراءة البيانات من البلوكتشين Provider يتم إستخدام
      const provider = new Provider({ rpc: { nodeUrl: RPC_API } })
      // Provider والعنوان والمُزود ABI قمنا بإستدعاء العقد الذكي الخاص بنا عن طريق إدخال
      const mycontract = new Contract(contractAbi, contractAddress, provider)
      // check_address إستدعاء القيمة من الدالة
      // check_address كما تلاحظ قمنا أيضاً بتمرير عنوان المحفظة المتصلة بالموقع إلى الدالة
      const check = await mycontract.check_address(account.address)
      // تخزين القيمة
      setJoinedWhitelist(check)
    } catch (err) {
      // يقوم بطباعة اي مشكلة قد تحدث اثناء تشغيل الدالة
      alert(err.message)
    }
  }

  // whitelist تعمل الدالة على إضافة المتصل بالموقع إلى
  const addAddressToWhitelist = async () => {
    try {
      // وعنوان العقد الذكي وحساب محفظة المتصل ABI قمنا بإستدعاء العقد الذكي الخاص بنا عن طريق إدخال
      // لان الهدف الكتابة على العقد فنحن بالحاجة إلى توقيع المستخدم Provider كما تلاحظ لم نقوم بإدخال
      const contract = new Contract(contractAbi, contractAddress, account)
      // كحالة إنتظار loading تفعيل
      setLoading(true)
      // add_address_to_whitelist بواسطة دالة whitelist إضافة المستخدم إلى
      await contract.add_address_to_whitelist()
      // يقوم بطباعة النص عند الإنتهاء من إضافة الشخص
      alert("You successfully incremented the counter!")
      // لكونه أنتهئ من إضافة الشخص loading إيقاف
      setLoading(false)
    } catch (err) {
      // يقوم بطباعة اي مشكلة قد تحدث اثناء تشغيل الدالة
      alert(err.message)
      // لكون الدالة توقفت عن العمل بسبب مشكلة ما loading إيقاف
      setLoading(false)
    }
  }

  // تمثل المصفوفة في نهاية استدعاء الوظيفة ما هي تغييرات الحالة التي ستؤدي إلى هذا التغيير
  // في هذه الحالة كلما تغيرت قيم الوظيفتين سيتم استدعاء هذا التغيير مباشرة
  useEffect(() => {
    connectWallet()
    getMaxNumberOfWhitelisted()
    getNumberOfWhitelisted()

    if(walletConnected) {
      checkIfAddressInWhitelist()
    }
    
  }, [walletConnected])

  // React يقوم بمراقبة حالة الزر يمكنك قرائته بشكل جيد وفهم ما يحدث كمطور
  const renderButton = () => {
    if (walletConnected) {
      if (joinedWhitelist) {
        return (
          <div className="text-[1.2rem] my-8 leading-[1]">
            Thanks for joining the Whitelist!
          </div>
        )
      } else if (loading) {
        return <div className="rounded-[4px] bg-blue-800 border-none text-white text-[15px] p-[20px] w-[200px] cursor-pointer mb-[2%]">Loading...</div>;
      } else {
        return (
          <button 
            onClick={addAddressToWhitelist} 
            className="rounded-[4px] bg-blue-800 border-none text-white text-[15px] p-[20px] w-[200px] cursor-pointer mb-[2%]"
          >
            Join the Whitelist
          </button>
        )
      }
    } else {
      return (
        <button onClick={connectWallet} className="rounded-[4px] bg-blue-800 border-none text-white text-[15px] p-[20px] w-[200px] cursor-pointer mb-[2%]">
          Connect your wallet
        </button>
      )
    }
  }

  return (
    <div>
      <div style={{ fontFamily: '"Courier New", Courier, monospace' }} className="min-h-[90vh] flex flex-row justify-center items-center">
        <div>
          <h1 className="text-[2rem] my-8">Welcome to Starknet Devs!</h1>
          <div className="text-[1.2rem] my-8 leading-[1]">
            Its an Whitelist collection for developers in Starknet.
          </div>
          <div className="text-[1.2rem] my-8 leading-[1]">
            {numberOfWhitelisted}/{maxNumberOfWhitelisted} have already joined the Whitelist.
          </div>
          {renderButton()}
        </div>
      </div>
    </div>
  )
}
```

<img src="https://web3arabs.com/courses/starknet/dapp/page-file.png"/>

يعمل الكود السابق بإختصار شديد على تشغيل العقد الذكي او المشروع الذي قمنا ببناء عقده (**Whitelist**) في الواجهة الامامية بحيث يتمكن المستخدم من ربط محفظته واضافة المهام وتحديثها وازالتها.

```js
// ستقوم بوضع عنوان عقدك الذكي هنا من اجل استخدامه لاحقاً
const contractAddress = "add_contract_address_here"
// الذي قمنا بإنشائه سابقاً هنا RPC API ستقوم بوضع رابط
const RPC_API = "add_infura_rpc_api_url_here"
```

لقد قمنا أولاً بإضافة عنوان العقد الذكي الخاص بنا الذي قمنا بنشره على شبكة **starknet goerli** الإختبارية في المتغير (**contractAddress**) ومن ثم قمنا بإضافة رابط **RPC API** الذي قمنا بإنشائه في الدرس السابق.

يمكنك تجربة تطبيقك الان على - <a href="http://localhost:3000" target="_blank">localhost:3000</a> - عن طريق إدخال هذا الأمر:

```bash
npm run dev
```

إنه يعمل, لقد انتهيت من بناء تطبيق DApps بنجاح 🥳🥳

<img src="https://web3arabs.com/courses/starknet/dapp/frontend-home.png"/>

يمكنك الوصول الى المشروع بشكل مباشر على <a href="https://github.com/Web3Arabs/Whitelist-Dapp" target="_blank"> GitHub من هنا</a>

كما هو الحال دائمًا، إذا كانت لديك أي أسئلة أو شعرت بالتعثر أو أردت فقط أن تقول مرحبًا، فقم بالإنضمام على <a href="https://t.me/Web3ArabsDAO" target="_blank">Telegram</a> او <a href="https://discord.gg/ykgUvqMc4Q" target="_blank">Discord</a> وسنكون أكثر من سعداء لمساعدتك!
