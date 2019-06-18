IMAGE:=lms:latest
CONTAINER:=lms
VERSION:=7.9.2_pre20190615

OVERLAY:=git://anongit.gentoo.org/user/squeezebox.git

ETC_SOURCE:=/etc/logitechmediaserver
LIBRARY:=/mnt/music

all: pull build create install

pull:
	docker pull gentoo/stage3-amd64:latest

squeezebox:
	git clone --depth=1 $(OVERLAY) $@

freshen:
	cd squeezebox && git pull

build:
	docker build \
		--build-arg VERSION=$(VERSION) \
		--progress=plain \
		--tag $(IMAGE) \
		.

lms-etc:
	docker volume create lms-etc

lms-etc-init:
	docker cp $(ETC_SOURCE) $(CONTAINER):/etc/logitechmediaserver/
	# COPY --chown=logitechmediaserver logitechmediaserver /etc/logitechmediaserver

create:
	docker create \
		--name $(CONTAINER) \
		--mount type=bind,source=/usr/portage,destination=/usr/portage \
		--mount type=volume,source=lms-etc,destination=/etc/logitechmediaserver \
		--mount type=bind,source=$(LIBRARY),destination=/mnt/music \
		$(IMAGE)

install:
	docker start $(CONTAINER)
	docker exec -t $(CONTAINER) /root/install-lms.sh $(VERSION)
	docker cp sysklogd.rc7 /etc/init.d/sysklogd

clean:
	docker rmi gentoo/stage3-amd64:latest $(IMAGE)
	docker rm $(CONTAINER)
	rm -rf squeezebox
