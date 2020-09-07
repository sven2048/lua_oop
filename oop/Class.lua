local function _create(factory)
    
    local instance = factory.__create()
    
    for k, v in pairs(factory) do
        
        if k ~= "new" and k ~= "__create" and k ~= "super" then
            instance[k] = v
        end
    end
    
    if not factory.super and not instance.ctor then
        instance.ctor = function()
        end
    end
    
    if factory.super then
        
        local superInstance = _create(factory.super)
        instance.super      = superInstance
        setmetatable(instance, { __index = superInstance })
    end
    
    instance.__index = instance
    return instance
end

function class(className, superFactory)
    
    local superType = type(superFactory)
    local factory
    
    if superType ~= "table" then
        superType    = nil
        superFactory = nil
    end
    
    factory         = {}
    factory.super   = superFactory
    factory.__cname = className
    
    function factory.new(...)
        
        local instance = _create(factory)
        instance:ctor(...)
        return instance
    end
    
    return factory
end