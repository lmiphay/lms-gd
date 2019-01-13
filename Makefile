
all: base lms

base:
	make -C lms-base

lms:
	make -C lms-7.9.1

prune:
	docker image prune --all --force

clean:
	for dir in lms-base lms-7.9.1 ; do make -C $$dir clean; done
