import 'package:flutter/widgets.dart';

/// Localized, user-facing metadata for the built-in roleplay catalog.
///
/// System prompts intentionally remain in English because they are model
/// instructions, not UI. Unknown locales fall back to English.
abstract final class LocalizedScenarioContent {
  static String languageName(Locale locale) =>
      _languageNames[locale.languageCode] ?? 'English';

  static String? personaName(String scenarioId, Locale locale) =>
      _personaNames[scenarioId];

  static List<String>? quests(String scenarioId, Locale locale) {
    final translations = _quests[scenarioId];
    if (translations == null) return null;
    return translations[locale.languageCode] ?? translations['en'];
  }

  static List<String> customScenarioQuests(Locale locale, String topic) {
    final templates = _customQuestTemplates[locale.languageCode] ??
        _customQuestTemplates['en']!;
    return templates.map((text) => text.replaceAll('{topic}', topic)).toList();
  }

  static const _languageNames = <String, String>{
    'ar': 'Arabic',
    'de': 'German',
    'en': 'English',
    'es': 'Spanish',
    'fr': 'French',
    'hi': 'Hindi',
    'id': 'Indonesian',
    'it': 'Italian',
    'ja': 'Japanese',
    'ko': 'Korean',
    'pt': 'Portuguese',
    'ru': 'Russian',
    'th': 'Thai',
    'vi': 'Vietnamese',
  };

  // Chinese role titles avoid leaking English honorifics into other locales.
  static const _personaNames = <String, String>{
    'food_1': 'Lǐ fúwùyuán (李服务员)',
    'taxi_1': 'Wáng shīfu (王师傅)',
    'market_1': 'Chén āyí (陈阿姨)',
    'doctor_1': 'Zhāng yīshēng (张医生)',
    'intro_1': 'Péngyou (朋友)',
    'job_1': 'Liú jīnglǐ (刘经理)',
  };

  static const _customQuestTemplates = <String, List<String>>{
    'en': [
      'Greet your conversation partner',
      'Discuss {topic}',
      'Ask a question in Chinese'
    ],
    'fr': [
      'Saluez votre interlocuteur',
      'Discutez de {topic}',
      'Posez une question en chinois'
    ],
    'de': [
      'Begrüßen Sie Ihren Gesprächspartner',
      'Sprechen Sie über {topic}',
      'Stellen Sie eine Frage auf Chinesisch'
    ],
    'es': [
      'Saluda a tu interlocutor',
      'Habla sobre {topic}',
      'Haz una pregunta en chino'
    ],
    'it': [
      'Saluta il tuo interlocutore',
      'Parla di {topic}',
      'Fai una domanda in cinese'
    ],
    'pt': [
      'Cumprimente seu interlocutor',
      'Converse sobre {topic}',
      'Faça uma pergunta em chinês'
    ],
    'ru': [
      'Поприветствуйте собеседника',
      'Обсудите тему «{topic}»',
      'Задайте вопрос на китайском языке'
    ],
    'ar': [
      'حيِّ شريكك في المحادثة',
      'ناقش {topic}',
      'اطرح سؤالًا باللغة الصينية'
    ],
    'hi': [
      'अपने वार्तालाप साथी का अभिवादन करें',
      '{topic} पर चर्चा करें',
      'चीनी भाषा में एक प्रश्न पूछें'
    ],
    'id': [
      'Sapa lawan bicara Anda',
      'Diskusikan {topic}',
      'Ajukan pertanyaan dalam bahasa Mandarin'
    ],
    'ja': ['会話相手に挨拶する', '{topic}について話す', '中国語で質問する'],
    'ko': ['대화 상대에게 인사하세요', '{topic}에 대해 이야기하세요', '중국어로 질문하세요'],
    'th': [
      'ทักทายคู่สนทนาของคุณ',
      'พูดคุยเกี่ยวกับ {topic}',
      'ถามคำถามเป็นภาษาจีน'
    ],
    'vi': [
      'Chào hỏi người đối thoại',
      'Thảo luận về {topic}',
      'Đặt một câu hỏi bằng tiếng Trung'
    ],
  };

  static const _quests = <String, Map<String, List<String>>>{
    'food_1': {
      'en': [
        'Ask for the menu',
        'Order one dish and one drink',
        'Ask for the bill'
      ],
      'fr': [
        'Demandez le menu',
        'Commandez un plat et une boisson',
        "Demandez l’addition"
      ],
      'de': [
        'Bitten Sie um die Speisekarte',
        'Bestellen Sie ein Gericht und ein Getränk',
        'Bitten Sie um die Rechnung'
      ],
      'es': ['Pide el menú', 'Pide un plato y una bebida', 'Pide la cuenta'],
      'it': [
        'Chiedi il menù',
        'Ordina un piatto e una bevanda',
        'Chiedi il conto'
      ],
      'pt': ['Peça o cardápio', 'Peça um prato e uma bebida', 'Peça a conta'],
      'ru': [
        'Попросите меню',
        'Закажите одно блюдо и один напиток',
        'Попросите счёт'
      ],
      'ar': [
        'اطلب قائمة الطعام',
        'اطلب طبقًا واحدًا ومشروبًا واحدًا',
        'اطلب الفاتورة'
      ],
      'hi': ['मेन्यू माँगें', 'एक व्यंजन और एक पेय ऑर्डर करें', 'बिल माँगें'],
      'id': [
        'Minta menu',
        'Pesan satu hidangan dan satu minuman',
        'Minta tagihan'
      ],
      'ja': ['メニューを頼む', '料理と飲み物を一つずつ注文する', '会計を頼む'],
      'ko': ['메뉴를 요청하세요', '요리 하나와 음료 하나를 주문하세요', '계산서를 요청하세요'],
      'th': [
        'ขอเมนู',
        'สั่งอาหารหนึ่งอย่างและเครื่องดื่มหนึ่งแก้ว',
        'ขอเช็กบิล'
      ],
      'vi': [
        'Xin thực đơn',
        'Gọi một món ăn và một đồ uống',
        'Yêu cầu tính tiền'
      ],
    },
    'taxi_1': {
      'en': [
        'Tell the driver you are going to the airport',
        'Ask how long the trip will take',
        'Complain about the traffic'
      ],
      'fr': [
        "Dites au chauffeur que vous allez à l’aéroport",
        'Demandez combien de temps durera le trajet',
        'Plaignez-vous de la circulation'
      ],
      'de': [
        'Sagen Sie dem Fahrer, dass Sie zum Flughafen fahren',
        'Fragen Sie, wie lange die Fahrt dauert',
        'Beschweren Sie sich über den Verkehr'
      ],
      'es': [
        'Dile al conductor que vas al aeropuerto',
        'Pregunta cuánto durará el trayecto',
        'Quéjate del tráfico'
      ],
      'it': [
        "Di’ all’autista che vai all’aeroporto",
        'Chiedi quanto durerà il viaggio',
        'Lamentati del traffico'
      ],
      'pt': [
        'Diga ao motorista que vai para o aeroporto',
        'Pergunte quanto tempo levará a viagem',
        'Reclame do trânsito'
      ],
      'ru': [
        'Скажите водителю, что едете в аэропорт',
        'Спросите, сколько займёт поездка',
        'Пожалуйтесь на пробки'
      ],
      'ar': [
        'أخبر السائق أنك ذاهب إلى المطار',
        'اسأل كم ستستغرق الرحلة',
        'اشتَكِ من الازدحام المروري'
      ],
      'hi': [
        'ड्राइवर को बताएँ कि आप हवाई अड्डे जा रहे हैं',
        'पूछें कि यात्रा में कितना समय लगेगा',
        'ट्रैफ़िक की शिकायत करें'
      ],
      'id': [
        'Beri tahu sopir bahwa Anda pergi ke bandara',
        'Tanyakan berapa lama perjalanannya',
        'Keluhkan kemacetan'
      ],
      'ja': ['空港へ行くと運転手に伝える', '所要時間を尋ねる', '渋滞について不満を言う'],
      'ko': ['기사에게 공항에 간다고 말하세요', '얼마나 걸리는지 물어보세요', '교통 체증에 대해 불평하세요'],
      'th': [
        'บอกคนขับว่าคุณกำลังไปสนามบิน',
        'ถามว่าจะใช้เวลาเดินทางนานเท่าไร',
        'บ่นเรื่องรถติด'
      ],
      'vi': [
        'Nói với tài xế rằng bạn đang đến sân bay',
        'Hỏi chuyến đi mất bao lâu',
        'Phàn nàn về tình trạng giao thông'
      ],
    },
    'market_1': {
      'en': [
        'Ask how much the silk shirt costs',
        'Say it is too expensive',
        'Bargain the price down to 100 RMB'
      ],
      'fr': [
        'Demandez le prix de la chemise en soie',
        "Dites qu’elle est trop chère",
        'Négociez le prix à 100 RMB'
      ],
      'de': [
        'Fragen Sie nach dem Preis des Seidenhemds',
        'Sagen Sie, dass es zu teuer ist',
        'Handeln Sie den Preis auf 100 RMB herunter'
      ],
      'es': [
        'Pregunta cuánto cuesta la camisa de seda',
        'Di que es demasiado cara',
        'Regatea el precio hasta 100 RMB'
      ],
      'it': [
        'Chiedi quanto costa la camicia di seta',
        'Di’ che è troppo cara',
        'Contratta il prezzo fino a 100 RMB'
      ],
      'pt': [
        'Pergunte quanto custa a camisa de seda',
        'Diga que é cara demais',
        'Negocie o preço até 100 RMB'
      ],
      'ru': [
        'Спросите, сколько стоит шёлковая рубашка',
        'Скажите, что это слишком дорого',
        'Сторгуйтесь до 100 юаней'
      ],
      'ar': [
        'اسأل عن سعر القميص الحريري',
        'قل إنه باهظ الثمن',
        'فاوِض حتى يصل السعر إلى 100 يوان'
      ],
      'hi': [
        'पूछें कि रेशमी कमीज़ की कीमत कितनी है',
        'कहें कि यह बहुत महँगी है',
        'मोलभाव करके कीमत 100 युआन तक लाएँ'
      ],
      'id': [
        'Tanyakan harga kemeja sutra',
        'Katakan bahwa harganya terlalu mahal',
        'Tawar harganya hingga 100 RMB'
      ],
      'ja': ['絹のシャツの値段を尋ねる', '高すぎると言う', '100元まで値切る'],
      'ko': ['실크 셔츠 가격을 물어보세요', '너무 비싸다고 말하세요', '100위안까지 가격을 흥정하세요'],
      'th': ['ถามราคาเสื้อไหม', 'บอกว่าแพงเกินไป', 'ต่อราคาให้เหลือ 100 หยวน'],
      'vi': [
        'Hỏi giá chiếc áo lụa',
        'Nói rằng nó quá đắt',
        'Mặc cả xuống còn 100 nhân dân tệ'
      ],
    },
    'doctor_1': {
      'en': [
        'Explain you have had a headache for two days',
        'Say you have a slight fever',
        'Ask if you need to take medicine'
      ],
      'fr': [
        'Expliquez que vous avez mal à la tête depuis deux jours',
        'Dites que vous avez un peu de fièvre',
        'Demandez si vous devez prendre des médicaments'
      ],
      'de': [
        'Erklären Sie, dass Sie seit zwei Tagen Kopfschmerzen haben',
        'Sagen Sie, dass Sie leichtes Fieber haben',
        'Fragen Sie, ob Sie Medikamente nehmen müssen'
      ],
      'es': [
        'Explica que te duele la cabeza desde hace dos días',
        'Di que tienes un poco de fiebre',
        'Pregunta si necesitas tomar medicamentos'
      ],
      'it': [
        'Spiega che hai mal di testa da due giorni',
        'Di’ che hai un po’ di febbre',
        'Chiedi se devi prendere medicine'
      ],
      'pt': [
        'Explique que está com dor de cabeça há dois dias',
        'Diga que está com um pouco de febre',
        'Pergunte se precisa tomar remédio'
      ],
      'ru': [
        'Объясните, что голова болит уже два дня',
        'Скажите, что у вас небольшая температура',
        'Спросите, нужно ли принимать лекарство'
      ],
      'ar': [
        'اشرح أنك تعاني من صداع منذ يومين',
        'قل إن لديك حمى خفيفة',
        'اسأل إن كنت بحاجة إلى تناول دواء'
      ],
      'hi': [
        'बताएँ कि आपको दो दिनों से सिरदर्द है',
        'कहें कि आपको हल्का बुखार है',
        'पूछें कि क्या आपको दवा लेने की ज़रूरत है'
      ],
      'id': [
        'Jelaskan bahwa Anda sakit kepala selama dua hari',
        'Katakan bahwa Anda sedikit demam',
        'Tanyakan apakah Anda perlu minum obat'
      ],
      'ja': ['二日前から頭痛があると説明する', '微熱があると伝える', '薬を飲む必要があるか尋ねる'],
      'ko': ['이틀 동안 두통이 있었다고 설명하세요', '미열이 있다고 말하세요', '약을 먹어야 하는지 물어보세요'],
      'th': [
        'อธิบายว่าคุณปวดศีรษะมาสองวันแล้ว',
        'บอกว่าคุณมีไข้เล็กน้อย',
        'ถามว่าคุณจำเป็นต้องกินยาหรือไม่'
      ],
      'vi': [
        'Giải thích rằng bạn bị đau đầu hai ngày nay',
        'Nói rằng bạn hơi sốt',
        'Hỏi xem bạn có cần uống thuốc không'
      ],
    },
    'intro_1': {
      'en': [
        'Greet your friend and say it has been a long time',
        'Share how you have been lately',
        'Ask what your friend has been doing recently'
      ],
      'fr': [
        'Saluez votre ami et dites que cela fait longtemps',
        'Racontez comment vous allez ces derniers temps',
        'Demandez à votre ami ce qu’il fait récemment'
      ],
      'de': [
        'Begrüßen Sie Ihren Freund und sagen Sie, dass Sie sich lange nicht gesehen haben',
        'Erzählen Sie, wie es Ihnen in letzter Zeit ergangen ist',
        'Fragen Sie, was Ihr Freund in letzter Zeit gemacht hat'
      ],
      'es': [
        'Saluda a tu amigo y dile que hace mucho que no se ven',
        'Cuenta cómo te ha ido últimamente',
        'Pregunta qué ha estado haciendo tu amigo recientemente'
      ],
      'it': [
        'Saluta il tuo amico e dì che non vi vedete da molto tempo',
        'Racconta come sei stato ultimamente',
        'Chiedi cosa ha fatto di recente il tuo amico'
      ],
      'pt': [
        'Cumprimente seu amigo e diga que vocês não se veem há muito tempo',
        'Conte como você tem passado ultimamente',
        'Pergunte o que seu amigo tem feito recentemente'
      ],
      'ru': [
        'Поприветствуйте друга и скажите, что вы давно не виделись',
        'Расскажите, как у вас шли дела в последнее время',
        'Спросите, чем ваш друг занимался в последнее время'
      ],
      'ar': [
        'حيِّ صديقك وقل إنكما لم تلتقيا منذ وقت طويل',
        'تحدث عن أحوالك في الآونة الأخيرة',
        'اسأل صديقك عما كان يفعله مؤخرًا'
      ],
      'hi': [
        'अपने दोस्त का अभिवादन करें और कहें कि बहुत समय हो गया है',
        'बताएँ कि हाल में आप कैसे रहे हैं',
        'पूछें कि आपका दोस्त हाल में क्या करता रहा है'
      ],
      'id': [
        'Sapa teman Anda dan katakan bahwa sudah lama tidak bertemu',
        'Ceritakan kabar Anda akhir-akhir ini',
        'Tanyakan apa yang dilakukan teman Anda belakangan ini'
      ],
      'ja': ['友達に挨拶して久しぶりだと伝える', '最近の自分の様子を話す', '友達が最近何をしていたか尋ねる'],
      'ko': [
        '친구에게 인사하고 오랜만이라고 말하세요',
        '최근에 어떻게 지냈는지 이야기하세요',
        '친구가 최근에 무엇을 했는지 물어보세요'
      ],
      'th': [
        'ทักทายเพื่อนและบอกว่าไม่ได้เจอกันนานแล้ว',
        'เล่าว่าช่วงนี้คุณเป็นอย่างไรบ้าง',
        'ถามว่าเมื่อเร็ว ๆ นี้เพื่อนของคุณทำอะไรบ้าง'
      ],
      'vi': [
        'Chào bạn của bạn và nói rằng đã lâu không gặp',
        'Chia sẻ tình hình gần đây của bạn',
        'Hỏi gần đây bạn của bạn đã làm gì'
      ],
    },
    'job_1': {
      'en': [
        'Introduce your professional background briefly',
        'Explain why you want to work at this company',
        'Ask a polite question about the company culture'
      ],
      'fr': [
        'Présentez brièvement votre parcours professionnel',
        'Expliquez pourquoi vous souhaitez travailler pour cette entreprise',
        "Posez une question polie sur la culture de l’entreprise"
      ],
      'de': [
        'Stellen Sie kurz Ihren beruflichen Werdegang vor',
        'Erklären Sie, warum Sie bei diesem Unternehmen arbeiten möchten',
        'Stellen Sie eine höfliche Frage zur Unternehmenskultur'
      ],
      'es': [
        'Presenta brevemente tu trayectoria profesional',
        'Explica por qué quieres trabajar en esta empresa',
        'Haz una pregunta cortés sobre la cultura de la empresa'
      ],
      'it': [
        'Presenta brevemente il tuo percorso professionale',
        'Spiega perché vuoi lavorare in questa azienda',
        'Fai una domanda cortese sulla cultura aziendale'
      ],
      'pt': [
        'Apresente brevemente sua trajetória profissional',
        'Explique por que deseja trabalhar nesta empresa',
        'Faça uma pergunta educada sobre a cultura da empresa'
      ],
      'ru': [
        'Кратко расскажите о своём профессиональном опыте',
        'Объясните, почему хотите работать в этой компании',
        'Вежливо спросите о корпоративной культуре'
      ],
      'ar': [
        'قدّم نبذة مختصرة عن خبرتك المهنية',
        'اشرح سبب رغبتك في العمل لدى هذه الشركة',
        'اطرح سؤالًا مهذبًا عن ثقافة الشركة'
      ],
      'hi': [
        'अपनी पेशेवर पृष्ठभूमि का संक्षेप में परिचय दें',
        'समझाएँ कि आप इस कंपनी में क्यों काम करना चाहते हैं',
        'कंपनी की संस्कृति के बारे में विनम्र प्रश्न पूछें'
      ],
      'id': [
        'Perkenalkan latar belakang profesional Anda secara singkat',
        'Jelaskan mengapa Anda ingin bekerja di perusahaan ini',
        'Ajukan pertanyaan sopan tentang budaya perusahaan'
      ],
      'ja': ['職歴を簡潔に紹介する', 'この会社で働きたい理由を説明する', '企業文化について丁寧に質問する'],
      'ko': [
        '직업 경력을 간단히 소개하세요',
        '이 회사에서 일하고 싶은 이유를 설명하세요',
        '회사 문화에 대해 정중하게 질문하세요'
      ],
      'th': [
        'แนะนำประวัติการทำงานของคุณโดยย่อ',
        'อธิบายว่าทำไมคุณจึงต้องการทำงานที่บริษัทนี้',
        'ถามเกี่ยวกับวัฒนธรรมองค์กรอย่างสุภาพ'
      ],
      'vi': [
        'Giới thiệu ngắn gọn về kinh nghiệm nghề nghiệp của bạn',
        'Giải thích vì sao bạn muốn làm việc tại công ty này',
        'Đặt một câu hỏi lịch sự về văn hóa công ty'
      ],
    },
  };
}
