final String tablePaniers = 'paniers';

class PanierFields {
  static final List<String> values = [
    /// Add all fields
    id, idGame, prix
  ];

  static final String id = '_id';
  static final String idGame = 'idGame';
  static final String prix = 'prix';
}

class Panier {
  final int? id;
  final String idGame;
  final double prix;

  const Panier({required this.id, required this.idGame, required this.prix});

  Panier copy({
    int? id,
    String? idGame,
    double? prix,
  }) =>
      Panier(
        id: id ?? this.id,
        idGame: idGame ?? this.idGame,
        prix: prix ?? this.prix,
      );

  static Panier fromJson(Map<String, Object?> json) => Panier(
        id: json[PanierFields.id] as int?,
        idGame: json[PanierFields.idGame] as String,
        prix: json[PanierFields.prix] as double,
      );

  Map<String, Object?> toJson() => {
        PanierFields.id: id,
        PanierFields.idGame: idGame,
        PanierFields.prix: prix,
      };
}
