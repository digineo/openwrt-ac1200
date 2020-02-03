OPENWRT := repos/openwrt

.PHONY: all
all: $(OPENWRT)/feeds.conf $(OPENWRT)/.config
	make -C $(OPENWRT) download
	ionice -c 3 nice -n19 make -C $(OPENWRT) -j$(shell nproc)

$(OPENWRT)/feeds.conf: feeds.conf
	cp $< $@
	cd $(OPENWRT); scripts/feeds update -a
	cd $(OPENWRT); scripts/feeds install -a

$(OPENWRT)/.config: config.ac1200pro
	cp $< $@
	make -C $(OPENWRT) defconfig
