namespace: Integrations.Slack
flow:
  name: postMessage
  inputs:
    - slackURL: 'https://slack.com/api/chat.postMessage'
    - slackChannel: schlumberger
    - slackToken: xoxp-200103613542-200103613574-309691159907-7c6ea5eff69b19c3462000496e6d9d76
    - slackMessageToPost: toBeFulfilled
  workflow:
    - http_client_post:
        do:
          io.cloudslang.base.http.http_client_post:
            - url: '${slackURL}'
            - proxy_host: proxy.eswdc.net
            - proxy_port: '8088'
            - headers: "${'authorization: Bearer ' + slackToken}"
            - body: "${'{\\\"channel\\\": \\\"' + slackChannel + '\\\",\\\"text\\\": \\\"' + slackMessageToPost + '\\\"}'}"
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      http_client_post:
        x: 206
        y: 237
        navigate:
          7dfc145a-2856-a1da-f1b0-4765d897ef23:
            targetId: 1bbe5589-b62b-30a2-b297-ae2fd978fd4e
            port: SUCCESS
    results:
      SUCCESS:
        1bbe5589-b62b-30a2-b297-ae2fd978fd4e:
          x: 463
          y: 243
