"use strict"

{cache, writeCache} = require './data'

cache.verCache ?= {}

expire = 20 * 60 * 1000 # 20 min

get = (name) ->
    info = cache.verCache[name]
    if info
        interval = info.expire or expire
        if Date.now() - info.timestamp < interval
            info.version
        else
            delete cache.verCache[name]
            ''
    else
        ''

set = (name, ver) ->
    cache.verCache[name] =
        version: ver
        timestamp: Date.now()

module.exports = {
    get
    set
    record: writeCache
}