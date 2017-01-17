N = require "nightmare"
n = N(
    show: true
    timeout: 10000
)

n.goto "http://www.baidu.com"
 .type "#kw", "China"
 .click "#su"
# .wait 30000
 .end()
 .then(->
     console.log "Done"
 )
 .catch (e) ->
     console.error e
