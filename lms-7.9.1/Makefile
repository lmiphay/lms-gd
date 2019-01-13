TAG="lms:7.9.1"

all: squeezebox update build

build:
	../bin/gd-build $(TAG) .

squeezebox:
	git clone git://anongit.gentoo.org/user/squeezebox.git

update:
	cd squeezebox && git pull

rmi:
	docker rmi $(TAG)
