<h1 id="toc_0">Bmob And Swift4.0</h1>

<p>懒得自己搭后台，索性寻觅一款好用的云后台平台。以前用过Bmob，还是不错的。但是不得不说他们的官方文档更新的太烂的，现在还是N年以前的版本，如果按照官方的文档来用一定满江红。所以自己写一个适用于Swift4.0的使用文档作为参考。</p>

<h2 id="toc_1">导入BmobSDK——3步即可</h2>

<ul>
<li>第一步：下载最新的SDK<a href="https://bmob.cn/sdk/Bmob_iOS_SDK_v2.3.0-20180411.zip">点击下载</a>，解压将BmobSDK.framework导入自己的项目里（官网的貌似不是最新的）</li>
<li>第二步：添加相关依赖库（官网的少了几个(#‵′)害得我报错好久）：
<img src="http://bmob-cdn-21468.b0.upaiyun.com/2018/09/10/af89f79440a95c6c80a9c0f039053dae.png" alt="MacDown Screenshot"></li>
<li>第三步：在Swift项目中创建一个头文件，添加一句代码（这步基本没有错的吧）：</li>
</ul>

<div><pre class="line-numbers"><code class="language-none">#import &lt;BmobSDK/Bmob.h&gt;</code></pre></div>

<p>验证一下：在<strong>AppDelegate.swift</strong>的<code>func application(_ application: UIApplication, didFinishLaunchingWithOption</code>里添加你所创立的应用密钥了。</p>

<div><pre class="line-numbers"><code class="language-none">func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -&gt; Bool {
        // Override point for customization after application launch.
        Bmob.register(withAppKey: &quot;XXXXXXXXXXXXXXXXXX&quot;)

        return true
    }</code></pre></div>

<p>运行一下没有报错~</p>

<h3 id="toc_2">以上是BmobSDK的导入，接下来就是进入正题了</h3>

<h2 id="toc_3">添加</h2>

<div><pre class="line-numbers"><code class="language-none">func save(){
        let chineseList:BmobObject = BmobObject(className: &quot;ChineseList&quot;)
        chineseList.setObject(&quot;鸟&quot;, forKey: &quot;chineseName&quot;)
        chineseList.setObject(5, forKey: &quot;stroke&quot;)
        chineseList.saveInBackground { (isSuccessful, error) in
            if error != nil{
                print(&quot;error is \(String(describing: error?.localizedDescription))&quot;)
            }else{
                print(&quot;success&quot;)
            }
        }
    }</code></pre></div>

<h2 id="toc_4">查询</h2>

<h3 id="toc_5">单条数据查询</h3>

<div><pre class="line-numbers"><code class="language-none">
func search()  {
        let query:BmobQuery = BmobQuery(className: &quot;ChineseList&quot;)
         query.getObjectInBackground(withId: &quot;GgEW333L&quot;) { (obj, error) in
         if error != nil {
         //进行错误处理
         }else{
         if obj != nil{
         //得到ChineseName和cheatMode
         let chineseName = obj?.object(forKey: &quot;chineseName&quot;) as! String
         print(&quot;ChineseName \(chineseName)&quot;)
         //打印objectId,createdAt,updatedAt
         print(&quot;objectid   \(String(describing: obj?.objectId))&quot;)
         print(&quot;createdAt  \(String(describing: obj?.createdAt))&quot;)
         print(&quot;updatedAt  \(String(describing: obj?.updatedAt))&quot;)
       }
    }
 }
         </code></pre></div>

<h3 id="toc_6">查询全部数据</h3>

<div><pre class="line-numbers"><code class="language-none">func searchAll()  {

   query.findObjectsInBackground { (array, error) in
            if error != nil {
                //进行错误处理
            }else{
                let count:Int = (array?.count)!
                print(count)
                for i in 0 ..&lt; count {
                    let obj = array![i] as! BmobObject
                    let chineseName = obj.object(forKey: &quot;chineseName&quot;) as? String
                    let chineseStroke = obj.object(forKey: &quot;stroke&quot;) as? Int
                    //打印汉字名字
                    print(&quot;汉字 \(String(describing: chineseName))的笔画是\(String(describing: chineseStroke))&quot;)
                    //打印objectId,createdAt,updatedAt
                    print(&quot;objectid   \(obj.objectId)&quot;)
                    print(&quot;createdAt  \(obj.createdAt)&quot;)
                    print(&quot;updatedAt  \(obj.updatedAt)&quot;)
                }
            }
        }
   }</code></pre></div>
