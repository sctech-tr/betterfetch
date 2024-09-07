Name:           betterfetch
Version:        1.7
Release:        1%{?dist}
Summary:        A script to quickly display system information
License:        GPL-3.0-or-later
URL:            https://github.com/sctech-tr/betterfetch
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch

BuildRequires:  bash
Requires:       bash

%description
betterfetch is a script to quickly display system information.

%prep
%autosetup

%build
# No build step required for this script.

%install
# Install script files to /usr/bin without the .sh extension
install -D -m 0755 betterfetch.sh %{buildroot}/usr/bin/betterfetch
install -D -m 0755 betterfetchrc.sh %{buildroot}/usr/bin/betterfetchrc

# Install configuration files to /etc
install -D -m 0644 betterfetchrc %{buildroot}/etc/betterfetchrc
install -D -m 0644 betterfetch-version %{buildroot}/etc/betterfetch-version

%files
/usr/bin/betterfetch
/usr/bin/betterfetchrc
/etc/betterfetchrc
/etc/betterfetch-version

%changelog
* Sat Sep 07 2024 sctech-tr <100468871+sctech-tr@users.noreply.github.com> - 1.7-1
- Initial packaging of betterfetch version 1.7
