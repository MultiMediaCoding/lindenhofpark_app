class BiologicalFact {
  final String title;
  final String content;
  final List<String> images;

  /// False, wenn der Text nur für einen einzelnen Baum gilt (z. B. ein
  /// Fledermauskasten) und nicht für andere Bäume derselben Art angezeigt
  /// werden darf.
  final bool speciesWide;

  const BiologicalFact({
    required this.title,
    required this.content,
    required this.images,
    this.speciesWide = true,
  });
}
