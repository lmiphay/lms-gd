VERSION ?= 7.9.2_pre20190615

CONTAINER ?= lms-$(VERSION)

OVERLAY ?= git://anongit.gentoo.org/user/squeezebox.git
BRANCH ?= master
MIRROR ?= http://distfiles.gentoo.org

ETC_SOURCE ?= /etc/logitechmediaserver
LIBRARY_SOURCE ?= /mnt/music
PORTAGE_SOURCE ?= /usr/portage

PORTAGE_DEST ?= /usr/portage

PORT_FORWARDS ?= -p 3483:3483 -p 3483:3483/udp -p 9000:9000 -p 9090:9090

all: pull image container

.PHONY: pull image container clean

pull:
	docker pull gentoo/stage3-amd64:latest

image: squeezebox.overlay logitechmediaserver.etc
	git -C squeezebox.overlay pull
	docker build --build-arg MIRROR=$(MIRROR) --progress=plain --tag lms/base:$(VERSION) .

container:
	docker volume create lms-etc
	docker create \
		$(PORT_FORWARDS) \
		--name $(CONTAINER) \
		--mount type=bind,source=$(PORTAGE_SOURCE),destination=$(PORTAGE_DEST) \
		--mount type=volume,source=lms-etc,destination=/etc/logitechmediaserver \
		--mount type=bind,source=$(LIBRARY_SOURCE),destination=/mnt/music \
		lms/base:$(VERSION)
	docker start $(CONTAINER)
	docker exec -t $(CONTAINER) make -f /root/Makefile.container MIRROR=$(MIRROR) initial
	docker commit $(CONTAINER) lms/utils:$(VERSION)
	docker exec -t $(CONTAINER) make -f /root/Makefile.container VERSION=$(VERSION) MIRROR=$(MIRROR) final

cleand:
	docker rm $(CONTAINER)
	docker rmi lms/utils:$(VERSION) lms/base:$(VERSION)

cleanartifacts:
	rm -rf squeezebox.overlay logitechmediaserver.etc

%.overlay:
	git clone --branch $(BRANCH) --depth=1 $(OVERLAY) $@

%.etc:
	mkdir -p $@ && [ -d $(ETC_SOURCE) ] && cp -pr $(ETC_SOURCE)/* $@/
