namespace: Actions
flow:
  name: pushMatchResult
  inputs:
    - fname: HPE
    - sname: MICROFOCUS
    - XMashapeKey: AEzXixt7XhmshnwhBQ15O2OlWwiip1MaDbQjsnmafSYpdmmGWD
    - XMashapeURL: 'https://love-calculator.p.mashape.com'
    - slackURL: 'https://slack.com/api/chat.postMessage'
    - slackChannel: test
    - slackToken: xoxb-334563548982-OS5qJiXioLlWME4UVNUB55xg
  workflow:
    - getPercentageMatch:
        do:
          Integrations.LoveCalculator.getPercentageMatch:
            - XMashapUrl: '${XMashapeURL}'
            - XMashapeKey: '${XMashapeKey}'
            - fname: '${fname}'
            - sname: '${sname}'
        publish:
          - messageToPost
        navigate:
          - FAILURE: on_failure
          - SUCCESS: postMessage
    - postMessage:
        do:
          Integrations.Slack.postMessage:
            - slackURL: '${slackURL}'
            - slackChannel: '${slackChannel}'
            - slackToken: '${slackToken}'
            - slackMessageToPost: '${messageToPost}'
            - attachments: '[]'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      getPercentageMatch:
        x: 98
        y: 155
      postMessage:
        x: 280
        y: 149
        navigate:
          1128c2fc-5205-6994-44a6-dfe509f8b521:
            targetId: 32ff11ff-d2a5-3e64-f7c8-80d8d5109f22
            port: SUCCESS
    results:
      SUCCESS:
        32ff11ff-d2a5-3e64-f7c8-80d8d5109f22:
          x: 453
          y: 151
