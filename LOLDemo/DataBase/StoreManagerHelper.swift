//
//  StoreManagerHelper.swift
//  LOLDemo
//
//  Created by gaomingyang1987 on 16/4/7.
//  Copyright © 2016年 gaomingyang1987. All rights reserved.
//

import UIKit

class StoreManagerHelper: NSObject {

    private  static let my_FMDatabaseQueue = FMDatabaseQueue(path: DataBasePre.getDataBasePath())
    
    class   func getSharedDatabaseQueue() ->FMDatabaseQueue{
        return my_FMDatabaseQueue
    }
    
    override init() {
        print("StoreManagerHelper初始化了一次")
    }
}
