
ETC_SRC=/etc/logitechmediaserver
VOL_NAME=lms-etc

all: create copyin

create:
	docker volume create $(VOL_NAME)

copyin:
	docker run --rm \
		--mount source=$(VOL_NAME),destination=/etc/logitechmediaserver \
		--mount type=bind,source=$(ETC_SRC),target=/lms-etc-source \
		gentoo/stage3-amd64:latest \
		cp -pr /lms-etc-source/. /etc/logitechmediaserver

backup:
	docker run --rm \
		--mount source=$(VOL_NAME),destination=/etc/logitechmediaserver \
		--mount type=bind,source=$(PWD),target=/backup \
		gentoo/stage3-amd64:latest \
		tar cvf /backup/backup.tar /etc/logitechmediaserver

clean:
	docker volume rm $(VOL_NAME)

inspect:
	docker volume inspect lms-etc


