#
# Copyright (C) 2006-2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=vtun
PKG_VERSION:=3.0.3
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/vtun
PKG_MD5SUM:=f3becf2a0270910a841060c08d1db824
#3.0.4PKG_MD5SUM:=f0bae5567df858577496d6ceccfa25be

PKG_FIXUP:=autoreconf
PKG_REMOVE_FILES:=

include $(INCLUDE_DIR)/package.mk

define Package/vtun
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+kmod-tun +VTUN_LZO:liblzo +VTUN_LZO:zlib +VTUN_SSL:libopenssl +USE_GLIBC:libbsd
  TITLE:=VPN tunneling daemon
  URL:=http://vtun.sourceforge.net
  SUBMENU:=VPN
  MENU:=1
endef

define Package/vtun/config
menu "Configuration"
        depends on PACKAGE_vtun

config VTUN_config

	depends on PACKAGE_vtun
	config VTUN_LZO
		bool "enable vtun compression"
		help
			vtun tunnels will be compressed
		default y

	config VTUN_SSL
		bool "enable vtun ssl encryption"
		help
			vtun tunnels will be encrypted
		default y
endmenu
endef

define Package/vtun/conffiles
/etc/vtund.conf
/etc/rc.vtund
/etc/ppp/checkvpn.sh
endef

CONFIGURE_ARGS += \
	$(if $(CONFIG_VTUN_LZO),--with-lzo-lib="$(STAGING_DIR)/usr/lib/",--disable-zlib) \
	$(if $(CONFIG_VTUN_LZO),--with-lzo-headers="$(STAGING_DIR)/usr/include/lzo",--disable-lzo) \
	$(if $(CONFIG_VTUN_SSL),--with-ssl-headers="$(STAGING_DIR)/usr/include/openssl",--disable-ssl) \
	$(if $(CONFIG_VTUN_SSL),--with-blowfish-headers="$(STAGING_DIR)/usr/include/openssl",--disable-ssl)
	
CONFIGURE_VARS += \
	LIBS="$(TARGET_LDFLAGS)"
	

define Package/vtun/install
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/vtund.conf $(1)/etc/vtund.conf-example
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/vtund $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) ./files/rc.vtund $(1)/etc/rc.vtund
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/vtund.init $(1)/etc/init.d/vtund
	$(INSTALL_DIR) $(1)/etc/ppp
	$(INSTALL_BIN) ./files/checkvpn.sh $(1)/etc/ppp/checkvpn.sh
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) ./files/vtund.conf $(1)/etc/vtund.conf
endef

$(eval $(call BuildPackage,vtun))
