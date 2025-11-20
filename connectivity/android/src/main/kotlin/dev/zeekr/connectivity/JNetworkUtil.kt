package dev.zeekr.connectivity

import java.net.Inet4Address

// https://cs.android.com/android/platform/superproject/main/+/main:packages/modules/Connectivity/framework/src/android/net/NetworkUtils.java
/**
 * Native methods for managing network interfaces.
 */
object JNetworkUtil {
    /**
     * @see JInet4AddressUtil.intToInet4AddressHTL
     */
    fun intToInetAddress(hostAddress: Int): Inet4Address {
        return JInet4AddressUtil.intToInet4AddressHTL(hostAddress)
    }

    /**
     * @see JInet4AddressUtil.inet4AddressToIntHTL
     */
    fun inetAddressToInt(inetAddr: Inet4Address): Int {
        return JInet4AddressUtil.inet4AddressToIntHTL(inetAddr)
    }

    /**
     * @see JInet4AddressUtil.prefixLengthToV4NetmaskIntHTL
     */
    fun prefixLengthToNetmaskInt(prefixLength: Int): Int {
        return JInet4AddressUtil.prefixLengthToV4NetmaskIntHTL(prefixLength)
    }

    /**
     * Convert a IPv4 netmask integer to a prefix length
     * @param netmask as an integer (0xff000000 for a /8 subnet)
     * @return the network prefix length
     */
    fun netmaskIntToPrefixLength(netmask: Int): Int {
        return Integer.bitCount(netmask)
    }

    /**
     * Convert an IPv4 netmask to a prefix length, checking that the netmask is contiguous.
     * @param netmask as a `Inet4Address`.
     * @return the network prefix length
     * @throws IllegalArgumentException the specified netmask was not contiguous.
     */
    fun netmaskToPrefixLength(netmask: Inet4Address): Int {
        return JInet4AddressUtil.netmaskToPrefixLength(netmask)
    }
}