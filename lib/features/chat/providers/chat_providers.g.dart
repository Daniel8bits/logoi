// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(chatRepository)
final chatRepositoryProvider = ChatRepositoryProvider._();

final class ChatRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<ChatRepository?>,
          ChatRepository?,
          FutureOr<ChatRepository?>
        >
    with $FutureModifier<ChatRepository?>, $FutureProvider<ChatRepository?> {
  ChatRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<ChatRepository?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ChatRepository?> create(Ref ref) {
    return chatRepository(ref);
  }
}

String _$chatRepositoryHash() => r'29e08d3c865d0e0d59932ba0eeac3abde481a1a7';

@ProviderFor(chatSessions)
final chatSessionsProvider = ChatSessionsProvider._();

final class ChatSessionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ChatSessionRow>>,
          List<ChatSessionRow>,
          Stream<List<ChatSessionRow>>
        >
    with
        $FutureModifier<List<ChatSessionRow>>,
        $StreamProvider<List<ChatSessionRow>> {
  ChatSessionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatSessionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatSessionsHash();

  @$internal
  @override
  $StreamProviderElement<List<ChatSessionRow>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ChatSessionRow>> create(Ref ref) {
    return chatSessions(ref);
  }
}

String _$chatSessionsHash() => r'7afdebc76b00e24222f2a3fabfd0abea5294fcaa';

@ProviderFor(chatMessages)
final chatMessagesProvider = ChatMessagesFamily._();

final class ChatMessagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ChatMessageRow>>,
          List<ChatMessageRow>,
          Stream<List<ChatMessageRow>>
        >
    with
        $FutureModifier<List<ChatMessageRow>>,
        $StreamProvider<List<ChatMessageRow>> {
  ChatMessagesProvider._({
    required ChatMessagesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'chatMessagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$chatMessagesHash();

  @override
  String toString() {
    return r'chatMessagesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<ChatMessageRow>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ChatMessageRow>> create(Ref ref) {
    final argument = this.argument as String;
    return chatMessages(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatMessagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatMessagesHash() => r'ba2225fb556b9dfd5835011e15515c5fb7d2a9b7';

final class ChatMessagesFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<ChatMessageRow>>, String> {
  ChatMessagesFamily._()
    : super(
        retry: null,
        name: r'chatMessagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ChatMessagesProvider call(String sessionId) =>
      ChatMessagesProvider._(argument: sessionId, from: this);

  @override
  String toString() => r'chatMessagesProvider';
}

/// Builds the current ChatDocumentContext from project + reader state.

@ProviderFor(chatContext)
final chatContextProvider = ChatContextProvider._();

/// Builds the current ChatDocumentContext from project + reader state.

final class ChatContextProvider
    extends
        $FunctionalProvider<
          AsyncValue<ChatDocumentContext?>,
          ChatDocumentContext?,
          FutureOr<ChatDocumentContext?>
        >
    with
        $FutureModifier<ChatDocumentContext?>,
        $FutureProvider<ChatDocumentContext?> {
  /// Builds the current ChatDocumentContext from project + reader state.
  ChatContextProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatContextProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatContextHash();

  @$internal
  @override
  $FutureProviderElement<ChatDocumentContext?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ChatDocumentContext?> create(Ref ref) {
    return chatContext(ref);
  }
}

String _$chatContextHash() => r'e5c219d48d3bf6a5d54da0053961cc6e4b79787a';

@ProviderFor(ActiveChat)
final activeChatProvider = ActiveChatProvider._();

final class ActiveChatProvider
    extends $NotifierProvider<ActiveChat, ActiveChatState> {
  ActiveChatProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeChatProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeChatHash();

  @$internal
  @override
  ActiveChat create() => ActiveChat();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActiveChatState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActiveChatState>(value),
    );
  }
}

String _$activeChatHash() => r'90a972cd4a1ded6672c6adf40222704d50142bf0';

abstract class _$ActiveChat extends $Notifier<ActiveChatState> {
  ActiveChatState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ActiveChatState, ActiveChatState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ActiveChatState, ActiveChatState>,
              ActiveChatState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
