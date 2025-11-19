package dev.zeekr.connectivity

import android.annotation.SuppressLint
import androidx.annotation.Keep

@SuppressLint("PrivateApi")
@Keep
class JIpConfiguration(val obj: Any) {
    companion object {
        val clazz: Class<*> get() = Class.forName("android.net.IpConfiguration")
    }

    enum class JIpAssignment {
        STATIC, DHCP, UNASSIGNED;

        companion object {
            val clazz: Class<*> get() = Class.forName("android.net.IpConfiguration\$IpAssignment")

            fun of(obj: Any): JIpAssignment {
                val index = JIpAssignment.clazz.enumConstants!!.indexOf(obj)
                return entries[index]
            }
        }

        val obj: Any get() = clazz.enumConstants!![ordinal]
    }

    var ipAssignment: JIpAssignment
        get() {
            val method = clazz.getMethod("getIpAssignment")
            val obj = method.invoke(this.obj) ?: throw NullPointerException("ipAssignment is null")
            return JIpAssignment.of(obj)
        }
        set(value) {
            val method = clazz.getMethod("setIpAssignment", JIpAssignment.clazz)
            method.invoke(this.obj, value.obj)
        }

    var staticIpConfiguration: JStaticIpConfiguration?
        get() {
            val method = clazz.getMethod("getStaticIpConfiguration")
            val obj = method.invoke(this.obj)
            return if (obj == null) null
            else JStaticIpConfiguration(obj)
        }
        set(value) {
            val method = clazz.getMethod("setStaticIpConfiguration", JStaticIpConfiguration.clazz)
            method.invoke(this.obj, value?.obj)
        }
}