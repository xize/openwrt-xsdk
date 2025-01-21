include $(TOPDIR)/rules.mk

PKG_NAME:=zyxel-t56-wireless-scripts-wifi-button
SOURCE_DIR:=/home/xize/openwrt/package/util/zyxel-t56-wireless-scripts-wifi-button
PKG_SOURCE_DATE:=2022-12-23
PKG_RELEASE:=1

PKG_MAINTAINER:=Guido Lucassen <glucassen@live.nl>
PKG_LICENSE:=GPL-2.0-only

include $(INCLUDE_DIR)/package.mk

define Package/zyxel-t56-wireless-scripts-wifi-button
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=Supporting wifi button for Zyxel T-56
	DEPENDS:=+kmod-button-hotplug
	PKGARCH:=all
endef

define Package/zyxel-t56-wireless-scripts-wifi-button/description
	Adds support and functionality for the wireless button to toggle it on and off.
endef

define Build/Compile
endef
 
define Package/zyxel-t56-wireless-scripts-wifi-button/install
	$(INSTALL_DIR) $(1)/etc/hotplug.d/button
	$(INSTALL_BIN) ./files/wifi $(1)/etc/hotplug.d/button/20-wifi-toggle
endef
 
$(eval $(call BuildPackage,zyxel-t56-wireless-scripts-wifi-button))