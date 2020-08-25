function class(classname, super)

    local superType = type(super)
    local cls

    if superType ~= "table" then
        superType = nil
        super = nil
    end

    if super then
    
        cls       = {}
        cls.super = super
    else
        cls = {ctor = function() end}
    end

    cls.__prototype = "class"
    cls.__cname     = classname

    local function __new(clazz)
    
        local instance
    
        if clazz.__create then
            instance = clazz.__create()
        else
            instance = {}
        end
        
        instance.class       = clazz
        instance.__prototype = "instance"
    
        for k, v in pairs(clazz) do
        
            if k ~= "__cname" and k ~= "__create" and k ~= "new" and k ~= "__index" and k ~= "super" and k ~= "__prototype" then
                instance[k] = v
            end
        end
    
        if clazz.super then
        
            local superInstance = __new(clazz.super)
            instance.super      = superInstance
            setmetatable(instance, { __index = superInstance })
        end
    
        instance.__index = instance
        return instance
    end

    function cls.new(...)
    
        local instance = __new(cls)
        instance:ctor(...)
        return instance
    end
        
    return cls
end