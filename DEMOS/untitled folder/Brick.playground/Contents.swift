//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


class test: NSObject {
    var value1 = 3
    var value2 = 4
    
    init(a:Int, b:Int) {
        super.init()
        
        self.value1 = a
        self.value2 = b
        
        self.swep(&self.value1, b:&self.value2)
        
        print(value1)
    }
}
extension NSObject {
    func swep<T>(inout a:T, inout b:T) {
        let temp = a
        a = b
        b = temp
    }
}

let t = test(a: 2, b: 3)




func requestImage(url: String) throws -> UIImage? {
    guard let image =  UIImage(named: url) else {
        let error = NSError(domain: "url error", code: -1, userInfo: nil)
        throw error
    }
    return image
}

do {
    let image = try requestImage("/url")
} catch {
    print(error)
}



class testStatic: NSObject {
    static func test() {
        print("fuc called")
    }
}

testStatic.test()


class testInt: NSObject {
    var property: String
    
    init(property:String) {
        self.property = property    //init befor init
        
        super.init()
        
        //code here
    }
}








//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var view = UIView(frame: CGRectMake(0, 0, 200, 300))
view.backgroundColor = UIColor.redColor()


/**
参考结论:
https://www.v2ex.com/t/224104#;     结论是   能向银行借多少就借多少，能拖多少年就拖多少年。把自己的钱留下来投资，能赚钱，跑赢CPI就足够。
n年后的1W跟现在的1Q完全不同。另外楼市崩盘也是时间题，如果n年内崩盘，损失全大部分由银行承担，自己可以放弃，然后重新购房，自己付的越多，承受损失越
大。
*/

let beforePay = 50 * 10000.0 //当前房价
let firstPay = 0 * 10000.0 //首付
let periods = 30 * 12 //借贷时间
let interest = 5.15 * 0.01 //借贷年利率 2.2750%


/**
月还款
A=P×i×(1+i)n/[(1+i)n-1]
A为每期还款金额
P为本金(贷款数)
i为利率(须折算成月利率)
n为贷款期数(按月计算)
*/

func monthPays(principal:Double, interest:Double, periods:Int) -> [Double] {
    var array:[Double] = []
    let i = interest / 12.0
    for var n = 0; n < periods; n += 1 {
        let monthPay = principal * i * (1+i)/((1+i)/Double(n) - 1)
        array.append(monthPay)
    }
    return array
}
let _monthPays = monthPays(beforePay - firstPay, interest: interest, periods: periods)


/**
 总计还款
 */
func totalPayBack(monthPays:[Double]) -> Double {
    var sum = 0.0
    for monthPay in monthPays {
        sum += monthPay
    }
    return sum
}
let _totalPayBack = totalPayBack(_monthPays)




/**
如果个人会投资，月入出去月供，生活支出后有结余，按年投资
将当前投资成功保留以供购车，旅游，医疗，养老等，不作为月供
*/
let wage = 23000.0  //3年后 预估在上海的长期工作收入水平
let livingExpenses = 6000.0 //生活总支出
let investmentGrowthRate = 8.000 * 0.01 //均衡投资增长率

/**
每年剩余 = (工资 - 生活基本支出 - 月供) * 12个月
第1年 每年剩余 * (1 + 年投资增长)^借贷年数
第2年 每年剩余 * （(1 + 年投资增长)^借贷年数-1）
第3年 每年剩余 * （(1 + 年投资增长)^借贷年数－2)
...
总计自由资产
*/

func savedFund(wage:Double, livingExpenses:Double, monthPays:[Double]) -> Double {
    var sum = 0.0
    for var year = 1; year <= monthPays.count ; year += 1 {
        sum += (wage - livingExpenses - monthPays[year]) * 12 * pow(1 + investmentGrowthRate, Double(monthPays.count / 12))
    }
    return sum
}

let _savedFund = savedFund(wage, livingExpenses: livingExpenses, monthPays: _monthPays)


