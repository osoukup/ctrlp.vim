#!/bin/bash
# RPM build script

if ! rpmlint -i vim-ctrlp.spec; then
    echo "ERROR: invalid spec file";
    exit 1;
fi

rpmdev-setuptree

cp vim-ctrlp.spec ~/rpmbuild/SPECS/
spectool -g -R ~/rpmbuild/SPECS/vim-ctrlp.spec

rpmbuild --quiet -ba ~/rpmbuild/SPECS/vim-ctrlp.spec
rpmlint -i ~/rpmbuild/RPMS/noarch/*
