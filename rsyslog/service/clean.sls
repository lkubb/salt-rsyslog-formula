# vim: ft=sls

{#-
    Stops the rsyslog service and disables it at boot time.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as rsyslog with context %}

Rsyslog is dead:
  service.dead:
    - name: {{ rsyslog.lookup.service.name }}
    - enable: false
