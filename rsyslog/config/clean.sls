# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as rsyslog with context %}

include:
  - {{ sls_service_clean }}

rsyslog-config-clean-file-absent:
  file.absent:
    - names:
      - {{ rsyslog.lookup.config }}
{%- if rsyslog.lookup.configd %}
{%-   if rsyslog.server.enable %}
      - {{ rsyslog.lookup.configd | path_join('10-remote.conf') }}
{%-   endif %}
{%-   if rsyslog.custom %}
{%-     for name in rsyslog.custom %}
      - {{ rsyslog.lookup.configd | path_join(name ~ '.conf') }}
{%-     endfor %}
{%-   endif %}
{%- endif %}
    - require:
      - sls: {{ sls_service_clean }}
