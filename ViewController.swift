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
        search()
//        remove()

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
    func search()  {
        let query:BmobQuery = BmobQuery(className: "ChineseList")
        /*查询单条数据
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
         */
        //        遍历全部数据
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
    //删除数据
    func remove() {
//        let query:BmobQuery = BmobQuery(className: "ChineseList")

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

