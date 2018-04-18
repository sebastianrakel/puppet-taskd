#!/bin/bash
set -e
if [ ! -d /tmp/vagrant/modules/taskd ]; then
	mkdir -p /tmp/vagrant/modules;
	# rsync -rv /vagrant/data/ /tmp/vagrant/data
	rsync -rv /vagrant/ /tmp/vagrant/modules/taskd
fi
