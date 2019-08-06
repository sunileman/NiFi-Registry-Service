# Continuously provide logs so that 'docker logs' can produce them
tail -F "${NIFI_REGISTRY_HOME}/logs/nifi-registry-app.log" &
"${NIFI_REGISTRY_HOME}/bin/nifi-registry.sh" run &
nifi_registry_pid="$!"

trap "echo Received trapped signal, beginning shutdown...;" KILL TERM HUP INT EXIT;

echo NiFi-Registry running with PID ${nifi_registry_pid}.
wait ${nifi_registry_pid}