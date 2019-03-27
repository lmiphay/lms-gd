LMSVER ?= 7.9.1

all: base lms

base:
	make -C lms-base

lms:
	make -C lms-$(LMSVER)

prune:
	docker image prune --all --force

clean:
	for dir in lms-base lms-$(LMSVER) ; do make -C $$dir clean; done
