//
//  HTTPConnection.swift
//  SwiftPlaygroundDemo_111
//
//  Created by gaomingyang1987 on 16/4/1.
//  Copyright © 2016年 gaomingyang1987. All rights reserved.
//

import UIKit

typealias RequestCallBack = (NSData?,NSError?) ->Void

protocol HTTPConnectionDelegate:NSObjectProtocol {
    func finishConnection(data:NSData)
    func failedConnection(error:NSError)
    
}


class HTTPConnection: NSObject {

//定义一个全局变量的闭包，来接收传进来的闭包
    var block:RequestCallBack!
//定义一个全局的代理，来接收传进来的代理
    var delegate:HTTPConnectionDelegate!
    
   /**
     参数1 请求url字符串
     参数2 http请求参数
     参数3 回调闭包
    **/
 class  func getRequestWithUrl(url:String,param:NSDictionary?,callBack:RequestCallBack){
    HTTPConnection().getRequest(url, param: param, callBack: callBack)
    }
    /**
     参数1 请求url字符串
     参数2 http请求参数
     参数3 回调代理
     **/
    class func  postRequestWithUrl(url:String,param:NSDictionary?,del:HTTPConnectionDelegate){
    HTTPConnection().postRequest(url, param: param, delegate: del)
    }
//=========对应类方法的对象方法
private   func getRequest(url:String,param:NSDictionary?,callBack:RequestCallBack){
    self.block = callBack
    var myUrl = url
    //判断是否有请求参数传进来
        if param != nil  {
            var list:Array<String> = Array<String>()
            //遍历请求参数字典
            for dict in param! {
//             print("dict:\(dict)")
//             print("key:\(dict.0)")
//             print("value:\(dict.1)")
            //我们可以看到，遍历后的字典是个元组，重新拼接key，value，
            let tmp = "\(dict.0)=\(dict.1)"
            list.append(tmp)
            }
          //数组转字符串
         let  paramStr = list.joinWithSeparator("&")
         
         //拼接完整url字符串
         myUrl = url.stringByAppendingString("?\(paramStr)")
        }
       print("myUrl:\(myUrl)")
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    let session = NSURLSession(configuration: config)
    let dataTask = session.dataTaskWithURL(NSURL(string: myUrl)!) { (data, response, error) in
        if self.block != nil {
        self.block(data,error)
        }
        }
    dataTask.resume()
    }
    
//--------对应post类方法的对象方法
  private  func postRequest(urlStr:String,param:NSDictionary?,delegate:HTTPConnectionDelegate){
    self.delegate = delegate
    let url = NSURL(string: urlStr)!
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
    if param != nil {
        var list:Array<String> = Array<String>()
        //遍历请求参数字典
        for dict in param! {
            //             print("dict:\(dict)")
            //             print("key:\(dict.0)")
            //             print("value:\(dict.1)")
            //我们可以看到，遍历后的字典是个元组，重新拼接key，value，
            let tmp = "\(dict.0)=\(dict.1)"
            list.append(tmp)
        }
        //数组转字符串
        let  paramStr = list.joinWithSeparator("&")
        //字符串转化为NSData
        let paramData = paramStr.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = paramData
    }
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    let session = NSURLSession(configuration: config)
    let dataTask = session.dataTaskWithRequest(request) { (data, response, error) in
        
        if error == nil {
            let canDo:Bool = self.delegate.respondsToSelector(Selector("finishConnection:"))
            if canDo {
            self.delegate.finishConnection(data!)
            }
        }else {
            let canDo:Bool = self.delegate.respondsToSelector(Selector("failedConnection:"))
            if canDo {
            self.delegate.failedConnection(error!)
            }
        }
    }
    dataTask.resume()
    
    }
    
}
