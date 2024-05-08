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
  const contractAddress = "0x07e614cfabb6c6d89a430561fd3ed1898ceda4330429d520e2d6946c3073963a"
  // الذي قمنا بإنشائه سابقاً هنا RPC API ستقوم بوضع رابط
  const RPC_API = "add_quicknode_rpc_api_url_here"

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
