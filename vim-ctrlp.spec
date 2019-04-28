%global appdata_dir %{_datadir}/appdata

Name:           vim-ctrlp
Version:        1.8.0
Release:        1%{?dist}
Summary:        Full path fuzzy file, buffer, mru, tag, ... finder for Vim

License:        Vim
URL:            https://github.com/ctrlpvim/ctrlp.vim
Source0:        %{name}-%{version}.tar.gz
Source1:        %{name}.metainfo.xml

Requires:       vim-common
Requires(post): vim
Requires(postun): vim
# Needed for AppData check
BuildRequires:  libappstream-glib
# Defines %%vimfiles_root
BuildRequires:  vim-filesystem
BuildArch:      noarch

%description
Full path fuzzy file, buffer, mru, tag, ... finder with an intuitive interface.
Written in pure Vimscript for MacVim, gVim and Vim version 7.0+. Has full
support for Vim's |regexp| as search pattern, built-in MRU files monitoring,
project's root finder, and more.

%prep
%setup -cq

%build


%install
mkdir -p %{buildroot}%{vimfiles_root}
cp -r {autoload,doc,plugin} %{buildroot}%{vimfiles_root}

# Install AppData
mkdir -p %{buildroot}%{appdata_dir}
install -m 644 %{SOURCE1} %{buildroot}%{appdata_dir}

%check
# Check the AppData add-on to comply with guidelines
appstream-util validate-relax --nonet %{buildroot}/%{appdata_dir}/*.metainfo.xml


%files
%license LICENSE
%doc readme.md
%{vimfiles_root}/autoload/*
%doc %{vimfiles_root}/doc/*
%{vimfiles_root}/plugin/*
%{appdata_dir}/%{name}.metainfo.xml


%changelog
* Tue Feb 26 2019 Ondřej Soukup <osoukup@redhat.com> - 1.8.0-1
- Initial package.
