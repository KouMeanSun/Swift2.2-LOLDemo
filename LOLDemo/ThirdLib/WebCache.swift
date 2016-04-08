//
//  WebCache.swift
//  SwiftPlaygroundDemo_111
//
//  Created by gaomingyang1987 on 16/4/2.
//  Copyright © 2016年 gaomingyang1987. All rights reserved.
//

import UIKit

class WebCache: NSObject {

    let DOWNLOAD_FILE_NAME  =  "WebCacheDir"
    
    var imageView:UIImageView!
    /**
     参数1 图片字符串url地址
     参数2 占位图片
     参数3 需要异步加载图片的imageview
     **/
    class  func  sd_setImageWithString(urlStr:String,placlHolder:String?,imageView:UIImageView){
        WebCache().setImageViewImageWithString(urlStr, placlHolder: placlHolder, imageView: imageView)
    }
 //=========
private   func setImageViewImageWithString(urlStr:String,placlHolder:String?,imageView:UIImageView) -> Void  {
        self.imageView = imageView
        if placlHolder != nil  {
            self.imageView.image = UIImage(named: placlHolder!)
        }
        if  !urlStr.isEmpty {
            //根据url字符串设置图片
            self.setImageWithUrl(urlStr)
        }
    }
    
 private   func setImageWithUrl(urlStr:String){
    //根据url判断本地沙盒是否存在该图片，存在则加载本地图片，不存在则从网络获取，并且存到沙盒中 
        let  path = self.getDownloadPath() + "/\(self.md5String(urlStr))"
        //print("图片path:\(path)")
    if NSFileManager.defaultManager().fileExistsAtPath(path) {
        self.imageView.image = UIImage(contentsOfFile: path)
     }else {
        //从网络获取图片！
        self.downLoadImageFromNet(urlStr, path: path)
     }
    
    }
    /**
     参数1 图片网络地址
     参数2 本地路经
     **/
    private func downLoadImageFromNet(urlStr:String,path:String){
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let url  = NSURL(string: urlStr)!
        let downLoadTask = session.downloadTaskWithURL(url) { (location, response, error) in
          // print("(location?.path)!:\((location?.path)!)")
//           try! NSFileManager.defaultManager().moveItemAtPath((location?.path)!, toPath: path)
            if error != nil {
            print("下载图片失败！error:\(error)")
            }else {
            
           try!  NSFileManager.defaultManager().moveItemAtPath(location!.path!, toPath: path)
           dispatch_async(dispatch_get_main_queue(), {
            self.imageView.image = UIImage(contentsOfFile: path)
           })
         }
        }
        downLoadTask.resume()
    }
    
    /**
     获取图片在沙盒的路径
     **/
  private  func getDownloadPath()->String {
        var path:String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        //拼接缓存图片文件夹路径，不存在则创建
        path = path.stringByAppendingString("/\(DOWNLOAD_FILE_NAME)")
        
        if !NSFileManager.defaultManager().fileExistsAtPath(path) {
//            NSFileManager.defaultManager().createFileAtPath(path, contents: nil, attributes: nil)
        try!  NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
        }
        return path
    }
    
    /**
    格式化URL地址
     **/
 private  func md5String(str:String) -> String{
        let cStr = (str as NSString).UTF8String
        let buffer = UnsafeMutablePointer<CUnsignedChar>.alloc(16)
        CC_MD5(cStr,(CC_LONG)(strlen(cStr)), buffer)
        let md5String = NSMutableString()
        for var i = 0; i < 16; ++i{
            md5String.appendFormat("%02x", buffer[i])
        }
        
        free(buffer)
        return md5String as String
    }
    ///========读取框架的缓存文件夹的大小
    /**
     获取缓存大小
     **/
    class func getDownloadCacheSize() ->String{
        let cache = WebCache()
        let length = cache.getCacheSize()
        let size:Double = Double(length)
        if (size < 1024.0){
            return "\(String(format: "%.2f", size))B"
        }else if (size>1024.0 && size < 1024.0*1024.0){
            return "\(String(format: "%.2f", size/1024))KB"
            
        }else if(size>1024.0*1024.0 && size < 1024.0*1024.0*1024.0){
            return "\(String(format: "%.2f", size/1024.0/1024.0))MB"
            
        }else {
            return "\(String(format: "%.2f", size/1024.0/1024.0/1024.0))GB"
        }
    }
    
 private   func getCacheSize() ->UInt64{
        var total:UInt64 = 0
        let fileEnumerator = NSFileManager.defaultManager().enumeratorAtPath(self.getDownloadPath())
        for fileName in fileEnumerator! {
            let filePath = self.getDownloadPath().stringByAppendingString("/\(fileName)")
            let atts:NSDictionary = try! NSFileManager.defaultManager().attributesOfItemAtPath(filePath)
            let length = atts.fileSize()
            total += length
            
        }
        return total
    }
    //===========清除图片缓存方法
    /**
     清除图片缓存方法
     **/
    class func clearCache(){
        WebCache().clearDownLoadCache()
    }
    
    
 private   func clearDownLoadCache(){
        let fileEnumerator = NSFileManager.defaultManager().enumeratorAtPath(self.getDownloadPath())
        for fileName in fileEnumerator! {
            let filePath  = self.getDownloadPath().stringByAppendingString("/\(fileName)")
            try! NSFileManager.defaultManager().removeItemAtPath(filePath)
        }
    }

}
