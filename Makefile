OPENWRT := repos/openwrt

.PHONY: all
all: $(OPENWRT)/feeds.conf $(OPENWRT)/.config apply-patches
	make -C $(OPENWRT) download
	ionice -c 3 nice -n19 make -C $(OPENWRT) -j$(shell nproc)
	ln -sf $(OPENWRT)/bin/targets/ramips/mt7621/ ./firmware

$(OPENWRT)/feeds.conf: feeds.conf
	cp $< $@
	cd $(OPENWRT); scripts/feeds update -a
	cd $(OPENWRT); scripts/feeds install -a

$(OPENWRT)/.config: config.ac1200pro
	cp $< $@
	make -C $(OPENWRT) defconfig

.PHONY: apply-patches
apply-patches: unapply-patches
	git -C $(OPENWRT) am < patches/openwrt/0001-Change-default-login-credentials.patch

.PHONY: unapply-patches
unapply-patches:
	git submodule update --init
