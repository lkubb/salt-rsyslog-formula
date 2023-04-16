# vim: ft=sls

{#-
    *Meta-state*.

    This installs the rsyslog package,
    manages the rsyslog configuration file
    and then starts the associated rsyslog service.
#}

include:
  - .package
  - .config
  - .service
