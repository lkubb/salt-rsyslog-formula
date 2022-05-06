# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as rsyslog with context %}

rsyslog-service-clean-service-dead:
  service.dead:
    - name: {{ rsyslog.lookup.service.name }}
    - enable: False
