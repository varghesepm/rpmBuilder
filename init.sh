#!/bin/bash

# yum update
yum clean all && yum -y update
yum -y install epel-release && yum clean all
yum -y install rpm-build make zlib-devel openssl-devel curl-devel asciidoc gcc redhat-lsb-core shadow-utils systemd openssl-libs wget libmaxminddb-devel


# Downloading nginx and vts module
wget http://nginx.org/packages/mainline/centos/7/x86_64/RPMS/nginx-1.19.10-1.el7.ngx.x86_64.rpm -O ~/rpmbuild/RPMS/nginx-1.19.10-1.el7.ngx.x86_64.rpm
wget http://nginx.org/download/nginx-1.19.10.tar.gz -O ~/rpmbuild/SOURCES/nginx-1.19.10.tar.gz
wget --no-check-certificate https://github.com/vozlt/nginx-module-vts/archive/master.zip -O ~/rpmbuild/SOURCES/nginx-module-vts_master.zip

# copy spec
# **MUST - manually copy .spec file into /root directory
cp /root/nginx-module-vts.spec ~/rpmbuild/SPECS/nginx-module-vts.spec

# build rpm package
rpmbuild -ba ~/rpmbuild/SPECS/nginx-module-vts.spec
rpmbuild -D 'debug_package %{nil}' -ba ~/rpmbuild/SPECS/nginx-module-vts.spec


# install nginx and VTS module
yum install ~/rpmbuild/RPMS/nginx-1.19.10-1.el7.ngx.x86_64.rpm
yum install ~/rpmbuild/RPMS/x86_64/nginx-module-vts-1.19.10-0.1.18.el7.ngx.x86_64.rpm

# Start Nginx
systemctl start nginx