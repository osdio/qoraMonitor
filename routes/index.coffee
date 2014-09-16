express = require 'express'
http = require 'http'
async = require 'async'
require 'date-utils'
router = express.Router()

formateTime = (second)->
  return [parseInt(second / 60 / 60), second / 60 % 60, second % 60].join(":").replace(/\b(\d)\b/g, "0$1")


router.get '/', (req, res)->
  getInfoDirect = (path)->
    return (callback)->
      http.get 'http://127.0.0.1:9085' + path, (res)->
        res.on 'data', (data)->
          callback null, data.toString()
  tasks =
    status: getInfoDirect('/qora/status')
    blockHeight: getInfoDirect('/blocks/height')
    isUpToDate: getInfoDirect('/qora/isuptodate')
    peers: getInfoDirect('/peers')
    blockTime: getInfoDirect('/blocks/time')
    generatingBalance: getInfoDirect('/blocks/generatingbalance')
    trasactionsNet: getInfoDirect('/transactions/network')
    blockLast: getInfoDirect('/blocks/last')


  async.parallel tasks, (err, results)->
    if err
      res.render 'index',
        title: 'error'
        err: true
      return
    results.blockLast = eval('(' + results.blockLast + ')')
    results.blockTime = new Date(Number(results.blockLast.timestamp) + Number(results.blockTime) * 1000).toFormat('YYYY-MM-DD HH24:MI:SS')
    results.blockLast.timestamp = new Date(results.blockLast.timestamp).toFormat('YYYY-MM-DD HH24:MI:SS')
    res.render 'index',
      title: "Qora Monitor"
      message: results
      err: false
module.exports = router
