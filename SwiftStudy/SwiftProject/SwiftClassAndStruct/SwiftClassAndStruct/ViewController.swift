//
//  ViewController.swift
//  SwiftClassAndStruct
//
//  Created by lz on 16/3/31.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var label: UILabel = {
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        label.center = self.view.center
        label.textAlignment = .Center
        self.view.addSubview(label)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.redColor();
        label.text = SomeClass.init().name
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        equalTest()
    }
    // struct为let时不能直接使用懒加载
    func structWithLazy() {
        var someStruct = SomeStructure()
        label.text = SomeStructure().age + someStruct.name // 结构体默认生成的是let类型，包含lazy属性的结构体只能为var
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * 2))
        dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                var newStruct = SomeStructure(name: "newStruct", age: "100")
                self.label.text = newStruct.name + newStruct.age
            });
        }
    }
    // 验证struct是值类型
    func structIsValue() {
        var someStruct1 = SomeStructure(name: "Lily",age: "21")
        let someStruct2 = someStruct1;
        someStruct1.age = "223"
        print("struct1.age = \(someStruct1.age) and struct2.age = \(someStruct2.age)")
        // 打印结果:struct1.age = 223 and struct2.age = 21
    }
    // 验证class是引用类型
    func classWithValue() {
        let someClass1 = SomeClass.init()
        print("class1 name is \(someClass1.name)")
        let someClass2 = someClass1
        someClass2.name = "newPerson"
        print("class1 name is \(someClass1.name)")
        // 打印结果:class1 name is Class
                //:class1 name is newPerson
    }
    
    // 等于和等价于
    func equalTest() {
        let dict = ["name":"Tom","age":"21"]
        var newDcit = dict
        if dict == newDcit {
            print("相等")
        }
        newDcit["name"] = "Lily"
        if (dict == newDcit) { // 等价于似乎只能用于引用类型之间的比较
            print("还是相等")
        }
        print("dict : \(dict) newDict : \(newDcit)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

