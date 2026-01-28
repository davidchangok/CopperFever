-- ====================================================================
-- Copper Fever - Utils\Security.lua
-- 安全审计模块 (符合 7.2.3 标准)
-- Author: David W Zhang
-- ====================================================================

local CF = CopperFever
CF.Security = CF.Security or {}
local SEC = CF.Security

-- ====================================================================
-- 安全统计信息
-- ====================================================================
SEC.Stats = {
    totalCalls = 0,
    successfulCalls = 0,
    failedCalls = 0,
    lastError = nil,
}

-- ====================================================================
-- API 调用审计函数
-- ====================================================================

--- 审计并执行一个受保护的 API 调用
-- @param apiFunction 要调用的函数 (e.g., C_CurrencyInfo.GetCurrencyInfo)
-- @param ... 传递给 apiFunction 的参数
-- @return boolean success, any results...
function SEC:AuditAPICall(apiFunction, ...)
    if type(apiFunction) ~= "function" then
        CF:LogError("Security Audit: Invalid API function provided.")
        self.Stats.failedCalls = self.Stats.failedCalls + 1
        self.Stats.lastError = "Invalid function type"
        return false, CF.ERROR_CODES.INVALID_PARAMETER
    end

    -- 增加调用计数
    self.Stats.totalCalls = self.Stats.totalCalls + 1

    -- 在未来的版本中，这里可以加入更复杂的 taint-checking、
    -- 调用频率限制或权限验证逻辑。
    -- CF:LogDebug("Security Audit on: %s", tostring(apiFunction))

    -- 使用 pcall 来安全地执行函数
    local success, result1, result2, result3, result4, result5 = pcall(apiFunction, ...)

    if not success then
        -- 如果调用失败，记录错误信息
        self.Stats.failedCalls = self.Stats.failedCalls + 1
        self.Stats.lastError = tostring(result1)
        
        CF:LogError("Audited API call failed: %s", tostring(result1))
        
        -- 返回失败状态和错误码
        return false, CF.ERROR_CODES.API_ERROR
    end

    -- 调用成功
    self.Stats.successfulCalls = self.Stats.successfulCalls + 1
    self.Stats.lastError = nil
    
    -- 返回成功状态和所有结果值
    -- 注意：pcall 最多可以返回多个值，我们需要正确传递它们
    return true, result1, result2, result3, result4, result5
end

-- ====================================================================
-- 安全统计查询
-- ====================================================================

--- 获取安全统计信息
-- @return table 包含统计信息的表
function SEC:GetStats()
    return {
        totalCalls = self.Stats.totalCalls,
        successfulCalls = self.Stats.successfulCalls,
        failedCalls = self.Stats.failedCalls,
        successRate = self.Stats.totalCalls > 0 
            and (self.Stats.successfulCalls / self.Stats.totalCalls * 100) 
            or 0,
        lastError = self.Stats.lastError,
    }
end

--- 重置安全统计信息
function SEC:ResetStats()
    self.Stats.totalCalls = 0
    self.Stats.successfulCalls = 0
    self.Stats.failedCalls = 0
    self.Stats.lastError = nil
    CF:LogInfo("Security stats reset")
end

--- 打印安全统计信息
function SEC:PrintStats()
    local stats = self:GetStats()
    CF:LogInfo("=== Security Audit Statistics ===")
    CF:LogInfo("Total API Calls: %d", stats.totalCalls)
    CF:LogInfo("Successful: %d", stats.successfulCalls)
    CF:LogInfo("Failed: %d", stats.failedCalls)
    CF:LogInfo("Success Rate: %.2f%%", stats.successRate)
    if stats.lastError then
        CF:LogInfo("Last Error: %s", stats.lastError)
    end
    CF:LogInfo("================================")
end

-- ====================================================================
-- Taint 检测辅助函数
-- ====================================================================

--- 检查一个函数是否被污染
-- @param funcName 函数名称字符串
-- @return boolean 是否被污染
function SEC:IsTainted(funcName)
    if type(funcName) ~= "string" then
        return false
    end
    
    -- 使用 issecurevariable 检测污染
    local isTainted = not issecurevariable(funcName)
    
    if isTainted then
        CF:LogWarning("Function is tainted: %s", funcName)
    end
    
    return isTainted
end

--- 检查当前是否处于安全环境
-- @return boolean 是否处于安全环境
function SEC:IsSecure()
    return issecure()
end

-- ====================================================================
-- API 调用速率限制
-- ====================================================================

SEC.RateLimits = {}

--- 检查 API 调用是否超过速率限制
-- @param key 限制键
-- @param maxCalls 最大调用次数
-- @param windowSeconds 时间窗口（秒）
-- @return boolean 是否允许调用
function SEC:CheckRateLimit(key, maxCalls, windowSeconds)
    if type(key) ~= "string" then
        return true -- 无限制键则允许
    end
    
    maxCalls = maxCalls or 100
    windowSeconds = windowSeconds or 60
    
    local now = GetTime()
    local limit = self.RateLimits[key]
    
    if not limit then
        -- 首次调用，初始化
        self.RateLimits[key] = {
            calls = 1,
            windowStart = now,
        }
        return true
    end
    
    -- 检查时间窗口是否过期
    if now - limit.windowStart >= windowSeconds then
        -- 重置窗口
        limit.calls = 1
        limit.windowStart = now
        return true
    end
    
    -- 检查是否超过限制
    if limit.calls >= maxCalls then
        CF:LogWarning("Rate limit exceeded for: %s (%d calls in %d seconds)", 
                      key, limit.calls, windowSeconds)
        return false
    end
    
    -- 增加计数
    limit.calls = limit.calls + 1
    return true
end

--- 重置指定的速率限制
-- @param key 限制键（nil 表示重置所有）
function SEC:ResetRateLimit(key)
    if key then
        self.RateLimits[key] = nil
    else
        self.RateLimits = {}
    end
end

-- ====================================================================
-- 增强的安全 API 调用（带速率限制）
-- ====================================================================

--- 带速率限制的安全 API 调用
-- @param rateLimitKey 速率限制键
-- @param apiFunction API 函数
-- @param ... 函数参数
-- @return boolean success, any results...
function SEC:RateLimitedAPICall(rateLimitKey, apiFunction, ...)
    -- 检查速率限制
    if not self:CheckRateLimit(rateLimitKey, 50, 5) then
        CF:LogError("API call rate limited: %s", rateLimitKey)
        return false, CF.ERROR_CODES.PERMISSION_DENIED
    end
    
    -- 执行审计调用
    return self:AuditAPICall(apiFunction, ...)
end

-- ====================================================================
-- 安全初始化
-- ====================================================================

--- 初始化安全模块
function SEC:Initialize()
    CF:LogInfo("Security module initialized")
    self:ResetStats()
    self:ResetRateLimit()
end

-- ====================================================================
-- 清理函数
-- ====================================================================

--- 清理安全模块
function SEC:Cleanup()
    CF:LogInfo("Security module cleanup")
    self:ResetStats()
    self:ResetRateLimit()
end

-- ====================================================================
-- 结束标记
-- ====================================================================