import 'package:flutter/material.dart';

class i18n {
  String language;
  i18n(this.language);

  static const Map fr_dict = {
    "subtitle": "Trouve le mot caché !",
    "word": "Mot",
    "how_to_play": "Comment jouer ?",
    "htp_desc": "Ce jeu consiste à trouver un nom commun (de niveau A2) choisit au hasard chaque jour, tout cela en un minimum d'essaies !\nL'indice de similarité vous indiques si vous êtes sur la bonne voie !",
    "chnage_l": "Changer de langue ?",
    "propose_fw": "Proposer un premier mot !",
    "day_nb": "Jour n°",
    "ldb": "Classement",
    "yes_word": 'Le mot d\'hier était:',
    "found": "Trouvé par",
    "persones": "personnes",
    "invalid_word": "Ce mot est invalide",
    "already_proposed": "Ce mot a déjà été proposé",
    "similarity": "Similarité",
    "progress": "Progression",
    "you_found": "Tu as trouvé",
    "in": "en",
    "tries": "essaies",
    "new_word_in": "Prochain mot dans",
    "share": "Partager",
    "summary": "Résumé",
    "an_example": "Un exemple ?",
    "an_example_desc": "Considerons le mot 'piscine', les mots similaires seront 'eau', 'vacances' et 'municipale'. Pourquoi cela ? Parce que dans les textes ces mots là se retrouvent souvent ensemble, ainsi leur similarité avec 'piscine' est plus importante que celle d'un mot tel que 'pyramide' !",
    "well_done": "Bien joué"

  };

  static const Map en_dict = {
    "subtitle": "Found the hidden word!",
    "word": "Word",
    "how_to_play": "How to play?",
    "htp_desc": "This game consists of finding a common name (level A2) chosen at random each day, the lower your number of proposals, the higher your score!",
    "chnage_l": "Change language?",
    "propose_fw": "Suggest a first word!",
    "day_nb": "Day n°",
    "ldb": "Ranking",
    "yes_word": "Yesterday's word was:",
    "found": "Found by",
    "persones": "people",
    "invalid_word": "This word is invalid",
    "already_proposed": "This word has already been proposed",
    "similarity": "Similarity",
    "progress": "Progress",
    "you_found": "You found",
    "in": "in",
    "tries": "tries",
    "new_word_in": "Next word in",
    "share": "Share",
    "summary": "Summary",
  "an_example": "An example ?",
  "an_example_desc": "Either the word to guess is 'pool', the similar words will be 'water', 'holiday' and 'municipal'. Why this? Because in the texts these words are often found together, so their similarity is more important than a word such as 'pyramid'!",
    "well_done": "Well done"


  };

  void setLanguage(String language){
    this.language = language;
  }
  String getTxt(String key){
    if (language == "fr"){
      return fr_dict[key];
    } else {
      return en_dict[key];
    }
  }


}