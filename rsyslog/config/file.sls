# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as rsyslog with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

rsyslog-config-file-file-managed:
  file.managed:
    - name: {{ rsyslog.lookup.config }}
    - source: {{ files_switch(['rsyslog.conf.j2'],
                              lookup='rsyslog-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ rsyslog.lookup.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        rsyslog: {{ rsyslog | json }}

{%- if rsyslog.lookup.configd %}
{%-   if rsyslog.server.enabled %}

Rsyslog server is configured:
  file.managed:
    - name: {{ rsyslog.lookup.configd | path_join('10-remote.conf') }}
    - source: {{ files_switch(['server.conf.j2'],
                              lookup='Rsyslog server is configured'
                 )
              }}
    - mode: '0644'
    - user: root
    - group: {{ rsyslog.lookup.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        rsyslog: {{ rsyslog | json }}
    - require:
      - sls: {{ sls_package_install }}
{%-   endif %}

{%-   if rsyslog.custom %}

Rsyslog custom configuration is managed:
  file.managed:
    - names:
{%-   for name in rsyslog.custom %}
      - {{ rsyslog.lookup.configd | path_join(name ~ '.conf') }}:
        - context:
            conf_name: {{ name }}
{%-   endfor %}
    - source: {{ files_switch(['custom.conf.j2'],
                              lookup='Rsyslog custom configuration is managed'
                 )
              }}
    - mode: '0644'
    - user: root
    - group: {{ rsyslog.lookup.rootgroup }}
    - defaults:
        rsyslog: {{ rsyslog | json }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
{%-   endif %}
{%- endif %}
