import 'package:cloudify_application/model/game_model.dart';

class GameUtils {
  static List<GameModels> getMockedGames() {
    return [
      GameModels(
          "1",
          "assets/images/Cyberpunk2077.jpg",
          "Cyberpunk2077",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
              "sed do eiusmod tempor incididunt ut ",
          500),
      GameModels(
          "2",
          "assets/images/Dying_Light_2.jpg",
          "Dying Light 2",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
              "sed do eiusmod tempor incididunt ut ",
          300),
      GameModels(
          "3",
          "assets/images/Spellbreak.jpg",
          "Spellbreak",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
              "sed do eiusmod tempor incididunt ut ",
          200),
      GameModels(
          "4",
          "assets/images/Horizon_Forbidden_West.jpg",
          "Horizon Forbidden West",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
              "sed do eiusmod tempor incididunt ut ",
          100),
      GameModels(
          "5",
          "assets/images/fifa-world.jpg",
          "FiFa World",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
              "sed do eiusmod tempor incididunt ut ",
          600),
    ];
  }
}
