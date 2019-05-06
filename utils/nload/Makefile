#
# Copyright (C) 2007-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=nload
PKG_VERSION:=0.7.4
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.roland-riegel.de/$(PKG_NAME)/$(PKG_SOURCE)
PKG_MD5SUM:=3c733c528f244ca5a4f76bf185729c39
PKG_MAINTAINER:=Roland Riegel <feedback@roland-riegel.de>

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/nload
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libncurses +libstdcpp
  TITLE:=Real bandwidth monitor
  URL:=http://www.roland-riegel.de/nload/
endef

define Package/nload/description
	nload is a console application which monitors network traffic 
	and bandwidth usage in real time. 
	It visualizes the in- and outgoing traffic using 
	two graphs and provides additional info like total amount 
	of transfered data and min/max network usage.
endef

define Package/nload/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/$(PKG_NAME) $(1)/usr/bin/
endef

$(eval $(call BuildPackage,nload))
