//
//  ViewController.swift
//  SwinjectDemo
//
//  Created by Songwen on 2018/8/29.
//  Copyright © 2018 Songwen. All rights reserved.
//

import UIKit
import Swinject

protocol Animal {
    var name: String { get }
}

class Cat: Animal {
    let name: String = "Mini"
    func catchMouse() {
        print("catch mouse")
    }
}

class Dog: Animal {
    let name: String
    init(name: String) {
        self.name = name
    }
    func keepDoor() {
        print("keep door")
    }
}

class Person {
    let pet: Animal

    init(pet: Animal) {
        self.pet = pet
    }

    func play() {
        let name = pet.name
        print("I'm playing with \(name).")
    }
}

func normal() {
    // 正常的操作
    let cat = Cat()
    let personWithCat = Person(pet: cat)
    personWithCat.play()

    let dog = Dog(name: "WangWang")
    let personWithDog = Person(pet: dog)
    personWithDog.play()
}

func inject() {
    let container: Container = {
        let c = Container()
        c.register(Animal.self) { _ in
            // animal default is cat
            Cat()
        }
        c.register(Dog.self, factory: { (r: Resolver, n: String) -> Dog in
            // dog is dog
            Dog(name: n)
        })
        c.register(Person.self) { (r: Resolver, a: Animal) -> Person in
            return Person(pet: a)
        }
        return c
    }()

    guard let cat = container.resolve(Animal.self) else { return }
    let personWithCat = container.resolve(Person.self, argument: cat as Animal) // 这里必须 as Animal, 与register的 block 绝对的一致, 为了避免失效, 可以统一规范
    personWithCat?.play()
    
    guard let dog = container.resolve(Dog.self, argument: "Wangwang") else { return }
    let personWithDog = container.resolve(Person.self, argument: dog as Animal)
    personWithDog?.play()
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        normal()
        inject()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

