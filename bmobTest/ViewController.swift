//
//  ViewController.swift
//  bmobTest
//
//  Created by Mac on 2018/9/10.
//  Copyright © 2018年 JessicaFuMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        save()
        searchExample(notEqualTo: "鸟")
        //        remove()
        searchExample(lessThanOrEqualTo: 6)
    }
    //添加数据
    
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
    
    //    查询数据
    //    MARK: 查询单条数据
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
        
    }
    //    MARK:查询全部数据
    func searchAll() {
        let query:BmobQuery = BmobQuery(className: "ChineseList")
        
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
//    更多去看官方文档http://doc.bmob.cn/data/ios/swift_develop_doc/
    func searchExample(notEqualTo: String){
        let query:BmobQuery = BmobQuery(className: "ChineseList")
        query.whereKey("chineseName", notEqualTo: notEqualTo)
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
    func searchExample(lessThanOrEqualTo: Int){
        let query:BmobQuery = BmobQuery(className: "ChineseList")
        query.whereKey("stroke", lessThanOrEqualTo: lessThanOrEqualTo)
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
    //MARK:删除指定id的数据
    func remove() {
        
        let query:BmobObject = BmobObject(outDataWithClassName: "ChineseList", objectId: "69924cbbcb")
        query.deleteInBackground { (isSuccessful, error) in
            if (isSuccessful) {
                //删除成功后的动作
                print ("success");
            }else{
                print("delete error \(String(describing: error?.localizedDescription))")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

