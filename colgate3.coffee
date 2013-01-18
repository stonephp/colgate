getElementsByClassName = (classname)->
  d = document
  e = d.getElementsByTagName('a')
  c = new RegExp('\\b'+classname+'\\b')
  r = []

  for x in e
    cn = x.className
    r.push(x) if c.test(cn)
  r

document.getElementsByClassName = getElementsByClassName if typeof document.getElementsByClassName != 'function'

boot = ->
  target = "http://m.yihaodian.com/mw/cms/20130115162446"
  return if not smt_b = getSmt_b()
  conf = getConf()
  hash = decodeSmtb smt_b
  return if not hash or not hash.placement
  return if not extraParam =  conf[hash.placement]
  url = "#{target}?#{extraParam}"
  anchor = document.getElementById('yihaodian')
  anchor.href = url

decodeSmtb = (s)->
  tmp = []
  ret = []
  s = "0#{s}" if s.length is 23
  for i in [s.length - 1..0]
    tmp.push(s.charAt(i))
  s = tmp.join('')
  for i in [0..s.length / 2]
    i = i * 2
    tmp = []
    tmp.push(s.charAt(i + 1))
    tmp.push(s.charAt(i))
    t = tmp.join("")
    num = parseInt(t, 16)
    num += 256 if num < (i / 2) + 1
    num -= (i / 2) + 1
    ret.push(num)
  placement: (ret[0] << 24) + (ret[1] << 16) + (ret[2] << 8) + ret[3]
  creative: (ret[4] << 24) + (ret[5] << 16) + (ret[6] << 8) + ret[7]
  keyword:  (ret[8] << 24) + (ret[9] << 16) + (ret[10] << 8) + ret[11]

getSmt_b = (name = '_smtz', cookie = document.cookie)->
  query = {}

  cookieName = "#{encodeURIComponent(name)}="
  cookieStart = document.cookie.indexOf(cookieName)
  cookieValue = null
  return if cookieStart is -1
  cookieEnd = document.cookie.indexOf(';', cookieStart)
  cookieEnd = document.cookie.length if cookieEnd is -1
  try
    cookieValue = decodeURIComponent(document.cookie.substring(cookieStart + cookieName.length, cookieEnd))
  catch e
  for x in cookieValue.split '&'
    [key, value] = x.split '='
    query[key] = decodeURIComponent value

  query.smt_b

getConf = ->
  200141624: "tracker_u=10508033188"
  200141625: "tracker_u=10508033188"
  200141626: "tracker_u=10508033188"
  200141627: "tracker_u=10508033188"
  200141615: "tracker_u=10840033189"
  200141616: "tracker_u=10840033189"
  200141617: "tracker_u=10840033189"
  200141618: "tracker_u=10840033189"
  200141619: "tracker_u=10840033189"
  200141620: "tracker_u=10840033189"
  200141621: "tracker_u=10840033189"
  200141622: "tracker_u=10140533190"
  200141623: "tracker_u=10140533190"

boot()
