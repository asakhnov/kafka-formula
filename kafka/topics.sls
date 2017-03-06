# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "kafka/map.jinja" import kafka with context %}

{%- if pillar.kafka.topics.enabled %}
{%- for topic in salt['pillar.get']('kafka:topics:names', []) %}

create_topic_{{ topic }}:
  cmd.run:
    - name: {{ kafka.base_dir }}/bin/kafka-topics.sh --create --zookeeper {{ kafka.conf.zookeeper.connect }} --replication-factor {{ kafka.topics.replication }} --partitions {{ kafka.topics.partitions }} --topic {{ topic }}
    - runas: root
    - unless: {{ kafka.base_dir }}/bin/kafka-topics.sh --list --zookeeper {{ kafka.conf.zookeeper.connect }} --topic {{ topic }} | grep {{ topic }}

{%- endfor %}
{%- endif %}
