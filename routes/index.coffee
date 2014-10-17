express = require 'express'
http = require 'http'
async = require 'async'
require 'date-utils'
settings = require '../settings'
router = express.Router()

router.get '/', (req, res, next)->
  if !req.session.user
    res.redirect('/login')
  next()

router.get '/', (req, res)->
  getInfoDirect = (path)->
    buffers = []
    return (callback)->
      get = http.get 'http://127.0.0.1:9085' + path, (res)->
        res.on 'data', (data)->
          buffers.push data
        res.on 'end', ()->
          callback null, buffers.toString()
      get.on 'error', (err)->
        callback err
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
    errRender=()->
      res.render 'index',
        title: 'error'
        message: "Get info failed , Plea make sure you have start the qora without -disablerpc "
        err: true
    if err
      errRender()
      return
    try
      results.blockLast = JSON.parse results.blockLast
      results.peers = JSON.parse results.peers
      results.blockTime = new Date(Number(results.blockLast.timestamp) + Number(results.blockTime) * 1000).toFormat('YYYY-MM-DD HH24:MI:SS')
      results.blockLast.timestamp = new Date(results.blockLast.timestamp).toFormat('YYYY-MM-DD HH24:MI:SS')
      res.render 'index',
        title: "Qora Monitor"
        message: results
        err: false
    catch e
      errRender()

router.get '/login', (req, res)->
  res.render 'login',
    titlt: "Log IN"

router.post '/login', (req, res)->
  console.log req.body
  if settings.loginPwd == req.body.pwd and settings.loginUserName == req.body.user
    req.session.user = req.body.user
    res.redirect '/'
  else
    res.redirect '/login'


module.exports = router
