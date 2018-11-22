TAG="lms/base:latest"

all: build

build: sysklogd.rc7
	DOCKER_BUILDKIT=1 docker build --tag $(TAG) .

sysklogd.rc7:
	cp ../common/sysklogd.rc7 .

clean:
	rm -f sysklogd.rc7
