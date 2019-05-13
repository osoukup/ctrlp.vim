#!/bin/bash
# RPM in KOJI build script
# needs to have Fedora development installed and valid Kerberos ticket
# https://fedoraproject.org/wiki/Join_the_package_collection_maintainers#Install_the_developer_client_tools
# kinit osoukup@FEDORAPROJECT.ORG

source /etc/os-release

VERSION=`grep Version vim-ctrlp.spec | cut -d: -f2 | xargs`
SOURCE=vim-ctrlp-$VERSION-1.fc$VERSION_ID.src.rpm

if [[ ! -e ~/rpmbuild/SRPMS/$SOURCE ]]; then
    echo "ERROR: no SRPM found";
    exit 1;
fi

koji build --scratch f$VERSION_ID ~/rpmbuild/SRPMS/$SOURCE
