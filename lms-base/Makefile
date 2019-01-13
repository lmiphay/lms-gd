TAG="lms/base:latest"

all: build

build: sysklogd.rc7
	../bin/gd-build $(TAG) .

sysklogd.rc7:
	cp ../common/sysklogd.rc7 .

clean:
	rm -f sysklogd.rc7

rmi:
	docker rmi $(TAG)

