

## supported env vars


### NFQ_ENABLE_RABBITMQ_MODULES (optional)

Provide space separated lists of modules in a single quoted string

example:
    docker run -it -e NFQ_ENABLE_RABBITMQ_MODULES='rabbitmq_management rabbitmq_top' <this_image>

#### list of available modules


* amqp_client
* cowboy
* cowlib
* mochiweb
* rabbitmq_amqp1_0
* rabbitmq_auth_backend_ldap
* rabbitmq_auth_mechanism_ssl
* rabbitmq_consistent_hash_exchange
* rabbitmq_event_exchange
* rabbitmq_federation
* rabbitmq_federation_management
* rabbitmq_jms_topic_exchange
* rabbitmq_management
* rabbitmq_management_agent
* rabbitmq_management_visualiser
* rabbitmq_mqtt
* rabbitmq_recent_history_exchange
* rabbitmq_sharding
* rabbitmq_shovel
* rabbitmq_shovel_management
* rabbitmq_stomp
* rabbitmq_top
* rabbitmq_tracing
* rabbitmq_trust_store
* rabbitmq_web_dispatch
* rabbitmq_web_stomp
* rabbitmq_web_stomp_examples
* sockjs
* webmachine


