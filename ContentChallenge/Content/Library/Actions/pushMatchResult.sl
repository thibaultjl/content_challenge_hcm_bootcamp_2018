namespace: Actions
flow:
  name: pushMatchResult
  inputs:
    - fname: HPE
    - sname: MICROFOCUS
    - XMashapeKey: 6F8xZgBPPnmshFaZ9hZTmG4ABCxKp1XK21AjsnPVyTT22EaLvk
    - XMashapeURL: 'https://love-calculator.p.mashape.com'
    - slackURL: 'https://slack.com/api/chat.postMessage'
    - slackChannel: schlumberger
    - slackToken: xoxp-200103613542-200103613574-309691159907-7c6ea5eff69b19c3462000496e6d9d76
  workflow:
    - getPercentageMatch:
        do:
          Integrations.LoveCalculator.getPercentageMatch:
            - XMashapUrl: '${XMashapeURL}'
            - XMashapeKey: '${XMashapeKey}'
            - fname: '${fname}'
            - sname: '${sname}'
        publish:
          - resultMatch: '${result}'
          - percentageMatch: '${percentage}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: postMessage
    - postMessage:
        do:
          Integrations.Slack.postMessage:
            - slackURL: '${slackURL}'
            - slackChannel: '${slackChannel}'
            - slackToken: '${slackToken}'
            - slackMessageToPost: '${fname + " and " + sname +" your percentage match is " + percentageMatch + " then " + resultMatch}'
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
        y: 154
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
