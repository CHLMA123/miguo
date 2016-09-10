# miguo

/**
*  1 KVO（iOS）
*/

KVO == Key Value Observing

/*
KVO的原理:
    只要给一个对象注册一个监听, 那么在运行时, 系统就会自动给该对象生成一个子类对象, 
    并且重写自动生成的子类对象的被监听属性的set方法, 然后在set方法中通知监听者
    NSKVONotifying_Person
*/

1. KVO的作用：

    可以监听某个对象属性的改变

2. KVO的内部实现原理：

    KVO是基于runtime机制实现的
    当某个类的属性对象第一次被观察时，系统就会在运行期间动态地创建该类的一个派生类，在这个派生类中重写基类的任何被观察属性的setter方法。派生类在被重写的setter方法内实现真正的通知机制
    如果原类为Person，那么生成的派生类名为NSKVONotifying_Person
    我们知道，每一个类中都有一个isa指针指向当前类，所有系统就是在当一个类的对象第一次被观察的时候，系统就会偷偷将isa指针指向动态生成的派生类，从而在被监听属性赋值时被执行的是派生类的setter方法
    键值观察通知依赖于NSObject 的两个方法: willChangeValueForKey: 和 didChangevlueForKey:；在一个被观察属性发生改变之前， willChangeValueForKey: 一定会被调用，这就 会记录旧的值。而当改变发生后，didChangeValueForKey: 会被调用，继而 observeValueForKey:ofObject:change:context: 也会被调用。

    补充：KVO的这套实现机制中苹果还偷偷重写了class方法，让我们误认为还是使用的当前类，从而达到隐藏生成的派生类 

3. 用法：

    创建对象，然后设置监听对象属性变化，
    然后设置监听变化方法observeValueForKeyPath....监听模型属性发生变化就会调用此方法，
    最后要记得从对象上移除监听。

4. 注意:

    KVO只能监听通过set方法修改的值
    如果使用KVO监听某个对象的属性, 当对象释放之前一定要移除监听
    经典错误：reason: 'An instance 0x7f9483516610 of class Person was deallocated while key value observers were still registered with it.


