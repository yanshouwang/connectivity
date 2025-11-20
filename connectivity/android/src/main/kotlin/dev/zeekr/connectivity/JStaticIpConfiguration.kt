package dev.zeekr.connectivity

import android.annotation.SuppressLint
import android.net.LinkAddress
import android.net.LinkProperties
import android.net.RouteInfo
import java.net.InetAddress

@SuppressLint("PrivateApi")
class JStaticIpConfiguration(val obj: Any) {
    companion object {
        val clazz: Class<*> get() = Class.forName("android.net.StaticIpConfiguration")
    }

    fun clear() {
        val method = clazz.getMethod("clear")
        method.invoke(this.obj)
    }

    val ipAddress: LinkAddress
        get() {
            val method = clazz.getMethod("getIpAddress")
            return method.invoke(this.obj) as LinkAddress
        }

    val gateway: InetAddress
        get() {
            val method = clazz.getMethod("getGateway")
            return method.invoke(this.obj) as InetAddress
        }

    val dnsServers: List<InetAddress>
        get() {
            val method = clazz.getMethod("getDnsServers")
            val servers = method.invoke(this.obj) as List<*>
            return servers.filterIsInstance<InetAddress>()
        }

    val domains: String?
        get() {
            val method = clazz.getMethod("getDomains")
            return method.invoke(this.obj) as String?
        }

    fun addDnsServer(server: InetAddress) {
        val method = clazz.getMethod("addDnsServer", InetAddress::class.java)
        method.invoke(this.obj, server)
    }

    fun getRoutes(iface: String?): List<RouteInfo> {
        val method = clazz.getMethod("getRoutes", String::class.java)
        val routes = method.invoke(this.obj, iface) as List<*>
        return routes.filterIsInstance<RouteInfo>()
    }

    fun toLinkProperties(iface: String?): LinkProperties {
        val method = clazz.getMethod("toLinkProperties", String::class.java)
        return method.invoke(this.obj, iface) as LinkProperties
    }
}