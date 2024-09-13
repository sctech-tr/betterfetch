Name:           betterfetch
Version:        1.8
Release:        1%{?dist}
Summary:        A script to quickly display system information
License:        GPL-3.0-or-later
URL:            https://github.com/sctech-tr/betterfetch
Source0:        %{URL}/archive/refs/tags/%{version}/%{name}-%{version}.tar.gz
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
# Install script files to %{_bindir} without the .sh extension
install -D -m 0755 betterfetch.sh %{buildroot}%{_bindir}/betterfetch
install -D -m 0755 betterfetchrc.sh %{buildroot}%{_bindir}/betterfetchrc

# Install configuration files to %{_sysconfdir}
install -D -m 0644 betterfetchrc %{buildroot}%{_sysconfdir}/betterfetchrc
install -D -m 0644 betterfetch-version %{buildroot}%{_sysconfdir}/betterfetch-version

# Install license file
install -D -m 0644 LICENSE %{buildroot}%{_datadir}/licenses/%{name}/LICENSE

%files
%license LICENSE
%{_bindir}/betterfetch
%{_bindir}/betterfetchrc
%{_sysconfdir}/betterfetchrc
%{_sysconfdir}/betterfetch-version

%changelog
* Fri Sep 13 2024 sctech-tr <100468871+sctech-tr@users.noreply.github.com> - 1.8-1
- Update to version 1.8

* Sat Sep 07 2024 sctech-tr <100468871+sctech-tr@users.noreply.github.com> - 1.7-1
- Initial packaging of betterfetch version 1.7
