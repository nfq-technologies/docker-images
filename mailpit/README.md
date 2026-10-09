## About mailpit

Mail catcher for development. Accepts any mail sent over SMTP and shows it
in a web UI instead of delivering it. Replacement for the unmaintained
[mailhog](../mailhog) image, with the same ports.

Based on [Mailpit](https://github.com/axllent/mailpit).


## Ports

example:
    docker run -d --name mailpit -p 8025:80 -p 1025:25 [image_name]


### 25 (SMTP)

Point your application's mailer here. All mail is accepted and stored, none
is delivered.


### 80 (web UI and API)

Browse caught mail in the browser, or fetch it through the REST API
(`/api/v1/messages`).