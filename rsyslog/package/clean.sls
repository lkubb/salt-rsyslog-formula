# vim: ft=sls

{#-
    Removes the rsyslog package.
    Has a depency on `rsyslog.config.clean`_.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_config_clean = tplroot ~ ".config.clean" %}
{%- from tplroot ~ "/map.jinja" import mapdata as rsyslog with context %}

include:
  - {{ sls_config_clean }}

Rsyslog is removed:
  pkg.removed:
    - name: {{ rsyslog.lookup.pkg.name }}
    - require:
      - sls: {{ sls_config_clean }}
