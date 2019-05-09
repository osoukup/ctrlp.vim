#!/bin/bash
# RPM in COPR build and test script
# needs to have COPR API key configured
# https://copr.fedorainfracloud.org/api/

source /etc/os-release

VERSION=`grep Version vim-ctrlp.spec | cut -d: -f2 | xargs`
SOURCE=vim-ctrlp-$VERSION-1.fc$VERSION_ID.src.rpm

if [[ ! -e ~/rpmbuild/SRPMS/$SOURCE ]]; then
    echo "ERROR: no SRPM found";
    exit 1;
fi

copr-cli build ctrlp.vim ~/rpmbuild/SRPMS/$SOURCE

mkdir vagrant
cp Vagrantfile vagrant/Vagrantfile
sed -i "s/[[:digit:]][[:digit:]]-cloud-base/$VERSION_ID-cloud-base/g" vagrant/Vagrantfile
sed -i "s/INSTALL/yum install yum-plugins-core -y ; yum copr enable osoukup\/ctrlp.vim -y ; yum install vim-ctrlp -y/g" vagrant/Vagrantfile


pushd vagrant
vagrant up
vagrant ssh
vagrant destroy -f
popd

rm -r vagrant
