Bmob And Swift4.0

懒得自己搭后台，索性寻觅一款好用的云后台平台。以前用过Bmob，还是不错的。但是不得不说他们的官方文档更新的太烂的，现在还是N年以前的版本，如果按照官方的文档来用一定满江红。所以自己写一个适用于Swift4.0的使用文档作为参考。

##导入BmobSDK——3步即可
* 第一步：下载最新的SDK[点击下载](https://bmob.cn/sdk/Bmob_iOS_SDK_v2.3.0-20180411.zip)，解压将BmobSDK.framework导入自己的项目里（官网的貌似不是最新的）
* 第二步：添加相关依赖库（官网的少了几个(#‵′)害得我报错好久）：
![MacDown Screenshot](http://bmob-cdn-21468.b0.upaiyun.com/2018/09/10/af89f79440a95c6c80a9c0f039053dae.png)
* 第三步：在Swift项目中创建一个头文件，添加一句代码（这步基本没有错的吧）：

~~~
#import <BmobSDK/Bmob.h>
~~~

验证一下：在**AppDelegate.swift**的`func application(_ application: UIApplication, didFinishLaunchingWithOption`里添加你所创立的应用密钥了。

~~~
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Bmob.register(withAppKey: "XXXXXXXXXXXXXXXXXX")

        return true
    }
~~~
运行一下没有报错~
###以上是BmobSDK的导入，接下来就是进入正题了
##添加

~~~
func save(){
        let chineseList:BmobObject = BmobObject(className: "ChineseList")
        chineseList.setObject("鸟", forKey: "chineseName")
        chineseList.setObject(5, forKey: "stroke")
        chineseList.saveInBackground { (isSuccessful, error) in
            if error != nil{
                print("error is \(String(describing: error?.localizedDescription))")
            }else{
                print("success")
            }
        }
    }
~~~


##查询
###单条数据查询
~~~

func search()  {
        let query:BmobQuery = BmobQuery(className: "ChineseList")
         query.getObjectInBackground(withId: "GgEW333L") { (obj, error) in
         if error != nil {
         //进行错误处理
         }else{
         if obj != nil{
         //得到ChineseName和cheatMode
         let chineseName = obj?.object(forKey: "chineseName") as! String
         print("ChineseName \(chineseName)")
         //打印objectId,createdAt,updatedAt
         print("objectid   \(String(describing: obj?.objectId))")
         print("createdAt  \(String(describing: obj?.createdAt))")
         print("updatedAt  \(String(describing: obj?.updatedAt))")
       }
    }
 }
         
~~~
###查询全部数据

~~~
func searchAll()  {

   query.findObjectsInBackground { (array, error) in
            if error != nil {
                //进行错误处理
            }else{
                let count:Int = (array?.count)!
                print(count)
                for i in 0 ..< count {
                    let obj = array![i] as! BmobObject
                    let chineseName = obj.object(forKey: "chineseName") as? String
                    let chineseStroke = obj.object(forKey: "stroke") as? Int
                    //打印汉字名字
                    print("汉字 \(String(describing: chineseName))的笔画是\(String(describing: chineseStroke))")
                    //打印objectId,createdAt,updatedAt
                    print("objectid   \(obj.objectId)")
                    print("createdAt  \(obj.createdAt)")
                    print("updatedAt  \(obj.updatedAt)")
                }
            }
        }
   }
~~~
