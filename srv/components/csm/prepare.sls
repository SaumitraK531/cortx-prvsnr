{% import_yaml 'components/defaults.yaml' as defaults %}

Add CSM repo:
  pkgrepo.managed:
    - name: {{ defaults.csm.repo.id }}
    - enabled: True
    - humanname: csm
    - baseurl: {{ defaults.csm.repo.url }}
    - gpgcheck: 0

Copy stats collector:
  file.managed:
    - name: /opt/statsd/csm-stats-collector
    - source: salt://components/misc_pkgs/statsd/files/csm_stats_collector
    - User: root
    - Group: root
    - mode: 755

Create Symlink:
  file.symlink:
    - name: /usr/bin/csm-stats-collector
    - target: /opt/statsd/csm-stats-collector

Setup crontab:
  cron.present:
    - name: /opt/statsd/csm-stats-collector 10
    - user: root
    - identifier: csm-stats-collector
