# vim: ft=sls

{#-
    Starts the rsyslog service and enables it at boot time.
    Has a dependency on `rsyslog.config`_.
#}

include:
  - .running
