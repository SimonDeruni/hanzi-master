import 'dart:convert';
import 'dart:io';

const langs=['ar','de','es','fr','hi','id','it','ja','ko','pt','ru','vi'];
const ch={'ar':'\u0627\u0644\u0641\u0635\u0644','de':'Kapitel','es':'Cap\u00edtulo','fr':'Chapitre','hi':'\u0905\u0927\u094d\u092f\u093e\u092f','id':'Bab','it':'Capitolo','ja':'\u7b2c','ko':'\uc81c','pt':'Cap\u00edtulo','ru':'\u0413\u043b\u0430\u0432\u0430','vi':'Ch\u01b0\u01a1ng'};
const fb={'ar':'\u062e\u0631\u0627\u0641\u0629','de':'Fabel','es':'F\u00e1bula','fr':'Fable','hi':'\u0915\u0939\u093e\u0928\u0940','id':'Fabel','it':'Favola','ja':'\u5bd3\u8a71','ko':'\uc6b0\ud654','pt':'F\u00e1bula','ru':'\u0411\u0430\u0441\u043d\u044f','vi':'Ng\u1ee5 ng\u00f4n'};
const pt={'ar':'\u062c\u0632\u0621','de':'Teil','es':'Parte','fr':'Partie','hi':'\u092d\u093e\u0917','id':'Bagian','it':'Parte','ja':'\u90e8','ko':'\ubd80','pt':'Parte','ru':'\u0427\u0430\u0441\u0442\u044c','vi':'Ph\u1ea7n'};
const vl={'ar':'\u0627\u0644\u0645\u062c\u0644\u062f','de':'Band','es':'Volumen','fr':'Volume','hi':'\u0916\u0902\u0921','id':'Volume','it':'Volume','ja':'\u5dfb','ko':'\uad8c','pt':'Volume','ru':'\u0422\u043e\u043c','vi':'T\u1eadp'};
const pr={'ar':'\u0645\u0642\u062f\u0645\u0629','de':'Prolog','es':'Pr\u00f3logo','fr':'Prologue','hi':'\u092a\u094d\u0930\u0938\u094d\u0924\u093e\u0935\u0928\u093e','id':'Prolog','it':'Prologo','ja':'\u5e8f\u7ae0','ko':'\ud504\ub85c\ub85c\uadf8','pt':'Pr\u00f3logo','ru':'\u041f\u0440\u043e\u043b\u043e\u0433','vi':'L\u1eddi m\u1edf \u0111\u1ea7u'};
const ap={'ar':'\u0623\u0645\u062b\u0627\u0644','de':'Aphorismen','es':'Aforismos','fr':'Aphorismes','hi':'\u0938\u0942\u0915\u094d\u0924\u093f\u092f\u093e\u0901','id':'Aforisme','it':'Aforismi','ja':'\u683c\u8a00','ko':'\uaca9\uc5b8','pt':'Aforismos','ru':'\u0410\u0444\u043e\u0440\u0438\u0437\u043c\u044b','vi':'Ch\u00e2m ng\u00f4n'};
const chr={'ar':'\u0633\u062c\u0644\u0627\u062a','de':'Die Chronik von','es':'La Cr\u00f3nica de','fr':'La Chronique de','hi':'\u0915\u093e \u0907\u0924\u093f\u0939\u093e\u0938','id':'Kronik','it':'La Cronaca di','ja':'\u306e\u8a18\u9332','ko':'\uc758 \uae30\ub85d','pt':'A Cr\u00f4nica de','ru':'\u0425\u0440\u043e\u043d\u0438\u043a\u0430','vi':'Bi\u00ean ni\u00ean s\u1eed'};

const Map<String,Map<String,String>> ph = {
  "Prologue: The Awakening of Destiny": {'ar':'\u0645\u0642\u062f\u0645\u0629: \u0635\u062d\u0648\u0629 \u0627\u0644\u0642\u062f\u0631','de':'Prolog: Das Erwachen des Schicksals','es':'Pr\u00f3logo: El despertar del destino','fr':'Prologue: L\u2019\u00e9veil du destin','hi':'\u092a\u094d\u0930\u0938\u094d\u0924\u093e\u0935\u0646\u093e: \u092d\u093e\u0917\u094d\u092f \u0915\u093e \u091c\u093e\u0917\u0930\u0923','id':'Prolog: Kebangkitan Takdir','it':'Prologo: Il risveglio del destino','ja':'\u5e8f\u7ae0: \u904b\u547d\u306e\u76ee\u899a\u3081','ko':'\ud504\ub85c\ub85c\uadf8: \uc6b4\uba85\uc758 \uac01\uc131','pt':'Pr\u00f3logo: O despertar do destino','ru':'\u041f\u0440\u043e\u043b\u043e\u0433: \u041f\u0440\u043e\u0431\u0443\u0436\u0434\u0435\u043d\u0438\u0435 \u0441\u0443\u0434\u044c\u0431\u044b','vi':'L\u1eddi m\u1edf \u0111\u1ea7u: S\u1ef1 th\u1ee9c t\u1ec9nh c\u1ee7a s\u1ed1 m\u1ec7nh'},
"The Awakening of Destiny": {'ar':'\u0635\u062d\u0648\u0629 \u0627\u0644\u0642\u062f\u0631','de':'Das Erwachen des Schicksals','es':'El despertar del destino','fr':'L\u2019\u00e9veil du destin','hi':'\u092d\u093e\u0917\u094d\u092f \u0915\u093e \u091c\u093e\u0917\u0930\u0923','id':'Kebangkitan Takdir','it':'Il risveglio del destino','ja':'\u904b\u547d\u306e\u76ee\u899a\u3081','ko':'\uc6b4\uba85\uc758 \uac01\uc131','pt':'O despertar do destino','ru':'\u041f\u0440\u043e\u0431\u0443\u0436\u0434\u0435\u043d\u0438\u0435 \u0441\u0443\u0434\u044c\u0431\u044b','vi':'S\u1ef1 th\u1ee9c t\u1ec9nh c\u1ee7a s\u1ed1 m\u1ec7nh'},
  "THE OAK AND THE REEDS": {'ar':'\u0627\u0644\u0628\u0644\u0648\u0637 \u0648\u0627\u0644\u0642\u0635\u0628','de':'DIE EICHE UND DAS SCHILF','es':'EL ROBLE Y LAS CA\u00d1AS','fr':'LE CH\u00caNE ET LES ROSEAUX','hi':'\u092c\u0932\u0942\u0924 \u0914\u0930 \u0928\u0930\u0915\u091f','id':'POHON EK DAN ALANG-ALANG','it':'LA QUERCIA E LE CANNE','ja':'\u6a2b\u306e\u6728\u3068\u8461','ko':'\ucc38\ub098\ubb34\uc640 \uac08\ub300','pt':'O CARVALHO E OS JUNCOS','ru':'\u0414\u0423\u0411 \u0418 \u0422\u0420\u041e\u0421\u0422\u041d\u0418\u041a','vi':'C\u00c2Y S\u1ed2I V\u00c0 C\u00c2Y S\u1eacY'},
  "THE ASS AND HIS BURDENS": {'ar':'\u0627\u0644\u062d\u0645\u0627\u0631 \u0648\u0623\u0639\u0628\u0627\u0624\u0647','de':'DER ESEL UND SEINE LASTEN','es':'EL ASNO Y SUS CARGAS','fr':'L\u2019\u00c2NE ET SES FARDEAUX','hi':'\u0917\u0927\u093e \u0914\u0930 \u0909\u0938\u0915\u0947 \u092c\u094b\u091d','id':'KELEDAI DAN BEBANNYA','it':'L\u2019ASINO E I SUOI CARICHI','ja':'\u30ed\u30d0\u3068\u305d\u306e\u8377\u7269','ko':'\ub2f9\ub098\uad6c\uc640 \uadf8\uc758 \uc9d0','pt':'O ASNO E SUAS CARGAS','ru':'\u041e\u0421\u0415\u041b \u0418 \u0415\u0413\u041e \u041d\u041e\u0428\u0418','vi':'L\u1eeaA V\u00c0 G\u00c1NH N\u1eb6NG C\u1ee6A N\u00d3'},
"THE DOLPHINS, THE WHALES, AND THE SPRAT": {'ar':'\u0627\u0644\u062f\u0644\u0627\u0641\u064a\u0646 \u0648\u0627\u0644\u062d\u064a\u062a\u0627\u0646 \u0648\u0627\u0644\u0633\u0645\u0643\u0629 \u0627\u0644\u0635\u063a\u064a\u0631\u0629','de':'DIE DELFINE, DIE WALE UND DIE SPROTTE','es':'LOS DELFINES, LAS BALLENAS Y EL ESPAD\u00cdN','fr':'LES DAUPHINS, LES BALEINES ET LE SPRAT','hi':'\u0921\u0949\u0932\u094d\u092b\u093c\u093f\u0928, \u0935\u094d\u0939\u0947\u0932 \u0914\u0930 \u0938\u094d\u092a\u094d\u0930\u0948\u091f','id':'LUMBA-LUMBA, PAUS, DAN IKAN SPRAT','it':'I DELFINI, LE BALENE E LO SPRATTO','ja':'\u30a4\u30eb\u30ab\u3001\u30af\u30b8\u30e9\u3001\u305d\u3057\u3066\u30b9\u30d7\u30e9\u30c3\u30c8','ko':'\ub3cc\uace0\ub798, \uace0\ub798, \uadf8\ub9ac\uace0 \uc815\uc5b4\ub9ac','pt':'OS GOLFINHOS, AS BALEIAS E O ESPADARTE','ru':'\u0414\u0415\u041b\u042c\u0424\u0418\u041d\u042b, \u041a\u0418\u0422\u042b \u0418 \u0428\u041f\u0420\u041e\u0422','vi':'C\u00c1 HEO, C\u00c1 VOI V\u00c0 C\u00c1 TR\u00cdCH'},
  "THE FOX AND THE MONKEY": {'ar':'\u0627\u0644\u062b\u0639\u0644\u0628 \u0648\u0627\u0644\u0642\u0631\u062f','de':'DER FUCHS UND DER AFFE','es':'EL ZORRO Y EL MONO','fr':'LE RENARD ET LE SINGE','hi':'\u0932\u094b\u092e\u0921\u093c\u0940 \u0914\u0930 \u092c\u0902\u0926\u0930','id':'RUBAH DAN MONYET','it':'LA VOLPE E LA SCIMMIA','ja':'\u72d0\u3068\u733f','ko':'\uc5ec\uc6b0\uc640 \uc6d0\uc22d\uc774','pt':'A RAPOSA E O MACACO','ru':'\u041b\u0418\u0421\u0410 \u0418 \u041e\u0411\u0415\u0417\u042c\u042f\u041d\u0410','vi':'C\u00c1O V\u00c0 KH\u1ec8'},
  "THE ASS AND THE LAPDOG": {'ar':'\u0627\u0644\u062d\u0645\u0627\u0631 \u0648\u0627\u0644\u0643\u0644\u0628 \u0627\u0644\u0635\u063a\u064a\u0631','de':'DER ESEL UND DER SCHOSSHUND','es':'EL ASNO Y EL PERRO DE FALDA','fr':'L\u2019\u00c2NE ET LE PETIT CHIEN','hi':'\u0917\u0927\u093e \u0914\u0930 \u0917\u094b\u0926 \u0915\u093e \u0915\u0941\u0924\u094d\u0924\u093e','id':'KELEDAI DAN ANJING PANGKUAN','it':'L\u2019ASINO E IL CANE DA GREMBO','ja':'\u30ed\u30d0\u3068\u611b\u73a9\u72ac','ko':'\ub2f9\ub098\uad6c\uc640 \uc560\uc644\uacac','pt':'O ASNO E O C\u00c3O DE COLO','ru':'\u041e\u0421\u0415\u041b \u0418 \u041a\u041e\u041c\u041d\u0410\u0422\u041d\u0410\u042f \u0421\u041e\u0411\u0410\u0427\u041a\u0410','vi':'L\u1eeaA V\u00c0 CH\u00d3 C\u1ea2NH'},
  "THE FIR TREE AND THE BRAMBLE": {'ar':'\u0634\u062c\u0631\u0629 \u0627\u0644\u062a\u0646\u0648\u0628 \u0648\u0627\u0644\u0639\u0644\u064a\u0642','de':'DER TANNENBAUM UND DER DORNSTRAUCH','es':'EL ABETO Y LA ZARZA','fr':'LE SAPIN ET LA RONCE','hi':'\u0926\u0947\u0935\u0926\u093e\u0930 \u0915\u093e \u092a\u0947\u0921\u093c \u0914\u0930 \u091d\u093e\u0921\u093c\u0940','id':'POHON CEMARA DAN SEMAK DURI','it':'L\u2019ABETE E IL ROVO','ja':'\u30e2\u30df\u306e\u6728\u3068\u30a4\u30d0\u30e9','ko':'\uc804\ub098\ubb34\uc640 \uac00\uc2dc\ub355\ubd88','pt':'O ABETO E A SILVA','ru':'\u0415\u041b\u042c \u0418 \u0415\u0416\u0415\u0412\u0418\u041a\u0410','vi':'C\u00c2Y LINH SAM V\u00c0 B\u1ee4I GAI'},
  "THE FLEA AND THE MAN": {'ar':'\u0627\u0644\u0628\u0631\u063a\u0648\u062b \u0648\u0627\u0644\u0631\u062c\u0644','de':'DER FLOH UND DER MANN','es':'LA PULGA Y EL HOMBRE','fr':'LA PUCE ET L\u2019HOMME','hi':'\u092a\u093f\u0938\u094d\u0938\u0942 \u0914\u0930 \u0906\u0926\u092e\u0940','id':'KUTU DAN MANUSIA','it':'LA PULCE E L\u2019UOMO','ja':'\u30ce\u30df\u3068\u4eba\u9593','ko':'\ubca4\ub8e9\uacfc \uc778\uac04','pt':'A PULGA E O HOMEM','ru':'\u0411\u041b\u041e\u0425\u0410 \u0418 \u0427\u0415\u041b\u041e\u0412\u0415\u041a','vi':'B\u1ecc CH\u00c9T V\u00c0 NG\u01af\u1edcI'},
};

String w(Map<String,String> m,String l)=>m[l]!;
String tr(String en,String l)=>ph.containsKey(en)?(ph[en]![l]??en):en;

void main() {
  final titles=File('tool/all_chapter_titles.txt').readAsLinesSync();
  int total=0,xl=0;
  for(final lang in langs){
    final out=<String,String>{};
    for(final en in titles){
      String? t;
      var m=RegExp(r'^Chapter (\d+)$').firstMatch(en);
      if(m!=null){t='${w(ch,lang)} ${m.group(1)}';}
      if(t==null){m=RegExp(r'^Chapter (\d+): (\d+)$').firstMatch(en);if(m!=null)t='${w(ch,lang)} ${m.group(1)}: ${m.group(2)}';}
      if(t==null){m=RegExp(r'^Chapter (\d+): The Chronicle of \u300a$').firstMatch(en);if(m!=null)t='${w(ch,lang)} ${m.group(1)}: ${w(chr,lang)}\u300a';}
      if(t==null){m=RegExp(r'^Chapter (\d+): The Chronicle of$').firstMatch(en);if(m!=null)t='${w(ch,lang)} ${m.group(1)}: ${w(chr,lang)}';}
      if(t==null){m=RegExp(r'^Chapter (\d+): Prologue$').firstMatch(en);if(m!=null)t='${w(ch,lang)} ${m.group(1)}: ${w(pr,lang)}';}
      if(t==null){m=RegExp(r'^Chapter (\d+): (.+)$').firstMatch(en);if(m!=null)t='${w(ch,lang)} ${m.group(1)}: ${tr(m.group(2)!,lang)}';}
      if(t==null){m=RegExp(r'^Fable (\d+): (\d+\.)\s+(.+)$').firstMatch(en);if(m!=null)t='${w(fb,lang)} ${m.group(1)}: ${m.group(2)} ${tr(m.group(3)!,lang)}';}
      if(t==null){m=RegExp(r'^Fable (\d+): (\d+\.?)$').firstMatch(en);if(m!=null)t='${w(fb,lang)} ${m.group(1)}: ${m.group(2)}';}
      if(t==null){m=RegExp(r'^Part (\d+): (.+)$').firstMatch(en);if(m!=null)t='${w(pt,lang)} ${m.group(1)}: ${tr(m.group(2)!,lang)}';}
      if(t==null){m=RegExp(r'^Prologue: (.+)$').firstMatch(en);if(m!=null)t='${w(pr,lang)}: ${tr(m.group(1)!,lang)}';}
      if(t==null){m=RegExp(r'^Volume (\d+): Aphorisms (\d+)-(\d+)$').firstMatch(en);if(m!=null)t='${w(vl,lang)} ${m.group(1)}: ${w(ap,lang)} ${m.group(2)}-${m.group(3)}';}
      out[en]=t??tr(en,lang);
    }
    final fp='assets/data/l10n/chapter_titles_$lang.json';
    File(fp).writeAsStringSync(const JsonEncoder.withIndent('  ').convert(out));
    final dc=out.entries.where((e)=>e.value!=e.key).length;
    total+=out.length;xl+=dc;
    print('$lang: ${out.length} titles ($dc translated)');
  }
  print('\nTotal: $total titles across ${langs.length} languages, $xl translated');
}