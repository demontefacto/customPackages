include $(TOPDIR)/rules.mk

PKG_NAME:=meson
PKG_VERSION:=0.53.2
PKG_RELEASE:=1

TITLE:=meson
PYPI_NAME:=meson
PKG_HASH:=3e8f830f33184397c2eb0b651ec502adb63decb28978bdc84b3558d71284c21f

PKG_MAINTAINER:=Andre Heider <a.heider@gmail.com>
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=COPYING

HOST_BUILD_DEPENDS:=ninja/host

include ../../lang/python/pypi.mk
include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk
include ../../lang/python/python3-package.mk

define Host/Configure
endef

define Host/Compile
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOSTPKG)/lib/meson
	$(CP) $(HOST_BUILD_DIR)/* $(STAGING_DIR_HOSTPKG)/lib/meson/
endef

define Host/Clean
	$(call Host/Clean/Default)
	rm -rf $(STAGING_DIR_HOSTPKG)/lib/meson
endef

define Package/meson
  SECTION:=devel
  CATEGORY:=Development
  TITLE:=meson
  URL:=https://mesonbuild.com/
  DEPENDS:=+ninja +python3-pkg-resources
  VARIANT:=python3
endef

define Package/meson/description
  Meson is an open source build system meant to be both extremely fast, and, even more importantly, as user friendly as possible.
endef

define Package/meson/install
endef

$(eval $(call HostBuild))
$(eval $(call Py3Package,meson))
$(eval $(call BuildPackage,meson))
$(eval $(call BuildPackage,meson-src))
