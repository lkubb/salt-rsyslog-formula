# -*- coding: utf-8 -*-
# vim: ft=yaml
---
rsyslog:
  lookup:
    master: template-master
    # Just for testing purposes
    winner: lookup
    added_in_lookup: lookup_value
    pkg:
      name: rsyslog
    config: '/etc/rsyslog.conf'
    service:
      name: rsyslog
    configd: /etc/rsyslog.d
  config:
    global:
      umask: '0022'
      workDirectory: /var/spool/rsyslog
    include: []
    modules:
      imklog:
        enabled: true
        parameters: {}
      imuxsock:
        enabled: true
        parameters: {}
      omfile:
        parameters:
          DirCreateMode: '0755'
          FileCreateMode: '0640'
          Template: RSYSLOG_TraditionalFileFormat
          fileGroup: adm
          fileOwner: root
    outputs:
      - filter: auth,authpriv.*
        target: /var/log/auth.log
      - filter: '*.*;auth,authpriv.none'
        sync: false
        target: /var/log/syslog
      - filter: daemon.*
        sync: false
        target: /var/log/daemon.log
      - filter: kern.*
        sync: false
        target: /var/log/kern.log
      - filter: lpr.*
        sync: false
        target: /var/log/lpr.log
      - filter: mail.*
        sync: false
        target: /var/log/mail.log
      - filter: user.*
        sync: false
        target: /var/log/user.log
      - filter: mail.info
        sync: false
        target: /var/log/mail.info
      - filter: mail.warn
        sync: false
        target: /var/log/mail.warn
      - filter: mail.err
        target: /var/log/mail.err
      - filter: '*.=debug;auth,authpriv.none;mail.none'
        sync: false
        target: /var/log/debug
      - filter: '*.=info;*.=notice;*.=warn;auth,authpriv.none;cron,daemon.none;mail.none'
        sync: false
        target: /var/log/messages
      - filter: '*.emerg'
        target: :omusrmsg:*
  custom: {}
  server:
    enabled: false
    inputs: {}
    modules: {}
    rulesets: {}
    templates: {}

  tofs:
    # The files_switch key serves as a selector for alternative
    # directories under the formula files directory. See TOFS pattern
    # doc for more info.
    # Note: Any value not evaluated by `config.get` will be used literally.
    # This can be used to set custom paths, as many levels deep as required.
    files_switch:
      - any/path/can/be/used/here
      - id
      - roles
      - osfinger
      - os
      - os_family
    # All aspects of path/file resolution are customisable using the options below.
    # This is unnecessary in most cases; there are sensible defaults.
    # Default path: salt://< path_prefix >/< dirs.files >/< dirs.default >
    #         I.e.: salt://rsyslog/files/default
    # path_prefix: template_alt
    # dirs:
    #   files: files_alt
    #   default: default_alt
    # The entries under `source_files` are prepended to the default source files
    # given for the state
    # source_files:
    #   rsyslog-config-file-file-managed:
    #     - 'example_alt.tmpl'
    #     - 'example_alt.tmpl.jinja'

    # For testing purposes
    source_files:
      rsyslog-config-file-file-managed:
        - 'example.tmpl.jinja'

  # Just for testing purposes
  winner: pillar
  added_in_pillar: pillar_value
