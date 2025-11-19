package dev.zeekr.connectivity.ethernet

import android.annotation.SuppressLint
import android.content.Context
import android.os.Handler
import androidx.annotation.Keep
import dev.zeekr.connectivity.JIpConfiguration
import net.bytebuddy.ByteBuddy
import net.bytebuddy.android.AndroidClassLoadingStrategy
import net.bytebuddy.description.method.MethodDescription
import net.bytebuddy.implementation.InvocationHandlerAdapter
import net.bytebuddy.matcher.ElementMatchers
import java.lang.reflect.InvocationHandler

@Keep
@SuppressLint("PrivateApi")
class JEthernetManager(context: Context) {
    companion object {
        val ETHERNET_SERVICE: String
            get() {
                val field = Context::class.java.getField("ETHERNET_SERVICE")
                return field.get(null) as String
            }

        val clazz: Class<*> get() = Class.forName("android.net.EthernetManager")
    }

    @Keep
    interface JListener {
        fun onAvailabilityChanged(iface: String, isAvailable: Boolean)
    }

    @Keep
    class JListenerImpl(context: Context, listener: JListener) {
        companion object {
            val clazz: Class<*> get() = Class.forName("android.net.EthernetManager\$Listener")
        }

        val obj: Any

        init {
            val matcher = ElementMatchers.named<MethodDescription>("onAvailabilityChanged")
            val handler = InvocationHandler { _, _, args ->
                val iface = args[0] as String
                val isAvailable = args[1] as Boolean
                Handler(context.mainLooper).post { listener.onAvailabilityChanged(iface, isAvailable) }
            }
            val implementation = InvocationHandlerAdapter.of(handler)
            val privateDirectory = context.getDir("generated", Context.MODE_PRIVATE)
            val classLoadingStrategy = AndroidClassLoadingStrategy.Wrapping(privateDirectory)
            this.obj = ByteBuddy().subclass(clazz).method(matcher).intercept(implementation).make()
                .load(clazz.classLoader, classLoadingStrategy).loaded.getConstructor().newInstance()
        }
    }

    val obj: Any = context.getSystemService(ETHERNET_SERVICE)

    val isAvailable: Boolean
        get() {
            val method = clazz.getMethod("isAvailable")
            return method.invoke(this.obj) as Boolean
        }

    val availableInterfaces: Array<String>
        get() {
            val method = clazz.getMethod("getAvailableInterfaces")
            val ifaces = method.invoke(this.obj) as Array<*>
            return ifaces.filterIsInstance<String>().toTypedArray()
        }

    fun getConfiguration(iface: String): JIpConfiguration {
        val method = clazz.getMethod("getConfiguration", String::class.java)
        val obj = method.invoke(this.obj, iface) ?: throw NullPointerException("configuration is null")
        return JIpConfiguration(obj)
    }

    fun setConfiguration(iface: String, config: JIpConfiguration) {
        val method = clazz.getMethod("setConfiguration", String::class.java, JIpConfiguration.clazz)
        method.invoke(this.obj, iface, config.obj)
    }

    fun isAvailable(iface: String): Boolean {
        val method = clazz.getMethod("isAvailable", String::class.java)
        return method.invoke(this.obj, iface) as Boolean
    }

    fun addListener(listener: JListenerImpl) {
        val method = clazz.getMethod("addListener", JListenerImpl.clazz)
        method.invoke(this.obj, listener.obj)
    }

    fun removeListener(listener: JListenerImpl) {
        val method = clazz.getMethod("removeListener", JListenerImpl.clazz)
        method.invoke(this.obj, listener.obj)
    }
}