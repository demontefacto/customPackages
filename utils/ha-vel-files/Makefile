#
# Copyright (C) 2007-2021 OpenWrt.org
# Copyright (C) 2010 Vertical Communications
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/version.mk
include $(INCLUDE_DIR)/feeds.mk

PKG_NAME:=ha-vel-files
PKG_VERSION:=202305
PKG_RELEASE:=1

PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/ha-vel-files
  SECTION:=base
  CATEGORY:=Base system
  TITLE:=Base filesystem for ha-vel
  URL:=https://ha-vel.eu
  VERSION:=$(PKG_VERSION)-$(PKG_RELEASE)
endef

define Package/ha-vel-files/conffiles
/etc/config/system
/etc/hosts
/etc/passwd
/etc/profile
/etc/protocols
/etc/rc.local
/etc/shadow
/etc/sysupgrade.conf
$(call $(TARGET)/conffiles)
endef

define Package/ha-vel-files/description
 This package contains a base ha-vel filesystem and system scripts for ha-vel OpenWrt.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile/Default

endef
Build/Compile = $(Build/Compile/Default)

ifdef CONFIG_SIGNED_PACKAGES
  define Build/Configure
	[ -s $(BUILD_KEY) -a -s $(BUILD_KEY).pub ] || \
		$(STAGING_DIR_HOST)/bin/usign -G -s $(BUILD_KEY) -p $(BUILD_KEY).pub -c "Local build key"

	[ -s $(BUILD_KEY).ucert ] || \
		$(STAGING_DIR_HOST)/bin/ucert -I -c $(BUILD_KEY).ucert -p $(BUILD_KEY).pub -s $(BUILD_KEY)

  endef

ifndef CONFIG_BUILDBOT
  define Package/base-files/install-key
	mkdir -p $(1)/etc/opkg/keys
	$(CP) $(BUILD_KEY).pub $(1)/etc/opkg/keys/`$(STAGING_DIR_HOST)/bin/usign -F -p $(BUILD_KEY).pub`

  endef
endif
endif


define Package/ha-vel-files/install
	$(CP) ./files/* $(1)/
	$(Package/base-files/install-key)
	$(Package/base-files/nand-support)
	$(Package/base-files/legacy-sdcard-support)
	$(Package/base-files/emmc-support)

	$(call ImageConfigOptions,$(1))
	$(call Package/base-files/install-target,$(1))
	for conffile in $(1)/etc/config/*; do \
		if [ -f "$$$$conffile" ]; then \
			grep "$$$${conffile##$(1)}" $(1)/CONTROL/conffiles || \
				echo "$$$${conffile##$(1)}" >> $(1)/CONTROL/conffiles; \
		fi \
	done

	$(if $(CONFIG_INCLUDE_CONFIG), \
		echo -e "# Build configuration for board $(BOARD)/$(SUBTARGET)/$(PROFILE)\n" >$(1)/etc/build.config; \
		cat $(BIN_DIR)/config.buildinfo >>$(1)/etc/build.config; \
		cat $(BIN_DIR)/feeds.buildinfo >>$(1)/etc/build.feeds; \
		cat $(BIN_DIR)/version.buildinfo >>$(1)/etc/build.version)

	$(if $(CONFIG_CLEAN_IPKG),, \
		mkdir -p $(1)/etc/opkg; \
		$(call FeedSourcesAppend,$(1)/etc/opkg/distfeeds.conf); \
		$(VERSION_SED_SCRIPT) $(1)/etc/opkg/distfeeds.conf)
	$(if $(CONFIG_IPK_FILES_CHECKSUMS),, \
		rm -f $(1)/sbin/pkg_check)
endef


$(eval $(call BuildPackage,ha-vel-files))
