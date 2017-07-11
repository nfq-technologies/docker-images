

## supported env vars


### NFQ_ENABLE_RABBITMQ_MODULES (optional)

Provide space separated lists of modules in a single quoted string

example:
    docker run -it -e NFQ_ENABLE_RABBITMQ_MODULES='rabbitmq_management rabbitmq_test' <this_image>

#### list of available modules


* amqp_client
* cowboy
* eldap
* mochiweb
* rabbitmq_amqp1_0
* rabbitmq_auth_backend_ldap
* rabbitmq_auth_mechanism_ssl
* rabbitmq_consistent_hash_exchange
* rabbitmq_federation
* rabbitmq_federation_management
* rabbitmq_management
* rabbitmq_management_agent
* rabbitmq_management_visualiser
* rabbitmq_mqtt
* rabbitmq_shovel
* rabbitmq_shovel_management
* rabbitmq_stomp
* rabbitmq_test
* rabbitmq_tracing
* rabbitmq_web_dispatch
* rabbitmq_web_stomp
* rabbitmq_web_stomp_examples
* sockjs
* webmachine
