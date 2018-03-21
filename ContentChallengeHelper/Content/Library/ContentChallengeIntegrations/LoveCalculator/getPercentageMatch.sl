namespace: ContentChallengeIntegrations.LoveCalculator
flow:
  name: getPercentageMatch
  inputs:
    - XMashapUrl: '${XMashapUrl}'
    - XMashapeKey: '${XMashapeKey}'
    - fname: '${fname}'
    - sname: '${sname}'
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
          - SUCCESS: append
          - FAILURE: on_failure
    - append:
        do:
          io.cloudslang.base.strings.append:
            - origin_string: '${fname + " and " + sname + ", your percentage match is " + percentageMatch + " % then "}'
            - text: '${resultMatch}'
        publish:
          - messageToPost: '${new_string}'
        navigate:
          - SUCCESS: SUCCESS
  outputs:
    - messageToPost: '${messageToPost}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      getPercentageMatch:
        x: 100
        y: 150
      getResult:
        x: 400
        y: 150
      getPercentage:
        x: 700
        y: 150
      append:
        x: 1000
        y: 150
        navigate:
          ab2e04b7-4880-f250-1734-f2dde7a36641:
            targetId: 7e978782-7165-59c4-6c54-b7d27db5a60c
            port: SUCCESS
    results:
      SUCCESS:
        7e978782-7165-59c4-6c54-b7d27db5a60c:
          x: 1300
          y: 150
