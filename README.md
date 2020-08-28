# lua oop framework

## 使用说明

1. 引入 Class.lua
    ```
    require "oop.Class"
    ```

2. 创建一个类
    ```
    BaseClass = class("BaseClass")

    function BaseClass.__create()
        
        ---@class BaseClass
        local Instance = {}
        
        function Instance:ctor(param)
            
        end
        
        function Instance:Call()
            
        end
        
        return Instance
    end
    ```

3. 继承一个类

    ```
    SubClass          = class("SubClass", BaseClass)

    SubClass.__create = function()
        
        local Instance = {}
        
        function Instance:ctor()
            
            --调用父类构造函数
            self.super:ctor("ParamFromSubClass")
        end
        
        function Instance:Call()

            --调用父类方法
            self.super:Call()
        end
                
        return Instance
    end
    ```

## 类的静态变量支持


1. 静态变量的定义

    ```
    SubClass          = class("SubClass", BaseClass)

    SubClass.static =
    {
        NAME = "static name"
    }

    SubClass.__create = function()
        
        ---@class SubClass
        local Instance = {}
                
        function Instance:ctor()
            
            --调用父类构造函数
            self.super:ctor("ParamFromSubClass")
        end
        
        function Instance:Call()

            --调用父类方法
            self.super:Call()
        end
            
        function Instance:GetStaticValue()
            --获取类的静态字段
            return self.static.NAME
        end
            
        return Instance
    end
    ```

2. 静态变量的获取

    ```
    方式1：从类的实例中获取

    local subInstance = SubClass.new()
    print(subInstance.static.NAME)
    
    方式1：从类中直接获取

    print(SubClass.static.NAME)
    ```

## 类的私有变量支持

1. 私有变量的定义

    ```
    SubClass          = class("SubClass", BaseClass)

    SubClass.static =
    {
        NAME = "static name"
    }

    SubClass.__create = function()
        
        ---@class SubClass
        local Instance = {}
        
        --私有变量
        local _value
                        
        --获取私有变量
        function Instance:GetValue()
            return _value
        end

        --设值私有变量  
        function Instance:SetValue(val)
            _value = val
        end
        
        return Instance
    end
    ```

2. 私有变量的获取

    ```
    local subInstance = SubClass.new()
    subInstance:SetValue(5)
    print("GetValue = " .. tostring(subInstance:GetValue()))
    ```

## 测试用例

```
    测试用例在examples目录。
```