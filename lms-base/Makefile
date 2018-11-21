TAG="lms/base:latest"

all: build

build: sysklogd.rc7
	docker build --tag $(TAG) .

sysklogd.rc7:
	cp ../sysklogd.rc7 .

clean:
	rm -f sysklogd.rc7
