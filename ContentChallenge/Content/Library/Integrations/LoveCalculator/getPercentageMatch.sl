namespace: Integrations.LoveCalculator
flow:
  name: getPercentageMatch
  inputs:
    - XMashapUrl: 'https://love-calculator.p.mashape.com'
    - XMashapeKey: 6F8xZgBPPnmshFaZ9hZTmG4ABCxKp1XK21AjsnPVyTT22EaLvk
    - fname: Michael
    - sname: Guillaume
  workflow:
    - getPercentageMatch:
        do:
          io.cloudslang.base.http.http_client_get:
            - url: "${XMashapUrl+'/getPercentage?fname='+fname+'&sname='+sname}"
            - proxy_host: proxy.eswdc.net
            - proxy_port: '8088'
            - headers: "${'X-Mashape-Key:' + XMashapeKey}"
        publish:
          - document: '${return_result}'
        navigate:
          - SUCCESS: getResult
          - FAILURE: on_failure
    - getResult:
        do:
          io.cloudslang.base.json.get_value:
            - json_input: '${document}'
            - json_path: result
        publish:
          - resultMatch: '${return_result}'
        navigate:
          - SUCCESS: getPercentage
          - FAILURE: on_failure
    - getPercentage:
        do:
          io.cloudslang.base.json.get_value:
            - json_input: '${document}'
            - json_path: percentage
        publish:
          - percentageMatch: '${return_result}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - result: '${resultMatch}'
    - percentage: '${percentageMatch}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      getPercentageMatch:
        x: 101
        y: 148
      getResult:
        x: 400
        y: 150
      getPercentage:
        x: 700
        y: 150
        navigate:
          9df8e644-4192-30e5-ea75-b741cf543d73:
            targetId: e2899c3f-8498-e877-888f-d5552a55cd69
            port: SUCCESS
    results:
      SUCCESS:
        e2899c3f-8498-e877-888f-d5552a55cd69:
          x: 1000
          y: 150
