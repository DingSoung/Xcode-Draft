//
//  AEC.swift
//  Swift
//
//  Created by Alex D. on 15/7/27.
//
//

import Foundation

class Teacher {
    var tName : String
    
    init(name:String) {
        tName = name
        println("老师 \(tName) 实例初始化完成.")
    }
    deinit {
        println("老师 \(tName) 实例析构完成.")
    }
    
    func getName() -> String {
        return tName
    }
    func classing() {
        println("老师 \(tName) 正在给学生讲课.")
    }
    
    
}

func TestARC()
{
    var teacher:Teacher? = Teacher(name:"张三")  //实例化一个Teacher对象将指向一个变量，此时产生了一个强引用(就好像OC中的引用计数+1)
    var refteacher:Teacher? = teacher            //再次产生强引用即(引用计数再+1)
    var refteacher2:Teacher? = teacher      //再次产生强引用即(引用计数再+1)</span>
    
    
    refteacher = nil            //第一个引用对象为nil并没有使实例释放,(引用计数-1)
    teacher?.classing()         //正常
    teacher = nil               //第二个引用对象为nil并没有使实例释放,(引用计数-1)
    refteacher2!.classing()     //正常
    refteacher2 = nil           //第三个引用对象为nil此时已没有作何引用了，因此ARC回收，实例释放.(引用计数-1)最后引用计数为0，则自动调用析构
    refteacher2?.classing()     //不再有输出
}
