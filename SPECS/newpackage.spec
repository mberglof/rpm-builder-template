Name:           %(echo $RPM_PROJECT_NAME:=newpackage)
Version:       	0.1 
Release:        1%{?dist}
Summary:        Summary of pkg

License:        MIT 
URL:            No
Source0:        www.ftp.com/tar.gz

BuildRequires:  
Requires:       

%description


%prep
%setup -q


%build
%configure
make %{?_smp_mflags}


%install
rm -rf $RPM_BUILD_ROOT
%make_install


%files
%doc



%changelog
