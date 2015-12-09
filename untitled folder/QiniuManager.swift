//
//  QiniuManager.swift
//  summer
//
//  Created by Alex D. on 15/8/12.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import Qiniu
class QiniuManager {
    
    static let instance = QiniuManager()
    var upManager:QNUploadManager?
    private init() {
        upManager = QNUploadManager()
    }
    
    //MARK: 上传文件
    func upload(token:String, data:NSData, key:String, process:((key:String, percent:Float)->Void)?, complete:((info:QNResponseInfo, key:String, resp:NSDictionary?)->Void)?, cancel:(()->Bool)?) {
        let opt = QNUploadOption(mime: "text/plain", progressHandler: { (key, percent) -> Void in
            print(key)
            process?(key: key, percent: percent)
            }, params: ["x:foo" : "fooval"], checkCrc: true) { () -> Bool in
                //取消
                if let block = cancel?() {
                    return block
                }else {
                    return false
                }
        }
        upManager?.putData(data, key: key, token: token, complete: { (info, key, resp) -> Void in
            complete?(info: info, key: key, resp: resp)
            }, option: opt)
    }
    
    //MARK: 断点续传
    func upload(folder:String, token:String, data:NSData, key:String, process:((key:String, percent:Float)->Void)?, complete:((info:QNResponseInfo, key:String, resp:NSDictionary?)->Void)?, cancel:(()->Bool)?) {
        do {
            //写标记
            self.upManager = try QNUploadManager(recorder: QNFileRecorder(folder: folder))
        } catch {
            self.upManager = QNUploadManager()
            print("启动断点续传失败\(error),自动切换到连续上传")
        }
        self.upload(token, data: data, key: key, process: process, complete: { (info, key, resp) -> Void in
            self.upManager = QNUploadManager()
            complete?(info: info, key: key, resp: resp)
            }) { () -> Bool in
                let isTrue = cancel?()
                if isTrue == true {
                    self.upManager = QNUploadManager()
                    return true
                }
                return false
        }
    }
}
