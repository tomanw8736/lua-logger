local Logger = require('logger')

-- making a new logger object
local log = Logger:new('example_log.txt', 1)

-- logging some stuff
log:info('Info!')
log:warning('Warning!')
log:error('Error!')
log:debug('Debug!')

-- closing the file
log:close()