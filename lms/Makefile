VERSION ?= 7.9.2_pre20190615

IMAGE ?= lms:$(VERSION)
CONTAINER ?= lms-$(VERSION)

OVERLAY ?= git://anongit.gentoo.org/user/squeezebox.git
MIRROR ?= http://distfiles.gentoo.org

ETC_SOURCE ?= /etc/logitechmediaserver
LIBRARY_SOURCE ?= /mnt/music
PORTAGE_SOURCE ?= /usr/portage

PORTAGE_DEST ?= /usr/portage

all: pull build create

.PHONY: pull lms-etc build create clean

pull:
	docker pull gentoo/stage3-amd64:latest

lms-etc:
	docker volume create lms-etc

build: squeezebox.repo logitechmediaserver.etc
	cd squeezebox.repo && git pull
	docker build \
		--build-arg VERSION=$(VERSION) \
		--build-arg MIRROR=$(MIRROR) \
		--progress=plain \
		--tag $(IMAGE) \
		.

create:
	docker create \
		--name $(CONTAINER) \
		--mount type=bind,source=$(PORTAGE_SOURCE),destination=$(PORTAGE_DEST) \
		--mount type=volume,source=lms-etc,destination=/etc/logitechmediaserver \
		--mount type=bind,source=$(LIBRARY_SOURCE),destination=/mnt/music \
		$(IMAGE)
	docker start $(CONTAINER)
	docker exec -t $(CONTAINER) /root/install-lms.sh $(VERSION)

squeezebox.repo:
	git clone --depth=1 $(OVERLAY) $@

logitechmediaserver.etc:
	mkdir -p $@ && cp -pr $(ETC_SOURCE)/* $@/

clean:
	rm -rf squeezebox.repo logitechmediaserver.etc
	docker rmi gentoo/stage3-amd64:latest $(IMAGE)
	docker rm $(CONTAINER)
