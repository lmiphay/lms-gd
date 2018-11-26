TAG="lms:7.9.1"

all: squeezebox update build

build:
	DOCKER_BUILDKIT=1 docker build --console true --tag $(TAG) .

squeezebox:
	git clone git://anongit.gentoo.org/user/squeezebox.git

update:
	cd squeezebox && git pull
