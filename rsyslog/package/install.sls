# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as rsyslog with context %}

Rsyslog is installed:
  pkg.installed:
    - name: {{ rsyslog.lookup.pkg.name }}
