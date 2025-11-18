import '../jni.dart' as jni;

enum SupplicantState {
  associated,
  associating,
  authenticating,
  completed,
  disconnected,
  dormant,
  fourWayHandshake,
  groupHandshake,
  inactive,
  interfaceDisabled,
  invalid,
  scanning,
  uninitialized;

  static bool isValidState(SupplicantState state) =>
      SupplicantStateImpl.isValidState(state);
}

final class SupplicantStateImpl {
  static bool isValidState(SupplicantState state) =>
      jni.SupplicantState.isValidState(state.api);
}

extension SupplicantStateX on SupplicantState {
  jni.SupplicantState get api {
    switch (this) {
      case SupplicantState.associated:
        return jni.SupplicantState.ASSOCIATED;
      case SupplicantState.associating:
        return jni.SupplicantState.ASSOCIATING;
      case SupplicantState.authenticating:
        return jni.SupplicantState.AUTHENTICATING;
      case SupplicantState.completed:
        return jni.SupplicantState.COMPLETED;
      case SupplicantState.disconnected:
        return jni.SupplicantState.DISCONNECTED;
      case SupplicantState.dormant:
        return jni.SupplicantState.DORMANT;
      case SupplicantState.fourWayHandshake:
        return jni.SupplicantState.FOUR_WAY_HANDSHAKE;
      case SupplicantState.groupHandshake:
        return jni.SupplicantState.GROUP_HANDSHAKE;
      case SupplicantState.inactive:
        return jni.SupplicantState.INACTIVE;
      case SupplicantState.interfaceDisabled:
        return jni.SupplicantState.INTERFACE_DISABLED;
      case SupplicantState.invalid:
        return jni.SupplicantState.INVALID;
      case SupplicantState.scanning:
        return jni.SupplicantState.SCANNING;
      case SupplicantState.uninitialized:
        return jni.SupplicantState.UNINITIALIZED;
    }
  }
}

extension JSupplicantStateX on jni.SupplicantState {
  SupplicantState get impl {
    if (this == jni.SupplicantState.ASSOCIATED) {
      return SupplicantState.associated;
    }
    if (this == jni.SupplicantState.ASSOCIATING) {
      return SupplicantState.associating;
    }
    if (this == jni.SupplicantState.AUTHENTICATING) {
      return SupplicantState.authenticating;
    }
    if (this == jni.SupplicantState.COMPLETED) {
      return SupplicantState.completed;
    }
    if (this == jni.SupplicantState.DISCONNECTED) {
      return SupplicantState.disconnected;
    }
    if (this == jni.SupplicantState.DORMANT) {
      return SupplicantState.dormant;
    }
    if (this == jni.SupplicantState.FOUR_WAY_HANDSHAKE) {
      return SupplicantState.fourWayHandshake;
    }
    if (this == jni.SupplicantState.GROUP_HANDSHAKE) {
      return SupplicantState.groupHandshake;
    }
    if (this == jni.SupplicantState.INACTIVE) {
      return SupplicantState.inactive;
    }
    if (this == jni.SupplicantState.INTERFACE_DISABLED) {
      return SupplicantState.interfaceDisabled;
    }
    if (this == jni.SupplicantState.INVALID) {
      return SupplicantState.invalid;
    }
    if (this == jni.SupplicantState.SCANNING) {
      return SupplicantState.scanning;
    }
    if (this == jni.SupplicantState.UNINITIALIZED) {
      return SupplicantState.uninitialized;
    }
    throw UnimplementedError('Unimplemented value: $this');
  }
}
