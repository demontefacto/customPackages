SNMP_TRANSPORTS_EXCLUDED = TCP TCPIPv6

TARGET_CFLAGS += $(FPIC)
TARGET_CPPFLAGS += -I$(STAGING_DIR)/usr/include/libnl-tiny

CONFIGURE_ARGS += \
        --enable-mfd-rewrites \
        --enable-shared \
        --enable-static \
        --with-endianness=$(if $(CONFIG_BIG_ENDIAN),big,little) \
        --with-logfile=/var/log/snmpd.log \
        --with-persistent-directory=/usr/lib/snmp/ \
        --with-default-snmp-version=1 \
        --with-sys-contact=root@localhost \
        --with-sys-location=Unknown \
        --enable-applications \
        --disable-debugging \
        --disable-manuals \
        --disable-scripts \
        --with-out-mib-modules="$(SNMP_MIB_MODULES_EXCLUDED)" \
        --with-mib-modules="$(SNMP_MIB_MODULES_INCLUDED)" \
        --with-out-transports="$(SNMP_TRANSPORTS_EXCLUDED)" \
        --with-transports="$(SNMP_TRANSPORTS_INCLUDED)" \
        --without-openssl \
        --with-libwrap \
        --without-mysql \
        --without-rpm \
        --without-zlib \
        --with-nl \
         $(call autoconf_bool,CONFIG_IPV6,ipv6) \
        --disable-perl-cc-checks \
        --disable-embedded-perl \
        --without-perl-modules

CONFIGURE_VARS += \
        ac_cv_header_netlink_netlink_h=yes \
        ac_cv_header_pcre_h=no \
        netsnmp_cv_func_nl_connect_LIBS=-lnl-tiny \

ifeq ($(CONFIG_IPV6),y)
SNMP_TRANSPORTS_INCLUDED+= UDPIPv6
endif

TARGET_LDFLAGS += -L$(TOOLCHAIN_DIR)/usr/lib

define Build/Compile
        $(MAKE) -C $(PKG_BUILD_DIR) \
                INSTALL_PREFIX="$(PKG_INSTALL_DIR)" \
                LDFLAGS="$(TARGET_LDFLAGS) -lm -lc" \
                all install
endef

define Build/InstallDev
        $(INSTALL_DIR) $(2)/bin
        $(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/net-snmp-config $(2)/bin/
        $(SED) 's,=/usr,=$(STAGING_DIR)/usr,g' $(2)/bin/net-snmp-config
        $(INSTALL_DIR) $(STAGING_DIR)/usr/bin
        $(LN) $(STAGING_DIR)/host/bin/net-snmp-config $(STAGING_DIR)/usr/bin/

        $(INSTALL_DIR) $(1)/usr/include
        $(CP) $(PKG_INSTALL_DIR)/usr/include/net-snmp $(1)/usr/include/
        $(INSTALL_DIR) $(1)/usr/lib
        $(CP) $(PKG_INSTALL_DIR)/usr/lib/libnetsnmp{,agent,helpers,mibs}.{a,so*} $(1)/usr/lib/
endef

define Package/libnetsnmp/install
        $(INSTALL_DIR) $(1)/usr/lib
        $(CP) $(PKG_INSTALL_DIR)/usr/lib/libnetsnmp{,agent,helpers,mibs}.so.* $(1)/usr/lib/
endef

define Package/snmp-mibs/install
        $(INSTALL_DIR) $(1)/usr/share/snmp/mibs
        $(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/snmp/mibs/* $(1)/usr/share/snmp/mibs/
endef

define Package/snmp-utils/install
        $(INSTALL_DIR) $(1)/usr/bin
        $(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/snmp{get,set,status,test,trap,walk} $(1)/usr/bin/
endef

define Package/snmpd/conffiles
/etc/snmpd/snmpd.conf
endef

define Package/snmpd/install
        $(INSTALL_DIR) $(1)/etc/snmpd
        $(INSTALL_DATA) ./files/snmpd.conf $(1)/etc/snmpd/snmpd.conf
        $(INSTALL_DIR) $(1)/etc/init.d
        $(INSTALL_BIN) ./files/snmpd.init $(1)/etc/init.d/snmpd
        $(INSTALL_DIR) $(1)/usr/sbin
        $(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/snmpd $(1)/usr/sbin/snmpd
endef

define Package/snmptrapd/install
        $(INSTALL_DIR) $(1)/etc/init.d
        $(INSTALL_BIN) ./files/snmptrapd.init $(1)/etc/init.d/snmptrapd
        $(INSTALL_DIR) $(1)/usr/lib 
        $(CP) $(PKG_INSTALL_DIR)/usr/lib/libnetsnmptrapd.so.* $(1)/usr/lib/ 
        $(INSTALL_DIR) $(1)/usr/sbin
        $(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/snmptrapd $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,libnetsnmp))
$(eval $(call BuildPackage,snmp-mibs))
$(eval $(call BuildPackage,snmp-utils))
$(eval $(call BuildPackage,snmpd))
$(eval $(call BuildPackage,snmpd-static))
$(eval $(call BuildPackage,snmptrapd))

