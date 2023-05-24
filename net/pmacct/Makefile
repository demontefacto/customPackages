#
# Copyright (C) 2006 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pmacct
PKG_VERSION:=1.6.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.pmacct.net/ 
PKG_HASH:=e6ede7f500fb1771b5cdfb63dfa016e34c19b8aa2d2f672bd4c63016a5d6bbe2
PKG_MAINTAINER:=Damiano Verzulli <damiano@verzulli.it>
PKG_LICENSE:=GPL-2.0

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_FIXUP:=autoreconf

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

CONFIGURE_ARGS += \
	--with-pcap-includes="$(STAGING_DIR)/usr/include" \
	--with-pcap-libs="$(STAGING_DIR)/usr/lib" \
	--enable-bgp-bins=no \
	--enable-bmp-bins=no \
	--enable-st-bins=no

TARGET_CFLAGS += -ffunction-sections -fdata-sections
TARGET_LDFLAGS += -Wl,--gc-sections

CONFIGURE_VARS += \
        BUILD_CC="$(TARGET_CC)" \
        HOSTCC="$(HOSTCC)" \
        td_cv_buggygetaddrinfo="no" \
        ac_cv_linux_vers=$(LINUX_VERSION) \
        ac_cv_header_rpc_rpcent_h=no \
        ac_cv_lib_rpc_main=no \
        ac_cv_path_PCAP_CONFIG=""

MAKE_FLAGS := CCOPT="$(TARGET_CFLAGS)" INCLS="-I. $(TARGET_CPPFLAGS)"


define Package/pmacct
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libpcap +libpthread
  TITLE:=a powerful IP accounting set of tools
  URL:=http://www.pmacct.net/
endef

define Package/pmacct/install	
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/pmacct $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/pmacctd $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/sfacctd $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/nfacctd $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,pmacct))