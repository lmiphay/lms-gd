TAG := lms:$(LMSVER)

all: squeezebox update build

build:
	DOCKER_BUILDKIT=1 docker build \
		--build-arg LMSVER=$(LMSVER) \
		--progress=plain \
		--tag ${TAG} \
		.

squeezebox:
	git clone git://anongit.gentoo.org/user/squeezebox.git

update:
	cd squeezebox && git pull

rmi:
	docker rmi $(TAG)
