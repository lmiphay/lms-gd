TAG="lms/base:latest"

OPT="--progress=plain"
#OPT="--no-cache --progress=plain"

all: build

build: sysklogd.rc7
	DOCKER_BUILDKIT=1 docker build $(OPT) --tag $(TAG) .

sysklogd.rc7:
	cp ../common/sysklogd.rc7 .

clean:
	rm -f sysklogd.rc7

rmi:
	docker rmi $(TAG)

