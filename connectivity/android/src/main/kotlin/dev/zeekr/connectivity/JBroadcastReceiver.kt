package dev.zeekr.connectivity

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

interface JBroadcastReceiver {
    fun onReceive(context: Context, intent: Intent)
}

class JBroadcastReceiverImpl(private val receiver: JBroadcastReceiver) : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if (context == null) throw NullPointerException("context is null")
        if (intent == null) throw NullPointerException("intent is null")
        this.receiver.onReceive(context, intent)
    }
}