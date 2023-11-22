part of sr25519;

class Sr25519 {
  // NewSigningContext returns a new transcript initialized with the context for the signature
  // .see: https://github.com/w3f/schnorrkel/blob/db61369a6e77f8074eb3247f9040ccde55697f20/src/context.rs#L183
  static merlin.Transcript newSigningContext(List<int> context, List<int> msg) {
    final transcript = merlin.Transcript('SigningContext');
    transcript
      ..appendMessage(utf8.encode(''), context)
      ..appendMessage(utf8.encode('sign-bytes'), msg);
    return transcript;
  }
}
