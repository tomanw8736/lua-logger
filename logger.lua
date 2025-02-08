local logger = {}
logger.__index = logger

local levels = { INFO = 1, WARNING = 2, ERROR = 3, DEBUG =4 }

function logger:new(log_file, min_level)
    local obj = setmetatable({}, self)
    obj.log_file   = log_file or 'log.txt'
    obj.min_level  = min_level or levels.INFO
    obj.file       = io.open(obj.log_file, 'a')
    return obj
end

function logger:log(level, message)
    local numeric_level = levels[level]
    if not numeric_level then
        error('Invalid log level:'.. tostring(level))
    end

    if numeric_level >= self.min_level then
        local timestamp = os.date("[%Y-%m-%d %H:%M:%S]")
        local log_entry = string.format("%s [%s] %s\n", timestamp, level, message)

        -- Print to console
        print(log_entry)

        -- Append to log file
        if self.file then
            self.file:write(log_entry)
            self.file:flush()
        end
    end
end

function logger:info(msg) self:log('INFO', msg) end
function logger:warning(msg) self:log('WARNING', msg) end
function logger:error(msg) self:log('ERROR', msg) end
function logger:debug(msg) self:log('DEBUG', msg) end

function logger:close()
    if self.file then
        self.file:close()
    end
end

return logger

