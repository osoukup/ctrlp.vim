#!/bin/bash
# RPM in KOJI build script
# needs to have Fedora development installed and valid Kerberos ticket
# https://fedoraproject.org/wiki/Join_the_package_collection_maintainers#Install_the_developer_client_tools
# kinit osoukup@FEDORAPROJECT.ORG

source /etc/os-release

SOURCE=$(basename $(find ~/rpmbuild/SRPMS/*))

if [[ ! -e ~/rpmbuild/SRPMS/$SOURCE ]]; then
    echo "ERROR: no SRPM found";
    exit 1;
fi

koji build --scratch f$VERSION_ID ~/rpmbuild/SRPMS/$SOURCE
