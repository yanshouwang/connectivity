package dev.zeekr.connectivity

import java.net.Inet4Address
import java.net.InetAddress
import java.net.UnknownHostException

// https://cs.android.com/android/platform/superproject/main/+/main:packages/modules/Connectivity/staticlibs/framework/com/android/net/module/util/Inet4AddressUtils.java
/**
 * Collection of utilities to work with IPv4 addresses.
 */
object JInet4AddressUtil {
    /**
     * Convert a IPv4 address from an integer to an InetAddress (0x04030201 -> 1.2.3.4)
     *
     *
     * This method uses the higher-order int bytes as the lower-order IPv4 address bytes,
     * which is an unusual convention. Consider [.intToInet4AddressHTH] instead.
     * @param hostAddress an int coding for an IPv4 address, where higher-order int byte is
     * lower-order IPv4 address byte
     */
    fun intToInet4AddressHTL(hostAddress: Int): Inet4Address {
        return intToInet4AddressHTH(Integer.reverseBytes(hostAddress))
    }

    /**
     * Convert a IPv4 address from an integer to an InetAddress (0x01020304 -> 1.2.3.4)
     * @param hostAddress an int coding for an IPv4 address
     */
    fun intToInet4AddressHTH(hostAddress: Int): Inet4Address {
        val addressBytes = byteArrayOf(
            (0xff and (hostAddress shr 24)).toByte(),
            (0xff and (hostAddress shr 16)).toByte(),
            (0xff and (hostAddress shr 8)).toByte(),
            (0xff and hostAddress).toByte()
        )

        try {
            return InetAddress.getByAddress(addressBytes) as Inet4Address
        } catch (e: UnknownHostException) {
            throw AssertionError()
        }
    }

    /**
     * Convert an IPv4 address from an InetAddress to an integer (1.2.3.4 -> 0x01020304)
     *
     *
     * This conversion can help order IP addresses: considering the ordering
     * 192.0.2.1 < 192.0.2.2 < ..., resulting ints will follow that ordering if read as unsigned
     * integers with [Integer.toUnsignedLong].
     * @param inetAddr is an InetAddress corresponding to the IPv4 address
     * @return the IP address as integer
     */
    fun inet4AddressToIntHTH(inetAddr: Inet4Address): Int {
        val addr = inetAddr.getAddress()
        return (((addr[0].toInt() and 0xff) shl 24) or ((addr[1].toInt() and 0xff) shl 16) or ((addr[2].toInt() and 0xff) shl 8) or (addr[3].toInt() and 0xff))
    }

    /**
     * Convert a IPv4 address from an InetAddress to an integer (1.2.3.4 -> 0x04030201)
     *
     *
     * This method stores the higher-order IPv4 address bytes in the lower-order int bytes,
     * which is an unusual convention. Consider [.inet4AddressToIntHTH] instead.
     * @param inetAddr is an InetAddress corresponding to the IPv4 address
     * @return the IP address as integer
     */
    fun inet4AddressToIntHTL(inetAddr: Inet4Address): Int {
        return Integer.reverseBytes(inet4AddressToIntHTH(inetAddr))
    }

    /**
     * Convert a network prefix length to an IPv4 netmask integer (prefixLength 17 -> 0xffff8000)
     * @return the IPv4 netmask as an integer
     */
    fun prefixLengthToV4NetmaskIntHTH(prefixLength: Int): Int {
        require(!(prefixLength < 0 || prefixLength > 32)) { "Invalid prefix length (0 <= prefix <= 32)" }
        // (int)a << b is equivalent to a << (b & 0x1f): can't shift by 32 (-1 << 32 == -1)
        return if (prefixLength == 0) 0 else -0x1 shl (32 - prefixLength)
    }

    /**
     * Convert a network prefix length to an IPv4 netmask integer (prefixLength 17 -> 0x0080ffff).
     *
     *
     * This method stores the higher-order IPv4 address bytes in the lower-order int bytes,
     * which is an unusual convention. Consider [.prefixLengthToV4NetmaskIntHTH] instead.
     * @return the IPv4 netmask as an integer
     */
    fun prefixLengthToV4NetmaskIntHTL(prefixLength: Int): Int {
        return Integer.reverseBytes(prefixLengthToV4NetmaskIntHTH(prefixLength))
    }

    /**
     * Convert an IPv4 netmask to a prefix length, checking that the netmask is contiguous.
     * @param netmask as a `Inet4Address`.
     * @return the network prefix length
     * @throws IllegalArgumentException the specified netmask was not contiguous.
     * @hide
     */
    fun netmaskToPrefixLength(netmask: Inet4Address): Int {
        // inetAddressToInt returns an int in *network* byte order.
        val i = inet4AddressToIntHTH(netmask)
        val prefixLength = Integer.bitCount(i)
        val trailingZeros = Integer.numberOfTrailingZeros(i)
        require(trailingZeros == 32 - prefixLength) { "Non-contiguous netmask: " + Integer.toHexString(i) }
        return prefixLength
    }

    /**
     * Returns the implicit netmask of an IPv4 address, as was the custom before 1993.
     */
    fun getImplicitNetmask(address: Inet4Address): Int {
        val firstByte = address.getAddress()[0].toInt() and 0xff // Convert to an unsigned value.
        if (firstByte < 128) {
            return 8
        } else if (firstByte < 192) {
            return 16
        } else if (firstByte < 224) {
            return 24
        } else {
            return 32 // Will likely not end well for other reasons.
        }
    }

    /**
     * Get the broadcast address for a given prefix.
     *
     *
     * For example 192.168.0.1/24 -> 192.168.0.255
     */
    fun getBroadcastAddress(addr: Inet4Address, prefixLength: Int): Inet4Address {
        val intBroadcastAddr = (inet4AddressToIntHTH(addr) or prefixLengthToV4NetmaskIntHTH(prefixLength).inv())
        return intToInet4AddressHTH(intBroadcastAddr)
    }

    /**
     * Get a prefix mask as Inet4Address for a given prefix length.
     *
     *
     * For example 20 -> 255.255.240.0
     */
    fun getPrefixMaskAsInet4Address(prefixLength: Int): Inet4Address {
        return intToInet4AddressHTH(prefixLengthToV4NetmaskIntHTH(prefixLength))
    }

    /**
     * Trim leading zeros from IPv4 address strings
     * Non-v4 addresses and host names remain unchanged.
     * For example, 192.168.000.010 -> 192.168.0.10
     * @param addr a string representing an ip address
     * @return a string properly trimmed
     */
    fun trimAddressZeros(addr: String?): String? {
        if (addr == null) return null
        val octets: Array<String?> = addr.split("\\.".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()
        if (octets.size != 4) return addr
        val builder = StringBuilder(16)
        var result: String? = null
        for (i in 0..3) {
            try {
                if (octets[i]!!.length > 3) return addr
                builder.append(octets[i]!!.toInt())
            } catch (e: NumberFormatException) {
                return addr
            }
            if (i < 3) builder.append('.')
        }
        result = builder.toString()
        return result
    }
}