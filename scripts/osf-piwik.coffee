piwik_url = process.env.PIWIK_URL + "index.php?module=API&idSite=" +
            process.env.PIWIK_OSF_SITE_ID +
            "&token_auth=" + process.env.PIWIK_TOKEN_AUTH +
            "&format=JSON"

module.exports = (robot) ->
  robot.respond /how many hits/i, (msg) ->
    api_url = piwik_url + "&method=VisitsSummary.getUniqueVisitors&period=day&date="
    robot.http(api_url + "yesterday").get() (err, res, body) ->
      yesterday = JSON.parse(body).value
      robot.http(api_url + "today").get() (err, res, body) ->
        today = JSON.parse(body).value

        msg.send "We got " + yesterday + " hits yesterday; we've gotten " + today + " hits so far today.
