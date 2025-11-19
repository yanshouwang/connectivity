package dev.zeekr.connectivity

import android.net.ConnectivityManager
import android.net.LinkProperties
import android.net.Network
import android.net.NetworkCapabilities
import android.os.Build
import androidx.annotation.Keep
import androidx.annotation.RequiresApi

@Keep
class JConnectivityManager {
    @Keep
    interface JNetworkCallback {
        fun onAvailable(network: Network)
        fun onBlockedStatusChanged(network: Network, blocked: Boolean)
        fun onCapabilitiesChanged(network: Network, networkCapabilities: NetworkCapabilities)
        fun onLinkPropertiesChanged(network: Network, linkProperties: LinkProperties)
        fun onLosing(network: Network, maxMsToLive: Int)
        fun onLost(network: Network)
        fun onReserved(networkCapabilities: NetworkCapabilities)
        fun onUnavailable()
    }

    @Keep
    class JNetworkCallbackImpl : ConnectivityManager.NetworkCallback {
        private val callback: JNetworkCallback

        constructor(callback: JNetworkCallback) : super() {
            this.callback = callback
        }

        @RequiresApi(Build.VERSION_CODES.S)
        constructor(callback: JNetworkCallback, flags: Int) : super(flags) {
            this.callback = callback
        }

        override fun onAvailable(network: Network) {
            super.onAvailable(network)
            this.callback.onAvailable(network)
        }

        override fun onBlockedStatusChanged(network: Network, blocked: Boolean) {
            super.onBlockedStatusChanged(network, blocked)
            this.callback.onBlockedStatusChanged(network, blocked)
        }

        override fun onCapabilitiesChanged(network: Network, networkCapabilities: NetworkCapabilities) {
            super.onCapabilitiesChanged(network, networkCapabilities)
            this.callback.onCapabilitiesChanged(network, networkCapabilities)
        }

        override fun onLinkPropertiesChanged(network: Network, linkProperties: LinkProperties) {
            super.onLinkPropertiesChanged(network, linkProperties)
            this.callback.onLinkPropertiesChanged(network, linkProperties)
        }

        override fun onLosing(network: Network, maxMsToLive: Int) {
            super.onLosing(network, maxMsToLive)
            this.callback.onLosing(network, maxMsToLive)
        }

        override fun onLost(network: Network) {
            super.onLost(network)
            this.callback.onLost(network)
        }

        override fun onReserved(networkCapabilities: NetworkCapabilities) {
            super.onReserved(networkCapabilities)
            this.callback.onReserved(networkCapabilities)
        }

        override fun onUnavailable() {
            super.onUnavailable()
            this.callback.onUnavailable()
        }
    }
}