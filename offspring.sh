#!/bin/bash

# example usage:
# export OFFSPRING_PROJECT=kafka
# export OFFSPRING_CONFIG=$KAFKA_HOME/config/server.properties
# export OFFSPRING_DELIMITER=.
# export OFFSPRING_EXCLUSION_REGEX=^KAFKA_HOME

OFFSPRING_INCLUSION_REGEX=^${OFFSPRING_PROJECT}_
for VAR in `env`
do
  if [[ $VAR =~ $OFFSPRING_INCLUSION_REGEX && ! $VAR =~ $OFFSPRING_EXCLUSION_REGEX ]]; then
    upper_to_lower="tr '[:upper:]' '[:lower:]'"
    config_name=`echo "$VAR" | sed -r "s/${OFFSPRING_PROJECT}_(.*)=.*/\1/g" | $upper_to_lower | tr _ ${OFFSPRING_DELIMITER}`
    env_var=`echo "$VAR" | sed -r "s/(.*)=.*/\1/g"`
    if [[ $1 == "echo" ]]; then
            echo "$config_name=${!env_var}"
    else
        if egrep -q "(^|^#)${config_name}=" $OFFSPRING_CONFIG; then
            sed -r -i "s@(^|^#)($config_name)=(.*)@\2=${!env_var}@g" $OFFSPRING_CONFIG #note that no config values may contain an '@' char
        else
            echo "$config_name=${!env_var}" >> $OFFSPRING_CONFIG
        fi
    fi
  fi
done
