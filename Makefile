#
# It's sometimes convenient to know the local IP address and MAC address.
# Sometimes it is useful to know a few other networking details too.
#
# Written by Glen Darling (mosquito@darlingevil.com), June 2019.
#

LOCAL_DEFAULT_ROUTE     := $(shell sh -c "ip route | grep default")
LOCAL_ROUTER_ADDRESS    := $(word 3, $(LOCAL_DEFAULT_ROUTE))
LOCAL_DEFAULT_INTERFACE := $(word 5, $(LOCAL_DEFAULT_ROUTE))
LOCAL_IP_ADDRESS        := $(shell sh -c "ip addr | egrep -A 3 eth1 | grep '    inet ' | sed 's/^    inet //;s|/.*||'")
LOCAL_MAC_ADDRESS       := $(shell sh -c "ip link show | sed 'N;s/\n/ /' | grep $(LOCAL_DEFAULT_INTERFACE) | sed 's/.*ether //;s/ .*//;'")
LOCAL_SUBNET_CIDR       := $(shell sh -c "echo $(wordlist 1, 3, $(subst ., ,$(LOCAL_IP_ADDRESS))) | sed 's/ /./g;s|.*|&.0/24|'")

coolness:
	@#echo "Default route:     \"$(LOCAL_DEFAULT_ROUTE)\""
	@#echo "Default interface:  \"$(LOCAL_DEFAULT_INTERFACE)\""
	@echo "Subnet CIDR:        \"$(LOCAL_SUBNET_CIDR)\""
	@echo "Router address:     \"$(LOCAL_ROUTER_ADDRESS)\""
	@echo "Local IPv4 address: \"$(LOCAL_IP_ADDRESS)\""
	@echo "Local MAC address:  \"$(LOCAL_MAC_ADDRESS)\""

.PHONY: coolness
