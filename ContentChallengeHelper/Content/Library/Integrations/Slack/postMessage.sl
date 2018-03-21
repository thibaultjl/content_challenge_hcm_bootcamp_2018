namespace: Integrations.Slack
flow:
  name: postMessage
  inputs:
    - slackURL: '${slackURL}'
    - slackChannel: '${slackChannel}'
    - slackToken: '${slackToken}'
    - slackMessageToPost: '${slackMessageToPost}'
    - attachments: '[]'
  workflow:
    - http_client_post:
        do:
          io.cloudslang.base.http.http_client_post:
            - url: '${slackURL}'
            - proxy_host: proxy.eswdc.net
            - proxy_port: '8088'
            - headers: "${'authorization: Bearer ' + slackToken}"
            - body: "${'{\\\"channel\\\": \\\"' + slackChannel + '\\\",\\\"text\\\": \\\"' + slackMessageToPost + '\\\",\\\"as_user\\\": \\\"true\\\",\\\"attachments\\\": ' + attachments + '}'}"
            - content_type: application/json
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
        x: 205
        y: 240
        navigate:
          7dfc145a-2856-a1da-f1b0-4765d897ef23:
            targetId: 1bbe5589-b62b-30a2-b297-ae2fd978fd4e
            port: SUCCESS
    results:
      SUCCESS:
        1bbe5589-b62b-30a2-b297-ae2fd978fd4e:
          x: 463
          y: 243
