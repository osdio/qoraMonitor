express = require 'express'
http = require 'http'
async = require 'async'
require 'date-utils'
router = express.Router()


router.get '/', (req, res)->
  getInfoDirect = (path)->
    return (callback)->
      get = http.get 'http://127.0.0.1:9085' + path, (res)->
        res.on 'data', (data)->
          callback null, data.toString()
      get.on 'error', (err)->
        callback err
  tasks =
    status: getInfoDirect('/qora/status')
    blockHeight: getInfoDirect('/blocks/height')
    isUpToDate: getInfoDirect('/qora/isuptodate')
    peers: getInfoDirect('/peers')
    blockTime: getInfoDirect('/blocks/time')
    generatingBalance: getInfoDirect('/blocks/generatingbalance')
  #trasactionsNet: getInfoDirect('/transactions/network')
    blockLast: getInfoDirect('/blocks/last')


  async.parallel tasks, (err, results)->
    if err
      res.render 'index',
        title: 'error'
        message: "Get info failed , Plea make sure you have start the qora without -disablerpc "
        err: true
      return
    results.blockLast = eval('(' + results.blockLast + ')')
    results.peers = eval('(' + results.peers + ')')
    #results.blockTime = new Date(Number(results.blockLast.timestamp) + Number(results.blockTime) * 1000).toFormat('YYYY-MM-DD HH24:MI:SS')
    results.blockLast.timestamp = new Date(results.blockLast.timestamp).toFormat('YYYY-MM-DD HH24:MI:SS')
    res.render 'index',
      title: "Qora Monitor"
      message: results
      err: false
module.exports = router
