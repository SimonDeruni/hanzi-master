import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/echo_hall/domain/entities/localized_scenario_content.dart';

/// Data model representing a random roleplay scenario preset.
class RandomPersonaPreset {
  final String topic;
  final String context;
  final String persona;
  final int difficultyIndex;

  const RandomPersonaPreset({
    required this.topic,
    required this.context,
    required this.persona,
    required this.difficultyIndex,
  });
}

/// Localized repository of curated persona presets for custom roleplay scenarios.
/// Supports all 14 languages: French and English fast-paths, plus dynamic
/// on-the-fly translation for all other languages via the free Gemini API.
abstract final class LocalizedPersonaPresets {
  static final Map<String, RandomPersonaPreset> _translationCache = {};

  /// Returns the base list of curated presets.
  static List<RandomPersonaPreset> getPresets(Locale locale) {
    if (locale.languageCode == 'fr') {
      return _frenchPresets;
    }
    return _englishPresets;
  }

  /// Resolves a preset in the user's active [locale].
  /// - If English, returns immediately (0ms).
  /// - If French, returns the pre-translated French preset immediately (0ms).
  /// - For any other of the 14 languages, checks in-memory cache or translates
  ///   dynamically via the free Gemini API.
  static Future<RandomPersonaPreset> resolvePreset({
    required GeminiService gemini,
    required RandomPersonaPreset basePreset,
    required Locale locale,
  }) async {
    final lang = locale.languageCode;
    if (lang == 'en') return basePreset;

    if (lang == 'fr') {
      final idx = _englishPresets.indexWhere((p) => p.topic == basePreset.topic);
      if (idx != -1 && idx < _frenchPresets.length) {
        return _frenchPresets[idx];
      }
      return basePreset;
    }

    final cacheKey = '${lang}_${basePreset.topic}';
    if (_translationCache.containsKey(cacheKey)) {
      return _translationCache[cacheKey]!;
    }

    final languageName = LocalizedScenarioContent.languageName(locale);
    final prompt = '''You are a professional translator for a Chinese language learning app.
Translate the following roleplay scenario into $languageName so a student speaking $languageName can understand it.
IMPORTANT:
1. Translate the topic, context, and persona description naturally into $languageName.
2. In the persona, keep the character's Chinese name and title in parentheses intact (e.g. 赵师傅, 老胡, 林列车长).
3. Respond ONLY in valid JSON format:
{
  "topic": "translated topic in $languageName",
  "context": "translated setting in $languageName",
  "persona": "translated persona in $languageName"
}

Topic: ${basePreset.topic}
Context: ${basePreset.context}
Persona: ${basePreset.persona}''';

    try {
      final response = await gemini.generateText(prompt);
      final clean = response
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();
      final map = jsonDecode(clean);
      final translated = RandomPersonaPreset(
        topic: (map['topic'] as String?)?.trim() ?? basePreset.topic,
        context: (map['context'] as String?)?.trim() ?? basePreset.context,
        persona: (map['persona'] as String?)?.trim() ?? basePreset.persona,
        difficultyIndex: basePreset.difficultyIndex,
      );
      _translationCache[cacheKey] = translated;
      return translated;
    } catch (e) {
      debugPrint('[LocalizedPersonaPresets] Gemini translation fallback: $e');
      return basePreset;
    }
  }

  /// Returns a localized SnackBar confirmation message when a preset is loaded across all 14 languages.
  static String loadedMessage(Locale locale, String topic, String personaName) {
    switch (locale.languageCode) {
      case 'fr':
        return '🎲 Scénario chargé : $topic ($personaName)';
      case 'de':
        return '🎲 Szenario geladen: $topic ($personaName)';
      case 'es':
        return '🎲 Escenario cargado: $topic ($personaName)';
      case 'it':
        return '🎲 Scenario caricato: $topic ($personaName)';
      case 'pt':
        return '🎲 Cenário carregado: $topic ($personaName)';
      case 'ru':
        return '🎲 Сценарий загружен: $topic ($personaName)';
      case 'ja':
        return '🎲 シナリオを読み込みました: $topic ($personaName)';
      case 'ko':
        return '🎲 시나리오가 로드되었습니다: $topic ($personaName)';
      case 'vi':
        return '🎲 Đã tải kịch bản: $topic ($personaName)';
      case 'id':
        return '🎲 Skenario dimuat: $topic ($personaName)';
      case 'hi':
        return '🎲 परिदृश्य लोड हुआ: $topic ($personaName)';
      case 'th':
        return '🎲 โหลดสถานการณ์แล้ว: $topic ($personaName)';
      case 'ar':
        return '🎲 تم تحميل السيناريو: $topic ($personaName)';
      default:
        return '🎲 Loaded: $topic ($personaName)';
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // French Presets (50 Curated Scenarios)
  // ══════════════════════════════════════════════════════════════════════════
  static const List<RandomPersonaPreset> _frenchPresets = [
    // ── Gastronomie & Culture Culinaire ──────────────────────────────────
    RandomPersonaPreset(
      topic: 'Dégustation de thé à Chengdu',
      context:
          'Une cour paisible en bambou dans une maison de thé à Chengdu, avec une douce mélodie de guzheng en fond sonore.',
      persona:
          'Maître Zhao (赵师傅), un sommelier de thé patient et érudit qui adore expliquer l\'art de l\'infusion Gongfu.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Marché de nuit et street food à Xi\'an',
      context:
          'Un marché de nuit animé et parfumé, regorgeant de brochettes grésillantes, de petits pains vapeur et d\'échoppes traditionnelles.',
      persona:
          'Tante Ma (马阿姨), une commerçante énergique et chaleureuse qui prépare les meilleurs Roujiamo et Liangpi de la ville.',
      difficultyIndex: 0, // Débutant
    ),
    RandomPersonaPreset(
      topic: 'Festin de fondue épicée à Chongqing',
      context:
          'Un restaurant de fondue animé à Chongqing, avec un bouillon rougeoyant bouillonnant et des arômes envoûtants de piment et de poivre.',
      persona:
          'Gérant Yu (余店长), le responsable passionné qui vous conseille sur les tripes de bœuf, le sang de canard et les sauces sésame.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Chariot de dim sum matinal à Canton',
      context:
          'Une maison de thé cantonaise traditionnelle et animée à Guangzhou, remplie de paniers vapeur en bambou fumants.',
      persona:
          'Chef Chen (陈师傅), un maître des dim sum cantonais souriant qui recommande ses raviolis aux crevettes (Har Gow) et ses Shumai frais.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Café filtre artisanal à Shanghai',
      context:
          'Un café minimaliste et branché dans l\'ancienne concession française lors d\'un dimanche après-midi pluvieux.',
      persona:
          'Barista Kevin (小凯), un jeune torréfacteur passionné qui adore faire découvrir les grains de café du Yunnan et leurs notes fruitées.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Préparation de raviolis faits maison à Harbin',
      context:
          'Une cuisine familiale chaleureuse dans le nord de la Chine en plein hiver, avec de la farine sur la table et des casseroles fumantes.',
      persona:
          'Grand-mère Liu (刘奶奶), une grand-mère attentionnée qui vous enseigne l\'art de plier les raviolis et de préparer la farce porc-ciboulette.',
      difficultyIndex: 0, // Débutant
    ),
    RandomPersonaPreset(
      topic: 'Brochettes au barbecue nocturne à Wuhan',
      context:
          'Une ruelle animée de street food en plein air, avec des brochettes d\'agneau au charbon de bois, des aubergines grillées et des bières fraîches.',
      persona:
          'Maître Gao (高师傅), un maître du barbecue charismatique qui discute avec les clients de l\'assaisonnement au cumin et du niveau de piment.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Achat de brochettes Tanghulu à Pékin en hiver',
      context:
          'Un coin de rue enneigé près du temple des Lamas, avec des brochettes d\'aubépines caramélisées éclatantes sur la glace.',
      persona:
          'Tante Song (宋阿姨), une marchande ambulante joviale proposant des Tanghulu traditionnels et des variantes modernes à la fraise.',
      difficultyIndex: 0, // Débutant
    ),
    RandomPersonaPreset(
      topic: 'Brasserie artisanale à Qingdao',
      context:
          'Une brasserie côtière animée avec de grands fûts en bois, une brise marine et de la bière fraîche à la pression.',
      persona:
          'Maître Hans (老胡), un maître brasseur chevronné qui partage des anecdotes sur les traditions brassicoles et la sélection du malt.',
      difficultyIndex: 2, // Avancé
    ),
    RandomPersonaPreset(
      topic: 'Atelier de cuisine du Sichuan',
      context:
          'Une cuisine ouverte vibrante avec des woks flamboyants, de l\'huile pimentée frémissante et du poivre frais du Sichuan.',
      persona:
          'Chef Zhang (张大厨), un professeur de cuisine sichuanaise enjoué qui explique l\'équilibre subtil entre le piquant et l\'engourdissement.',
      difficultyIndex: 2, // Avancé
    ),

    // ── Voyage, Nature & Aventure ─────────────────────────────────────────
    RandomPersonaPreset(
      topic: 'Malentendu de place dans le TGV chinois',
      context:
          'À bord d\'un train à grande vitesse Fuxing filant à 350 km/h entre Pékin et Shanghai.',
      persona:
          'Chef de train Lin (林列车长), un contrôleur poli et serviable qui vérifie les billets et aide à régler les échanges de sièges.',
      difficultyIndex: 0, // Débutant
    ),
    RandomPersonaPreset(
      topic: 'Randonnée au lever du soleil sur la Grande Muraille à Mutianyu',
      context:
          'Les anciens remparts en pierre de la Grande Muraille à l\'aube, enveloppés de montagnes verdoyantes et embrumées.',
      persona:
          'Guide Li (李向导), un guide de randonnée énergique qui raconte les légendes de la dynastie Ming et les secrets des tours de guet.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Descente en radeau de bambou sur la rivière Li à Guilin',
      context:
          'Glissade paisible sur les eaux émeraude entre les pics karstiques spectaculaires et brumeux près de Yangshuo.',
      persona:
          'Capitaine Huang (黄师傅), un batelier expérimenté qui montre les formations rocheuses célèbres figurant sur le billet de 20 yuans.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Caravane de chameaux sur la Route de la Soie à Dunhuang',
      context:
          'Les dunes dorées ondoyantes de la montagne Mingsha juste à côté de l\'oasis du lac du Croissant de Lune.',
      persona:
          'Oncle Ma (马向导), un guide du désert sage qui connaît les histoires des anciennes caravanes et l\'observation des étoiles.',
      difficultyIndex: 2, // Avancé
    ),
    RandomPersonaPreset(
      topic: 'Réservation dans une auberge avec cour traditionnelle à Dali',
      context:
          'Un hôtel de charme paisible de style Bai avec cour intérieure donnant sur le lac Erhai au Yunnan.',
      persona:
          'Aubergiste Tante Bai (白阿姨), une hôtesse locale hospitalière qui offre du thé aux fleurs fraîches et d\'excellents conseils de visite.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Pèlerinage au Palais du Potala à Lhassa',
      context:
          'Les marches majestueuses en pierre baignées de soleil devant le Palais du Potala avec des moulins à prières en rotation.',
      persona:
          'Tenzin (扎西), un guide culturel tibétain chaleureux et respectueux qui explique l\'histoire du temple et les coutumes locales.',
      difficultyIndex: 2, // Avancé
    ),
    RandomPersonaPreset(
      topic: 'Merveilles de glace et de neige à Harbin',
      context:
          'Un monde féerique sous zéro degré composé de palais de glace cristalline illuminés et d\'immenses sculptures de neige.',
      persona:
          'Maître Dong (董师傅), un sculpteur sur glace qui explique comment sont sculptés les blocs géants extraits du fleuve Songhua.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Téléphérique des montagnes d\'Avatar à Zhangjiajie',
      context:
          'Suspendu dans une cabine de téléphérique vitrée survolant des milliers de piliers de grès spectaculaires.',
      persona:
          'Hôtesse Sœur He (何姐), une garde forestière d\'ethnie Tujia qui présente la faune locale et la géographie unique du parc.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Camp d\'observation des étoiles dans le désert de Gobi au Gansu',
      context:
          'Un camp de yourtes sous une Voie Lactée éclatante et pure dans le désert aux abords de Jiayuguan.',
      persona:
          'Patron Zhou (周老板), un hôte chaleureux de glamping qui installe les télescopes et sert du thé d\'orge grillé bien chaud.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Croisière dans les Trois Gorges du fleuve Yangtsé',
      context:
          'Sur le pont supérieur d\'un navire de croisière naviguant à travers l\'impressionnante et étroite gorge de Qutang.',
      persona:
          'Professeur Qian (钱教授), un historien maritime retraité qui récite les poèmes de la dynastie Tang inspirés par les gorges.',
      difficultyIndex: 3, // Natif
    ),

    // ── Arts, Patrimoine & Artisanat Traditionnel ─────────────────────────
    RandomPersonaPreset(
      topic: 'Marchandage d\'antiquités à Panjiayuan à Pékin',
      context:
          'Le célèbre marché aux puces du week-end à Panjiayuan, bondé de rouleaux de calligraphie, de jade et d\'objets rétro.',
      persona:
          'Aîné Sun (孙大爷), un collectionneur pékinois à l\'œil affûté qui adore plaisanter et partager l\'histoire des objets anciens.',
      difficultyIndex: 2, // Avancé
    ),
    RandomPersonaPreset(
      topic: 'Atelier de porcelaine bleue et blanche à Jingdezhen',
      context:
          'Un four à poterie historique rempli de délicats vases en porcelaine crue et de pigments bleus de cobalt.',
      persona:
          'Maître Song (宋大师), un céramiste réputé qui vous guide pour tourner l\'argile et peindre au pinceau traditionnel.',
      difficultyIndex: 2, // Avancé
    ),
    RandomPersonaPreset(
      topic: 'Atelier de broderie sur soie de Suzhou',
      context:
          'Un atelier paisible dans un jardin au bord des canaux de Suzhou, avec des fils de soie précieux et des métiers en bois.',
      persona:
          'Professeure Yao (姚老师), une élégante maître de broderie double face qui explique la minutie de chaque point.',
      difficultyIndex: 2, // Avancé
    ),
    RandomPersonaPreset(
      topic: 'Loges et maquillage de l\'Opéra de Pékin',
      context:
          'En coulisses d\'un théâtre traditionnel de Pékin, parmi les costumes colorés, les miroirs et les coiffes étincelantes.',
      persona:
          'Professeure Mei (梅老师), une artiste chevronnée des rôles Dan qui explique les intonations vocales et le symbolisme des masques.',
      difficultyIndex: 3, // Natif
    ),
    RandomPersonaPreset(
      topic: 'Consultation de médecine traditionnelle chinoise',
      context:
          'Une apothicairerie historique Tongrentang parfumée au ginseng et aux baies de goji, avec des centaines de tiroirs à herbes en bois.',
      persona:
          'Docteur Ye (叶大夫), un médecin attentif et bienveillant qui prend votre pouls et vous explique l\'équilibre énergétique du Qi.',
      difficultyIndex: 2, // Avancé
    ),
    RandomPersonaPreset(
      topic: 'Tai-chi matinal au parc du Temple du Ciel',
      context:
          'Sous des cyprès centenaires à l\'aube, au milieu du chant des oiseaux et des aînés pratiquant des mouvements synchronisés.',
      persona:
          'Maître Lu (鲁师傅), un maître d\'arts martiaux serein et rigoureux qui enseigne la respiration et la fluidité de la posture.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Location de Hanfu pour une séance photo au Lac de l\'Ouest',
      context:
          'Une boutique de costumes traditionnels près du lac de l\'Ouest à Hangzhou, avec des portants de robes Tang et Song.',
      persona:
          'Styliste Yanyan (严严), une styliste créative qui vous aide à choisir la tenue d\'époque idéale et les épingles à cheveux.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Atelier de cithare ancienne Guqin',
      context:
          'Un atelier paisible en bois de pin à Hangzhou, rempli d\'instruments en paulownia ancien montés de cordes en soie.',
      persona:
          'Maître Gu (顾琴师), un luthier dévoué qui explique l\'accordage des sept cordes et la philosophie poétique de la musique.',
      difficultyIndex: 3, // Natif
    ),
    RandomPersonaPreset(
      topic: 'Théâtre d\'ombres chinoises du Shaanxi',
      context:
          'Derrière un écran de soie blanche illuminé, avec de fines figurines articulées en cuir translucide.',
      persona:
          'Oncle Liang (梁大叔), un marionnettiste populaire qui vous montre comment animer les figurines et chanter les légendes.',
      difficultyIndex: 2, // Avancé
    ),
    RandomPersonaPreset(
      topic: 'Atelier de calligraphie chinoise',
      context:
          'Un studio serein embaumant l\'encre de suie de pin, les rouleaux de papier de riz et les arômes délicats du thé.',
      persona:
          'Maître Shen (沈老师), un calligraphe respecté qui vous guide dans la tenue du pinceau, la posture et les traits fondamentaux.',
      difficultyIndex: 3, // Natif
    ),

    // ── Vie Moderne en Ville & Culture Urbaine ────────────────────────────
    RandomPersonaPreset(
      topic: 'Adoption d\'un chat dans un refuge animalier',
      context:
          'Un refuge chaleureux à Hangzhou où de jeunes chatons joueurs accueillent les visiteurs autour d\'un thé.',
      persona:
          'Xiaoling (小玲), une bénévole passionnée qui cherche le foyer idéal pour chaque animal recueilli.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Jeu d\'enquête immersive Jubensha (Murder Mystery)',
      context:
          'Un salon de détective thématique à Shanghai avec des joueurs costumés réunis autour d\'une table aux chandelles.',
      persona:
          'Maître du Jeu Xiao Lin (林DM), un animateur charismatique qui distribue les rôles et distille les indices d\'une affaire des années 1930.',
      difficultyIndex: 2, // Avancé
    ),
    RandomPersonaPreset(
      topic: 'Magasin de disques vinyles vintage à Shanghai',
      context:
          'Une boutique de vinyles secrète dans une ancienne ruelle Shikumen, remplie de pépites de Cantopop des années 80 et de jazz.',
      persona:
          'Patron Dave (老戴), un amoureux de musique indépendante qui vous conseille des albums vinyles rares et des concerts mythiques.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Soirée karaoké KTV entre amis',
      context:
          'Un salon de karaoké privé aux néons éclatants à Shenzhen, avec micros sans fil, corbeilles de fruits et écran tactile.',
      persona:
          'Xiao Ming (小明), un ami fêtard et dynamique qui encourage tout le monde à chanter ses tubes de Mandopop préférés.',
      difficultyIndex: 0, // Débutant
    ),
    RandomPersonaPreset(
      topic: 'Club de vélo urbain pour une balade nocturne',
      context:
          'Un rassemblement de cyclistes sur les quais au crépuscule, prêts pour une sortie nocturne face aux gratte-ciels illuminés.',
      persona:
          'Coach Han (韩队长), un cycliste athlétique et bienveillant qui accueille chaleureusement les nouveaux membres.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Échange de figurines figurines mystères (Blind Box)',
      context:
          'Une boutique de pop culture colorée à Chaoyang avec des vitrines de collection et des boîtes surprises fermées.',
      persona:
          'Tingting (婷婷), une collectionneuse passionnée qui échange des figurines rares et partage son enthousiasme pour l\'ouverture de boîtes.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Vidéo par drone au Bund à Shanghai',
      context:
          'La promenade du Bund au crépuscule, surplombant les gratte-ciels futuristes illuminés de Pudong.',
      persona:
          'Ah Jie (阿杰), un vidéaste aérien qui partage ses réglages de vol et ses angles de vue pour réussir un timelapse de nuit.',
      difficultyIndex: 2, // Avancé
    ),
    RandomPersonaPreset(
      topic: 'Café aux Golden Retrievers à Nanjing',
      context:
          'Un café lumineux et joyeux où une dizaine de chiens affectueux et joueurs viennent saluer les clients.',
      persona:
          'Xiaomei (小美), une éducatrice canine qui aide les visiteurs à donner des friandises et à prendre de jolies photos.',
      difficultyIndex: 0, // Débutant
    ),
    RandomPersonaPreset(
      topic: 'Salle d\'escalade de bloc à Chengdu',
      context:
          'Une salle d\'escalade moderne aux prises colorées sur fond de musique entraînante.',
      persona:
          'Coach Frank (方教练), un entraîneur motivant qui vous donne les meilleures astuces pour réussir un bloc difficile.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Salon manga et cosplay à Canton',
      context:
          'Un immense hall d\'exposition avec des stands de jeux vidéo, des décors photo et des créateurs en costume.',
      persona:
          'Yuki (小樱), une organisatrice enthousiaste qui guide les photographes et coordonne les passages sur scène.',
      difficultyIndex: 1, // Intermédiaire
    ),

    // ── Vie Quotidienne, Démarches & Achats ────────────────────────────────
    RandomPersonaPreset(
      topic: 'Demander son chemin dans un Hutong à Pékin',
      context:
          'Un dédale de ruelles historiques en briques grises, bordées de vélos, de cours carrées et de grenadiers.',
      persona:
          'Grand-père Wang (王大爷), un voisin retraité assis avec sa cage à oiseaux qui indique la route avec des repères du quartier.',
      difficultyIndex: 0, // Débutant
    ),
    RandomPersonaPreset(
      topic: 'Achat de fruits frais au marché de quartier',
      context:
          'Un marché matinal vivant et parfumé proposant des étals de litchis, de mangues et de fruits du dragon frais.',
      persona:
          'Oncle Liu (刘大叔), un marchand de fruits chaleureux qui vous fait goûter un morceau de melon sucré avant d\'acheter.',
      difficultyIndex: 0, // Débutant
    ),
    RandomPersonaPreset(
      topic: 'Bouquet de fleurs au marché de Kunming',
      context:
          'Le célèbre marché aux fleurs de Dounan, entouré de milliers de roses fraîches, de lys et d\'eucalyptus.',
      persona:
          'Sœur Hua (花姐), une fleuriste passionnée qui vous aide à composer un splendide bouquet pour l\'anniversaire d\'un ami.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Retouches chez le tailleur d\'une ruelle ancienne',
      context:
          'Une petite boutique traditionnelle remplie de machines à coudre, de coupons de tissu et de mètres rubans.',
      persona:
          'Maître Ni (倪师傅), un tailleur shanghaïen expérimenté qui prend vos mesures et ajuste parfaitement l\'ourlet.',
      difficultyIndex: 1, // Intermédiaire
    ),
    RandomPersonaPreset(
      topic: 'Récupération d\'un colis dans un casier automatique',
      context:
          'Au pied d\'un immeuble résidentiel, devant une grande armoire de casiers connectés intelligents.',
      persona:
          'Livreur Xiao Zhang (快递小张), un jeune coursier souriant qui vous aide à retrouver votre code de retrait et votre paquet.',
      difficultyIndex: 0, // Débutant
    ),
    RandomPersonaPreset(
      topic: 'Réparation de crevaison de vélo devant l\'université',
      context:
          'Un petit atelier de réparation ambulant installé sous un grand banian au bord du trottoir.',
      persona:
          'Oncle Ding (丁师傅), un mécanicien vélo rapide qui répare votre chambre à air et règle vos freins en cinq minutes.',
      difficultyIndex: 0, // Débutant
    ),

    // ── Carrière, Tech & Monde Professionnel ─────────────────────────────
    RandomPersonaPreset(
      topic: 'Démonstration produit dans une entreprise tech à Shenzhen',
      context:
          'Un stand high-tech futuriste dans un salon technologique à Shenzhen présentant des appareils IA de pointe.',
      persona:
          'Chef de produit Guo (郭经理), un ingénieur dynamique présentant la nouvelle génération d\'objets connectés à commande vocale.',
      difficultyIndex: 2, // Avancé
    ),
    RandomPersonaPreset(
      topic: 'Studio de live-streaming e-commerce',
      context:
          'Un studio de diffusion énergique avec anneaux lumineux, étagères de produits et écrans de commentaires en direct.',
      persona:
          'Animatrice Bella (贝拉), une présentatrice de téléachat vedette répétant sa présentation de produits et ses promotions flash.',
      difficultyIndex: 2, // Avancé
    ),
    RandomPersonaPreset(
      topic: 'Grand marché du commerce international de Yiwu',
      context:
          'Un gigantesque complexe commercial de plusieurs étages abritant des millions d\'articles d\'artisanat et d\'objets du quotidien.',
      persona:
          'Patron Lin (林老板), un négociant expérimenté négociant des commandes en gros et présentant des échantillons d\'usine.',
      difficultyIndex: 2, // Avancé
    ),
    RandomPersonaPreset(
      topic: 'Programme d\'échange sur un campus universitaire',
      context:
          'Une pelouse ensoleillée devant la bibliothèque universitaire avec des étudiants révisant en buvant un thé au lait perlé.',
      persona:
          'David (大卫), un tuteur étudiant dynamique et bienveillant qui partage ses conseils sur la vie de campus et les clubs.',
      difficultyIndex: 0, // Débutant
    ),
  ];

  // ══════════════════════════════════════════════════════════════════════════
  // English Presets (50 Curated Scenarios)
  // ══════════════════════════════════════════════════════════════════════════
  static const List<RandomPersonaPreset> _englishPresets = [
    // ── Food & Culinary Culture ──────────────────────────────────
    RandomPersonaPreset(
      topic: 'Tea Tasting in Chengdu',
      context:
          'A quiet bamboo courtyard teahouse in Chengdu with gentle guzheng music playing.',
      persona:
          'Master Zhao (赵师傅), a patient and knowledgeable tea sommelier who loves explaining Gongfu tea brewing.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Street Food Night Market in Xi\'an',
      context:
          'A bustling, smoky night market filled with skewers, steamed buns, and street food stalls.',
      persona:
          'Auntie Ma (马阿姨), an energetic and loud stall owner who makes the crispiest Roujiamo and Liangpi in town.',
      difficultyIndex: 0, // Beginner
    ),
    RandomPersonaPreset(
      topic: 'Chongqing Spicy Hotpot Feast',
      context:
          'A lively hotpot restaurant in Chongqing with boiling crimson broth and fragrant chili aroma.',
      persona:
          'Manager Yu (余店长), a fiery hotpot restaurant manager who recommends signature tripe, duck blood, and mild broth options.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Morning Dim Sum Cart in Guangzhou',
      context:
          'A bustling traditional Cantonese teahouse in Guangzhou filled with steaming bamboo baskets.',
      persona:
          'Chef Chen (陈师傅), a cheerful Cantonese dim sum chef recommending fresh Har Gow shrimp dumplings and Shumai.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Ordering Hand-Drip Coffee in Shanghai',
      context:
          'A chic minimalist cafe in the French Concession during a rainy Sunday afternoon.',
      persona:
          'Barista Kevin (小凯), a passionate young coffee roaster who loves discussing Yunnan coffee beans and flavor notes.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Handmade Dumpling Feast in Harbin',
      context:
          'A warm northern home kitchen during winter with flour on the table and steaming dumpling pots.',
      persona:
          'Grandma Liu (刘奶奶), a doting northern grandmother who teaches you how to pinch dumpling pleats and make pork-scallion filling.',
      difficultyIndex: 0, // Beginner
    ),
    RandomPersonaPreset(
      topic: 'Midnight BBQ Skewers in Wuhan',
      context:
          'An open-air night street food alley with sizzling lamb skewers, roasted eggplant, and cold beer.',
      persona:
          'Master Gao (高师傅), a charismatic charcoal BBQ master bantering with customers about spice levels and secret cumin rubs.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Ordering Sugar-Coated Haws in Winter Beijing',
      context:
          'A snowy street corner outside the Lama Temple with glowing red candied hawthorn skewers on ice.',
      persona:
          'Auntie Song (宋阿姨), a cheerful seasonal street vendor offering crisp traditional Tanghulu and modern strawberry glaze.',
      difficultyIndex: 0, // Beginner
    ),
    RandomPersonaPreset(
      topic: 'Craft Beer Brewery in Qingdao',
      context:
          'A lively coastal taproom with wooden barrels, ocean breeze, and fresh wheat beer taps.',
      persona:
          'Master Hans (老胡), a veteran master brewer who shares stories about historic brewing traditions and malt selection.',
      difficultyIndex: 2, // Advanced
    ),
    RandomPersonaPreset(
      topic: 'Sichuan Cooking Masterclass',
      context:
          'A vibrant open kitchen with woks blazing, chili oil simmering, and fresh peppercorns.',
      persona:
          'Chef Zhang (张大厨), a cheerful Sichuan culinary teacher who explains how to balance spicy and numbing flavors.',
      difficultyIndex: 2, // Advanced
    ),

    // ── Travel, Nature & Adventure ──────────────────────────────
    RandomPersonaPreset(
      topic: 'High-Speed Rail Seat Mix-Up',
      context:
          'Inside a sleek Fuxing bullet train traveling at 350 km/h from Beijing to Shanghai.',
      persona:
          'Conductor Lin (林列车长), a polite and helpful high-speed rail conductor checking tickets and resolving seats.',
      difficultyIndex: 0, // Beginner
    ),
    RandomPersonaPreset(
      topic: 'Great Wall Sunrise Trek in Mutianyu',
      context:
          'The ancient stone ramparts of the Great Wall at dawn, surrounded by misty green mountains.',
      persona:
          'Guide Li (李向导), an energetic hiking guide who shares Ming dynasty defense folklore and watchtower secrets.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Bamboo Raft Drift on Guilin Li River',
      context:
          'Gliding along emerald karst waters between dramatic misty limestone peaks near Yangshuo.',
      persona:
          'Captain Huang (黄师傅), a veteran river rafter who points out famous rock formations from 20-yuan banknote views.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Silk Road Camel Trek in Dunhuang',
      context:
          'The rolling golden sand dunes of Mingsha Mountain next to the Crescent Lake oasis.',
      persona:
          'Uncle Ma (马向导), a wise desert trekker who knows ancient caravan lore and stargazing routes.',
      difficultyIndex: 2, // Advanced
    ),
    RandomPersonaPreset(
      topic: 'Booking a Courtyard Homestay in Dali',
      context:
          'A serene Bai-style boutique courtyard hotel overlooking Erhai Lake in Yunnan.',
      persona:
          'Innkeeper Auntie Bai (白阿姨), a hospitable local host who offers fresh flower tea and sightseeing tips.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Potala Palace Pilgrimage in Lhasa',
      context:
          'The majestic sun-drenched stone steps outside the Potala Palace with spinning prayer wheels.',
      persona:
          'Tenzin (扎西), a reverent and warm local Tibetan cultural guide explaining temple history and etiquette.',
      difficultyIndex: 2, // Advanced
    ),
    RandomPersonaPreset(
      topic: 'Harbin Ice & Snow World Wonder',
      context:
          'A sub-zero wonderland of illuminated crystal ice palaces and towering snow sculptures.',
      persona:
          'Master Dong (董师傅), an ice sculpture artisan who explains how massive Songhua River ice blocks are carved.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Zhangjiajie Avatar Mountain Cable Car',
      context:
          'Suspended high in a glass cable car soaring above thousands of sandstone pillar peaks.',
      persona:
          'Attendant Sister He (何姐), a friendly Tujia national park ranger explaining local wildlife and geography.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Gobi Desert Stargazing Camp in Gansu',
      context:
          'A luxury yurt camp under a crystal-clear Milky Way sky in the desert outside Jiayuguan.',
      persona:
          'Boss Zhou (周老板), a friendly glamping host setting up telescopes and serving hot roasted barley tea.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Yangtze River Three Gorges Cruise',
      context:
          'On the sun deck of a river cruise ship passing through the dramatic towering Qutang Gorge.',
      persona:
          'Professor Qian (钱教授), a retired maritime historian who narrates Tang dynasty poet travels through the gorges.',
      difficultyIndex: 3, // Native
    ),

    // ── Art, Heritage & Traditional Crafts ──────────────────────
    RandomPersonaPreset(
      topic: 'Buying Antiques in Beijing Panjiayuan',
      context:
          'The famous Panjiayuan weekend flea market crowded with calligraphy scrolls, jade, and vintage trinkets.',
      persona:
          'Elder Sun (孙大爷), a sharp-eyed vintage collector with a Beijing accent who enjoys bantering about history.',
      difficultyIndex: 2, // Advanced
    ),
    RandomPersonaPreset(
      topic: 'Jingdezhen Blue & White Porcelain Studio',
      context:
          'A historic pottery kiln filled with delicate unfired porcelain vases and cobalt blue glazes.',
      persona:
          'Master Song (宋大师), an acclaimed ceramicist guiding you through throwing clay on the wheel and brush painting.',
      difficultyIndex: 2, // Advanced
    ),
    RandomPersonaPreset(
      topic: 'Suzhou Silk Embroidery Studio',
      context:
          'A peaceful canal-side garden studio in Suzhou with fine silk threads and wooden embroidery frames.',
      persona:
          'Teacher Yao (姚老师), an elegant master of double-sided silk embroidery explaining stitch precision.',
      difficultyIndex: 2, // Advanced
    ),
    RandomPersonaPreset(
      topic: 'Peking Opera Dressing Room & Makeup',
      context:
          'Backstage at a traditional Beijing opera theater with colorful costumes, mirrors, and headpieces.',
      persona:
          'Teacher Mei (梅老师), a veteran Dan role performer helping you understand operatic vocal tone and facial symbolism.',
      difficultyIndex: 3, // Native
    ),
    RandomPersonaPreset(
      topic: 'Traditional Chinese Medicine Consultation',
      context:
          'A historic Tongrentang apothecary scented with ginseng, wolfberry, and hundreds of wooden herbal drawers.',
      persona:
          'Doctor Ye (叶大夫), a gentle and perceptive TCM physician who checks your pulse and explains balanced Qi diet.',
      difficultyIndex: 2, // Advanced
    ),
    RandomPersonaPreset(
      topic: 'Morning Tai Chi in Temple of Heaven Park',
      context:
          'Beneath ancient cypress trees at dawn with park birds and seniors practicing synchronized movements.',
      persona:
          'Master Lu (鲁师傅), a calm and disciplined martial artist coaching breathing control and fluid posture.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Renting a Hanfu for a Photo Shoot',
      context:
          'A traditional costume boutique near the West Lake with racks of Tang and Song dynasty robes.',
      persona:
          'Stylist Yanyan (严严), a creative fashion stylist who helps you pick the right dynastic garments and hairpins.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Guqin Ancient Zither Instrument Workshop',
      context:
          'A quiet pine-wood studio in Hangzhou filled with aged paulownia wood and silk-string instruments.',
      persona:
          'Master Gu (顾琴师), a dedicated luthier who explains the ancient 7-string tuning and poetic philosophy of music.',
      difficultyIndex: 3, // Native
    ),
    RandomPersonaPreset(
      topic: 'Shaanxi Shadow Puppet Theater',
      context:
          'Behind an illuminated white silk screen with delicate translucent leather shadow figures.',
      persona:
          'Uncle Liang (梁大叔), a folk puppeteer showing you how to manipulate leather joints and sing dramatic stories.',
      difficultyIndex: 2, // Advanced
    ),
    RandomPersonaPreset(
      topic: 'Chinese Calligraphy Workshop',
      context:
          'A tranquil studio scented with pine soot ink, rice paper scrolls, and soft tea aromas.',
      persona:
          'Master Shen (沈老师), a respected calligrapher who guides brush technique, posture, and character strokes.',
      difficultyIndex: 3, // Native
    ),

    // ── Modern City Life & Youth Culture ────────────────────────
    RandomPersonaPreset(
      topic: 'Adopting a Cat at an Animal Shelter',
      context:
          'A cozy pet rescue center in Hangzhou with energetic rescue kittens and tea for visitors.',
      persona:
          'Xiaoling (小玲), a warm and enthusiastic shelter volunteer who wants to find the best match for each pet.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Script Murder Mystery (Jubensha) Game',
      context:
          'A themed detective lounge in Shanghai with costumed players and candlelight.',
      persona:
          'DM Xiao Lin (林DM), a charismatic mystery game host assigning roles and delivering clues for a 1930s case.',
      difficultyIndex: 2, // Advanced
    ),
    RandomPersonaPreset(
      topic: 'Vintage Vinyl Record Shop in Shanghai',
      context:
          'A hidden vinyl store in an old lane house packed with classic 80s Cantopop and jazz records.',
      persona:
          'Boss Dave (老戴), an indie music lover who recommends classic vinyl albums and rare concert recordings.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'KTV Karaoke Party with Friends',
      context:
          'A vibrant private neon-lit karaoke room in Shenzhen with microphones, fruit platters, and screen controls.',
      persona:
          'Xiao Ming (小明), an upbeat and funny party organizer encouraging everyone to sing their favorite Mandopop tracks.',
      difficultyIndex: 0, // Beginner
    ),
    RandomPersonaPreset(
      topic: 'Joining a City Bike Cycling Club',
      context:
          'A gathering of cyclists by the riverfront preparing for an evening ride around the city skyline.',
      persona:
          'Coach Han (韩队长), an athletic and encouraging cycling club organizer welcoming new members.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Blind Box Toy Trading Meetup',
      context:
          'A colorful pop-culture toy store in Chaoyang with display shelves and unopened collectible boxes.',
      persona:
          'Tingting (婷婷), an enthusiastic toy collector trading rare figurines and sharing unboxing luck.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Drone Skyline Videography at the Bund',
      context:
          'The Bund promenade at dusk overlooking the futuristic illuminated skyscrapers of Pudong.',
      persona:
          'Ah Jie (阿杰), an aerial videographer sharing drone flight settings and camera angles for night timelapses.',
      difficultyIndex: 2, // Advanced
    ),
    RandomPersonaPreset(
      topic: 'Golden Retriever Cafe in Nanjing',
      context:
          'A sunny, cheerful pet cafe with dozens of friendly, fluffy dogs greeting visitors.',
      persona:
          'Xiaomei (小美), a dog trainer helping guests feed treats and take cute photos with the retrievers.',
      difficultyIndex: 0, // Beginner
    ),
    RandomPersonaPreset(
      topic: 'Bouldering Climbing Gym in Chengdu',
      context:
          'A modern indoor climbing gym with vibrant colored hold routes and energetic music.',
      persona:
          'Coach Frank (方教练), an encouraging climbing coach giving beta advice on how to conquer a tricky V4 route.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Anime & Cosplay Expo in Guangzhou',
      context:
          'A massive convention hall filled with colorful game booths, photo walls, and costumed creators.',
      persona:
          'Yuki (小樱), a cheerful cosplay organizer directing photographers and arranging group stage performances.',
      difficultyIndex: 1, // Intermediate
    ),

    // ── Daily Life, Errands & Shopping ──────────────────────────
    RandomPersonaPreset(
      topic: 'Asking for Directions in a Beijing Hutong',
      context:
          'A maze of historic grey-brick alleys with bicycles, courtyards, and pomegranate trees.',
      persona:
          'Grandpa Wang (王大爷), a retired neighbor sitting with his birdcage who gives detailed directions with local landmarks.',
      difficultyIndex: 0, // Beginner
    ),
    RandomPersonaPreset(
      topic: 'Buying Fresh Fruit at a Wet Market',
      context:
          'A lively morning neighborhood market with mounds of fresh lychees, mangoes, and dragonfruit.',
      persona:
          'Vendor Uncle Liu (刘大叔), a friendly fruit merchant who lets you taste sweet melons before buying.',
      difficultyIndex: 0, // Beginner
    ),
    RandomPersonaPreset(
      topic: 'Flower Market Bouquet in Kunming',
      context:
          'The famous Dounan Flower Market surrounded by thousands of fresh roses, lilies, and eucalyptus stems.',
      persona:
          'Sister Hua (花姐), a knowledgeable florist helping you arrange a fresh bouquet for a friend\'s birthday.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Tailor Alterations in an Old Lane House',
      context:
          'A traditional tailor shop filled with sewing machines, fabrics, and measuring tapes.',
      persona:
          'Master Ni (倪师傅), an experienced Shanghainese master tailor taking measurements and adjusting hemlines.',
      difficultyIndex: 1, // Intermediate
    ),
    RandomPersonaPreset(
      topic: 'Express Parcel Locker Retrieval',
      context:
          'Downstairs at a residential apartment gate next to a smart Hive box locker system.',
      persona:
          'Courier Xiao Zhang (快递小张), a friendly delivery courier helping you look up pickup codes and packages.',
      difficultyIndex: 0, // Beginner
    ),
    RandomPersonaPreset(
      topic: 'Bicycle Flat Tire Repair at Campus Gate',
      context:
          'A small outdoor roadside toolkit stand under a large leafy banyan tree.',
      persona:
          'Uncle Ding (丁师傅), a speedy mechanic who patches bicycle tires and tunes brakes in five minutes.',
      difficultyIndex: 0, // Beginner
    ),

    // ── Career, Tech & Professional Life ────────────────────────
    RandomPersonaPreset(
      topic: 'Tech Company Product Demo',
      context:
          'A futuristic tech conference booth in Shenzhen showcasing cutting-edge AI hardware.',
      persona:
          'Product Manager Guo (郭经理), a tech-savvy engineer presenting next-generation voice AI gadgets.',
      difficultyIndex: 2, // Advanced
    ),
    RandomPersonaPreset(
      topic: 'E-commerce Live-Stream Studio',
      context:
          'A high-energy broadcast studio with ring lights, product display racks, and live comment monitors.',
      persona:
          'Streamer Bella (贝拉), a top live-stream host rehearsing product pitches and flash sale discounts.',
      difficultyIndex: 2, // Advanced
    ),
    RandomPersonaPreset(
      topic: 'Yiwu International Trade Market',
      context:
          'A vast multi-story commercial exhibition mall filled with millions of wholesale goods and crafts.',
      persona:
          'Trader Boss Lin (林老板), a seasoned export merchant negotiating bulk shipping orders and factory samples.',
      difficultyIndex: 2, // Advanced
    ),
    RandomPersonaPreset(
      topic: 'University Campus Exchange Program',
      context:
          'A sunny lawn outside the university library with students studying and drinking milk tea.',
      persona:
          'David (大卫), an outgoing senior student mentor sharing campus tips, course enrollment, and club activities.',
      difficultyIndex: 0, // Beginner
    ),
  ];
}
