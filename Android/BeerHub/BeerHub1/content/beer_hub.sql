--
-- Файл сгенерирован с помощью SQLiteStudio v3.2.1 в Сб сен 26 21:52:57 2020
--
-- Использованная кодировка текста: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Таблица: beer
DROP TABLE IF EXISTS beer;
CREATE TABLE beer (_id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, brewery_id INTEGER REFERENCES brewery (_id) NOT NULL DEFAULT (1), style_id INTEGER REFERENCES style (_id) NOT NULL DEFAULT (1), abv REAL, ibu INTEGER, craft BOOLEAN DEFAULT (0) NOT NULL, name TEXT NOT NULL, info TEXT, rating INTEGER DEFAULT (0) NOT NULL, web TEXT);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (1, 1, 2, 4.0, 22, 0, 'Staropramen Smíchov', 'Jiskrné zlatavé pivo, láká jemnou sladovou vůní a chmelovým aroma. Osvěžující čistá pivní chuť s příjemným řízem uhasí vaši žízeň.', 0, 'https://staropramen.cz/pivo/smichov');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (2, 2, 2, 4.0, 15, 0, 'Velkopopovický Kozel Světlý', 'Světlé výčepní pivo s lahodnou chutí a zářivě zlatavou barvou.', 0, 'https://www.kozel.cz/nase-pivo/');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (3, 2, 5, 3.8, 14, 0, 'Velkopopovický Kozel Černý', 'Tmavé výčepní pivo vyráběné z pečlivě vybrané směsi čtyř druhů sladů.', 0, 'https://www.kozel.cz/nase-pivo/');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (4, 2, 3, 4.6, 25, 0, 'Velkopopovický Kozel 11', 'Světlý ležák s plnější chutí tří druhů sladů a jemnou hořkostí chmele.', 0, 'https://www.kozel.cz/nase-pivo/');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (5, 2, 2, 4.8, NULL, 0, 'Velkopopovický Kozel Mistrův Ležák', 'Světlý ležák s vyjímečně bohatou chutí díky 4 druhům sladů a 3 druhům chmele.', 0, 'https://www.kozel.cz/nase-pivo/');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (6, 2, 5, 4.8, NULL, 0, 'Velkopopovický Kozel Řezaný 11', 'Řezaný ležák snoubící jemnou hořkou chuť světlého piva a karamelové tóny piva černého.', 0, 'https://www.kozel.cz/nase-pivo/');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (7, 2, 4, 4.8, 26, 0, 'Velkopopovický Kozel Florián', 'Limitovaná polotmavá 11, která od velkopopovických sládků dostala barvu s jemným červeným nádechem. V určitých měsících je k dostání v síti COOP.', 0, 'https://www.kozel.cz/nase-pivo/');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (8, 3, 6, 4.4, NULL, 0, 'Plzeňský Prazdroj', 'Jedinečný světlý plzeňský ležák se stal legendou mezi pivy a dal vzniknout zcela nové pivní kategorii (Pils, Pilsner). Jeho receptura i varní postup se od jeho vzniku v roce 1842 nezměnily. Díky umění plzeňských sládků se nemění ani jeho kvalita a jeho chuťový profil. To ostatně prokazují pravidelná laboratorní srovnání, z nichž nejstarší se datuje do roku 1897.', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (9, 3, 6, 4.4, NULL, 0, 'Plzeňský Prazdroj "Hladinka"', 'Jedinečný světlý plzeňský ležák se stal legendou mezi pivy a dal vzniknout zcela nové pivní kategorii (Pils, Pilsner). Jeho receptura i varní postup se od jeho vzniku v roce 1842 nezměnily. Díky umění plzeňských sládků se nemění ani jeho kvalita a jeho chuťový profil. To ostatně prokazují pravidelná laboratorní srovnání, z nichž nejstarší se datuje do roku 1897.

Hladinka je nejčastější způsob čepování piva. Jeho základem je čepování na jeden zátah tak, aby se na konci vytvořila mokrá krémovitá pěna, která nebude přesahovat okraj sklenice.

Půllitry musejí být vždy vychlazené na teplotu piva, čisté a hlavně ještě mokré!', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (10, 3, 6, 4.4, NULL, 0, 'Plzeňský Prazdroj "Mlíko"', 'Jedinečný světlý plzeňský ležák se stal legendou mezi pivy a dal vzniknout zcela nové pivní kategorii (Pils, Pilsner). Jeho receptura i varní postup se od jeho vzniku v roce 1842 nezměnily. Díky umění plzeňských sládků se nemění ani jeho kvalita a jeho chuťový profil. To ostatně prokazují pravidelná laboratorní srovnání, z nichž nejstarší se datuje do roku 1897.

Jako mlíko označujeme půlitr husté, krémové pěny. Jde o způsob čepování piva, který je oblíbený hlavně u žen. Mlíko je totiž oproti hladince nebo šnytu nasládlejší.

Půllitry musejí být vždy vychlazené na teplotu piva, čisté a hlavně ještě mokré!', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (11, 3, 6, 4.4, NULL, 0, 'Plzeňský Prazdroj "Šnyt"', 'Jedinečný světlý plzeňský ležák se stal legendou mezi pivy a dal vzniknout zcela nové pivní kategorii (Pils, Pilsner). Jeho receptura i varní postup se od jeho vzniku v roce 1842 nezměnily. Díky umění plzeňských sládků se nemění ani jeho kvalita a jeho chuťový profil. To ostatně prokazují pravidelná laboratorní srovnání, z nichž nejstarší se datuje do roku 1897.

Šnyt je menší míra piva s větším podílem krémovité pěny. Právě silná vrstva pěny dodává pivu jemnější říz a uchovává jej delší dobu čerstvé. Proto je šnyt vhodný jako koštovací pivo pro výčepní nebo také ideální volbou pro ty, kteří už nemají chuť nebo čas na velké pivo.

Půllitry musejí být vždy vychlazené na teplotu piva, čisté a hlavně ještě mokré!', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (12, 1, 2, 4.7, 26, 0, 'Staropramen Jedenáctka', 'Zlatavě-jantarová připravená z kombinace 7 druhů chmelů a 3 druhů sladů. Vyvážená chuť s vyladěnou výraznější hořkostí.', 0, 'https://staropramen.cz/pivo/jedenactka');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (13, 1, 3, 5.0, 27, 0, 'Staropramen Ležák', 'Poctivě prokvašený ležák v sobě snoubí harmonii sladu z polabského ječmene, českých aromatických a německých hořkých chmelů.', 0, 'https://staropramen.cz/pivo/lezak');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (14, 1, 5, 4.4, 25, 0, 'Staropramen Černý', 'Tmavý ležák bavorského typu s plnou nasládlou karamelovou příchutí a jemnou chmelovou hořkostí.', 0, 'https://staropramen.cz/pivo/cerny');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (15, 1, 2, 0.49, 25, 0, 'Staropramen Nealko', 'Hořké nealkoholické pivo s nezaměnitelnou sladovou chutí a vůní. Vychází z tradiční české technologie - řízeného kvašení.', 0, 'https://staropramen.cz/pivo/nealko');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (16, 1, 1, 4.0, NULL, 0, 'Staropramen Déčko', 'Tradiční pivo se sníženým obsahem cukrů. Vhodné pro diabetiky a pro  lidi  trpící poruchami zažívání.', 0, 'https://staropramen.cz/pivo/decko');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (17, 1, 2, 5.0, 18, 0, 'Staropramen Nefiltr Pšeničný', 'Charakteristický Nefiltr v sobě spojuje tradici českého ležáku s německým a belgickým pšeničným sladem, koriandrem a ovocnými tóny.', 0, 'https://staropramen.cz/pivo/nefiltr-psenicny');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (18, 1, 3, 5.2, NULL, 0, 'Staropramen Extra Chmelená', 'Opravdu hořká dvanáctka, která získala svou výraznou chuť díky pětinásobnému chmelení za použití žateckého poloraného červeňáku.', 0, 'https://staropramen.cz/pivo/extra-chmelena');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (19, 1, 4, 4.8, 26, 0, 'Staropramen Granát', 'Vybroušený polotmavý ležák s granátovou barvou, který je daný kombinací světlého, bavorského a karamelového sladu.', 0, 'https://staropramen.cz/pivo/granat');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (20, 1, 4, 5.1, NULL, 0, 'Staropramen Velvet', 'Pivo se sametovou chutí, hustou krémovou pěnou a jemně nahořklými tóny následovanými karamelovým dozníváním.', 0, 'https://staropramen.cz/pivo/velvet');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (21, 4, 5, 5.0, NULL, 0, 'Flekovský Ležák', 'Flekovský tmavý 13° ležák vyrábíme z vody, chmele a čtyř druhů ječmenného sladu. Nepoužíváme žádné konzervační přípravky ani umělá barviva. Všechny suroviny jsou z ČR. ', 0, 'https://ufleku.cz/');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (22, 3, 6, 4.4, NULL, 0, 'Plzeňský Prazdroj 12°', 'Výborný plzeňský dvanáctistupňový ležák (ke kterému přes veškerou snahu nedostanete “kořalku”).', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (23, 5, 6, NULL, NULL, 0, 'Světlý Speciál', 'Spodně kvašené pivo plzeňského typu. K vaření světlého ležáku používáme nejkvalitnější české suroviny a tradiční postup výroby.', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (24, 5, 4, NULL, NULL, 1, 'Vídeňské Červené', 'Dobře vyleželé kvalitní pivo s jemnou vůní vídeňského sladu se zabarvením do červena. Má vyrovnanou chuť s lehkým chmelovým dozníváním a svěžím závěrem.', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (25, 5, 5, NULL, NULL, 0, 'Tmavý Speciál', 'Spodně kvašený speciál vařený z více druhů sladu a žateckého chmele. Pivo je temné barvy a má jemné chmelové aroma.', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (26, 5, 9, NULL, NULL, 1, 'Triple Hopped IPA', 'Silné speciální pivo vařené v britském stylu.
Pro pivo je charakteristická vyšší hořkost, klasická sladovost a výrazné chmelové aroma.', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (27, 5, 2, NULL, NULL, 1, 'Dunkel Weiss Starobavorské pivo', 'Polotmavé pivo bavorskeho typu Dunkels. Jako takové, vyrobeno podle starobylého originálního receptu. Pšeničny speciál ma nízkou hořkost, polotmavou barvu a sladovou chuť.', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (28, 5, 1, NULL, NULL, 1, 'Klášterní Speciál Sv. Jiljí № 4', 'Klášterní pivo Sv. Jiljí No.4, je zlatavá obdoba původního tmavého Klášterního speciálu. Pivo je po běžném chmelovaru ještě dochmelováno za studena.', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (29, 6, 2, NULL, NULL, 0, 'Světlá Kočka', 'Světlé pivo minipivovary U Dvou koček.', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (30, 6, 5, NULL, NULL, 0, 'Tmavá Kočka', 'Tmavé pivo minipivovary U Dvou koček.', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (31, 7, 4, 5.3, NULL, 1, 'Sv. Norbert polotmavý', 'Naše pivo Sv. Norbert, pojmenované podle zakladatele řádu premonstrátů, jež sídlí ve Strahovském klášteře, je vyráběno pouze z přírodních surovin – vody, sladu, chmele a kvasnic. Plně tedy respektujeme letitý zákon o čistotě piva - Reinheitsgebot z roku 1516. V našem pivu proto nenajdete žádné chmelové extrakty ani cukr, pivo je nepasterováno a nefiltrováno. Ponecháváme v pivu vše, co je dobré. Sv. Norbert obsahuje zbytkové pivovarské kvasnice s obsahem vitamínu B.', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (32, 7, 5, 5.5, NULL, 1, 'Sv. Norbert dark', 'Naše pivo Sv. Norbert, pojmenované podle zakladatele řádu premonstrátů, jež sídlí ve Strahovském klášteře, je vyráběno pouze z přírodních surovin – vody, sladu, chmele a kvasnic. Plně tedy respektujeme letitý zákon o čistotě piva - Reinheitsgebot z roku 1516. V našem pivu proto nenajdete žádné chmelové extrakty ani cukr, pivo je nepasterováno a nefiltrováno. Ponecháváme v pivu vše, co je dobré. Sv. Norbert obsahuje zbytkové pivovarské kvasnice s obsahem vitamínu B.', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (33, 7, 9, 6.3, NULL, 1, 'Sv. Norbert IPA', 'Naše pivo Sv. Norbert, pojmenované podle zakladatele řádu premonstrátů, jež sídlí ve Strahovském klášteře, je vyráběno pouze z přírodních surovin – vody, sladu, chmele a kvasnic. Plně tedy respektujeme letitý zákon o čistotě piva - Reinheitsgebot z roku 1516. V našem pivu proto nenajdete žádné chmelové extrakty ani cukr, pivo je nepasterováno a nefiltrováno. Ponecháváme v pivu vše, co je dobré. Sv. Norbert obsahuje zbytkové pivovarské kvasnice s obsahem vitamínu B.', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (34, 8, 2, 4.2, 24, 0, 'Krušovice Královská 10°', 'Vzpomenete si, kdy jste si naposledy pochutnali na poctivě uvařené, pořádné české desítce? Sládci z Krušovic pochopili, že do české hospody pravá desítka prostě patří. A uvařili ji tak, jak ji před nimi vařili celé generace těch mimořádně nadaných pivovarnických mistrů, na něž měla naše země vždycky štěstí.

Krušovice Desítka je výborně pitelné pivo, které se vyznačuje čirou zlatou barvou a krémovou pěnou. Chuť a vůni ji dodávají tři druhy ječných sladů z vybraných odrůd kvalitního českého a moravského ječmene. Díky žateckému chmelu má příjemně vyznívající hořkost.

Skvěle se pije a osvěží při všech myslitelných příležitostech.

Kombinace s pokrmy: Pečené maso, žebra, utopenci, velmi dobře jde s nakládaným sýrem nebo ještě lépe se zrajícími sýry.', 0, 'https://krusovice.cz/nase-piva/rizna-10');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (35, 8, 3, 5.0, 29, 0, 'Krušovice Královská 12°', 'Je královskou volbou mezi krušovickými pivy. Dlouho doznívající, výrazná hořkost, plná sladová chuť i vůně a sytě zlatá barva, to jsou vlastnosti excelentního ležáku českého typu. Kdo má rád hořká piva, je Královská 12 přímo pro něj.

Doporučení k pokrmům: Vepřová pečená masa, středně přezrálý sýr z kravského nebo ovčího mléka.', 0, 'https://krusovice.cz/nase-piva/kralovska-12');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (36, 8, 5, 3.8, 19, 0, 'Krušovice Černé', 'Pivo Krušovice Černé je tradičním výrobkem krušovického pivovaru již více než sto let a jeho výroba nebyla nikdy přerušena. Je dlouhodobě nejoceňovanějším tmavým pivem ve střední Evropě a nedají na něj dopustit ti, kdo mají rádi speciální, chuťově výrazná a přitom osvěžující piva.

Krušovice Černé se vyznačuje plností, výraznou karamelovou chutí s tóny pražené kávy, jemnou chmelovou hořkostí. Nositelem výborných chuťových vlastností jsou vedle kvalitní pramenité vody z křivoklátských lesů a chmele ze žatecké chmelařské oblasti také speciální druhy ječných sladů - český, barevný, karamelový a mnichovský. Ty dodávají pivu jeho typicky tmavou barvu. Pivo se proto může používat jako skvělá ingredience k vaření, kdy jídlu dodává rafinovanou chuť. A co je důležité, nenajdete v něm žádná barviva ani doslazovadla.

Kombinace s pokrmy: Uzené maso, uzené ryby, žebra marinovaná v černém pivu, buřty na pivu, dále pak sladké dezerty s kávovou nebo čokoládovou chutí.', 0, 'https://krusovice.cz/nase-piva/cerne');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (37, 8, 2, 4.3, 15, 0, 'Krušovice Pšenicne', 'Zavedením pšeničného piva do svého portfolia obnovil Královský pivovar Krušovice v Čechách tradici vaření pšeničných svrchně kvašených piv, která u nás převládala až do poloviny 19. Století, než je vytlačily světlé ležáky.', 0, 'https://krusovice.cz/nase-piva/psenicne');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (38, 8, 2, 4.8, '', 0, 'Krušovice Mušketýr 11°', 'Chuťově plná a zároveň skvěle pitelná jedenáctka s charakteristickou hořkostí českého chmele odrůd Premiant a Žatecký poloraný červeňák. Vyšší plnost a hutnou pěnu jí dodávají čtyři druhy sladů - český, mnichovský, karamelový a pšeničný.

Doporučení k pokrmům: Tradiční české pokrmy, jako jsou guláš, vepřový řízek, hovězí steak nebo nakládaný sýr.', 0, 'https://krusovice.cz/nase-piva/k11');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (39, 8, 5, NULL, NULL, 0, 'Krušovice Řezané 11°', NULL, 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (40, 9, 2, NULL, NULL, 1, 'Malostranský Ležák', 'Tradiční světlé pivo vařené podle klasické české receptury. Tři druhy sladu dávají pivu vyváženou zaoblenou chuť a dva druhy chmele příjemnou hořkost a čerstvost s kořeněnou bylinnou vůní.', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (41, 9, 4, NULL, NULL, 1, 'Rubín', 'Plno sladový polotmavý Ležák s karamelovou chutí a nižší hořkostí. Patři k zástupcům piv označených jako "Vienna styl".

', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (42, 9, 5, NULL, NULL, 1, 'Tmavý speciál "Černý Havran"', 'Tmavé pivo se zvýrazněnou karamelově čokoládovou chutí pražené sladu a kávy. Povedená harmonie chutí a vůní sladkého sladu, měkké hořkosti a sušeného ovoce.', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (43, 9, 9, NULL, NULL, 1, 'Amarillo New England IPA', 'Svrchně kvašené pivo uvařeno za využití technologie „Dry hopping“, při výrobě byl použit americký chmel Amarillo, který dal pivu chuť po tropickém ovoci.', 0, NULL);
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (44, 10, 3, 4.9, NULL, 0, 'Bakalář Světlý Ležák', 'Oblíbený ležák plné chuti, vařený podle tradiční receptury. Vyznačuje se chmelovou hořkostí, zlatou barvou a bohatou pěnou. Obsah alkoholu: 4,9% obj.', 0, 'http://www.pivobakalar.cz/?i=1');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (45, 10, 2, 4.0, NULL, 0, 'Bakalář Světlé Výčepní', 'Příjemně hořké pivo vyvážené chuti a zlaté barvy. Obsah alkoholu: 4,0 % obj.', 0, 'http://www.pivobakalar.cz/?i=1');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (46, 10, 5, 3.8, NULL, 0, 'Bakalář Tmavé Výčepní', 'Plné pivo temné barvy s výraznou chmelovou hořkostí. Obsah alkoholu: 3,8% obj.', 0, 'http://www.pivobakalar.cz/?i=1');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (47, 10, 4, 4.5, NULL, 0, 'Bakalář Řezané Výčepní', 'Plnější pivo rubínové barvy, s jemnou příchutí karamelu a nádechem chmelové hořkosti. Obsah alkoholu: 4,5% obj.', 0, 'http://www.pivobakalar.cz/?i=1');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (48, 10, 11, 5.2, NULL, 0, 'Bakalář Světlý Ležák za Studena Chmelený', 'Nezaměnitelné pivo s vyšší původní stupňovitostí, charakteristické nádherným aroma sušených chmelových hlávek Žateckého poloraného červeňáku a sytou barvou s temně zlatými odlesky. Obsah alkoholu : 5,2% obj.', 0, 'http://www.pivobakalar.cz/?i=1');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (49, 10, 11, 5.8, NULL, 0, 'Bakalář Medový Speciál', 'Speciální světlé pivo bohaté chuti, s nádechem chmelové hořkosti a doznívajícím podtónem lesního medu. Obsah alkoholu : 5,8% obj.', 0, 'http://www.pivobakalar.cz/?i=1');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (50, 10, 2, 0.5, NULL, 0, 'Bakalář Nealkoholické za Studena Chmelený', 'Jediné nealkoholické pivo za studena chmelené. Jeho vyvážená chuť je dána dokonalým spojením sladového základu vařeného s vysoce kvalitním chmelem a sušených chmelových hlávek Žateckého poloraného červeňáku, které jsou v pivu macerovány po celou dobu ležení a dodávají nealkoholickému pivu nezaměnitelnou a ničím nenahraditelnou vůni a chuť. Obsah alkoholu: max. 0,5 % obj.', 0, 'http://www.pivobakalar.cz/?i=1');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (51, 10, 2, 4.5, NULL, 0, 'Bakalář 11° Světlý Ležák', 'Plnější pivo zlatavé barvy a vyrovnané chuti s příjemnými dozvuky chmelové hořkosti. Obsah alkoholu: 4,5% obj.', 0, 'http://www.pivobakalar.cz/?i=1');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (52, 10, 3, 4.9, NULL, 0, 'Černovar Světlý Ležák', 'Klasický český světlý ležák sytě zlaté barvy, dokonale vyvážené plné chuti se zřetelným dozvukem chmelové hořkosti a jemnou chmelovou vůní. Obsah alkoholu 4,9% obj.', 0, 'http://www.pivobakalar.cz/?i=1&TARG=cernovar');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (53, 10, 5, 4.5, NULL, 0, 'Černovar Tmavý Ležák', 'Klasický český tmavý ležák s bohatou chutí. Je dána speciální kombinací čtyř druhů sladu, které pivu dávají také plnost a výjimečnou karamelovou chuť a vůni. Příjemná hořkost a bohatá stabilní pěna dotvářejí jedinečný charakter piva. Obsah alkoholu: 4,5% obj.
', 0, 'http://www.pivobakalar.cz/?i=1&TARG=cernovar');
INSERT INTO beer (_id, brewery_id, style_id, abv, ibu, craft, name, info, rating, web) VALUES (54, 10, 2, 4.0, NULL, 0, 'Pražačka Světlé Výčepní', 'Tradiční české světlé pivo nižší stupňovitosti, svěží chuti a světle zlaté barvy, s příjemnou vůní a jemnou hořkostí. Obsah alkoholu: 4,0% obj.', 0, 'http://www.pivobakalar.cz/?i=1&TARG=prazacka');

-- Таблица: beer_brand
DROP TABLE IF EXISTS beer_brand;
CREATE TABLE beer_brand (_id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, name TEXT NOT NULL, brewery_id INTEGER REFERENCES brewery (_id) NOT NULL DEFAULT (- 1));
INSERT INTO beer_brand (_id, name, brewery_id) VALUES (1, 'Staropramen', 1);
INSERT INTO beer_brand (_id, name, brewery_id) VALUES (2, 'Velkopopovický Kozel', 2);
INSERT INTO beer_brand (_id, name, brewery_id) VALUES (3, 'Plzeňský Prazdroj', 3);
INSERT INTO beer_brand (_id, name, brewery_id) VALUES (4, 'Krušovice', 8);
INSERT INTO beer_brand (_id, name, brewery_id) VALUES (5, 'Bakalář', 10);
INSERT INTO beer_brand (_id, name, brewery_id) VALUES (6, 'Černovar', 10);
INSERT INTO beer_brand (_id, name, brewery_id) VALUES (7, 'Pražačka', 10);

-- Таблица: beer_place
DROP TABLE IF EXISTS beer_place;
CREATE TABLE beer_place (_id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, place_id INTEGER REFERENCES place (_id) NOT NULL DEFAULT (1), beer_id INTEGER REFERENCES beer (_id) NOT NULL DEFAULT (1), serving_id INTEGER REFERENCES serving (_id) DEFAULT (2) NOT NULL);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (1, 1, 9, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (2, 1, 10, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (3, 1, 11, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (4, 2, 9, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (5, 2, 10, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (6, 2, 11, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (7, 3, 9, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (8, 3, 10, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (9, 3, 11, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (10, 4, 9, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (11, 4, 10, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (12, 4, 11, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (13, 5, 9, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (14, 5, 10, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (15, 5, 11, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (16, 1, 8, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (17, 2, 8, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (18, 3, 8, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (19, 4, 8, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (20, 5, 8, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (21, 6, 8, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (22, 6, 9, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (23, 6, 10, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (24, 6, 11, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (25, 7, 21, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (26, 8, 22, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (27, 9, 23, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (28, 9, 24, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (29, 9, 25, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (30, 9, 26, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (31, 9, 27, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (32, 9, 28, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (33, 10, 29, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (34, 10, 30, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (35, 11, 31, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (36, 11, 32, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (37, 11, 33, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (38, 12, 2, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (39, 12, 3, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (40, 12, 8, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (41, 13, 12, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (42, 13, 19, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (43, 13, 17, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (44, 13, 18, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (45, 13, 15, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (46, 14, 12, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (47, 14, 17, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (48, 14, 20, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (49, 14, 15, 2);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (50, 15, 14, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (51, 15, 20, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (52, 15, 19, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (53, 15, 17, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (54, 15, 18, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (55, 15, 15, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (56, 15, 12, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (57, 15, 1, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (58, 16, 19, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (59, 16, 20, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (60, 16, 14, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (61, 16, 12, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (62, 16, 17, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (63, 16, 1, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (64, 17, 17, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (65, 17, 1, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (66, 17, 18, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (67, 17, 12, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (68, 17, 19, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (69, 17, 15, 2);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (70, 18, 17, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (71, 18, 1, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (72, 18, 12, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (73, 18, 15, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (74, 19, 17, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (75, 19, 15, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (76, 19, 12, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (77, 20, 38, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (78, 20, 36, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (79, 20, 39, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (80, 21, 8, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (81, 22, 4, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (82, 22, 3, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (83, 22, 2, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (84, 22, 6, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (85, 22, 5, 3);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (86, 23, 8, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (87, 24, 2, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (88, 24, 3, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (89, 38, 40, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (90, 38, 41, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (91, 38, 42, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (92, 38, 43, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (93, 41, 44, 1);
INSERT INTO beer_place (_id, place_id, beer_id, serving_id) VALUES (94, 41, 47, 1);

-- Таблица: beer_tr
DROP TABLE IF EXISTS beer_tr;
CREATE TABLE beer_tr (_id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, beer_id INTEGER REFERENCES beer (_id) NOT NULL, locale INTEGER REFERENCES locale (code) NOT NULL, name TEXT, info TEXT);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (1, 1, 'en_US', 'Staropramen Smichov', 'Sparkling Golden beer, attracts a subtle malt aroma and aroma of hops. Refreshing clean taste of beer with a pleasant aroma perfectly quenches thirst.
');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (2, 1, 'ru_RU', 'Старопрамен Смихов', 'Искрящееся золотистое пиво, привлекает тонким солодовым ароматом и ароматом хмеля. Освежающий чистый вкус пива с приятным ароматом отлично утоляет жажду.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (3, 1, 'cs_rCZ', 'Staropramen Smíchov', 'Jiskrné zlatavé pivo, láká jemnou sladovou vůní a chmelovým aroma. Osvěžující čistá pivní chuť s příjemným řízem uhasí vaši žízeň.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (4, 2, 'ru_RU', 'Козел Светлый', 'Легкое светлое пиво с восхитительным вкусом и ярким золотистым цветом.

Если вы любите пивные эксперименты, это пиво можно сочетать с темным пивом Козел, смешивая в пропоцриях 1:1. Таким образом можно получить знаменитое резаное пиво с карамельным вкусом и солодовым оттенком.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (5, 3, 'ru_RU', 'Козел Темный', 'Темное пиво, приготовленное из тщательно отобранной смеси четырех видов солода.

Если вы любите пивные эксперименты, это пиво можно сочетать со светлым пивом Козел, смешивая в пропоцриях 1:1. Таким образом можно получить знаменитое резаное пиво с карамельным вкусом и солодовым оттенком.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (6, 4, 'ru_RU', 'Козел 11', 'Легкое светлое пиво с более полным вкусом трех видов солода и тонкой горечью хмеля.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (7, 5, 'ru_RU', 'Козел Мастер Лагер', 'Cветлое пиво с исключительно насыщенным вкусом благодаря четырем видам солода и трем видам хмеля.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (8, 6, 'ru_RU', 'Козел Резаный', 'Резанное (смешанное светлое и темное) пиво сочетает в себе тонкий горьковатый вкус светлого пива и карамельные ноты темного пива Козел.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (9, 7, 'ru_RU', 'Козел Флориан', 'Ограниченное полутемное пиво с красноватым оттенком и плотностью 11°. Пиво доступно в сети COOP только в определенные месяцы.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (10, 2, 'en_US', 'Kozel Light', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (11, 3, 'en_US', 'Kozel Dark', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (12, 4, 'en_US', 'Kozel 11', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (13, 5, 'en_US', 'Kozel Master Lager', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (14, 7, 'en_US', 'Kozel Florian', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (15, 8, 'ru_RU', 'Пилснер Урквел', 'Пилснер Урквел (Plzeňský Prazdroj) - светлое Пльзеньское пиво, которое стало легендой и породило совершенно новую категорию (сорт) - Pils, Pilsner. Его рецепт и процесс приготовления не изменились с момента его создания в 1842 году. Пиво имеет насыщенный вкус, интенсивную горечь и характерный хмельной аромат.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (16, 9, 'ru_RU', 'Пилснер Урквел "Гладинка"', 'Пилснер Урквел (Plzeňský Prazdroj) - светлое Пльзеньское пиво, которое стало легендой и породило совершенно новую категорию (сорт) - Pils, Pilsner. Его рецепт и процесс приготовления не изменились с момента его создания в 1842 году. Пиво имеет насыщенный вкус, интенсивную горечь и характерный хмельной аромат.

Гладинка (Hladinka) - самый распространенный способ разлива пива. Он заключается в одинарном нажатии на кран так, чтобы в конце получился не очень большой слой сливочной пены, которая не выходит за края кружки.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (17, 10, 'ru_RU', 'Пилснер Урквел "Молоко"', 'Пилснер Урквел (Plzeňský Prazdroj) - светлое Пльзеньское пиво, которое стало легендой и породило совершенно новую категорию (сорт) - Pils, Pilsner. Его рецепт и процесс приготовления не изменились с момента его создания в 1842 году. Пиво имеет насыщенный вкус, интенсивную горечь и характерный хмельной аромат.

В качестве Молока (Mlíko) мы обозначаем пол-литра густой, сливочной пены. Это метод разливного пива, особенно популярен среди женщин. Молоко более сладкое по сравнению с Гладинкой (Hladinka) или Улиткой (Šnyt).');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (18, 11, 'ru_RU', 'Пилснер Урквел "Улитка"', 'Пилснер Урквел (Plzeňský Prazdroj) - светлое Пльзеньское пиво, которое стало легендой и породило совершенно новую категорию (сорт) - Pils, Pilsner. Его рецепт и процесс приготовления не изменились с момента его создания в 1842 году. Пиво имеет насыщенный вкус, интенсивную горечь и характерный хмельной аромат.

Улитка (Šnyt) - это меньшая доля пива с большей долей сливочной пены. Именно толстый слой пены придает пиву более тонкую изюминку и дольше сохраняет свежесть.
');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (19, 8, 'en_US', 'Pilsner Urquell', 'This legendary pale Pilsen lager has become a legend amongst beers, and has created a completely new category of beer (Pils, Pilsner). Neither the recipe nor the brewing process has changed since it was first made in 1842.
');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (20, 9, 'en_US', 'Pilsner Urquell "Level"', 'This legendary pale Pilsen lager has become a legend amongst beers, and has created a completely new category of beer (Pils, Pilsner). Neither the recipe nor the brewing process has changed since it was first made in 1842.

The Level (Hladinka) is the most common way of tapping beer. Its basis is tapping on one pull so that a wet creamy foam forms at the end, which will not go beyond the edge of the jar.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (21, 10, 'en_US', 'Pilsner Urquell "Milk"', 'This legendary pale Pilsen lager has become a legend amongst beers, and has created a completely new category of beer (Pils, Pilsner). Neither the recipe nor the brewing process has changed since it was first made in 1842.

As Milk (Mlíko), we mark a half-liter of thick, creamy foam. This is a way of tapping beer, which is popular mainly with women. Because the milk is sweeter than the Level (Hladinka) or Snail (Šnyt).');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (22, 11, 'en_US', 'Pilsner Urquell "Snai"', 'This legendary pale Pilsen lager has become a legend amongst beers, and has created a completely new category of beer (Pils, Pilsner). Neither the recipe nor the brewing process has changed since it was first made in 1842.

Snail (Šnyt) is a smaller measure of beer with a larger proportion of creamy foam. It is the thick layer of foam that gives the beer a softer rim and keeps it fresh for a long time. Therefore, the snail is suitable as a broom beer for takeout, or also an ideal option for those who no longer have a taste or time for a large beer.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (23, 12, 'ru_RU', 'Старопрамен 11', 'Золотисто-янтарный лагер, приготовленный из комбинации 7 видов хмеля и 3 видов солода. Сбалансированный вкус с более выраженной горечью.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (24, 12, 'en_US', 'Staropramen 11', '');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (25, 13, 'ru_RU', 'Старопрамен Лежак', 'Светлое пиво, которое сочетает в себе гармонию солода из полабского ячменя, чешского ароматного и немецкого горького хмеля.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (26, 13, 'en_US', 'Staropramen Premium', 'A light beer that combines the harmony of malt from polabian barley, Czech aromatic and German bitter hops.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (27, 14, 'ru_RU', 'Старопрамен Темный', 'Темное пиво баварского типа с полным сладковатым карамельным вкусом и тонкой хмелевой 
горечью.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (28, 14, 'en_US', 'Staropramen Dark', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (29, 15, 'ru_RU', 'Старопрамен Безалкогольное', 'Горькое безалкогольное пиво с безошибочным солодовым вкусом и ароматом. Он основан на 
традиционной чешской технологии-контролируемой ферментации.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (30, 15, 'en_US', 'Staropramen Alcohol Free', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (31, 17, 'ru_RU', 'Старопрамен Нефильтрованное Пшеничное', 'Характеристики этого пива сочетают в себе традиции чешского лагера с немецким и бельгийским пшеничным солодом, кориандром и фруктовыми нотами.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (32, 17, 'en_US', 'Staropramen Unfiltered Wheat', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (33, 18, 'ru_RU', 'Старопрамен 12', 'Старопрамен Экстра Хмель (Extra Chmelená) - действительно горький двенадцать, который приобрел свой особый вкус благодаря пятикратному охмелению с использованием жатецкого полуранного румянца.
');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (34, 18, 'en_US', 'Staropramen 12', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (35, 19, 'ru_RU', 'Старопрамен Гранат', 'Гранат (Granát) - полутемный лагер (13) с гранатовым цветом, в котором сочетается легкость Баварского и карамельного солода.
');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (36, 19, 'en_US', 'Staropramen Garnet', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (37, 20, 'ru_RU', 'Старопрамен Вельвет', 'Пиво с бархатистым вкусом, густой сливочной пеной и тонко горьковатыми нотками с 
последующим карамельным послевкусием.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (38, 20, 'en_US', 'Staropramen Velvet', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (39, 21, 'ru_RU', 'Флековский Лежак', 'Специальное темное пиво, "Флековский Лагер", с 13% экстракта и 5% алкоголя. Пиво производится из воды, хмеля, дрожжей и четырех видов ячменного солода, без консервантов и искусственных красителей.

 ');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (40, 21, 'en_US', 'Flekov Lager', 'The U Fleků dark lager is brewed using purely natural ingredients – water, hops, yeast and four kinds of barley malt. We use no artificial colours and preservatives.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (41, 22, 'ru_RU', 'Пилснер Урквел 12°', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (42, 22, 'en_US', 'Pilsner Urquell 12°', 'The excellent twelve-degree Pilsner lager (despite all the efforts you cannot get the "distillates" to drink with).');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (43, 22, 'de_DE', 'Pilsner Urquell 12°', 'Hervorragendes Pilsener Lagerbier mit zwölf Grad Stammwürze (zu dem Sie trotz aller Mühe keinen „Schnaps“ bekommen).');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (44, 23, 'ru_RU', 'Светлый лагер', 'Светлое пиво плзеньского типа, низового брожения, приготовленное по традиционной технологии с использованием лучшего чешского солода и хмеля.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (45, 23, 'en_US', 'Lager', 'Bottom-fermented pilsner beer. We use highest quality Czech ingredients and traditional recipe.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (46, 23, 'cs_rCZ', 'Světlý Speciál', 'Spodně kvašené pivo plzeňského typu. K vaření světlého ležáku používáme nejkvalitnější české suroviny a tradiční postup výroby.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (47, 24, 'ru_RU', 'Венское Красное', 'Специальное красное пиво, сваренное из венского и карамелизированного солода и специального сорта хмеля. Свежий сбалансированный вкус с мягким хмелевым послевкусием.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (48, 24, 'en_US', 'Vienna Red', 'Quality beer with a delicate aroma of Vienna malt with reddish tone and special balanced fullness and fresh finish.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (49, 24, 'cs_rCZ', 'Vídeňské Červené', 'Dobře vyleželé kvalitní pivo s jemnou vůní vídeňského sladu se zabarvením do červena. Má vyrovnanou chuť s lehkým chmelovým dozníváním a svěžím závěrem.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (50, 25, 'ru_RU', 'Темный Лагер', 'Темное пиво низового брожения, приготовленное из нескольких сортов солода и знаменитого жатецкого хмеля. Пиво отличается насыщенным шоколадным цветом и тонким хмелевым ароматом.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (51, 25, 'en_US', 'Dark Lager', 'Bottom-fermented dark beer prepared by five kinds of malt and well-known Saaz hops. Beer has a strong chocolate color and delicate hop flavor.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (52, 25, 'cs_rCZ', 'Tmavý Speciál', 'Spodně kvašený speciál vařený z více druhů sladu a žateckého chmele. Pivo je temné barvy a má jemné chmelové aroma.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (53, 26, 'ru_RU', 'Triple Hopped IPA', 'Крепкое специальное пиво, сваренное в британском стиле. Пиво характеризуется повышенной горечью, классической солодовостью и
отчетливым хмелевым ароматом.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (54, 26, 'en_US', 'Triple Hopped IPA', 'Strong special beer brewed in British style.
Beer is characterized by higher bitterness, classical maltiness and a distinct hop aroma.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (55, 26, 'cs_rCZ', 'Triple Hopped IPA', 'Silné speciální pivo vařené v britském stylu.
Pro pivo je charakteristická vyšší hořkost, klasická sladovost a výrazné chmelové aroma.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (56, 27, 'ru_RU', 'Старобаварское пиво', 'Пиво, приготовленное по старинному рецепту, в стиле баварского «Данкель». Специальное пшеничное пиво насыщенного цвета, с легкой горчинкой и ярким солодовым вкусом.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (57, 27, 'en_US', 'Old Bavarian beer', 'The bavarian type beer Dunkels prepared on the ancient recipe. Wheat special beer has low bitterness, distinctive semidark color and malty flavor.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (58, 27, 'cs_rCZ', 'Dunkel Weiss Starobavorské pivo', 'Polotmavé pivo bavorskeho typu Dunkels. Jako takové, vyrobeno podle starobylého originálního receptu. Pšeničny speciál ma nízkou hořkost, polotmavou barvu a sladovou chuť.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (59, 28, 'ru_RU', 'Mонастырское пиво Св. Ильи № 4', 'Монастырское пиво Св. Ильи №4, золотой аналог нашего традиционного темного выдержанного монастырского пива, проходит дополнительным процессом холодного дохмеления.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (60, 28, 'en_US', 'Monastic Special of St. Giles № 4', 'Monastic beer St. Giles No.4 is the golden period of the original dark Monastic special. Beer has distinctive hoppy tones in a combination of coriander and citrus.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (61, 28, 'cs_rCZ', 'Klášterní Speciál Sv. Jiljí № 4', 'Klášterní pivo Sv. Jiljí No.4, je zlatavá obdoba původního tmavého Klášterního speciálu. Pivo je po běžném chmelovaru ještě dochmelováno za studena.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (62, 2, 'cs_rCZ', 'Velkopopovický Kozel Světlý', 'Světlé výčepní pivo s lahodnou chutí a zářivě zlatavou barvou.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (63, 3, 'cs_rCZ', 'Velkopopovický Kozel Černý', 'Tmavé výčepní pivo vyráběné z pečlivě vybrané směsi čtyř druhů sladů.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (64, 4, 'cs_rCZ', 'Velkopopovický Kozel 11', 'Světlý ležák s plnější chutí tří druhů sladů a jemnou hořkostí chmele.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (65, 5, 'cs_rCZ', 'Velkopopovický Kozel Mistrův Ležák', 'Světlý ležák s plnějším tělem a vyšším podílem karamelových sladů.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (66, 6, 'cs_rCZ', 'Velkopopovický Kozel Řezaný 11', 'Řezaný ležák snoubící jemnou hořkou chuť světlého piva a karamelové tóny piva černého.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (67, 7, 'cs_rCZ', 'Velkopopovický Kozel Florián', 'Limitovaná polotmavá 11, která od velkopopovických sládků dostala barvu s jemným červeným nádechem. V určitých měsících je k dostání v síti COOP.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (68, 29, 'ru_RU', 'Кошка Светлое', 'Светлое пиво сваренное на мини пивоварни У Двух кошек.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (69, 29, 'en_US', 'Světlá Kočka', 'Světlé pivo minipivovary U Dvou koček.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (70, 29, 'cs_rCZ', 'Světlá Kočka', 'Světlé pivo minipivovary U Dvou koček.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (71, 30, 'ru_RU', 'Кошка Темное', 'Темное пиво сваренное на мини пивоварни У Двух кошек.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (72, 30, 'en_US', 'Tmavá Kočka', 'Tmavé pivo minipivovary U Dvou koček.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (73, 30, 'cs_rCZ', 'Tmavá Kočka', 'Tmavé pivo minipivovary U Dvou koček.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (74, 31, 'ru_RU', 'Sv. Norbert polotmavý', 'Пиво Sv. Norbert производится только из натуральных ингредиентов - воды, солода, хмеля и дрожжей соблюдая вековой закон о чистоте пива - Reinheitsgebot от 1516 года. Поэтому в пиве вы не найдете ни экстрактов хмеля, ни сахара, пиво непастеризованное и нефильтрованное.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (75, 31, 'en_US', 'Sv. Norbert polotmavý', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (76, 31, 'cs_rCZ', 'Sv. Norbert polotmavý', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (77, 32, 'ru_RU', 'Sv. Norbert dark', 'Пиво Sv. Norbert производится только из натуральных ингредиентов - воды, солода, хмеля и дрожжей соблюдая вековой закон о чистоте пива - Reinheitsgebot от 1516 года. Поэтому в пиве вы не найдете ни экстрактов хмеля, ни сахара, пиво непастеризованное и нефильтрованное.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (78, 32, 'en_US', 'Sv. Norbert dark', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (79, 32, 'cs_rCZ', 'Sv. Norbert dark', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (80, 33, 'ru_RU', 'Sv. Norbert IPA', 'Пиво Sv. Norbert производится только из натуральных ингредиентов - воды, солода, хмеля и дрожжей соблюдая вековой закон о чистоте пива - Reinheitsgebot от 1516 года. Поэтому в пиве вы не найдете ни экстрактов хмеля, ни сахара, пиво непастеризованное и нефильтрованное.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (81, 33, 'en_US', 'Sv. Norbert IPA', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (82, 33, 'cs_rCZ', 'Sv. Norbert IPA', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (83, 34, 'ru_RU', 'Krušovice Královská 10°', 'Krušovice Světlé (Krušovice Královská 10°) features a clear golden colour and creamy head. The taste and aroma come from using three types of malt from select varieties of high-quality Bohemian and Moravian barley. Hops give the beer a pleasant bitterness.

Krušovice Světlé is a highly drinkable and refreshing beer for any occasion.

The perfect food match: Typically smooth taste of traditional Czech fish complemented by beer pastry should be accompanied by relatively smooth and refreshing beer whose taste is dominated by a balanced body and pleasant not excessively adhesive bitterness. These requirements are met in full by Krušovice Světlé.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (84, 34, 'en_US', 'Krušovice Světlé', 'Krušovice Světlé (Krušovice Královská 10°) features a clear golden colour and creamy head. The taste and aroma come from using three types of malt from select varieties of high-quality Bohemian and Moravian barley. Hops give the beer a pleasant bitterness.

Krušovice Světlé is a highly drinkable and refreshing beer for any occasion.

The perfect food match: Typically smooth taste of traditional Czech fish complemented by beer pastry should be accompanied by relatively smooth and refreshing beer whose taste is dominated by a balanced body and pleasant not excessively adhesive bitterness. These requirements are met in full by Krušovice Světlé.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (85, 34, 'cs_rCZ', 'Krušovice Královská 10°', 'Vzpomenete si, kdy jste si naposledy pochutnali na poctivě uvařené, pořádné české desítce? Sládci z Krušovic pochopili, že do české hospody pravá desítka prostě patří. A uvařili ji tak, jak ji před nimi vařili celé generace těch mimořádně nadaných pivovarnických mistrů, na něž měla naše země vždycky štěstí.

Krušovice Desítka je výborně pitelné pivo, které se vyznačuje čirou zlatou barvou a krémovou pěnou. Chuť a vůni ji dodávají tři druhy ječných sladů z vybraných odrůd kvalitního českého a moravského ječmene. Díky žateckému chmelu má příjemně vyznívající hořkost.

Skvěle se pije a osvěží při všech myslitelných příležitostech.

Kombinace s pokrmy: Pečené maso, žebra, utopenci, velmi dobře jde s nakládaným sýrem nebo ještě lépe se zrajícími sýry.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (86, 35, 'ru_RU', 'Krušovice Královská 12°', 'Krušovice Imperial (Krušovice Královská 12°) is an export lager golden in colour, with balanced taste and medium bitterness made with hops.

The perfect food match: Traditional Czech cuisine, roasted meat, especially pork, chicken, cheese.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (87, 35, 'en_US', 'Krušovice Imperial', 'Krušovice Imperial (Krušovice Královská 12°) is an export lager golden in colour, with balanced taste and medium bitterness made with hops.

The perfect food match: Traditional Czech cuisine, roasted meat, especially pork, chicken, cheese.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (88, 35, 'cs_rCZ', 'Krušovice Královská 12°', 'Je královskou volbou mezi krušovickými pivy. Dlouho doznívající, výrazná hořkost, plná sladová chuť i vůně a sytě zlatá barva, to jsou vlastnosti excelentního ležáku českého typu. Kdo má rád hořká piva, je Královská 12 přímo pro něj.

Doporučení k pokrmům: Vepřová pečená masa, středně přezrálý sýr z kravského nebo ovčího mléka.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (89, 36, 'ru_RU', 'Krušovice Černé', 'Krušovice Černé is characterised by a full, distinctively caramel taste with tones of roasted coffee, gentle hoppy bitterness and a typical dark colour.

Krušovice Černé is the right choice for consumers who enjoy special, refreshing beers of distinctive taste.

The perfect food match: Pork in combination with pepper tastes great with dark beer. We recommend Krušovice Černé which thanks to its distinctive caramel (but not sweet) and slightly roasted taste is a great accompaniment for meat and sauces.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (90, 36, 'en_US', 'Krušovice Černé', 'Krušovice Černé is characterised by a full, distinctively caramel taste with tones of roasted coffee, gentle hoppy bitterness and a typical dark colour.

Krušovice Černé is the right choice for consumers who enjoy special, refreshing beers of distinctive taste.

The perfect food match: Pork in combination with pepper tastes great with dark beer. We recommend Krušovice Černé which thanks to its distinctive caramel (but not sweet) and slightly roasted taste is a great accompaniment for meat and sauces.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (91, 36, 'cs_rCZ', 'Krušovice Černé', 'Zavedením pšeničného piva do svého portfolia obnovil Královský pivovar Krušovice v Čechách tradici vaření pšeničných svrchně kvašených piv, která u nás převládala až do poloviny 19. Století, než je vytlačily světlé ležáky.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (92, 37, 'ru_RU', 'Krušovice Pšenicne', 'Krušovice Pšeničné is unfiltered, slightly cloudy, foamy beer with an intense aroma and distinctive kick. It features a very light and harmonic flavour complemented with fruity tones.

A highly refreshing and pleasant change for those that enjoy discovering unconventional and intriguing tastes.

The perfect food match: Pšeničné goes very well with any fish, we recommend salmon in particular.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (93, 37, 'en_US', 'Krušovice Pšenicne', 'Krušovice Pšeničné is unfiltered, slightly cloudy, foamy beer with an intense aroma and distinctive kick. It features a very light and harmonic flavour complemented with fruity tones.

A highly refreshing and pleasant change for those that enjoy discovering unconventional and intriguing tastes.

The perfect food match: Pšeničné goes very well with any fish, we recommend salmon in particular.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (94, 37, 'cs_rCZ', 'Krušovice Pšenicne', 'Zavedením pšeničného piva do svého portfolia obnovil Královský pivovar Krušovice v Čechách tradici vaření pšeničných svrchně kvašených piv, která u nás převládala až do poloviny 19. Století, než je vytlačily světlé ležáky.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (95, 38, 'ru_RU', 'Krušovice Mušketýr 11°', 'Chuťově plná a zároveň skvěle pitelná jedenáctka s charakteristickou hořkostí českého chmele odrůd Premiant a Žatecký poloraný červeňák. Vyšší plnost a hutnou pěnu jí dodávají čtyři druhy sladů - český, mnichovský, karamelový a pšeničný.

Doporučení k pokrmům: Tradiční české pokrmy, jako jsou guláš, vepřový řízek, hovězí steak nebo nakládaný sýr.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (96, 38, 'en_US', 'Krušovice Mušketýr 11°', 'Chuťově plná a zároveň skvěle pitelná jedenáctka s charakteristickou hořkostí českého chmele odrůd Premiant a Žatecký poloraný červeňák. Vyšší plnost a hutnou pěnu jí dodávají čtyři druhy sladů - český, mnichovský, karamelový a pšeničný.

Doporučení k pokrmům: Tradiční české pokrmy, jako jsou guláš, vepřový řízek, hovězí steak nebo nakládaný sýr.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (97, 38, 'cs_rCZ', 'Krušovice Mušketýr 11°', 'Chuťově plná a zároveň skvěle pitelná jedenáctka s charakteristickou hořkostí českého chmele odrůd Premiant a Žatecký poloraný červeňák. Vyšší plnost a hutnou pěnu jí dodávají čtyři druhy sladů - český, mnichovský, karamelový a pšeničný.

Doporučení k pokrmům: Tradiční české pokrmy, jako jsou guláš, vepřový řízek, hovězí steak nebo nakládaný sýr.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (98, 38, 'de_DE', 'Krušovice Mušketýr 11°', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (99, 39, 'ru_RU', 'Krušovice Řezané 11°', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (100, 39, 'en_US', 'Krušovice Řezané 11°', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (101, 39, 'cs_rCZ', 'Krušovice Řezané 11°', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (102, 39, 'de_DE', 'Krušovice Řezané 11°', NULL);
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (103, 40, 'ru_RU', 'Malostranský Ležák', 'Malostranský Ležák (Малостранский Лежак) - традиционное светлое пиво, сваренное по классическому чешскому рецепту. Три вида солода дают пиву сбалансированный округлый вкус а два вида хмеля приятную горечь и свежесть с пряно-травянистым ароматом.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (104, 40, 'en_US', 'Malostranský Lager', 'Traditional lager beer brewed according to the classic Czech recipe. Three kinds of malt give the beer a balanced taste and two kinds of hops with a pleasant bitterness and freshness an herbal aroma.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (105, 40, 'cs_rCZ', 'Malostranský Ležák', 'Tradiční světlé pivo vařené podle klasické české receptury. Tři druhy sladu dávají pivu vyváženou zaoblenou chuť a dva druhy chmele příjemnou hořkost a čerstvost s kořeněnou bylinnou vůní.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (106, 41, 'ru_RU', 'Ruby Special', 'Полно-сладовый полутемный лагер с карамельным вкусом и выразительной горечью. Он принадлежит к представителям Венского пива.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (107, 41, 'en_US', 'Ruby Special', 'A full-bodied semi-dark lager with caramel flavor and lower bitterness. It belongs to representatives of beers labeled "Vienna style."');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (108, 41, 'cs_rCZ', 'Rubín', 'Plno sladový polotmavý Ležák s karamelovou chutí a nižší hořkostí. Patři k zástupcům piv označených jako "Vienna styl".');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (109, 42, 'ru_RU', 'Tmavý speciál "Černý Havran"', 'Tmavý speciál "Černý Havran" (Темное специальное "Черный Ворон") - темное пиво с выраженным карамельно – шоколадным вкусом жаренного солода и кофе. Гармония вкуса и аромата сладкого солодового характера, мягкой хмелевой горечи и сухофруктов.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (110, 42, 'en_US', 'Dark Special "Black Raven"', 'Dark beer with highlighting caramel chocolate flavor of roasted malt and coffee. Harmony of taste and smell of sweet malt, soft bitterness and dried fruit.

');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (111, 42, 'cs_rCZ', 'Tmavý speciál "Černý Havran"', 'Tmavé pivo se zvýrazněnou karamelově čokoládovou chutí pražené sladu a kávy. Povedená harmonie chutí a vůní sladkého sladu, měkké hořkosti a sušeného ovoce.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (112, 43, 'ru_RU', 'Amarillo New England IPA', 'Пиво верхового брожения, сваренное с использованием технологии холодного охмеления, которая вплоть до мутности и ароматов, создает эффект свежевыжатого сока из тропических фруктов.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (113, 43, 'en_US', 'Amarillo New England IPA', 'Top-fermented beer brewed using the “Dry Hopping” technology, the American Amarillo hops were used to make the beer taste of tropical fruit.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (114, 43, 'cs_rCZ', 'Amarillo New England IPA', 'Svrchně kvašené pivo uvařeno za využití technologie „Dry hopping“, při výrobě byl použit americký chmel Amarillo, který dal pivu chuť po tropickém ovoci.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (115, 44, 'ru_RU', 'Бакалар Светлое Лагерное', 'Популярное лагерное пиво, обладает богатым вкусом, варится по традиционной рецептуре, с хмелевой горчинкой, золотистым цветом и богатой пеной. Объемная доля спирта: 4,9% об.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (116, 44, 'en_US', 'Bakalar Pale Lager', 'A popular full-tasted lager brewed according to traditional recipe characterized by hop bitterness, golden colour, and rich foam. Alcohol content 4,9% vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (117, 44, 'cs_rCZ', 'Bakalář Světlý Ležák', 'Oblíbený ležák plné chuti, vařený podle tradiční receptury. Vyznačuje se chmelovou hořkostí, zlatou barvou a bohatou pěnou. Obsah alkoholu: 4,9% obj.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (118, 44, 'de_DE', 'Bakalar Pale Lager', 'A popular full-tasted lager brewed according to traditional recipe characterized by hop bitterness, golden colour, and rich foam. Alcohol content 4,9% vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (119, 45, 'ru_RU', 'Бакалар Светлое Легкое', 'Легкое пиво, приятная горчинка, гармоничный вкус и золотистый цвет. Объемная доля спирта: 4% об.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (120, 45, 'en_US', 'Bakalar Pale Beer', 'A lighter beer of nicely bitter, well-balanced taste and golden colour. Alcohol content 4% vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (121, 45, 'cs_rCZ', 'Bakalář Světlé Výčepní', 'Příjemně hořké pivo vyvážené chuti a zlaté barvy. Obsah alkoholu: 4,0 % obj.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (122, 45, 'de_DE', 'Bakalar Pale Beer', 'A lighter beer of nicely bitter, well-balanced taste and golden colour. Alcohol content 4% vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (123, 46, 'ru_RU', 'Бакалар Темное Легкое', 'Богатый вкус, темный цвет, ярко выраженная хмелевая горчинка.
Объемная доля спирта: 3,8% об.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (124, 46, 'en_US', 'Bakalar Dark Beer', 'A full-tasted beer of dark colour with emphasized hop bitterness. Alcohol content 3,8% vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (125, 46, 'cs_rCZ', 'Bakalář Tmavé Výčepní', 'Plné pivo temné barvy s výraznou chmelovou hořkostí. Obsah alkoholu: 3,8% obj.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (126, 46, 'de_DE', 'Bakalar Dark Beer', 'A full-tasted beer of dark colour with emphasized hop bitterness. Alcohol content 3,8% vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (127, 47, 'ru_RU', 'Бакалар Полутемное Легкое', 'Рубиновый цвет, вкус обогащен привкусом карамели и легкой хмелевой горчинкой. Объемная доля спирта: 4,5% об.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (128, 47, 'en_US', 'Bakalar Amber Beer', 'A full-tasted beer of ruby colour with nice caramel flavour and a touch of hop bitterness. Alcohol content 4,5% vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (129, 47, 'cs_rCZ', 'Bakalář Řezané Výčepní', 'Plnější pivo rubínové barvy, s jemnou příchutí karamelu a nádechem chmelové hořkosti. Obsah alkoholu: 4,5% obj.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (130, 47, 'de_DE', 'Bakalar Amber Beer', 'A full-tasted beer of ruby colour with nice caramel flavour and a touch of hop bitterness. Alcohol content 4,5% vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (131, 48, 'ru_RU', 'Бакалар Светлое Холодного Охмеления', 'Уникальное пиво с более высокой плотностью, с чудесным ароматом сушеных хмелевых шишок "Žateckého poloraného červeňáku" и глубоким цветом с темнозолотистыми отблесками. Объемная доля спирта: 5,2 % об.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (132, 48, 'en_US', 'Bakalar Dry Hopped Lager Beer', 'An unmistakable beer with a higher original volume, characterized by a wonderful aroma of dried Saaz hops and a rich colour with dark golden reflections. Alcohol content 5,2 % vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (133, 48, 'cs_rCZ', 'Bakalář Světlý Ležák za Studena Chmelený', 'Nezaměnitelné pivo s vyšší původní stupňovitostí, charakteristické nádherným aroma sušených chmelových hlávek Žateckého poloraného červeňáku a sytou barvou s temně zlatými odlesky. Obsah alkoholu : 5,2% obj.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (134, 48, 'de_DE', 'Bakalar Dry Hopped Lager Beer', 'An unmistakable beer with a higher original volume, characterized by a wonderful aroma of dried Saaz hops and a rich colour with dark golden reflections. Alcohol content 5,2 % vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (135, 49, 'ru_RU', 'Бакалар Медовое Специальное', 'Специальное светлое пиво с богатым вкусом, с оттенком хмелевой горечи и послевкусием лесного меда. Объемная доля спирта: 5,8% об.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (136, 49, 'en_US', 'Bakalar Special Honey Beer', 'Special lager beer characterized by rich taste with a touch of hop bitterness and base notes of forest honey. Alcohol content: 5,8% vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (137, 49, 'cs_rCZ', 'Bakalář Medový Speciál', 'Speciální světlé pivo bohaté chuti, s nádechem chmelové hořkosti a doznívajícím podtónem lesního medu. Obsah alkoholu : 5,8% obj.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (138, 49, 'de_DE', 'Bakalar Special Honey Beer', 'Special lager beer characterized by rich taste with a touch of hop bitterness and base notes of forest honey. Alcohol content: 5,8% vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (139, 50, 'ru_RU', 'Бакалар Безалкогольное Холодного Охмеления', 'Единственное безалкогольное пиво холодного охмеления. Его вкус подчеркнут ароматом сушеного жатецкого хмеля "Žateckého poloraného červeňáku", который придает уникальный и неповторимый вкус и аромат этому безалкогольному пиву. Объемная доля спирта: макс. 0,5% об.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (140, 50, 'en_US', 'Dry Hopped Alcohol Free Beer', 'The only cold hopped non-alcoholic beer. Its flavour is accentuated by hop aroma which gives unmistakable and irreplaceable smell and taste to this non-alcoholic beer. Alcohol content: max. 0,5% vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (141, 50, 'cs_rCZ', 'Bakalář Nealkoholické za Studena Chmelený', 'Jediné nealkoholické pivo za studena chmelené. Jeho vyvážená chuť je dána dokonalým spojením sladového základu vařeného s vysoce kvalitním chmelem a sušených chmelových hlávek Žateckého poloraného červeňáku, které jsou v pivu macerovány po celou dobu ležení a dodávají nealkoholickému pivu nezaměnitelnou a ničím nenahraditelnou vůni a chuť. Obsah alkoholu: max. 0,5 % obj.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (142, 50, 'de_DE', 'Dry Hopped Alcohol Free Beer', 'The only cold hopped non-alcoholic beer. Its flavour is accentuated by hop aroma which gives unmistakable and irreplaceable smell and taste to this non-alcoholic beer. Alcohol content: max. 0,5% vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (143, 51, 'ru_RU', 'Бакалар 11° Светлое', 'Пиво золотистого цвета, со сбалансированным вкусом с приятным отголоском хмелевой горечи. Объемная доля спирта: 4,5% об.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (144, 51, 'en_US', 'Bakalar 11° Pale Lager', 'A full-tasted beer of golden colour and well-balanced taste with nice aftertaste of hop bitterness. Alcohol content: 4,5% vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (145, 51, 'cs_rCZ', 'Bakalář 11° Světlý Ležák', 'Plnější pivo zlatavé barvy a vyrovnané chuti s příjemnými dozvuky chmelové hořkosti. Obsah alkoholu: 4,5% obj.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (146, 51, 'de_DE', 'Bakalar 11° Pale Lager', 'A full-tasted beer of golden colour and well-balanced taste with nice aftertaste of hop bitterness. Alcohol content: 4,5% vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (147, 52, 'ru_RU', 'Черновар Светлое Лагерное', 'Классическое чешское лагерное пиво насыщенного золотистого цвета, с тонко сбалансированным с отчетливым отголоском хмелевой горечи и тонким хмелевым ароматом. Объемная доля спирта: 4,9 % об.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (148, 52, 'en_US', 'Černovar Premium Lager', 'A traditional Czech premium lager characterized by rich golden colour, perfectly balanced full flavour with a distinct aftertaste of hop bitterness and subtle hop aroma. Alcohol content 4,9 % vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (149, 52, 'cs_rCZ', 'Černovar Světlý Ležák', 'Klasický český světlý ležák sytě zlaté barvy, dokonale vyvážené plné chuti se zřetelným dozvukem chmelové hořkosti a jemnou chmelovou vůní. Obsah alkoholu 4,9% obj.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (150, 52, 'de_DE', 'Černovar Premium Lager', 'A traditional Czech premium lager characterized by rich golden colour, perfectly balanced full flavour with a distinct aftertaste of hop bitterness and subtle hop aroma. Alcohol content 4,9 % vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (151, 53, 'ru_RU', 'Черновар Темное Лагерное', 'Традиционное чешское темное лагерное пиво с богатым вкусом. Вкус дан специальным сочетанием четырех сортов солода, которые пиву также дают полноту и исключительный карамельный вкус и аромат. Приятная горечь и богатая пена, завершают уникальный характер пива. Объемная доля спирта: 4,5 % об.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (152, 53, 'en_US', 'Černovar Dark Lager', 'A traditional Czech dark lager with rich flavour given by a special combination of four types of malt, which also endows the beer with fullness and a unique caramel flavour and aroma. A pleasant bitterness and rich stable foam complete the unique character of the beer. Alcohol content 4,5 % vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (153, 53, 'cs_rCZ', 'Černovar Tmavý Ležák', 'Klasický český tmavý ležák s bohatou chutí. Je dána speciální kombinací čtyř druhů sladu, které pivu dávají také plnost a výjimečnou karamelovou chuť a vůni. Příjemná hořkost a bohatá stabilní pěna dotvářejí jedinečný charakter piva. Obsah alkoholu: 4,5% obj.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (154, 53, 'de_DE', 'Černovar Dark Lager', 'A traditional Czech dark lager with rich flavour given by a special combination of four types of malt, which also endows the beer with fullness and a unique caramel flavour and aroma. A pleasant bitterness and rich stable foam complete the unique character of the beer. Alcohol content 4,5 % vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (155, 54, 'ru_RU', 'Пражачка Светлое Легкое', 'Традиционное чешское светлое не крепкое пиво, со свежим вкусом и светло-золотистым цветом, с приятным ароматом и тонкой горечью. Объемная доля спирта: 4,0 % об.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (156, 54, 'en_US', 'Pražačka Pale Beer', 'A traditional Czech pale beer of a lower volume characterized by its fresh taste, light golden colour, pleasant yeast aroma as well as mild bitterness. Alcohol content 4,0 % vol.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (157, 54, 'cs_rCZ', 'Pražačka Světlé Výčepní', 'Tradiční české světlé pivo nižší stupňovitosti, svěží chuti a světle zlaté barvy, s příjemnou vůní a jemnou hořkostí. Obsah alkoholu: 4,0% obj.');
INSERT INTO beer_tr (_id, beer_id, locale, name, info) VALUES (158, 54, 'de_DE', 'Pražačka Pale Beer', 'A traditional Czech pale beer of a lower volume characterized by its fresh taste, light golden colour, pleasant yeast aroma as well as mild bitterness. Alcohol content 4,0 % vol.');

-- Таблица: brewery
DROP TABLE IF EXISTS brewery;
CREATE TABLE brewery (_id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, name TEXT NOT NULL, info TEXT, small BOOLEAN DEFAULT (0) NOT NULL, phone TEXT, web TEXT, email TEXT, address TEXT, location TEXT, google TEXT, mapsme TEXT, mapycz TEXT, enabled BOOLEAN NOT NULL DEFAULT (1));
INSERT INTO brewery (_id, name, info, small, phone, web, email, address, location, google, mapsme, mapycz, enabled) VALUES (1, 'Staropramen', 'Pivovary Staropramen s. r. o. jsou druhým největším producentem piva v České republice a  lídrem v inovacích. Svým spotřebitelům nabízejí jedno z nejširších portfolií pivních značek. Společnost je také významným českým exportérem piva, značku Staropramen si mohou spotřebitelé vychutnat ve více než 35 zemích světa. Společnost provozuje dva pivovary - Staropramen a Ostravar.', 0, '+420 251 027 251', 'https://staropramen.cz/', 'info@staropramen.cz', 'Pivovary Staropramen, s. r. o. Nádražní 84, 150 00 Praha 5', '50.0684239,14.4066800', NULL, NULL, 'https://en.mapy.cz/s/kufupekojo', 1);
INSERT INTO brewery (_id, name, info, small, phone, web, email, address, location, google, mapsme, mapycz, enabled) VALUES (2, 'Pivovar Velké Popovice', 'Pivovar Velké Popovice pochází ze 16. století a nachází se zčásti na území obce Velké Popovice, zčásti na území obce Petříkov v okrese Praha-východ. Od roku 2002 patří společnosti Plzeňský Prazdroj a.s., která byla do roku 2016 součástí skupiny SABMiller. V současnosti patří do skupiny Asahi Breweries, Ltd.', 0, '+420 222 710 159', 'https://www.kozel.cz/', 'info@prazdroj.cz', 'Pivovar Velké Popovice, Ringhofferova 1, 251 69 Velké Popovice, Česko', '49.92415,14.63452', NULL, NULL, NULL, 1);
INSERT INTO brewery (_id, name, info, small, phone, web, email, address, location, google, mapsme, mapycz, enabled) VALUES (3, 'Plzeňský Prazdroj', 'Unikátnost českého piva se opírá o tradiční ryze české technologické postupy a kvalitu použitých surovin. Vyniká sytější barvou, plnou chutí, intenzivní hořkostí a výrazným chmelovým aroma.', 0, '+420 222 710 159', 'http://www.prazdroj.cz/', 'info@prazdroj.cz', 'U Prazdroje 64/7, 301 00 Plzeň, Česko', '49.75141,13.39379', NULL, NULL, NULL, 1);
INSERT INTO brewery (_id, name, info, small, phone, web, email, address, location, google, mapsme, mapycz, enabled) VALUES (4, 'U Fleků', 'První písemná zmínka o podniku se datuje do roku 1499, kdy dům koupil sladovník Vít Skřemenec. Pivovar U Fleků je  jedním z mála pivovarů ve střední Evropě, kde se pivo vaří bez přestávky déle než 500 let.

S nástupem komunismu byl podnik znárodněn. Původní majitelé (rodina Brtníků) jej získali zpět po pádu režimu v roce 1991.', 1, '+420 224 934 019', 'https://ufleku.cz/', 'ufleku@ufleku.cz', 'Pivovar a Restaurace U FLEKŮ s.r.o. Křemencova 11, Praha 1, 110 00', '50.0789651,14.4164314', NULL, NULL, NULL, 1);
INSERT INTO brewery (_id, name, info, small, phone, web, email, address, location, google, mapsme, mapycz, enabled) VALUES (5, 'U Tří růží', 'Minipivovar U tří růží navazuje na více než šestisetletou historii vaření piva v tomto historickém domě v pražské Husově ulici. Vysokou kvalitu piva zaručuje zkušený vrchní sládek Robert Maňák, držitel mnoha prestižních ocenění. Naše pivo se vaří za využití moderních technologií, z vysoce kvalitních surovin a dle nejvyšších standardů. Přesto však jsou zachovány tradiční, léty prověřené postupy. Vybavení minipivovaru zahrnuje desetihektolitrovou varnu vyrobenou v Pacovských strojírnách. Je umístěna v přízemírestaurace a doplněna otevřenou spilkou, fermentačními a ležáckými tanky ve středověkém sklepení. Mikropivovar U tří růží má výrobní kapacitu 1 200-1 500 hl/rok.', 1, '+420 601 588 281', 'https://www.u3r.cz/', 'petr.blaha@u3r.cz', 'Husova 10/232, 110 00, Praha 1', '50.0856169,14.4183297', NULL, NULL, 'https://en.mapy.cz/s/hafazulefo', 1);
INSERT INTO brewery (_id, name, info, small, phone, web, email, address, location, google, mapsme, mapycz, enabled) VALUES (6, 'U Dvou koček', 'Minipivovar a restaurace ve kterém se připravuje světlé, polotmavé a tmavé pivo Kočka.', 1, '+420 224 229 982', 'http://udvoukocek.cz/', 'info@udvoukocek.cz', 'Restaurant U Dvou koček, Uhelný trh 415/10, 110 00 Praha 1', '50.0834914,14.4205303', 'https://goo.gl/maps/fRTV42GcPiBWApvg9', NULL, 'https://en.mapy.cz/s/mojapogavo', 1);
INSERT INTO brewery (_id, name, info, small, phone, web, email, address, location, google, mapsme, mapycz, enabled) VALUES (7, 'Klášterní pivovar Strahov', 'Klášterní pivovar Strahov patří do kategorie restauračních minipivovarů s ročním výstavem okolo 1000hl. Osobně cítíme úlohu minipivovaru jako producenta vysoce kvalitních speciálních piv.

Naše pivo Sv. Norbert, pojmenované podle zakladatele řádu premonstrátů, jež sídlí ve Strahovském klášteře, je vyráběno pouze z přírodních surovin – vody, sladu, chmele a kvasnic. Plně tedy respektujeme letitý zákon o čistotě piva - Reinheitsgebot z roku 1516. V našem pivu proto nenajdete žádné chmelové extrakty ani cukr, pivo je nepasterováno a nefiltrováno. Ponecháváme v pivu vše, co je dobré. Sv. Norbert obsahuje zbytkové pivovarské kvasnice s obsahem vitamínu B. Kromě světlého a tmavého Norberta vyrábíme čtyřikrát do roka pivní speciály a další příležitostná piva.', 1, '+420 233 353 155', 'http://www.klasterni-pivovar.cz/', 'pivovar@klasterni-pivovar.cz', 'Strahovské nádvoří 301, 118 00 Prague 1', '50.0868797,14.3885033', 'https://goo.gl/maps/4yQtijZ5qdHSwtLE9', NULL, 'https://en.mapy.cz/s/josusaguvo', 1);
INSERT INTO brewery (_id, name, info, small, phone, web, email, address, location, google, mapsme, mapycz, enabled) VALUES (8, 'Krušovice', 'The Royal Brewery of Krušovice (cs: Královský pivovar Krušovice, short form Krušovice) is a Czech brewery, established in 1581 in the village of Krušovice. It was sold to Emperor Rudolf II in 1583, and the Imperial Crown of Austria became part of the company''s logo. Arnošt Josef Valdštejn bought the brewery in 1685.

After 1945, the Krušovice Brewery was a state-owned company. The brewery was privatised in 1993, and began exporting to the United States and United Kingdom. The company was acquired by Heineken in 2007.', 0, '+420 313 569 202', 'https://krusovice.cz/', 'heineken@heineken.com', 'U Pivovaru 1, Krušovice, okres Rakovník, Středočeský kraj, Česko', '50.1736572,13.7726169', 'https://goo.gl/maps/xGNkS3M6BELr9rEb9', NULL, 'https://en.mapy.cz/s/getopojoze', 1);
INSERT INTO brewery (_id, name, info, small, phone, web, email, address, location, google, mapsme, mapycz, enabled) VALUES (9, 'Vojanův Dvůr', 'Vojanův dvůr brewery and restaurant is located in Malá Strana (the Lesser Town) in an historic building that was originally a bishopric court dating back to the 13th century.

The grand opening of the brewery was held in July 2018, making Vojanův dvůr the first micro-brewery in Malá Strana. The beer here is brewed by Robert Maňák, an experienced brew master from our sister brewery U tří růží. Under his guidance you can look forward to special beers you won’t find elsewhere.', 1, '+420 257 532 660', 'https://www.vojanuvdvur.cz/', 'info@vojanuvdvur.cz', 'U lužického semináře 119/21, 118 00  Praha, Malá Strana, Praha', '50.0897331,14.4095136', 'https://goo.gl/maps/pKN6QwnbuHcdfGgA8', NULL, 'https://en.mapy.cz/s/kuvetutapa', 1);
INSERT INTO brewery (_id, name, info, small, phone, web, email, address, location, google, mapsme, mapycz, enabled) VALUES (10, 'Pivovar Bakalář', 'Tradiční pivovar v Rakovníku, také Pivovar Bakalář, je pivovar v Rakovníku, který funguje již od 15. století. V tomto pivovaru se vaří pivo pod značkou Bakalář a s exportními značkami Černovar a Pražačka.

Piva značky Bakalář se vyznačují jedinečnou chmelovou hořkostí, plnou chutí, výraznou barvou a bohatou pevnou pěnou.

Černovar Světlé a Černovar Černé jsou klasické české ležáky sytých barev, jemně vyvážené chuti s příjemnými dozvuky chmelové hořkosti. Receptury obou piv byly postaveny pro exportní trhy, takže vyhovují chuťovým nárokům a očekáváním jak evropského, tak světového konzumenta.

Pražačka je tradiční české pivo nižší stupňovitosti, svěží chuti a jiskřivé světle zlaté barvy s příjemnou vůní a jemnou hořkostí.', 0, '+420 313 285 533', 'http://www.pivobakalar.cz/', 'info@pivobakalar.cz', 'Havlíčkova 69, Rakovník, okres Rakovník, Středočeský kraj, Česko', '50.1064483,13.7276244', 'https://goo.gl/maps/qQbyZowB4eVFxyYe8', NULL, 'https://en.mapy.cz/s/jetebudaka', 1);
INSERT INTO brewery (_id, name, info, small, phone, web, email, address, location, google, mapsme, mapycz, enabled) VALUES (11, 'Камышинский Пивзавод', 'Небольшой пивзавод в котором до сих пор варят пиво по советской технологии.', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);

-- Таблица: brewery_tr
DROP TABLE IF EXISTS brewery_tr;
CREATE TABLE brewery_tr (_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, brewery_id INTEGER REFERENCES brewery (_id) NOT NULL, locale INTEGER REFERENCES locale (code) NOT NULL, name TEXT NOT NULL, about TEXT, info TEXT, comments TEXT);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (1, 1, 'ru_RU', 'Старопрамен', 'Старопрамен (Staropramen) - Чешская пивоваренная компания, вторая по величине и мощности в стране. Расположена в районе Смихов (Smíchov), Прага 5.', 'Пивоварня была основана в 1869 году, а торговая марка Staropramen, что дословно означает "старый источник", была зарегистрирована в 1911 году. Пивоварня принадлежит компании Molson Coors (с 2012 года), и её продукция экспортируется в 37 стран, в основном в Европу и в Северную Америку.

История пивоварни Staropramen начинается в 1869 году, когда акции акционерного общества "Пивоварня в Смихове" (Joint Stock Brewery in Smíchov) были выставлены на продажу. В 1871 году было завершено строительство основных зданий пивоварни и сварено первое пиво.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (2, 1, 'en_US', 'Staropramen', 'Staropramen Brewery is the second largest brewery in the Czech Republic and is situated in
the Smíchov district in Prague 5.', 'The brewery was founded in 1869 and the brand name Staropramen, literally meaning "old spring", was registered in 1911. It is owned by Molson Coors (since 2012) and its product are exported to 37 different countries, mostly in Europe and North America.

Staropramen Brewery''s history begins in 1869 when shares for a "Joint Stock Brewery in Smíchov" where offered for sale. The brewery building was completed and beer first brewed in 1871.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (3, 3, 'ru_RU', 'Пилснер Урквел', NULL, 'Plzeňský Prazdroj, известный у нас как пивоварня Pilsner Urquell, является чешской 
пивоварней, основанной в 1842 году со штаб-квартирой в городе Пльзень, Чешская Республика. 
Это была первая пивоварня, производившая светлое пиво под маркой Pilsner Urquell. 
Популярность пива Pilsner Urquell привела к его множественному копированию, вследствии 
чего, появился сорт пива, называемый pilsner, или, иногда, pilsener. Название пивоварни, 
Pilsner Urquell, которое можно приблизительно перевести как "первоисточник в Пльзене", 
было принято в качестве товарного знака в 1898 году. Pilsner Urquell является крупнейшим 
производителем пива в Чешской Республике, а также крупнейшим экспортером пива за рубежом.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (4, 3, 'en_US', 'Pilsner Urquell', NULL, 'Plzeňský Prazdroj, known in English as the Pilsner Urquell Brewery, is a Czech brewery 
founded in 1842 and headquartered in Plzeň, Czech Republic. It was the first brewery to 
produce pale lager, branded as Pilsner Urquell. The popularity of Pilsner Urquell 
resulting in it being much copied so that more than two-thirds of the beer produced in the 
world today is pale lager, sometimes named pils, pilsner and pilsener after Pilsner 
Urquell. The brewery name, Pilsner Urquell, which can be roughly translated into English 
as "the original source at Pilsen", was adopted as a trademark in 1898. Pilsner Urquell is 
the largest beer producer in the Czech Republic and is also the largest exporter of beer 
abroad.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (5, 2, 'ru_RU', 'Велкопоповицкий Козел', NULL, 'Пивоварня Velké Popovice датируется 16 веком и расположен частично на территории села Велке Поповице, частично на территории села Петржиков в районе Прага-Восток. С 2002 года принадлежит компании Пльзень Праздрой А.в 2016 году группа стала частью группы SABMiller. В настоящее время он принадлежит к группе Asahi Breweries, Ltd. На пивоварне варят знаменитое пиво Велкопоповицкий Козел.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (6, 2, 'en_US', 'Velkopopovický Kozel', NULL, 'The Brewery of Velké Popovice comes from 16 century. it is located partly on the territory of the village of Velké Popovice, partly on the territory of the village of Petříkov in the Prague-East District. Since 2002, Plzeňský Prazdroj A. belongs to the company.s., which until 2016 was part of the SABMiller Group. It currently belongs to the group Asahi Breweries, Ltd.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (7, 4, 'ru_RU', 'У Флеку', NULL, 'В пивоварне "У Флеку" пиво варят уже 500 лет. Первое письменное упоминание о пивоварне, расположенной на улице Кременцова, относится к 1499 году.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (8, 4, 'en_US', 'U Fleků', NULL, 'The first written document dates back to 1499 when the house was bought by maltster Vít Skřemenec. The brewery U Fleků is one of few breweries in Central Europe which has been brewing continuously for over 500 years.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (9, 5, 'ru_RU', 'У Трех роз', NULL, 'В пивоварне «У Трех роз» всегда в наличии широкий ассортимент пива верхового и низового брожения, сваренного под руководством опытного пивовара Роберта Маняка. Умелое сочетание современных технологий, традиционных методов и использование качественного сырья позволяет обеспечить высокое качество изготавливаемого пива. Все сорта пива варятся в варочном цехе, расположенном на первом этаже ресторана, в котле объемом десять гектолитров, производства завода «Пацовске строирны». Котел дополняет открытый чан, в котором пиво отстаивается, ферментационные баки и лагерные танки в средневековом подвале. Производительность пивоварни достигает 1200-1500 гектолитров в год. Учитывая, что у нашего ресторана есть собственная пивоварня, мы предлагаем вам увлекательную экскурсию в сопровождении профессионального гида. Вы сможете подробно познакомиться с технологией производства пива, увидев лично все этапы.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (10, 5, 'en_US', 'U Tří růží', NULL, 'In our brewery U Tří růží a wide variety of beers (top and bottom-fermented) are brewed by our experienced brewer Robert Maňák. In combination with modern technologies, traditional methods and high quality ingredients we guarantee you the best quality beer. A 10 hectoliter brew house made by Pacov Machine Works is placed directly on our ground floor of our restaurant and is supplied with fermentation tanks and lager tanks in our medieval dungeons. Our brewery products 1200-1500 hectoliters per year. Thanks to our offered tour provided with a expert commentary our guest get to see the production and brewing of our beer with their own eyes.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (11, 6, 'ru_RU', 'У Двух кошек', NULL, 'Мини пивоварня в самом центре Праги в которой варят светлое, янтарное и темное пиво.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (12, 6, 'en_US', 'U Dvou koček', NULL, 'Mini brewery in the heart of Prague where light, amber and dark beer is brewed.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (13, 7, 'ru_RU', 'Монастырская Пивоварня Страхов', NULL, 'Монастырскую пивоварню "Страгов" вы найдете неподалеку от Пражского Града, на территории Страговского монастыря, который был основан в 1142 году королем Владиславом II. Первые упоминания о пивоварне появляются на рубеже XIII – XIV вв. О строительстве новой, полностью функционирующей пивоварни в месте расположения сегодняшнего ресторана, принял решение аббат Кашпар Квестенберг в 1628 году. В 1907 году пивоварня перестала работать, а помещения использовались только в качестве хозяйственных построек. Пивоварня была восстановлена только в 2000 году в ходе обширной, сложной реконструкции всего объекта. Монастырская пивоварня "Страгов" в своем сегодняшнем виде предлагает посетителям в общей сложности 230 мест в трех специальных помещениях: собственно пивоварня, ресторан "Св. Норберт" и пивоваренный двор.

Пиво Sv. Norbert производится только из натуральных ингредиентов - воды, солода, хмеля и дрожжей соблюдая вековой закон о чистоте пива - Reinheitsgebot от 1516 года. Поэтому в пиве вы не найдете ни экстрактов хмеля, ни сахара, пиво непастеризованное и нефильтрованное.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (14, 7, 'en_US', 'Strahov Monastic Brewery', NULL, 'The Strahov Monastic Brewery is located close by to the Prague Castle in the building of the Strahov Monastery, which was founded by King Vladislav II in 1142. The first documentation on the brewery come form the turn of the 13th and 14th centuries. The decision on the construction of a new and fully functional brewery, where the restaurant is today, was made by Abbot Kaspar Questenberg in 1628. The brewery was closed in 1907, and the buildings were used solely as farm houses. The brewery was restored only three years ago, in 2000, during an extensive and difficult reconstruction of the entire complex. The current Strahov Monastic Brewery offers to its guests a total capacity of 230 seats in three peculiar environments the brewery itself, St. Norbert Restaurant and Brewery Courtyard.

', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (15, 8, 'ru_RU', 'Krušovice', NULL, 'The Royal Brewery of Krušovice (cs: Královský pivovar Krušovice, short form Krušovice) is a Czech brewery, established in 1581 in the village of Krušovice. It was sold to Emperor Rudolf II in 1583, and the Imperial Crown of Austria became part of the company''s logo. Arnošt Josef Valdštejn bought the brewery in 1685.

After 1945, the Krušovice Brewery was a state-owned company. The brewery was privatised in 1993, and began exporting to the United States and United Kingdom. The company was acquired by Heineken in 2007.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (16, 8, 'en_US', 'Krušovice', NULL, 'The Royal Brewery of Krušovice (cs: Královský pivovar Krušovice, short form Krušovice) is a Czech brewery, established in 1581 in the village of Krušovice. It was sold to Emperor Rudolf II in 1583, and the Imperial Crown of Austria became part of the company''s logo. Arnošt Josef Valdštejn bought the brewery in 1685.

After 1945, the Krušovice Brewery was a state-owned company. The brewery was privatised in 1993, and began exporting to the United States and United Kingdom. The company was acquired by Heineken in 2007.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (17, 9, 'ru_RU', 'Vojanův Dvůr', NULL, 'Пивоварня и ресторан «Воянув двур» (Vojanův dvůr) находятся в пражском районе Мала-Страна, в исторических зданиях первоначальной епископской резиденции XIII века.

В июле 2018 года была торжественно открыта сама пивоварня, благодаря чему «Воянув Двур» стал первым мини-пивоваренным заводом в районе Мала-Страна. Пиво здесь варит опытный пивовар Роберт Маньак (Robert Maňák) из сестринской пивоварни «У Трех роз» (U tří růží). Вас ждет пиво, отличающееся от обычного ассортимента на рынке.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (18, 9, 'en_US', 'Vojanův Dvůr', NULL, 'Vojanův dvůr brewery and restaurant is located in Malá Strana (the Lesser Town) in an historic building that was originally a bishopric court dating back to the 13th century.

The grand opening of the brewery was held in July 2018, making Vojanův dvůr the first micro-brewery in Malá Strana. The beer here is brewed by Robert Maňák, an experienced brew master from our sister brewery U tří růží. Under his guidance you can look forward to special beers you won’t find elsewhere.

', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (19, 9, 'cs_rCZ', 'Vojanův Dvůr', NULL, 'Vojanův dvůr brewery and restaurant is located in Malá Strana (the Lesser Town) in an historic building that was originally a bishopric court dating back to the 13th century.

The grand opening of the brewery was held in July 2018, making Vojanův dvůr the first micro-brewery in Malá Strana. The beer here is brewed by Robert Maňák, an experienced brew master from our sister brewery U tří růží. Under his guidance you can look forward to special beers you won’t find elsewhere.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (20, 10, 'ru_RU', 'Pivovar Bakalář', NULL, 'Традиционная пивоварня в Раковнике, также пивоварня Бакалар, работает с 15 века. Тут варят пиво под марками Бакалар (Bakalář), Черновар (Černovar) и Пражечка Pražačka.

Отличительной особенностью пива Bakalář является особая хмелевая горечь, насыщенный богатый вкус, выразительный цвет и богатая густая пена.

Черновар светлое и темное это классические чешское пиво насыщенных цветов, с тонко сбалансированным вкусом и с приятным отголоском хмелевой горечи. Обе рецептуры Черновара были построены для экспортных рынков, поэтому соответствуют вкусовым требованиям и ожиданиям не только европейского, но и мирового потребителя.

Пражечка - традиционное чешское пиво с низшей плотностью, свежим вкусом, светло-золотистым цветом с приятно-дрожжевым ароматом и тонкой горечью.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (21, 10, 'en_US', 'Pivovar Bakalář', NULL, 'Традиционная пивоварня в Раковнике, также пивоварня Бакалар, работает с 15 века. Тут варят пиво под марками Бакалар (Bakalář), Черновар (Černovar) и Пражечка Pražačka.

All Bakalář branded beers are characterized by unique hop bitterness, full taste, emphasized color and rich firm foam.

Černovar are traditional Czech lagers, characterized by rich color and well-balanced taste with pleasant touch of hop bitterness in the aftertaste.

Pražačka is a traditional low-density pale beer characterized by its fresh taste, light golden color, pleasant yeast aroma as well as mild bitterness.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (22, 10, 'cs_rCZ', 'Pivovar Bakalář', NULL, 'Tradiční pivovar v Rakovníku, také Pivovar Bakalář, je pivovar v Rakovníku, který funguje již od 15. století. V tomto pivovaru se vaří pivo pod značkou Bakalář a s exportními značkami Černovar a Pražačka.

Piva značky Bakalář se vyznačují jedinečnou chmelovou hořkostí, plnou chutí, výraznou barvou a bohatou pevnou pěnou.

Černovar Světlé a Černovar Černé jsou klasické české ležáky sytých barev, jemně vyvážené chuti s příjemnými dozvuky chmelové hořkosti. Receptury obou piv byly postaveny pro exportní trhy, takže vyhovují chuťovým nárokům a očekáváním jak evropského, tak světového konzumenta.

Pražačka je tradiční české pivo nižší stupňovitosti, svěží chuti a jiskřivé světle zlaté barvy s příjemnou vůní a jemnou hořkostí.', NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (23, 11, 'ru_RU', 'Камышинский Пивзавод', NULL, NULL, NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (24, 11, 'en_US', 'Камышинский Пивзавод', NULL, NULL, NULL);
INSERT INTO brewery_tr (_id, brewery_id, locale, name, about, info, comments) VALUES (25, 11, 'cs_rCZ', 'Камышинский Пивзавод', NULL, NULL, NULL);

-- Таблица: choice_beer
DROP TABLE IF EXISTS choice_beer;
CREATE TABLE choice_beer (_id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, beer_id INTEGER REFERENCES beer (_id) NOT NULL, why TEXT NOT NULL);
INSERT INTO choice_beer (_id, beer_id, why) VALUES (1, 1, 'Traditional Czech lager. Perfectly quenches thirst.');

-- Таблица: choice_beer_tr
DROP TABLE IF EXISTS choice_beer_tr;
CREATE TABLE choice_beer_tr (_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, choice_id INTEGER REFERENCES choice_beer (_id) NOT NULL, locale TEXT REFERENCES locale (code), why TEXT);
INSERT INTO choice_beer_tr (_id, choice_id, locale, why) VALUES (1, 1, 'ru_RU', 'Традиционное чешский лагер. Прекрасно утоляет жажду.');
INSERT INTO choice_beer_tr (_id, choice_id, locale, why) VALUES (2, 1, 'en_US', 'Traditional Czech lager. Perfectly quenches thirst.');

-- Таблица: choice_place
DROP TABLE IF EXISTS choice_place;
CREATE TABLE choice_place (_id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, place_id INTEGER REFERENCES place (_id) NOT NULL, why TEXT NOT NULL);
INSERT INTO choice_place (_id, place_id, why) VALUES (1, 8, 'Plzeňský Prazdroj 12°.');
INSERT INTO choice_place (_id, place_id, why) VALUES (2, 10, 'Světlá Kočka, Tmavá Kočka.');
INSERT INTO choice_place (_id, place_id, why) VALUES (3, 13, 'Staropramen beer and good kitchen.');
INSERT INTO choice_place (_id, place_id, why) VALUES (4, 14, 'Staropramen beer and good kitchen.');

-- Таблица: choice_place_tr
DROP TABLE IF EXISTS choice_place_tr;
CREATE TABLE choice_place_tr (_id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, choice_id REFERENCES choice_place (_id) NOT NULL, locale TEXT REFERENCES locale (code) NOT NULL, why TEXT);
INSERT INTO choice_place_tr (_id, choice_id, locale, why) VALUES (1, 2, 'ru_RU', 'Собственное пиво "Кошка" и не плохая кухня.');
INSERT INTO choice_place_tr (_id, choice_id, locale, why) VALUES (2, 2, 'en_US', 'Own "Kočka" beer and good kitchen.');
INSERT INTO choice_place_tr (_id, choice_id, locale, why) VALUES (3, 3, 'ru_RU', 'Свежее пиво Старопрамен и отличная кухня.');
INSERT INTO choice_place_tr (_id, choice_id, locale, why) VALUES (4, 3, 'en_US', 'Staropramen beer and good kitchen.');
INSERT INTO choice_place_tr (_id, choice_id, locale, why) VALUES (5, 4, 'ru_RU', 'Свежее пиво Старопрамен и отличная кухня.');
INSERT INTO choice_place_tr (_id, choice_id, locale, why) VALUES (6, 4, 'en_US', 'Staropramen beer and good kitchen.');

-- Таблица: city
DROP TABLE IF EXISTS city;
CREATE TABLE city (_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, country_id INTEGER NOT NULL REFERENCES country (_id), name TEXT NOT NULL, info TEXT, web TEXT, wiki TEXT, sku TEXT NOT NULL, location TEXT, google TEXT, mapsme TEXT, mapycz TEXT, enabled BOOLEAN NOT NULL DEFAULT (1));
INSERT INTO city (_id, country_id, name, info, web, wiki, sku, location, google, mapsme, mapycz, enabled) VALUES (2, 2, 'Москва', NULL, 'https://www.mos.ru/', 'https://en.wikipedia.org/wiki/Moscow', 'city_moscow', '55.7504461,37.6174942', 'https://goo.gl/maps/18syPSjucUBuwFjeA', NULL, 'https://en.mapy.cz/s/fojugefugu', 1);
INSERT INTO city (_id, country_id, name, info, web, wiki, sku, location, google, mapsme, mapycz, enabled) VALUES (3, 3, 'London', NULL, 'https://www.london.gov.uk/', 'https://en.wikipedia.org/wiki/London', 'city_london', '51.4897692,0.1431919', 'https://goo.gl/maps/TvNZ7fXnbmQMQXsd8', NULL, 'https://en.mapy.cz/s/noravanana', 1);
INSERT INTO city (_id, country_id, name, info, web, wiki, sku, location, google, mapsme, mapycz, enabled) VALUES (4, 5, 'Praha', NULL, 'http://www.praha.eu/jnp/cz/index.html', 'https://en.wikipedia.org/wiki/Prague', 'city_prague', '50.0835494,14.4341414', 'https://goo.gl/maps/xKF54SVcJZuRLgGK8', NULL, 'https://en.mapy.cz/s/mekodosacu', 1);
INSERT INTO city (_id, country_id, name, info, web, wiki, sku, location, google, mapsme, mapycz, enabled) VALUES (5, 6, 'Dresden', NULL, 'https://www.dresden.de/index_de.php', 'https://en.wikipedia.org/wiki/Dresden', 'city_dresden', '51.0764194,13.7383917', 'https://goo.gl/maps/XtCFzQa4UU5AjG9QA', NULL, 'https://en.mapy.cz/s/2uwaV', 1);
INSERT INTO city (_id, country_id, name, info, web, wiki, sku, location, google, mapsme, mapycz, enabled) VALUES (6, 7, 'Мінск', NULL, 'https://minsk.gov.by/', 'https://en.wikipedia.org/wiki/Minsk', 'city_minsk', '53.9023339,27.5618792', 'https://goo.gl/maps/SDwvuPLGQhCSVDwT9', NULL, 'https://en.mapy.cz/s/mumefucaku', 1);
INSERT INTO city (_id, country_id, name, info, web, wiki, sku, location, google, mapsme, mapycz, enabled) VALUES (7, 2, 'Камышин', 'Камы́шин - город областного значения в Волгоградской области России. Административный центр Камышинского района, образует городской округ город Камышин.', 'http://www.admkamyshin.info/', 'https://en.wikipedia.org/wiki/Kamyshin', 'city_kam', '50.0808422,45.4048003', 'https://goo.gl/maps/DVSwAgN2cH65Cmk37', NULL, 'https://en.mapy.cz/s/nagumubudu', 1);

-- Таблица: city_tr
DROP TABLE IF EXISTS city_tr;
CREATE TABLE city_tr (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, city_id INTEGER NOT NULL REFERENCES city (_id), locale INTEGER REFERENCES locale (code), name TEXT NOT NULL, about TEXT, info TEXT, comments TEXT);
INSERT INTO city_tr (id, city_id, locale, name, about, info, comments) VALUES (3, 2, 'en_US', 'Moscow', 'The capital of Russia.', NULL, NULL);
INSERT INTO city_tr (id, city_id, locale, name, about, info, comments) VALUES (4, 2, 'ru_RU', 'Москва', 'Столица России.', NULL, NULL);
INSERT INTO city_tr (id, city_id, locale, name, about, info, comments) VALUES (5, 3, 'en_US', 'London', 'The capital of Great Britain.', NULL, NULL);
INSERT INTO city_tr (id, city_id, locale, name, about, info, comments) VALUES (6, 3, 'ru_RU', 'Лондон', 'Столица Великобритании.', NULL, NULL);
INSERT INTO city_tr (id, city_id, locale, name, about, info, comments) VALUES (7, 4, 'en_US', 'Prague', 'The capital of Czech Republic.', NULL, NULL);
INSERT INTO city_tr (id, city_id, locale, name, about, info, comments) VALUES (8, 4, 'ru_RU', 'Прага', 'Столица Чехии.', NULL, NULL);
INSERT INTO city_tr (id, city_id, locale, name, about, info, comments) VALUES (9, 4, 'cs_rCZ', 'Praha', NULL, NULL, NULL);
INSERT INTO city_tr (id, city_id, locale, name, about, info, comments) VALUES (10, 5, 'ru_RU', 'Дрезден', 'Небольшой город на юге Германии.', NULL, NULL);
INSERT INTO city_tr (id, city_id, locale, name, about, info, comments) VALUES (11, 5, 'en_US', 'Dresden', NULL, NULL, NULL);
INSERT INTO city_tr (id, city_id, locale, name, about, info, comments) VALUES (12, 5, 'cs_rCZ', 'Drážďany', NULL, NULL, NULL);
INSERT INTO city_tr (id, city_id, locale, name, about, info, comments) VALUES (13, 5, 'de_DE', 'Dresden', NULL, NULL, NULL);
INSERT INTO city_tr (id, city_id, locale, name, about, info, comments) VALUES (14, 6, 'ru_RU', 'Минск', 'Столица Белоруссии.', NULL, NULL);
INSERT INTO city_tr (id, city_id, locale, name, about, info, comments) VALUES (15, 6, 'en_US', 'Minsk', 'The capital of Belarus.', NULL, NULL);
INSERT INTO city_tr (id, city_id, locale, name, about, info, comments) VALUES (16, 6, 'cs_rCZ', 'Minsk', NULL, NULL, NULL);
INSERT INTO city_tr (id, city_id, locale, name, about, info, comments) VALUES (17, 6, 'de_DE', 'Minsk', NULL, NULL, NULL);
INSERT INTO city_tr (id, city_id, locale, name, about, info, comments) VALUES (18, 7, 'ru_RU', 'Камышин', NULL, NULL, NULL);
INSERT INTO city_tr (id, city_id, locale, name, about, info, comments) VALUES (19, 7, 'en_US', 'Kamyshin', NULL, NULL, NULL);
INSERT INTO city_tr (id, city_id, locale, name, about, info, comments) VALUES (20, 7, 'cs_rCZ', 'Kamyshin', NULL, NULL, NULL);

-- Таблица: country
DROP TABLE IF EXISTS country;
CREATE TABLE country (_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, name TEXT NOT NULL, info TEXT, web TEXT, wiki TEXT, location TEXT DEFAULT "0:0", google TEXT, mapsme TEXT, mapycz TEXT, yandex TEXT, enabled BOOLEAN NOT NULL DEFAULT (1));
INSERT INTO country (_id, name, info, web, wiki, location, google, mapsme, mapycz, yandex, enabled) VALUES (2, 'Россия', NULL, 'http://russia.com/', 'https://en.wikipedia.org/wiki/Russia', '61.698653, 99.505405', 'https://goo.gl/maps/1utGjJb8krDw4dT56', NULL, 'https://en.mapy.cz/s/mobefavole', 'https://yandex.ru/maps/-/CCQtZYUdgA', 1);
INSERT INTO country (_id, name, info, web, wiki, location, google, mapsme, mapycz, yandex, enabled) VALUES (3, 'England', NULL, 'https://www.visitbritain.com/gb/en', 'https://en.wikipedia.org/wiki/England', '53.139499, -1.685177', 'https://goo.gl/maps/XYjz2TW6tgjRzTwX9', NULL, 'https://en.mapy.cz/s/pezupevopa', 'https://yandex.ru/maps/-/CCQtZYaWOB', 1);
INSERT INTO country (_id, name, info, web, wiki, location, google, mapsme, mapycz, yandex, enabled) VALUES (4, 'USA', NULL, 'https://www.visittheusa.com/', 'https://en.wikipedia.org/wiki/United_States', '36.952915, -99.115868', 'https://goo.gl/maps/qJ8LYkxuZsL1B9xy8', NULL, 'https://en.mapy.cz/s/fodonarole', 'https://yandex.ru/maps/-/CCQtZYe1WA', 1);
INSERT INTO country (_id, name, info, web, wiki, location, google, mapsme, mapycz, yandex, enabled) VALUES (5, 'Česko', NULL, 'https://www.czechtourism.com/home/', 'https://en.wikipedia.org/wiki/Czech_Republic', '49.574818, 15.267847', 'https://goo.gl/maps/zksYXJkW2GDdyTXL6', NULL, 'https://en.mapy.cz/s/focatovaco', 'https://yandex.ru/maps/-/CCQtZYeFoB', 1);
INSERT INTO country (_id, name, info, web, wiki, location, google, mapsme, mapycz, yandex, enabled) VALUES (6, 'Deutschland', NULL, 'https://www.germany.travel/', 'https://en.wikipedia.org/wiki/Germany', '51.3515653,10.5940178', 'https://goo.gl/maps/Y4jNbRneSuRXvLgm6', NULL, 'https://en.mapy.cz/s/3gBcq', 'https://yandex.ru/maps/-/CCQtZUtTGD', 0);
INSERT INTO country (_id, name, info, web, wiki, location, google, mapsme, mapycz, yandex, enabled) VALUES (7, 'Беларусь', NULL, 'https://www.belarus.by/en/', 'https://en.wikipedia.org/wiki/Belarus', '53.7891753,27.6995908', 'https://goo.gl/maps/8u6HHoA6hAedCbNJ7', NULL, 'https://en.mapy.cz/s/patamonuna', 'https://yandex.ru/maps/-/CCQtZYqjdC', 1);

-- Таблица: country_tr
DROP TABLE IF EXISTS country_tr;
CREATE TABLE country_tr (_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, country_id INTEGER NOT NULL DEFAULT (1) REFERENCES country (_id), locale INTEGER REFERENCES locale (code), name TEXT NOT NULL, about TEXT, info TEXT, comments TEXT);
INSERT INTO country_tr (_id, country_id, locale, name, about, info, comments) VALUES (3, 2, 'en_US', 'Russia', NULL, NULL, NULL);
INSERT INTO country_tr (_id, country_id, locale, name, about, info, comments) VALUES (4, 2, 'ru_RU', 'Россия', NULL, NULL, NULL);
INSERT INTO country_tr (_id, country_id, locale, name, about, info, comments) VALUES (5, 3, 'en_US', 'England', NULL, NULL, 'Best ales and stouts!');
INSERT INTO country_tr (_id, country_id, locale, name, about, info, comments) VALUES (6, 3, 'ru_RU', 'Англия', NULL, NULL, 'Лучшие эли и стауты!');
INSERT INTO country_tr (_id, country_id, locale, name, about, info, comments) VALUES (7, 5, 'en_US', 'Czech Republic', NULL, NULL, 'Best lagers in the world!');
INSERT INTO country_tr (_id, country_id, locale, name, about, info, comments) VALUES (8, 5, 'ru_RU', 'Чешская Республика', NULL, NULL, 'Лучшие лагеры в мире!');
INSERT INTO country_tr (_id, country_id, locale, name, about, info, comments) VALUES (9, 4, 'en_US', 'US', NULL, NULL, NULL);
INSERT INTO country_tr (_id, country_id, locale, name, about, info, comments) VALUES (10, 4, 'ru_RU', 'США', NULL, NULL, NULL);
INSERT INTO country_tr (_id, country_id, locale, name, about, info, comments) VALUES (11, 5, 'cs_rCZ', 'Česko', NULL, NULL, 'Best lagers in the world!');
INSERT INTO country_tr (_id, country_id, locale, name, about, info, comments) VALUES (12, 6, 'ru_RU', 'Германия', NULL, NULL, NULL);
INSERT INTO country_tr (_id, country_id, locale, name, about, info, comments) VALUES (13, 6, 'en_US', 'Germany', NULL, NULL, NULL);
INSERT INTO country_tr (_id, country_id, locale, name, about, info, comments) VALUES (14, 6, 'cs_rCZ', 'Německo', NULL, NULL, NULL);
INSERT INTO country_tr (_id, country_id, locale, name, about, info, comments) VALUES (15, 6, 'de_DE', 'Deutschland', NULL, NULL, NULL);
INSERT INTO country_tr (_id, country_id, locale, name, about, info, comments) VALUES (16, 7, 'ru_RU', 'Беларусь', NULL, NULL, NULL);
INSERT INTO country_tr (_id, country_id, locale, name, about, info, comments) VALUES (17, 7, 'en_US', 'Belarus', NULL, NULL, NULL);
INSERT INTO country_tr (_id, country_id, locale, name, about, info, comments) VALUES (18, 7, 'cs_rCZ', 'Bělorusko', NULL, NULL, NULL);
INSERT INTO country_tr (_id, country_id, locale, name, about, info, comments) VALUES (19, 7, 'de_DE', 'Belarus', NULL, NULL, NULL);

-- Таблица: locale
DROP TABLE IF EXISTS locale;
CREATE TABLE locale (code TEXT PRIMARY KEY ASC UNIQUE NOT NULL, name TEXT NOT NULL, enabled BOOLEAN DEFAULT (1));
INSERT INTO locale (code, name, enabled) VALUES ('ru_RU', 'Русский', 1);
INSERT INTO locale (code, name, enabled) VALUES ('en_US', 'English US', 1);
INSERT INTO locale (code, name, enabled) VALUES ('cs_rCZ', 'Czech Republic', 0);
INSERT INTO locale (code, name, enabled) VALUES ('de_DE', 'Germany', 0);

-- Таблица: place
DROP TABLE IF EXISTS place;
CREATE TABLE place (_id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, city_id INTEGER REFERENCES city (_id) NOT NULL, type INTEGER REFERENCES place_type (_id), name TEXT NOT NULL, info TEXT, brewery BOOLEAN DEFAULT (0), web TEXT, wiki TEXT, phone TEXT, email TEXT, address TEXT, location TEXT, google TEXT, mapsme TEXT, mapycz TEXT, rating_beer INTEGER DEFAULT (0) NOT NULL, rating_food INTEGER DEFAULT (0) NOT NULL, rating_service INTEGER DEFAULT (0) NOT NULL, enabled BOOLEAN NOT NULL DEFAULT (1));
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (1, 4, 1, 'Lokál U Bílé kuželky', 'Vychutnejte si pečlivě ošetřené pivo a čerstvě navařené domácí jídlo. Pivo u nás putuje co nejkratšími trubkami rovnou do půllitru a zůstává čerstvé až do posledního loku.', 0, 'http://lokal-ubilekuzelky.ambi.cz/', NULL, '+420 257 212 014', 'kuzelka@ambi.cz', 'Míšeňská 12
118 00 Prague 1', '50.08766,14.40753', 'https://g.page/lokalubilekuzelky', NULL, NULL, 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (2, 4, 1, 'Lokál Dlouhááá', 'Vychutnejte si pečlivě ošetřené pivo a čerstvě navařené domácí jídlo. Pivo u nás putuje co nejkratšími trubkami rovnou do půllitru a zůstává čerstvé až do posledního loku.', 0, 'http://lokal-dlouha.ambi.cz/', NULL, '+420 734 283 874', 'dlouha@ambi.cz', 'Dlouhá 33, 110 00 Prague 1', '50.09111,14.42529', 'https://goo.gl/maps/jgCCDFn1fquK2Wt69', NULL, NULL, 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (3, 4, 1, 'Lokál U Zavadilů', 'Vychutnejte si pečlivě ošetřené pivo a čerstvě navařené domácí jídlo. Pivo u nás putuje co nejkratšími trubkami rovnou do půllitru a zůstává čerstvé až do posledního loku.', 0, 'http://lokal-uzavadilu.ambi.cz/', NULL, '+420 244 467 448', 'uzavadilu@ambi.cz', 'K Verneráku 70/1, 148 00 Praha 4', '50.0140783,14.4833362', 'https://g.page/lokaluzavadilu?share', NULL, NULL, 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (4, 4, 1, 'Lokál Nad Stromovkou', 'Vychutnejte si pečlivě ošetřené pivo a čerstvě navařené domácí jídlo. Pivo u nás putuje co nejkratšími trubkami rovnou do půllitru a zůstává čerstvé až do posledního loku.', 0, 'http://lokal-nadstromovkou.ambi.cz/', NULL, '+420 220 912 319', 'nadstromovkou@ambi.cz', 'Nad Královskou oborou 232/31, 170 00 Praha 7', '50.1030819,14.4161608', 'https://goo.gl/maps/yHNcQbGXbu4ZxkkAA', NULL, NULL, 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (5, 4, 1, 'Lokál Hamburk', 'Vychutnejte si pečlivě ošetřené pivo a čerstvě navařené domácí jídlo. Pivo u nás putuje co nejkratšími trubkami rovnou do půllitru a zůstává čerstvé až do posledního loku.', 0, 'http://lokal-hamburk.ambi.cz/', NULL, '+420 222 310 361', 'hamburk@ambi.cz', 'Sokolovská 55, 186 00 Praha 8', '50.0931954,14.4446153', 'https://goo.gl/maps/QSAJYUzrDCprM9or8', NULL, NULL, 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (6, 4, 1, 'Lokál Korunní', 'Vychutnejte si pečlivě ošetřené pivo a čerstvě navařené domácí jídlo. Pivo u nás putuje co nejkratšími trubkami rovnou do půllitru a zůstává čerstvé až do posledního loku.', 0, 'https://www.korunni.lokal.cz/', NULL, '+420 604 500 257', NULL, 'Korunní 39, 120 00 Praha 2', '50.0754668,14.4419196', 'https://goo.gl/maps/unjeR2YjGxtUAp6j6', NULL, NULL, 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (7, 4, 1, 'U Fleků', 'První písemná zmínka o podniku se datuje do roku 1499, kdy dům koupil sladovník Vít Skřemenec. Pivovar U Fleků je  jedním z mála pivovarů ve střední Evropě, kde se pivo vaří bez přestávky déle než 500 let.

S nástupem komunismu byl podnik znárodněn. Původní majitelé (rodina Brtníků) jej získali zpět po pádu režimu v roce 1991.', 1, 'https://ufleku.cz/', NULL, '+420 224 934 019', 'ufleku@ufleku.cz', 'Pivovar a Restaurace U FLEKŮ s.r.o. Křemencova 11, Praha 1, 110 00', '50.0789651,14.4164314', 'https://goo.gl/maps/S94TJcveHnWF4yJu6', NULL, NULL, 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (8, 4, 1, 'U Zlatého Tygra', 'Tradiční Plzeňská pivnice s neopakovatelnou atmosférou a koloritem v srdci staré Prahy.', 0, 'http://www.uzlatehotygra.cz/', NULL, '+420 222 221 111', 'info@uzlatehotygra.cz', 'U Zlatého Tygra, Husova 228/17, 110 00 Prague 1', '50.0858306,14.4180422', 'https://goo.gl/maps/DNN3pyNgPnM9XSns9', NULL, NULL, 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (9, 4, 5, 'U Tří růží', 'Minipivovar a restaurace U Tří růží v Praze se nachází v samotném historickém centru, v Husově ulici v těsné blízkosti Karlova mostu a Staroměstského náměstí. Ihned po vstupu na vás dýchne místní výjimečná atmosféra staropražského pivovaru, kterou umocňují nástěnné malby akademických malířů Jiřího Bernarda a Pavla Jakla, vykreslující obrazy z bohaté historie domu a pivovarnictví v Čechách.

V přízemí pivovaru je pak umístěna varna, kde se pod vedením zkušeného sládka Roberta Maňáka vaří šest druhů piva.', 1, 'https://www.u3r.cz/', NULL, '+420 602 795 330', 'rezervace@u3r.cz', 'Husova 10/232, 110 00, Praha 1', '50.0856169,14.4183297', 'https://goo.gl/maps/TyNaUDM6JU2QNDpD7', NULL, 'https://en.mapy.cz/s/hafazulefo', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (10, 4, 1, 'U Dvou koček', 'Minipivovar a restaurace ve kterém se připravuje světlé, polotmavé a tmavé pivo Kočka.', 1, 'http://udvoukocek.cz/', NULL, '+420 224 229 982', 'info@udvoukocek.cz', 'Restaurant U Dvou koček, Uhelný trh 415/10, 110 00 Praha 1', '50.0834914,14.4205303', 'https://goo.gl/maps/fRTV42GcPiBWApvg9', NULL, 'https://en.mapy.cz/s/mojapogavo', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (11, 4, 1, 'Klášterní pivovar Strahov', 'Nedaleko Pražského hradu najdete místo pivním labužníkům zaslíbené. Mimo pivních speciálů podáváme prvotřídní pokrmy a nasávat můžete i jedinečnou atmosférou Strahovského kláštera, který byl založen v roce 1143 králem Vladislavem II. První zmínky o pivovaru pocházejí z přelomu 13. a 14. století. O stavbě nového pivovaru, stojícího na místě dnešní restaurace, rozhodl tehdejší opat Kašpar Questenberg v roce 1629. V roce 1907 byl však pivovar zrušen a objekty byly využívány pouze jako hospodářská stavení. Pivovar byl obnoven znovu až v roce 2000 při rozsáhlé a náročné rekonstrukci celého objektu.

Současná podoba Klášterního pivovaru Strahov nabízí hostům kapacitu 230 míst ve třech osobitých prostorech a to ve vlastním pivovaru a ve dvoupatrové restauraci Sv. Norbert, v letních měsících otevíráme pro své hosty zahrádku na pivovarském dvoře s kapacitou cca 80 míst.', 1, 'http://www.klasterni-pivovar.cz/', NULL, '+420 233 353 155', 'zuzana@klasterni-pivovar.cz', 'Strahovské nádvoří 301, 118 00 Prague 1', '50.0868797,14.3885033', 'https://goo.gl/maps/4yQtijZ5qdHSwtLE9', NULL, 'https://en.mapy.cz/s/josusaguvo', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (12, 4, 3, 'U Černého vola', 'Традиционная чешская пивная куда приходят именно попить пива. Находится в двух шагах от Пражской Лореты.', 0, 'https://www.facebook.com/ucernehovola/', NULL, '+420 606 626 929', NULL, 'Loretánské náměstí 107/1
118 00  Praha, Hradčany
Praha', '50.0881844,14.3918419', 'https://goo.gl/maps/Eo5mtzJR89TYuj3R9', NULL, 'https://en.mapy.cz/s/pufutofoju', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (13, 4, 5, 'Potrefená Husa Resslova', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 0, 'https://staropramen.cz/hospody/restaurace-praha-resslova', NULL, '+420 224 918 691', 'ph-resslova@seznam.cz', 'Resslova 1775/1, 120 00  Praha, Nové Město, Praha', '50.0757675,14.4149694', 'https://goo.gl/maps/54YXEMmRp44PxFY18', NULL, 'https://en.mapy.cz/s/dasulamolu', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (14, 4, 5, 'Potrefená Husa Národní', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 0, 'https://staropramen.cz/hospody/restaurace-praha-narodni-trida', NULL, '+ 420 734 756 900', 'info@potrefenahusa.net', 'Národní 364/39, 110 00  Praha, Staré Město, Praha', '50.0828972,14.4209689', 'https://goo.gl/maps/vj5aa26A6fairULd8', NULL, 'https://en.mapy.cz/s/bemukanaza', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (15, 4, 5, 'Potrefená Husa na Verandách', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 0, 'https://staropramen.cz/hospody/restaurace-praha-na-verandach', NULL, '+420 257 191 200', 'manager@phnaverandach.cz', 'Nádražní 43/84, 150 00  Praha, Smíchov, Praha', '50.0685464,14.4065503', 'https://goo.gl/maps/3kpANA1tZAe5gPtg7', NULL, 'https://en.mapy.cz/s/ketopafono', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (16, 4, 5, 'Potrefená Husa Hybernská', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 0, 'https://staropramen.cz/hospody/restaurace-praha-hybernska', NULL, '+420 224 243 631', 'info@potrefena-husa.eu', 'Dlážděná 1003/7, 110 00  Praha, Nové Město, Praha', '50.0871314,14.4319497', 'https://goo.gl/maps/6Le7kJGD3rZmbhyZ9', NULL, 'https://en.mapy.cz/s/resupejolo', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (17, 4, 5, 'Potrefená Husa Albertov', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 0, 'https://staropramen.cz/hospody/restaurace-praha-albertov', NULL, '+420 236 071 028', 'manager@phalbertov.cz', 'Na Slupi 2102/2b, 128 00  Praha, Nové Město, Praha', '50.0664519,14.4225264', 'https://goo.gl/maps/eQhPtnYRffNbYJKJ6', NULL, 'https://en.mapy.cz/s/jecetavuze', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (18, 4, 5, 'Potrefená Husa Vinohrady', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 0, 'https://staropramen.cz/hospody/restaurace-praha-vinohrady', NULL, '+420 267 310 360', 'manager.vinohrady@husy.cz', 'Vinohradská 1666/104, 130 00  Praha, Vinohrady, Praha', '50.0773772,14.4554531', 'https://goo.gl/maps/PnFiuMj3JvV2D8Y76', NULL, 'https://en.mapy.cz/s/pucodetofo', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (19, 4, 5, 'Potrefená Husa Hlavní Nádraží', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 0, 'https://staropramen.cz/hospody/beerpoint-hlavni-nadrazi-praha', NULL, '+420 774 439 340', '64005.potrefena.husa@lagardere-tr.cz', 'Wilsonova 300/8, 110 00  Praha, Vinohrady, Praha', '50.0839233,14.4343308', 'https://goo.gl/maps/zq2DE7toefBND9BE7', NULL, 'https://en.mapy.cz/s/rapedupazo', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (20, 4, 5, 'U Špirků', 'Tradiční restaurace U Špirků v Kožné ulici č. 12, se nachází 50 m jižně od Staroměstského náměstí. Tato restaurace patřila mezi nejznámější pražské podniky konce 19. a I. poloviny 20. století.

Zcela výjimečný středověký ráz Kožné ulice a její poloha v samém středu Prahy umožňuje návštěvníkům přenést se o několik staletí zpět a poznat kouzlo staré Prahy. Tento zážitek, lze umocnit výborným jídlem a pitím podávaným v naší restauraci, která je provozovaná již od roku 1870 a patří mezi nejstarší Pražské podniky. V letech 2004-2006 provedená rekonstrukce umožnila obnovit krásu původních interiérů včetně atmosféry konce 19. století.

Stylová vinárna se nachází v suterénu a nabízí příjemné posezení 60 hostům. Dobový ráz, četné umělecké prvky a přístup denního světla zajímavě technicky řešeným pochozím oknem, vytváří ideální prostředí pro klidnou večeři či posezení u skleničky vína. Vinárna je stejně jako restaurace vybavena špičkovým vzduchotechnickým a klimatizačním systémem a vytápěnou podlahou.

Na objednávku lze využít služeb obsluhované vyhlídkové terasy, ze které je fantastický výhled na celou historickou část Prahy.

Hypermoderní kuchyňský provoz je srdcem restaurace a pro naše hosty vytváří hotová i minutková jídla v té nejvyšší kvalitě. Jako jedna z mála, má restaurace U Špirků denně obměňovaný sortiment hotových jídel a poledních menu za velmi výhodné ceny. Pracovní tým restaurace U Špirků je přesvědčený o tom, že dnes stejně jako před více než stočtyřiceti lety platí, že nejvýhodnější klasické stravování v centru Prahy je v restauraci U Špirků. Budeme velice rádi, když se sami přijdete přesvědčit.', 0, 'http://www.u-spirku.cz/', NULL, '+420 224 210 073
', 'manager@u-spirku.cz', 'Kožná 1024/12
110 00  Praha, Staré Město
Praha', '50.0862847,14.4214097', 'https://goo.gl/maps/wEtuZk786NhxCy3e8', NULL, 'https://en.mapy.cz/s/rafajufeco', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (21, 4, 1, 'U Hrocha', 'Prostě hospoda pro fanoušky kvalitního piva a vybrané společnosti.', 0, 'https://www.facebook.com/noreservationsonthispage/', NULL, '+420 257 533 389', NULL, 'Thunovská 178/10, 118 00  Praha, Malá Strana, Praha', '50.0891608,14.4032325', 'https://goo.gl/maps/QN2vKaMtNR2HX3XW7', NULL, 'https://en.mapy.cz/s/majadavafe', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (22, 4, 5, 'Kozlovna U Paukerta', 'Vychutnejte si nezaměnitelnou atmosféru originálních hospod Velkopopovického Kozla.

Skvělá česká kuchyně s klasickými recepturami od našich předků. Založená na tradičních domácích postupech s důrazem na čerstvost surovin bez použití dochucovadel a umělých přísad. Pocit jedinečnosti dodává i naše profesionální obsluha.

Naši proškolení výčepní mistři milující pivo čepují vynikající velkopopovickou jedenáctku přímo z tanků, vždy s pěnou hustou jako smetana. Kozel 11 drží díky tradičním výrobním postupům a použití kvalitních českých ingrediencí ochrannou známku České pivo.

Majestátní socha Kozla, netradiční stoly s kovovými kopýtky nebo i takové detaily jako háčky na oblečení. Všechny tyto elementy ve spojení s materiály dřeva, kůže i kovu navozují příjemnou a nezapomenutelnou atmosféru každé Kozlovny.', 0, 'http://www.kozlovna.cz/u-paukerta', NULL, '+420 222 212 144', 'info@cetrad.cz', 'Národní 981/17, 110 00  Praha, Staré Město, Praha', '50.0819358,14.4170181', 'https://goo.gl/maps/nGY4feYuyhUpfJib8', NULL, 'https://en.mapy.cz/s/camupesuge', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (23, 4, 5, 'U Malého Glena', 'Najdete nás v malebném centru Malé Strany. Ůtulný  interiér v nedávno zrekonstruovaném barokním domě podtrhuje nejen vstřícná obsluha, ale i obsáhlé menu a široký výběr jazzových, bluesových a mezižánrových koncertů v podání předních, zejména domácích, ale i zahraničních hudebníků.

Podnik je rozdělen do dvou částí - BAR & RESTAURANT a  JAZZ & BLUES CLUB – místo každodenních koncertů.

U Malého Glena si můžete vybrat z nabídky jak zahraničnich piv (irský Guinness, kvasnicový Paulaner, Corona, Heineken...), tak i vynikajících tuzemských piv (Plzeňský Prazdroj, Budvar, Velvet či nepasterizovaný Bernard).

Milovníkům vín nabízíme pestrý výběr moravských i zahraničních vín, znalcům koktejlů pak rozsáhlý nápojový lístek obsahující až 50 možných variací. Fanoušci jistě ocení výběr kvalitních rumů a dalších nápojů tradičních a vynikajících značek.

V uvolněné atmosféře naší restaurace podáváme jak pozdní snídaně, obědy i večeře. Jako jedni z mála na Malé straně podáváme jídla až do 23.30h! Veškeré produkty a ingredience, které zpracováváme, vybíráme tak, aby splnily nejpřísnější kritéria. Stejně tak pečlivě dbáme na výběr dodavatelů, kteří vždy patří k těm nejlepším ve svém oboru.', 0, 'http://malyglen.cz/en/pages', NULL, '+420 257 531 717', 'malyglen@malyglen.cz', 'Karmelitská 374/23, 118 00  Praha, Malá Strana, Praha', '50.0868150,14.4037056', 'https://goo.gl/maps/R45VwYHzhDzpKvQi6', NULL, 'https://en.mapy.cz/s/cenesohone', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (24, 4, 6, 'Hospůdka Na Hradbách', 'Один из пивных садов Праги.', 0, 'https://www.facebook.com/hospudkanahradbach/', NULL, '+420 734 112 214', 'hospudkanahradbach@gmail.com', 'V Pevnosti 16/2, 128 00 Praha, Vyšehrad, Praha', '50.0636100,14.4220953', 'https://goo.gl/maps/dpye3aZEyj9WM3UV7', NULL, 'https://en.mapy.cz/s/2dwbQ', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (25, 2, 1, 'Parka', 'Бар крафтового пива в центре Москвы. Большой выбор пива, отличная кухня (особенно блюда на гриле).', 0, 'https://www.facebook.com/parkacraft', NULL, '+7 926 160 63 13', NULL, 'ул. Пятницкая, 22,стр.1, Москва, 115035', '55.7414406,37.6283864', 'https://goo.gl/maps/UwyLnAhqYkbZDHjn8', NULL, 'https://en.mapy.cz/s/kejuruhura', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (26, 2, 1, 'Варка', 'Бар крафтового пива в центре Москвы. Большой выбор пива, вкусные бургеры от BurgerHeroes, пивные закуски. Есть настойки и самогон.', 0, 'https://vk.com/varkacraftbar', NULL, '+7 966 384 54 04', NULL, 'ул. Александра Солженицына, 1/5, Москва, 109004', '55.7421156,37.6552839', 'https://goo.gl/maps/ECVY6D6FcKhMdrz28', NULL, 'https://en.mapy.cz/s/kehavukuda', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (27, 2, 1, 'Craftland Cultural Bar', 'Бар крафтового пива в центре Москвы.', 0, 'https://www.instagram.com/craftland.bar/', NULL, '+7 495 140 19 82', NULL, 'ул. Александра Солженицына, д.17 стр.1, Москва, 109004', '55.7439322,37.6614064', 'https://g.page/craftland-cultural-bar?share', NULL, 'https://en.mapy.cz/s/polasarele', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (28, 2, 2, 'Black Swan', 'Паб в центре Москвы.', 0, 'http://www.bspubshop.ru/', NULL, '+7 495 114 52 15', NULL, 'ул. Солянка, 1, Москва, 101000', '55.7544758,37.6379275', 'https://goo.gl/maps/pQjdBUqhX1dUkKgq5', NULL, 'https://en.mapy.cz/s/barohecamu', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (29, 2, 3, 'Taproom Pivzavod 77', 'Фирменный бар пивоварни Pivzavod 77.', 0, 'http://pivzavod77-cafe.ru/kafe-bar_taproom_pivzavod_77_na_ulitse_pokrovka/', NULL, '+7 926 149 56 75', '', 'ул. Покровка, 17с1, Москва, 101000', '55.7597739,37.6451303', 'https://g.page/Kafe_bar_Taproom_Pivzavod_77?share', NULL, 'https://en.mapy.cz/s/mutenuruno', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (30, 2, 5, 'Krombacher Beer Kitchen', 'Фирменный ресторан Krombacher в Москве.', 0, 'https://beerkitchen.ru/', NULL, '+7 495 734 70 60', NULL, '1-я Тверская-Ямская ул., 19, Москва, 125047', '55.7742911,37.5883764', 'https://goo.gl/maps/P3khbTrS1KvSc9z3A', NULL, 'https://en.mapy.cz/s/posejehogo', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (31, 2, 1, 'Дом, В Котором', 'Крафтовый бар с необычным интерером.', 0, 'https://www.facebook.com/domvkotorompub', NULL, '+7 926 864 20 99', NULL, 'ул. Покровка, 14/2 стр 3, Москва, 101000', '55.7586300,37.6453194', 'https://goo.gl/maps/yfyBYxmZwt8JKSbE9', NULL, 'https://en.mapy.cz/s/kojalubupu', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (32, 2, 7, 'Широкую на широкую', 'Бар и рюмочная.', 0, 'https://www.facebook.com/shirokayabar/', NULL, '+7 499 408 28 27', NULL, 'Кривоколенный пер., 10 строение 5, Москва, 101000', '55.7615203,37.6362136', 'https://goo.gl/maps/n7VTrz9fn5EmGx6B8', NULL, 'https://en.mapy.cz/s/cosakonufu', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (33, 2, 7, 'Зинзиве́р', 'Бар и рюмочная.', 0, 'https://www.facebook.com/tararahnul/', NULL, '+7 915 329 48 22', NULL, 'Покровский б-р, 2/14, Москва, 101000', '55.7588158,37.6455297', 'https://goo.gl/maps/qCEFSmCo5nXZCy8S8', NULL, 'https://en.mapy.cz/s/fomanujeca', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (34, 2, 2, 'Connolly Station', 'Ирландский паб в самом центре Москвы, названый в честь центрального ж/д вокзала в Дублине, открытого в далеком 1844 году.', 0, 'https://connollypub.com/', NULL, '+7 499 678 21 44', NULL, 'пер. Столешников, 8, Москва, 125009', '55.7622528,37.6126989', 'https://goo.gl/maps/zCwBfRJaX4dc1QyPA', NULL, 'https://en.mapy.cz/s/homebusega', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (35, 2, 1, 'Золотая Лихорадка', 'Неплохой паб в Перово.', 0, 'http://www.perovobar.ru/', NULL, '+7 495 368 74 60', NULL, 'Перовская ул., 62, Москва, 111394', '55.7449086,37.7945475', 'https://goo.gl/maps/vpMJvaUdDXQnkx7C7', NULL, 'https://en.mapy.cz/s/mepokajuvu', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (36, 2, 4, 'Brasserie Lambic', 'Сеть Brasserie Lambic входит в число лучших пивных ресторанов столицы. Говорящее название сразу подсказывает любителям пенного напитка, что здесь они смогут найти островок настоящей Бельгии, проникнуться духом классической брюссельской брассерии и насладиться большим выбором отличнейшего пива. Здесь одинаково комфортно будут чувствовать себя как любители демократичной атмосферы, так и ценители элитарных заведений.', 0, 'https://6.lambicbar.ru/', NULL, '+7 495 150 14 56', NULL, 'ул. Большая Ордынка, дом 65, Москва, 115184', '55.7314869,37.6243608', 'https://g.page/BrasserieLambic6?share', NULL, 'https://en.mapy.cz/s/duhakecuge', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (37, 2, 5, 'Пилзнер', 'Ресторан с чешской кухней, в котором наливают чешский Пилзнер и Козел, сваренный на заводе в Калуге.

Ресторан расположен в здании, построенном 1904 году, по проекту архитектора Кражецкого и Вашкова С. И. Изначально здесь располагался доходный дом Храма Троицы Живоначальной на Грязех.', 0, 'https://pilsner.ru/', NULL, '+7 495 624-70-03', NULL, 'ул. Покровка, д. 15/16, Москва, 101000', '55.7593347,37.6448731', 'https://goo.gl/maps/5c8nG6qxxCVFnWtB9', NULL, 'https://en.mapy.cz/s/lacaletovu', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (38, 4, 5, 'Vojanův Dvůr', 'Pivovar a restaurace Vojanův dvůr se nachází na Malé Straně, v historických prostorách původního biskupského dvoru ze 13. století. V červenci 2018 byla slavnostně zahájena činnost vlastního pivovaru, čímž se Vojanův dvůr stal prvním minipivovarem na Malé Straně. Pivo zde vaří zkušený sládek ze sesterského pivovaru U tří růží, Robert Maňák. Těšit se můžete na pivní speciály odlišné od běžného sortimentu na trhu.

Šéfkuchař Martin Procházka připravuje delikatesy tradiční české a moravské kuchyně v moderním pojetí. Restaurace s kapacitou až 300 míst nabízí dostatek místa uvnitř i venku na prostorné letní zahrádce, nechybí ani kryté podium, je tedy ideálním prostorem pro svatby, rauty, teambuildingy nebo uzavřenou společnost.', 0, 'https://www.vojanuvdvur.cz/', NULL, '+420 257 532 660', 'info@vojanuvdvur.cz', 'U lužického semináře 119/21, 118 00  Praha, Malá Strana, Praha', '50.0897331,14.4095136', 'https://goo.gl/maps/pKN6QwnbuHcdfGgA8', NULL, 'https://en.mapy.cz/s/kuvetutapa', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (39, 6, 5, 'Друзья', 'Ресторан и пивоварня "Друзья" - это богатая кухня и более 15 сортов собственного пива.', 0, 'https://druzya.by/', NULL, '+375 29 396 58 58', 'banket@druzya.by', 'ул. Кульман 40, Минск, Беларусь', '53.9281344,27.5681797', 'https://g.page/DruzyaBrewery?share', NULL, 'https://en.mapy.cz/s/navedosano', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (40, 6, 5, 'Батлер', 'Современная гастрономия в сочетании с вкусным пивом собственного производства – вот в чем секрет ресторана Батлер, который разместился на бережно отреставрированных двух этажах исторического здания XVIII века в монастырском квартале.', 0, 'https://sp-beer.by/restorany/butler', NULL, '+375 29 396 96 67', NULL, 'ул. Герцена 4, Минск, Беларусь', '53.9049797,27.5580167', 'https://goo.gl/maps/Nvb9YvYUw9zQ7cHA9', NULL, 'https://en.mapy.cz/s/buceruvaso', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (41, 4, 1, 'Vinárna U sv. Anežky', 'Маленький уютный винный бар в котором наливают пиво Бакалар.', 0, 'http://www.svataanezka.cz/', NULL, '+420 222 311 293', 'novokarel@centrum.cz', 'Anežská 807/3, 110 00  Praha, Staré Město, Praha', '50.0918694,14.4239711', 'https://goo.gl/maps/p7hrvmRxTSZLdAN37', NULL, 'https://en.mapy.cz/s/mamecofavo', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (42, 4, 1, 'U Sadu', 'Žižkovská pivnice se zahrádkou a nekuřáckou částí. Minimálně 10 druhů čepovaných piv (Plzeň tank, Sádek 11° - vařeno pouze pro naší pivnici!). Pravidelně piva z malých pivovarů. Belgická trapistická piva a lahvové speciály. Kuchyně (do 4 hod.!) nabízí českou, mezinárodní i vegetariánskou kuchyni, jehněčí maso, snídaňová a polední menu. Pravidelné kulinářské akce. Jukebox, sportovní přenosy, Wi-Fi. Vstup se psy. Dárkové pivní koše a PIKNIK koše. Prodej sudů a půjčovna chlazení. Rozvoz jídel, alkoholu i nealko nápojů po Praze. Catering. Možnost platby kreditní kartou.', 0, 'https://www.usadu.cz/', NULL, '+420 222 727 072', 'usadu@usadu.cz', 'Škroupovo náměstí 1528/6, 130 00  Praha, Žižkov, Praha', '50.0804900,14.4492244', 'https://goo.gl/maps/uPJycW1EzMJcLvar8', NULL, 'https://en.mapy.cz/s/lulofamafe', 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (43, 7, 3, 'Пивной Ларёк', 'Фирменная точка продаж Камышинского Пивзавода. В наличии весь ассортимент пива Пегас. Есть слолик с навесом.', 0, NULL, NULL, NULL, NULL, 'ул. Советская, 27, Камышин, Волгоградская обл., 403873', '50.0815783,45.4031206', 'https://goo.gl/maps/pUhYFiF3nJGwJFZr5', NULL, NULL, 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (44, 7, 3, 'Пивной Ларёк', 'Фирменная точка продаж Камышинского Пивзавода. В наличии весь ассортимент пива Пегас. Есть слолик с навесом.', 0, NULL, NULL, NULL, NULL, NULL, '50.0918800,45.3849031', NULL, NULL, NULL, 0, 0, 0, 1);
INSERT INTO place (_id, city_id, type, name, info, brewery, web, wiki, phone, email, address, location, google, mapsme, mapycz, rating_beer, rating_food, rating_service, enabled) VALUES (45, 7, 3, 'Продажа Пива', 'Фирменная точка продаж Камышинского Пивзавода. В наличии весь ассортимент пива Пегас. Есть слолик с навесом.', 0, NULL, NULL, NULL, NULL, NULL, '50.0909853,45.3743753', 'https://yandex.ru/maps/-/CCQai2UNlD', NULL, 'https://en.mapy.cz/s/pelenuzoke', 0, 0, 0, 1);

-- Таблица: place_tr
DROP TABLE IF EXISTS place_tr;
CREATE TABLE place_tr (_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, place_id INTEGER REFERENCES place (_id) NOT NULL, locale INTEGER REFERENCES locale (code) NOT NULL, name TEXT NOT NULL, comments TEXT, about TEXT, info TEXT, article TEXT);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (1, 1, 'ru_RU', 'Lokál U Bílé kuželky', 'Пилснер Урквел (Plzeňský Prazdroj), Козел (Velkopopovický Kozel)', 'Сеть ресторанов и отелей Lokál предлагает свежее танковое пиво и традиционную чешскую кухню.', 'Тут наливают танковый Пилснер Урквел (Plzeňský Prazdroj) и танковый Темный Козел (Velkopopovický Kozel). Пиво всегда свежее и вкусное.

Lokál пользуются большой популярностью среди местных жителей и студентов. Бывает очень людно, но выпить кружку пива можно всегда!', 'Тут наливают танковый Пилснер Урквел (Plzeňský Prazdroj), причем тремя способами, "Гладинка" (Hladinka - стандартный слой пены), "Молоко" ( - почти полная кружка пены) и "Улитка" ().  Пиво всегла свежее и вкусное.

Lokál пользуются большой популярностью среди местных жителей и студентов.');
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (2, 1, 'en_US', 'Lokál U Bílé kuželky', 'Pilsner Urquell (Plzeňský Prazdroj), Kozel (Velkopopovický Kozel)', 'The restaurant and hotel chain Lokál offers fresh tank beer and traditional Czech cuisine.', 'Pilsner Urquell (Plzeňský Prazdroj) and Kozel (Velkopopovický Kozel) from tanks are poured here. Beer is always fresh and delicious. Lokál is very popular among residents and students. It may be very crowded, but you always can have your glass of beer!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (3, 1, 'cs_rCZ', 'Lokál U Bílé kuželky', 'Plzeňský Prazdroj, Velkopopovický Kozel', 'Řetězec restaurací a hotelů Lokál nabízí čerstvé tankové pivo a tradiční českou kuchyni.', 'Vychutnejte si pečlivě ošetřené pivo a čerstvě navařené domácí jídlo. Pivo u nás putuje co nejkratšími trubkami rovnou do půllitru a zůstává čerstvé až do posledního loku!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (4, 2, 'ru_RU', 'Lokál Dlouhááá', 'Пилснер Урквел (Plzeňský Prazdroj), Козел (Velkopopovický Kozel)', 'Сеть ресторанов и отелей Lokál предлагает свежее танковое пиво и традиционную чешскую кухню.', 'Тут наливают танковый Пилснер Урквел (Plzeňský Prazdroj) и танковый Темный Козел (Velkopopovický Kozel). Пиво всегда свежее и вкусное.

Lokál пользуются большой популярностью среди местных жителей и студентов. Бывает очень людно, но выпить кружку пива можно всегда!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (5, 2, 'en_US', 'Lokál Dlouhááá', 'Pilsner Urquell (Plzeňský Prazdroj), Kozel (Velkopopovický Kozel)', 'The restaurant and hotel chain Lokál offers fresh tank beer and traditional Czech cuisine.', 'Pilsner Urquell (Plzeňský Prazdroj) and Kozel (Velkopopovický Kozel) from tanks are poured here. Beer is always fresh and delicious. Lokál is very popular among residents and students. It may be very crowded, but you always can have your glass of beer!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (6, 2, 'cs_rCZ', 'Lokál Dlouhááá', 'Plzeňský Prazdroj, Velkopopovický Kozel', 'Řetězec restaurací a hotelů Lokál nabízí čerstvé tankové pivo a tradiční českou kuchyni.', 'Vychutnejte si pečlivě ošetřené pivo a čerstvě navařené domácí jídlo. Pivo u nás putuje co nejkratšími trubkami rovnou do půllitru a zůstává čerstvé až do posledního loku!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (7, 3, 'ru_RU', 'Lokál U Zavadilů', 'Пилснер Урквел (Plzeňský Prazdroj), Козел (Velkopopovický Kozel)', 'Сеть ресторанов и отелей Lokál предлагает свежее танковое пиво и традиционную чешскую кухню.', 'Тут наливают танковый Пилснер Урквел (Plzeňský Prazdroj) и танковый Темный Козел (Velkopopovický Kozel). Пиво всегда свежее и вкусное.

Lokál пользуются большой популярностью среди местных жителей и студентов. Бывает очень людно, но выпить кружку пива можно всегда!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (8, 3, 'en_US', 'Lokál U Zavadilů', 'Pilsner Urquell (Plzeňský Prazdroj), Kozel (Velkopopovický Kozel)', 'The restaurant and hotel chain Lokál offers fresh tank beer and traditional Czech cuisine.', 'Pilsner Urquell (Plzeňský Prazdroj) and Kozel (Velkopopovický Kozel) from tanks are poured here. Beer is always fresh and delicious. Lokál is very popular among residents and students. It may be very crowded, but you always can have your glass of beer!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (9, 3, 'cs_rCZ', 'Lokál U Zavadilů', 'Plzeňský Prazdroj, Velkopopovický Kozel', 'Řetězec restaurací a hotelů Lokál nabízí čerstvé tankové pivo a tradiční českou kuchyni.', 'Vychutnejte si pečlivě ošetřené pivo a čerstvě navařené domácí jídlo. Pivo u nás putuje co nejkratšími trubkami rovnou do půllitru a zůstává čerstvé až do posledního loku!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (10, 4, 'ru_RU', 'Lokál Nad Stromovkou', 'Пилснер Урквел (Plzeňský Prazdroj), Козел (Velkopopovický Kozel)', 'Сеть ресторанов и отелей Lokál предлагает свежее танковое пиво и традиционную чешскую кухню.', 'Тут наливают танковый Пилснер Урквел (Plzeňský Prazdroj) и танковый Темный Козел (Velkopopovický Kozel). Пиво всегда свежее и вкусное.

Lokál пользуются большой популярностью среди местных жителей и студентов. Бывает очень людно, но выпить кружку пива можно всегда!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (11, 4, 'en_US', 'Lokál Nad Stromovkou', 'Pilsner Urquell (Plzeňský Prazdroj), Kozel (Velkopopovický Kozel)', 'The restaurant and hotel chain Lokál offers fresh tank beer and traditional Czech cuisine.', 'Pilsner Urquell (Plzeňský Prazdroj) and Kozel (Velkopopovický Kozel) from tanks are poured here. Beer is always fresh and delicious. Lokál is very popular among residents and students. It may be very crowded, but you always can have your glass of beer!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (12, 4, 'cs_rCZ', 'Lokál Nad Stromovkou', 'Plzeňský Prazdroj, Velkopopovický Kozel', 'Řetězec restaurací a hotelů Lokál nabízí čerstvé tankové pivo a tradiční českou kuchyni.', 'Vychutnejte si pečlivě ošetřené pivo a čerstvě navařené domácí jídlo. Pivo u nás putuje co nejkratšími trubkami rovnou do půllitru a zůstává čerstvé až do posledního loku!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (13, 5, 'ru_RU', 'Lokál Hamburk', 'Пилснер Урквел (Plzeňský Prazdroj), Козел (Velkopopovický Kozel)', 'Сеть ресторанов и отелей Lokál предлагает свежее танковое пиво и традиционную чешскую кухню.', 'Тут наливают танковый Пилснер Урквел (Plzeňský Prazdroj) и танковый Темный Козел (Velkopopovický Kozel). Пиво всегда свежее и вкусное.

Lokál пользуются большой популярностью среди местных жителей и студентов. Бывает очень людно, но выпить кружку пива можно всегда!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (14, 5, 'en_US', 'Lokál Hamburk', 'Pilsner Urquell (Plzeňský Prazdroj), Kozel (Velkopopovický Kozel)', 'The restaurant and hotel chain Lokál offers fresh tank beer and traditional Czech cuisine.', 'Pilsner Urquell (Plzeňský Prazdroj) and Kozel (Velkopopovický Kozel) from tanks are poured here. Beer is always fresh and delicious. Lokál is very popular among residents and students. It may be very crowded, but you always can have your glass of beer!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (15, 5, 'cs_rCZ', 'Lokál Hamburk', 'Plzeňský Prazdroj, Velkopopovický Kozel', 'Řetězec restaurací a hotelů Lokál nabízí čerstvé tankové pivo a tradiční českou kuchyni.', 'Vychutnejte si pečlivě ošetřené pivo a čerstvě navařené domácí jídlo. Pivo u nás putuje co nejkratšími trubkami rovnou do půllitru a zůstává čerstvé až do posledního loku!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (16, 6, 'ru_RU', 'Lokál Korunní', 'Пилснер Урквел (Plzeňský Prazdroj), Козел (Velkopopovický Kozel)', 'Сеть ресторанов и отелей Lokál предлагает свежее танковое пиво и традиционную чешскую кухню.', 'Тут наливают танковый Пилснер Урквел (Plzeňský Prazdroj) и танковый Темный Козел (Velkopopovický Kozel). Пиво всегда свежее и вкусное.

Lokál пользуются большой популярностью среди местных жителей и студентов. Бывает очень людно, но выпить кружку пива можно всегда!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (17, 6, 'en_US', 'Lokál Korunní', 'Pilsner Urquell (Plzeňský Prazdroj), Kozel (Velkopopovický Kozel)', 'The restaurant and hotel chain Lokál offers fresh tank beer and traditional Czech cuisine.', 'Pilsner Urquell (Plzeňský Prazdroj) and Kozel (Velkopopovický Kozel) from tanks are poured here. Beer is always fresh and delicious. Lokál is very popular among residents and students. It may be very crowded, but you always can have your glass of beer!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (18, 6, 'cs_rCZ', 'Lokál Korunní', 'Plzeňský Prazdroj, Velkopopovický Kozel', 'Řetězec restaurací a hotelů Lokál nabízí čerstvé tankové pivo a tradiční českou kuchyni.', 'Vychutnejte si pečlivě ošetřené pivo a čerstvě navařené domácí jídlo. Pivo u nás putuje co nejkratšími trubkami rovnou do půllitru a zůstává čerstvé až do posledního loku!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (19, 7, 'ru_RU', 'U Fleků', 'Флековский Лежак (Flekovský Ležák)', 'Мини-пивоварня и ресторан со своим пивом и отличной кухней. Здесь варят один сорт, Флековский Лежак (Flekovský Ležák - темный лагер). Есть внутренний дворик где можно приятно провести время в хорошую погоду.', 'Пивоварня U Fleků (У Флеку) - одна из немногих пивоварен в Центральной Европе, которая непрерывно работает вот уже более 500 лет (первое письменное упоминание относится к 1499 году).

Сам ресторан довольно большой (1200 мест) с несколькими отдельными залами, внутренним двориком и общими столами. Есть магазинчик с сувенирами. Пиво можно купить на вынос. Бывает очень людно.', 'Минипивоварня и ресторан со своим пивом и отличной кухней. Здесь варят один сорт, Флековский Лежак (Flekovský Ležák - темный лагер), есть внутренний дворик где можно приятно провести время в хорошую погоду.

Пивоварня U Fleků (У Флеку) - одна из немногих пивоварен в Центральной Европе, которая непрерывно работает вот уже более 500 лет (первое письменное упоминание относится к 1499 году). С наступлением коммунистического режима пивоварня была национализирована. Первоначальные владельцы (семья Brtníků) смогли его вренуть только после падения режима в 1991 году.

Сам ресторан довольно большой (1200 мест) с несколькими отдельными залами, внутренним двориком и общими столами. Есть магазинчик с сувенирами. Пиво можно купить на вынос.

Как и во многих популярных среди туристов местах, в часы пик (обед и ужин), найти свободный столик бывает не просто.');
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (20, 7, 'en_US', 'U Fleků', 'Flekov Lager (Flekovský Ležák)', 'The microbrewery and the restaurant with its own beer and the delicious cuisine. The only kind of beer is brewed here - Flekov Lager (Flekovský Ležák - dark lager). There is an inner yard where you can wonderfully spend time while a good weather.', 'U Fleků brewery is of few breweries in the Central Eurore that is continiously working for more than 500 years (the first written mention of it refers to 1499).

The restaurant itself is rather big (1200 sits) with several dining rooms, the inner yard and common tables. There is also a souvenir shop. You can buy beer to-go. It may be very crowded.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (21, 7, 'cs_rCZ', 'U Fleků', 'Flekovský Ležák', 'The microbrewery and the restaurant with its own beer and the delicious cuisine. The only kind of beer is brewed here - Flekov Lager (Flekovský Ležák - dark lager). There is an inner yard where you can wonderfully spend time while a good weather.', 'U Fleků brewery is of few breweries in the Central Eurore that is continiously working for more than 500 years (the first written mention of it refers to 1499).

The restaurant itself is rather big (1200 sits) with several dining rooms, the inner yard and common tables. There is also a souvenir shop. You can buy beer to-go. It may be very crowded.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (22, 8, 'ru_RU', 'У Золотого Тигра', 'Пилснер Урквел 12° (Plzeňský Prazdroj 12°)', 'Известная пивная с отличной кухней. Тут наливают один сорт пива, свежайший Пилснер Урквел (Plzeňský Prazdroj).', 'U Zlatého Tygra (У Золотого Тигра) - традиционная Пильзенская пивная в самом сердце старой Праги. Пивная пользуется огромной популярностью как среди местных жителей, так и среди туристов. Попасть сюда бывает довольно сложно.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (23, 8, 'en_US', 'Golden Tiger', 'Pilsner Urquell 12° (Plzeňský Prazdroj 12°)', 'A famous bar with delicious cuisine. The only kind of beer is poured here - the freshest Pilsner Urquell (Plzeňský Prazdroj).', 'U Zlatého Tygra (Golden Tiger) - the traditional Pilsner beer hall with a unique atmosphere in the heart of old Prague. This place is super popular among both locals and tourists. It can be a problem to find a seat.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (24, 8, 'cs_rCZ', 'U Zlatého Tygra', 'Plzeňský Prazdroj 12°', 'Známá pivnice s výbornou kuchyní. Zde se nalije jeden druh piva, čerstvý Plzeňský Prazdroj.', 'Tradiční Plzeňská pivnice s neopakovatelnou atmosférou a koloritem v srdci staré Prahy.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (26, 9, 'ru_RU', 'У Трех роз', 'Несколько сортов собственного пива', 'Мини-пивоварня и ресторан со своим пивом (6 сортов!) и не плохой традиционной кухней.', 'Ресторан трехэтажный, на стенах можно увидеть рисунки художников Йиржи Бернарда и Павла Якла, рассказывающие об истории дома и пивоварения в Чехии. Производством пива руководит опытный пивовар Роберт Маняк. Бывает людно.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (27, 9, 'en_US', 'U Tří růží', 'Несколько сортов собственного пива', 'Мини-пивоварня и ресторан со своим пивом (6 сортов!) и не плохой традиционной кухней.', 'The brewery and restaurant U Tří růží in Prague is situated in the historical center on Husova street close to the famous Charles Bridge and Old Town Square. Right after your entering the feeling of the unique atmosphere of an Old-Prague brewery will overcome you. The feeling is intensified by wall-paintings by artists Jiří Bernard and Pavel Jakl who drew and painted pictures about the history of brewing in the Czech lands as the rich history of the house (the brewery U Tří růží).

You may notice brew-house on the ground floor where under the leadership of our experience brew master Robert Maňák you have the chance to try 6 different beers.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (28, 9, 'cs_rCZ', 'U Tří růží', 'Несколько сортов собственного пива', 'Мини-пивоварня и ресторан со своим пивом (6 сортов!) и не плохой традиционной кухней.', 'Minipivovar a restaurace U Tří růží v Praze se nachází v samotném historickém centru, v Husově ulici v těsné blízkosti Karlova mostu a Staroměstského náměstí. Ihned po vstupu na vás dýchne místní výjimečná atmosféra staropražského pivovaru, kterou umocňují nástěnné malby akademických malířů Jiřího Bernarda a Pavla Jakla, vykreslující obrazy z bohaté historie domu a pivovarnictví v Čechách. V přízemí pivovaru je pak umístěna varna, kde se pod vedením zkušeného sládka Roberta Maňáka vaří šest druhů piva.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (29, 10, 'ru_RU', 'У Двух кошек', 'Кошка Светлое (Světlá Kočka), Кошка Темное (Tmavá Kočka)', 'Ресторан и мини-пивоварня. Здесь варят два вида пива Кошка, светлое и темное.', 'Место пользуется популярностью среди местных, имеет золотой сертификат Pilsner и несколько наград за "Чистые трубки" (Za čisté trubky).

Ресторан разделен на 2 зоны, бар и зал со столиками. Летом в меню появляется вкусный домашний лимонад. Иногда, с утра в будни, можно увидеть, как работает пивовар.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (30, 10, 'en_US', 'U Dvou koček', 'Light Cat (Světlá Kočka), Dark Cat (Tmavá Kočka)', 'The restaurant and microbrewery. Two kinds of beer Koshka are brewed here - the light and the dark one.', 'This place is popular among locals and has Golden Pilsner certificate and several prizes for "Clean tubes" (Za čisté trubky).

The restaraunt is divided into two parts: the bar and the dining room. In summer you can find tasty homemade lemonade here. On some working days in the morning you can see how the brewer works.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (31, 10, 'cs_rCZ', 'U Dvou koček', 'Světlá Kočka, Tmavá Kočka', 'The restaurant and microbrewery. Two kinds of beer Koshka are brewed here - the light and the dark one.', 'This place is popular among locals and has Golden Pilsner certificate and several prizes for "Clean tubes" (Za čisté trubky).

The restaraunt is divided into two parts: the bar and the dining room. In summer you can find tasty homemade lemonade here. On some working days in the morning you can see how the brewer works.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (32, 11, 'ru_RU', 'Монастырская Пивоварня Страгов', 'Sv. Norbert', 'Мини-пивоварня и ресторан на территории Страговского монастыря. Здесь варят несколько сортов пива Sv. Norbert.', 'В пиве Sv. Norbert присутствуют только натуральные ингредиенты - вода, солод, хмель и дрожжи, что соотвтетствует закону о чистоте пива (Reinheitsgebot) от 1516 года. Пиво непастеризованное и нефильтрованное.

Ресторан с отличной кухней. В состав многих блюд входит пиво собственного производства. Бывает очень людно.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (33, 11, 'en_US', 'Strahov Monastic Brewery', 'Sv. Norbert', 'Мини-пивоварня и ресторан на территории Страговского монастыря. Здесь варят несколько сортов пива Sv. Norbert.', 'В пиве Sv. Norbert присутствуют только натуральные ингредиенты - вода, солод, хмель и дрожжи, что соотвтетствует закону о чистоте пива (Reinheitsgebot) от 1516 года. Пиво непастеризованное и нефильтрованное.

Ресторан с отличной кухней. В состав многих блюд входит пиво собственного производства. Бывает очень людно.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (34, 11, 'cs_rCZ', 'Klášterní pivovar Strahov', 'Sv. Norbert', 'Мини-пивоварня и ресторан на территории Страговского монастыря. Здесь варят несколько сортов пива Sv. Norbert.', 'В пиве Sv. Norbert присутствуют только натуральные ингредиенты - вода, солод, хмель и дрожжи, что соотвтетствует закону о чистоте пива (Reinheitsgebot) от 1516 года. Пиво непастеризованное и нефильтрованное.

Ресторан с отличной кухней. В состав многих блюд входит пиво собственного производства. Бывает очень людно.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (35, 12, 'ru_RU', 'U Černého vola', 'Козел (Velkopopovický Kozel)', 'U Černého vola (У Черного быка) - традиционная чешская пивная куда приходят именно попить пива. Находится в двух шагах от Пражской Лореты.', 'U Černého vola (У Черного быка) - традиционная чешская пивная куда приходят именно попить пива. Находится в двух шагах от Пражской Лореты.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (36, 12, 'en_US', 'U Černého vola', 'Kozel (Velkopopovický Kozel)', 'U Černého vola (У Черного быка) - традиционная чешская пивная куда приходят именно попить пива. Находится в двух шагах от Пражской Лореты.', 'U Černého vola (У Черного быка) - традиционная чешская пивная куда приходят именно попить пива. Находится в двух шагах от Пражской Лореты.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (37, 12, 'cs_rCZ', 'U Černého vola', 'Velkopopovický Kozel', 'U Černého vola (У Черного быка) - традиционная чешская пивная куда приходят именно попить пива. Находится в двух шагах от Пражской Лореты.', 'U Černého vola (У Черного быка) - традиционная чешская пивная куда приходят именно попить пива. Находится в двух шагах от Пражской Лореты.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (38, 13, 'ru_RU', 'Potrefená Husa Resslova', 'Старопрамен (Staropramen)', 'Сеть фирменных ресторанов Staropramen. Отличная кухня, свежайшее пиво, приемлемые цены!', 'Рестораны имеют современный интерьер и пользуются популярностью у местных жителей и студентов.

Ассортимент кухни и пива от ресторана к ресторану немного отличается. Но всегда есть блюда из мяса, супы и салаты, а так же несколько сортов свежайшего пива Staropramen.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (39, 13, 'en_US', 'Potrefená Husa Resslova', 'Staropramen', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (40, 13, 'cs_rCZ', 'Potrefená Husa Resslova', 'Staropramen', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (41, 14, 'ru_RU', 'Potrefená Husa Národní', 'Старопрамен (Staropramen)', 'Сеть фирменных ресторанов Staropramen. Отличная кухня, свежайшее пиво, приемлемые цены!', 'Рестораны имеют современный интерьер и пользуются популярностью у местных жителей и студентов.

Ассортимент кухни и пива от ресторана к ресторану немного отличается. Но всегда есть блюда из мяса, супы и салаты, а так же несколько сортов свежайшего пива Staropramen.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (42, 14, 'en_US', 'Potrefená Husa Národní', 'Staropramen', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (43, 14, 'cs_rCZ', 'Potrefená Husa Národní', 'Staropramen', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (44, 15, 'ru_RU', 'Potrefená Husa na Verandách', 'Старопрамен (Staropramen)', 'Сеть фирменных ресторанов Staropramen. Отличная кухня, свежайшее пиво, приемлемые цены!', 'Рестораны имеют современный интерьер и пользуются популярностью у местных жителей и студентов.

Ассортимент кухни и пива от ресторана к ресторану немного отличается. Но всегда есть блюда из мяса, супы и салаты, а так же несколько сортов свежайшего пива Staropramen.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (45, 15, 'en_US', 'Potrefená Husa na Verandách', 'Staropramen', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (46, 15, 'cs_rCZ', 'Potrefená Husa na Verandách', 'Staropramen', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (47, 16, 'ru_RU', 'Potrefená Husa Hybernská', 'Старопрамен (Staropramen)', 'Сеть фирменных ресторанов Staropramen. Отличная кухня, свежайшее пиво, приемлемые цены!', 'Рестораны имеют современный интерьер и пользуются популярностью у местных жителей и студентов.

Ассортимент кухни и пива от ресторана к ресторану немного отличается. Но всегда есть блюда из мяса, супы и салаты, а так же несколько сортов свежайшего пива Staropramen.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (48, 16, 'en_US', 'Potrefená Husa Hybernská', 'Staropramen', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (49, 16, 'cs_rCZ', 'Potrefená Husa Hybernská', 'Staropramen', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (50, 17, 'ru_RU', 'Potrefená Husa Albertov', 'Старопрамен (Staropramen)', 'Сеть фирменных ресторанов Staropramen. Отличная кухня, свежайшее пиво, приемлемые цены!', 'Рестораны имеют современный интерьер и пользуются популярностью у местных жителей и студентов.

Ассортимент кухни и пива от ресторана к ресторану немного отличается. Но всегда есть блюда из мяса, супы и салаты, а так же несколько сортов свежайшего пива Staropramen.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (51, 17, 'en_US', 'Potrefená Husa Albertov', 'Staropramen', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (52, 17, 'cs_rCZ', 'Potrefená Husa Albertov', 'Staropramen', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (53, 18, 'ru_RU', 'Potrefená Husa Vinohrady', 'Старопрамен (Staropramen)', 'Сеть фирменных ресторанов Staropramen. Отличная кухня, свежайшее пиво, приемлемые цены!', 'Рестораны имеют современный интерьер и пользуются популярностью у местных жителей и студентов.

Ассортимент кухни и пива от ресторана к ресторану немного отличается. Но всегда есть блюда из мяса, супы и салаты, а так же несколько сортов свежайшего пива Staropramen.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (54, 18, 'en_US', 'Potrefená Husa Vinohrady', 'Staropramen', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (55, 18, 'cs_rCZ', 'Potrefená Husa Vinohrady', 'Staropramen', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (56, 19, 'ru_RU', 'Potrefená Husa Hlavní Nádraží', 'Старопрамен (Staropramen)', 'Сеть фирменных ресторанов Staropramen. Отличная кухня, свежайшее пиво, приемлемые цены!', 'Рестораны имеют современный интерьер и пользуются популярностью у местных жителей и студентов.

Ассортимент кухни и пива от ресторана к ресторану немного отличается. Но всегда есть блюда из мяса, супы и салаты, а так же несколько сортов свежайшего пива Staropramen.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (57, 19, 'en_US', 'Potrefená Husa Hlavní Nádraží', 'Staropramen', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (58, 19, 'cs_rCZ', 'Potrefená Husa Hlavní Nádraží', 'Staropramen', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', 'Moderní česká i světové kuchyně, vždy čerstvé suroviny ve špičkové kvalitě, široká škála točených piv v čele s tankovým Staropramenem a polední menu jako nikde jinde.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (59, 20, 'ru_RU', 'U Špirků', 'Krušovice', 'Традиционный ресторан U Špirků расположен на улице Kožná, дом № 12, в 50 м от Старогородской площади (Staroměstské náměstí) по направлению к югу. Этот ресторан стал одним из самых известных пражских заведений уже в конце XIX – I пол. XX в.', 'Традиционный ресторан U Špirků расположен на улице Kožná, дом № 12, в 50 м от Старогородской площади (Staroměstské náměstí) по направлению к югу. Этот ресторан стал одним из самых известных пражских заведений уже в конце XIX – I пол. XX в.

Уникальный средневековый характер улицы Kožná и ее расположение в самом центре Праги позволяют посетителям вернуться на несколько веков назад и открыть для себя магию древней Праги. Незабываемое впечатление дополнит вкусная еда и напитки, подаваемые в нашем ресторане, работающем уже с 1870 г. и являющемся одним из старейших пражских заведений подобного рода. Благодаря реконструкции, проведенной в 2004 – 2006 гг., была восстановлена красота изначального интерьера, а также атмосфера конца XIX в.

Стильный винный бар расположен в подвальном этаже, он предлагает 60 уютных мест для отдыха. Оформленный в духе эпохи интерьер, многочисленные элементы искусства и естественный дневной свет, проникающий через интересно технически решенное проходное окно, создают идеальную атмосферу для спокойного ужина или отдыха с бокалом вина. Винный бар и ресторан оборудованы первоклассной вентиляционной системой и системой кондиционирования воздуха, а также полами с подогревом.

По предварительному бронированию можно посидеть на обслуживаемой панорамной террасе, с которой открывается изумительный вид на всю историческую часть Праги.

Кухня с ультрасовременным оборудованием – сердце ресторана, она предлагает нашим посетителям готовые блюда и блюда быстрого приготовления самого высокого качества. Ресторан «U Špirků» – один из немногих ресторанов, в котором ежедневно меняется ассортимент готовых блюд и обеденных меню, предлагаемых по весьма приемлемым ценам. Рабочий коллектив ресторана «U Špirků» убежден, что и сегодня, как и более чем сто сорок лет назад, ресторан «U Špirků» – самый приятный классический ресторан в центре Праги. Мы будем очень рады, если вы сами придете в этом убедиться!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (60, 20, 'en_US', 'U Špirků', 'Krušovice', 'U Špirků is a traditional restaurant situated at 12 Kožná Street, 50 metres south of the Old Town Square. At the end of the 19th century and in the first half of the 20th century this restaurant belonged among the most famous in Prague.', 'U Špirků is a traditional restaurant situated at 12 Kožná Street, 50 metres south of the Old Town Square. At the end of the 19th century and in the first half of the 20th century this restaurant belonged among the most famous in Prague.

The completely extraordinary medieval character of Kožná Street, and its position in the very centre of Prague, allows visitors to travel back several centuries and discover the magic of old Prague. This experience can be enhanced with the delicious food and drinks served in our restaurant, the establishment of which in 1870 makes it one of the oldest restaurants in Prague. Its reconstruction, which took place in 2004-2006, made it possible to restore the beauty of the original interiors including the atmosphere of the late 19th century.

A stylish wine bar is located in the basement and offers comfortable seating for 60 guests. The period character, numerous artistic elements and natural daylight provided by an interesting walk-on window, creates a perfect environment for a quiet dinner or just to sit-down over a glass of wine. Like the restaurant the wine bar is also equipped with a top-class air-conditioning system and heated floor.

It is further possible to take advantage of our services on a panoramic terrace, from which there is a fantastic view of the entire historical part of Prague.

The ultramodern kitchen is the heart of the restaurant operation and creates ready-made and short-order dishes of the highest quality for our guests. U Špirků is one of the few restaurants to offer a changing assortment of meals and lunch menus at very reasonable prices every day. The staff are convinced that today, as it was one hundred and forty years ago, U Špirků is truly the most classic restaurant in the city centre of Prague. We would be very pleased if you come and discover this for yourselves.

', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (61, 20, 'cs_rCZ', 'U Špirků', 'Krušovice', 'Tradiční restaurace U Špirků v Kožné ulici č. 12, se nachází 50 m jižně od Staroměstského náměstí. Tato restaurace patřila mezi nejznámější pražské podniky konce 19. a I. poloviny 20. století.

', 'Tradiční restaurace U Špirků v Kožné ulici č. 12, se nachází 50 m jižně od Staroměstského náměstí. Tato restaurace patřila mezi nejznámější pražské podniky konce 19. a I. poloviny 20. století.

Zcela výjimečný středověký ráz Kožné ulice a její poloha v samém středu Prahy umožňuje návštěvníkům přenést se o několik staletí zpět a poznat kouzlo staré Prahy. Tento zážitek, lze umocnit výborným jídlem a pitím podávaným v naší restauraci, která je provozovaná již od roku 1870 a patří mezi nejstarší Pražské podniky. V letech 2004-2006 provedená rekonstrukce umožnila obnovit krásu původních interiérů včetně atmosféry konce 19. století.

Stylová vinárna se nachází v suterénu a nabízí příjemné posezení 60 hostům. Dobový ráz, četné umělecké prvky a přístup denního světla zajímavě technicky řešeným pochozím oknem, vytváří ideální prostředí pro klidnou večeři či posezení u skleničky vína. Vinárna je stejně jako restaurace vybavena špičkovým vzduchotechnickým a klimatizačním systémem a vytápěnou podlahou.

Na objednávku lze využít služeb obsluhované vyhlídkové terasy, ze které je fantastický výhled na celou historickou část Prahy.

Hypermoderní kuchyňský provoz je srdcem restaurace a pro naše hosty vytváří hotová i minutková jídla v té nejvyšší kvalitě. Jako jedna z mála, má restaurace U Špirků denně obměňovaný sortiment hotových jídel a poledních menu za velmi výhodné ceny. Pracovní tým restaurace U Špirků je přesvědčený o tom, že dnes stejně jako před více než stočtyřiceti lety platí, že nejvýhodnější klasické stravování v centru Prahy je v restauraci U Špirků. Budeme velice rádi, když se sami přijdete přesvědčit.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (63, 21, 'ru_RU', 'U Hrocha', 'Пилснер Урквел (Plzeňský Prazdroj)', 'U Hrocha (У Бегемота) - небольшой бар для любителей качественного пива и хорошей компании.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (64, 21, 'en_US', 'U Hrocha', 'Pilsner Urquell (Plzeňský Prazdroj)', 'U Hrocha (У Бегемота) - небольшой бар для любителей качественного пива и хорошей компании.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (65, 21, 'cs_rCZ', 'U Hrocha', 'Plzeňský Prazdroj', 'Prostě hospoda pro fanoušky kvalitního piva a vybrané společnosti.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (66, 22, 'ru_RU', 'Kozlovna U Paukerta', 'Козел (Velkopopovický Kozel)', 'Enjoy the significant atmosphere of the original restaurants of Velkopopovický Kozel.', 'Enjoy the significant atmosphere of the original restaurants of Velkopopovický Kozel.

Our great czech cuisine works with classic recipes from our ancestors. It is based on traditional domestic procedures and emphasizes the freshness of produce. We do not use any synthetic flavoring or artificial additives. Our professional personnel adds to the unique feeling of the restaurant.

Our trained and beer loving bartenders draft the beer directly from tanks. It always has a foam as thick as a whipped cream. Thanks to its traditional manufacturing process and the use of quality czech ingredient Kozel 11 holds the trademark České pivot (Czech Beer).

Majestic statue, unusual tables with metal hoofs and such details as hooks for clothes. All those elements combined with wood, leather and metal create a pleasant and unforgettable atmosphere of each Kozlovna.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (67, 22, 'en_US', 'Kozlovna U Paukerta', 'Kozel (Velkopopovický Kozel)', 'Enjoy the significant atmosphere of the original restaurants of Velkopopovický Kozel.', 'Enjoy the significant atmosphere of the original restaurants of Velkopopovický Kozel.

Our great czech cuisine works with classic recipes from our ancestors. It is based on traditional domestic procedures and emphasizes the freshness of produce. We do not use any synthetic flavoring or artificial additives. Our professional personnel adds to the unique feeling of the restaurant.

Our trained and beer loving bartenders draft the beer directly from tanks. It always has a foam as thick as a whipped cream. Thanks to its traditional manufacturing process and the use of quality czech ingredient Kozel 11 holds the trademark České pivot (Czech Beer).

Majestic statue, unusual tables with metal hoofs and such details as hooks for clothes. All those elements combined with wood, leather and metal create a pleasant and unforgettable atmosphere of each Kozlovna.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (68, 22, 'cs_rCZ', 'Kozlovna U Paukerta', 'Velkopopovický Kozel', 'Vychutnejte si nezaměnitelnou atmosféru originálních hospod Velkopopovického Kozla.', 'Vychutnejte si nezaměnitelnou atmosféru originálních hospod Velkopopovického Kozla.

Skvělá česká kuchyně s klasickými recepturami od našich předků. Založená na tradičních domácích postupech s důrazem na čerstvost surovin bez použití dochucovadel a umělých přísad. Pocit jedinečnosti dodává i naše profesionální obsluha.

Naši proškolení výčepní mistři milující pivo čepují vynikající velkopopovickou jedenáctku přímo z tanků, vždy s pěnou hustou jako smetana. Kozel 11 drží díky tradičním výrobním postupům a použití kvalitních českých ingrediencí ochrannou známku České pivo.

Majestátní socha Kozla, netradiční stoly s kovovými kopýtky nebo i takové detaily jako háčky na oblečení. Všechny tyto elementy ve spojení s materiály dřeva, kůže i kovu navozují příjemnou a nezapomenutelnou atmosféru každé Kozlovny.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (69, 23, 'ru_RU', 'U Malého Glena', 'Пилснер Урквел (Plzeňský Prazdroj), Бернард (Bernard)', 'Our food menu includes a variety of tasty dishes, fun appetizers and generous main dishes. We serve food styles of various flavors: Czech Cuisines, TexMex and even bagels!', 'Our warm cosy interior in a recently renovated 1600 Baroque Building.  U malého Glena (UMG) is staffed by friendly and knowledgeable personnel.  Serving great food, amazing beers and cocktails.

Upstairs is a spacious BAR with a wide variety of tables and bar stools which can accommodate all size parties with many different configuarations.

Downstairs in our music club, LIVE JAZZ & BLUES shows are presented seven nights a week, with renouned talented musicians from all over the world.

Along side our wide selection of Imported Beer; Guinness, Paulaner, Corona and Heineken we pour delicious Czech Beers including Pilsner Urguell, Velvet and non-pasteurized Bernard. Our amazing bartenders can also offer to make you one of the 50 mixed drinks and cocktails on our menu. You can also enjoy the best offer of other food specials and more traditional drinks.   Our food menu has a wide range for breakfast, lunch and dinner. Items are served from 11 AM until just before midnight.

Our kitchen concentrates on using the best available locally sourced products. 

All of our suppliers are from Prague‘s local markets. You can rely on being served the highest quality meats, vegetables and other ingredients.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (70, 23, 'en_US', 'U Malého Glena', 'Pilsner Urquell (Plzeňský Prazdroj), Bernard', 'Our food menu includes a variety of tasty dishes, fun appetizers and generous main dishes. We serve food styles of various flavors: Czech Cuisines, TexMex and even bagels!', 'Our warm cosy interior in a recently renovated 1600 Baroque Building.  U malého Glena (UMG) is staffed by friendly and knowledgeable personnel.  Serving great food, amazing beers and cocktails.

Upstairs is a spacious BAR with a wide variety of tables and bar stools which can accommodate all size parties with many different configuarations.

Downstairs in our music club, LIVE JAZZ & BLUES shows are presented seven nights a week, with renouned talented musicians from all over the world.

Along side our wide selection of Imported Beer; Guinness, Paulaner, Corona and Heineken we pour delicious Czech Beers including Pilsner Urguell, Velvet and non-pasteurized Bernard. Our amazing bartenders can also offer to make you one of the 50 mixed drinks and cocktails on our menu. You can also enjoy the best offer of other food specials and more traditional drinks.   Our food menu has a wide range for breakfast, lunch and dinner. Items are served from 11 AM until just before midnight.

Our kitchen concentrates on using the best available locally sourced products. 

All of our suppliers are from Prague‘s local markets. You can rely on being served the highest quality meats, vegetables and other ingredients.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (71, 23, 'cs_rCZ', 'U Malého Glena', 'Plzeňský Prazdroj, Bernard', 'U Malého Glena si můžete vybrat z nabídky jak zahraničnich piv (irský Guinness, kvasnicový Paulaner, Corona, Heineken...), tak i vynikajících tuzemských piv (Plzeňský Prazdroj, Budvar, Velvet či nepasterizovaný Bernard).', 'Najdete nás v malebném centru Malé Strany. Ůtulný  interiér v nedávno zrekonstruovaném barokním domě podtrhuje nejen vstřícná obsluha, ale i obsáhlé menu a široký výběr jazzových, bluesových a mezižánrových koncertů v podání předních, zejména domácích, ale i zahraničních hudebníků.

Podnik je rozdělen do dvou částí - BAR & RESTAURANT a  JAZZ & BLUES CLUB – místo každodenních koncertů.

U Malého Glena si můžete vybrat z nabídky jak zahraničnich piv (irský Guinness, kvasnicový Paulaner, Corona, Heineken...), tak i vynikajících tuzemských piv (Plzeňský Prazdroj, Budvar, Velvet či nepasterizovaný Bernard).

Milovníkům vín nabízíme pestrý výběr moravských i zahraničních vín, znalcům koktejlů pak rozsáhlý nápojový lístek obsahující až 50 možných variací. Fanoušci jistě ocení výběr kvalitních rumů a dalších nápojů tradičních a vynikajících značek.

V uvolněné atmosféře naší restaurace podáváme jak pozdní snídaně, obědy i večeře. Jako jedni z mála na Malé straně podáváme jídla až do 23.30h! Veškeré produkty a ingredience, které zpracováváme, vybíráme tak, aby splnily nejpřísnější kritéria. Stejně tak pečlivě dbáme na výběr dodavatelů, kteří vždy patří k těm nejlepším ve svém oboru.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (72, 24, 'ru_RU', 'Hospůdka Na Hradbách', 'Пилснер Урквел (Plzeňský Prazdroj), Козел (Velkopopovický Kozel)', 'Один из трёх пивных садов Праги. Тут можно выпить пива на открытом воздухе и полюбоваться красивым видом.', 'Летом во дворе заведения готовят блюда на гриле (сосиски, мясо, овощи). Так же есть несколько традиционных закусок. Наливают Козел (Velkopopovický Kozel) и Пилснер (Plzeňský Prazdroj). Отличное место, что бы отдохнуть во время посещения Вышеграда!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (73, 24, 'en_US', 'Hospůdka Na Hradbách', 'Pilsner Urquell (Plzeňský Prazdroj), Kozel (Velkopopovický Kozel)', 'Один из трёх пивных садов Праги. Тут можно выпить пива на открытом воздухе и полюбоваться красивым видом.', 'Летом во дворе заведения готовят блюда на гриле (сосиски, мясо, овощи). Так же есть несколько традиционных закусок. Наливают Козел (Velkopopovický Kozel) и Пилснер (Plzeňský Prazdroj). Отличное место, что бы отдохнуть во время посещения Вышеграда!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (74, 24, 'cs_rCZ', 'Hospůdka Na Hradbách', 'Plzeňský Prazdroj, Velkopopovický Kozel', 'Один из трёх пивных садов Праги. Тут можно выпить пива на открытом воздухе и полюбоваться красивым видом.', 'Летом во дворе заведения готовят блюда на гриле (сосиски, мясо, овощи). Так же есть несколько традиционных закусок. Наливают Козел (Velkopopovický Kozel) и Пилснер (Plzeňský Prazdroj). Отличное место, что бы отдохнуть во время посещения Вышеграда!', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (75, 25, 'ru_RU', 'Parka', 'Крафтовое пиво (разливное и бутылочное)', 'Бар крафтового пива в центре Москвы. Большой выбор пива и отличная кухня (особенно блюда на гриле и бургеры).', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (76, 25, 'en_US', 'Parka', 'Крафтовое пиво (разливное и бутылочное)', 'Бар крафтового пива в центре Москвы. Большой выбор пива и отличная кухня (особенно блюда на гриле и бургеры).', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (77, 26, 'ru_RU', 'Варка', 'Крафтовое пиво (разливное и бутылочное)', 'Бар крафтового пива в центре Москвы. Большой выбор пива, вкусные бургеры от BurgerHeroes, пивные закуски. Есть настойки и самогон.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (78, 26, 'en_US', 'Варка', 'Крафтовое пиво (разливное и бутылочное)', 'Бар крафтового пива в центре Москвы. Большой выбор пива, вкусные бургеры от BurgerHeroes, пивные закуски. Есть настойки и самогон.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (79, 27, 'ru_RU', 'Craftland Cultural Bar', 'Крафтовое пиво (разливное и бутылочное)', 'Бар крафтового пива. Не плохой ассортимент, вкусные бургеры, отличная атмосфера.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (80, 27, 'en_US', 'Craftland Cultural Bar', 'Крафтовое пиво (разливное и бутылочное)', 'Бар крафтового пива. Не плохой ассортимент, вкусные бургеры, отличная атмосфера.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (81, 28, 'ru_RU', 'Black Swan', 'Эли, Стауты', 'Паб в центре Москвы с непередаваемой атмосферой, хорошей едой и вкусным пивом.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (82, 28, 'en_US', 'Black Swan', 'Ales, Stouts', 'Паб в центре Москвы с непередаваемой атмосферой, хорошей едой и вкусным пивом.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (83, 29, 'ru_RU', 'Taproom Pivzavod 77', 'Крафтовое пиво (разливное)', 'Фирменный бар пивоварни Pivzavod 77.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (84, 29, 'en_US', 'Taproom Pivzavod 77', 'Крафтовое пиво (разливное)', 'Фирменный бар пивоварни Pivzavod 77.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (85, 31, 'ru_RU', 'Дом, В Котором', 'Крафтовое пиво (разливное и бутылочное)', 'Крафтовый бар с необычным интерьером (в здании бара растёт дерево).', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (86, 31, 'en_US', 'Дом, В Котором', 'Крафтовое пиво (разливное и бутылочное)', 'Крафтовый бар с необычным интерьером (в здании бара растёт дерево).', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (87, 30, 'ru_RU', 'Krombacher Beer Kitchen', 'Пово Кромбахер (Krombacher)', 'Фирменный ресторан Krombacher в Москве. Свежее пиво и хорошая кухня.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (88, 30, 'en_US', 'Krombacher Beer Kitchen', 'Krombacher Beer', 'Фирменный ресторан Krombacher в Москве. Свежее пиво и хорошая кухня.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (89, 32, 'ru_RU', 'Широкую на широкую', 'Собственные настойки, пиво.', 'Бар и рюмочная с отличной атмосферой.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (90, 32, 'en_US', 'Широкую на широкую', 'Собственные настойки, пиво.', 'Бар и рюмочная с отличной атмосферой.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (91, 33, 'ru_RU', 'Зинзиве́р', 'Собственные настойки, пиво.', 'Бар и рюмочная с отличной атмосферой.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (92, 33, 'en_US', 'Зинзиве́р', 'Собственные настойки, пиво.', 'Бар и рюмочная с отличной атмосферой.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (93, 34, 'ru_RU', 'Connolly Station', 'Эли, Стауты', 'Ирландский паб в самом центре Москвы, названый в честь центрального ж/д вокзала в Дублине, открытого в далеком 1844 году. По выходным играет живая музыка.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (94, 34, 'en_US', 'Connolly Station', 'Ales, Stouts', 'Ирландский паб в самом центре Москвы, названый в честь центрального ж/д вокзала в Дублине, открытого в далеком 1844 году. По выходным играет живая музыка.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (95, 35, 'ru_RU', 'Золотая Лихорадка', 'Лагеры, Эли, Стауты', 'Паб в Перово. Хорошая кухня и неплохое пиво.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (96, 35, 'en_US', 'Золотая Лихорадка', 'Lagers, Ales, Stouts', 'Паб в Перово. Хорошая кухня и неплохое пиво.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (97, 36, 'ru_RU', 'Brasserie Lambic', 'Бельгийское пиво (разливное и бутылочное)', 'Классическая бельгийская брассерия (Brasserie) с большим выбором разливного и бутылочного бельгийского пива и неплохой кухней. Заведение не из дешевых.
', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (98, 36, 'en_US', 'Brasserie Lambic', 'Бельгийское пиво (разливное и бутылочное)', 'Классическая бельгийская брассерия (Brasserie) с большим выбором разливного и бутылочного бельгийского пива и неплохой кухней. Заведение не из дешевых.
', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (99, 37, 'ru_RU', 'Пилзнер', 'Козел (Kozel), Пилснер Урквел (Pilsner Urquel)', 'Ресторан с чешской кухней, в котором наливают чешский Пилзнер и Козел, сваренный на заводе в Калуге (очень даже неплох).', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (100, 37, 'en_US', 'Pilsner', 'Kozel, Pilsner Urquell', 'Ресторан с чешской кухней, в котором наливают чешский Пилзнер и Козел, сваренный на заводе в Калуге (очень даже неплох).', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (101, 38, 'ru_RU', 'Vojanův Dvůr', 'Несколько сортов собственного пива', 'Минипивоварня и ресторан со своим пивом. Под руководством опытного пивовара Роберта Маняка, тут варят шесть сортов пива.', 'Пивоварня и ресторан «Воянув двур» (Vojanův dvůr) находятся в пражском районе Мала-Страна, в исторических зданиях первоначальной епископской резиденции XIII века. В июле 2018 года была торжественно открыта сама пивоварня, благодаря чему «Воянув Двур» стал первым мини-пивоваренным заводом в районе Мала-Страна. Пиво здесь варит опытный пивовар Роберт Маньак (Robert Maňák) из сестринской пивоварни «У Трех роз» (U tří růží). Вас ждет пиво, отличающееся от обычного ассортимента на рынке.

Шеф-повар Мартин Прохазка (Martin Procházka) готовит деликатесы традиционной чешской и моравской кухни в современной концепции. Ресторан предлагает большое пространство внутри и снаружи в просторном летнем саду, включая крытый подиум, что делает его идеальным местом для проведения свадеб, раутов, тимбилдинга или закрытых мероприятий.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (102, 38, 'en_US', 'Vojanův Dvůr', 'Несколько сортов собственного пива', 'Vojanův dvůr brewery and restaurant is located in Malá Strana (the Lesser Town) in an historic building that was originally a bishopric court dating back to the 13th century.', 'Vojanův dvůr brewery and restaurant is located in Malá Strana (the Lesser Town) in an historic building that was originally a bishopric court dating back to the 13th century. The grand opening of the brewery was held in July 2018, making Vojanův dvůr the first micro-brewery in Malá Strana. The beer here is brewed by Robert Maňák, an experienced brew master from our sister brewery U tří růží. Under his guidance you can look forward to special beers you won’t find elsewhere.

Head chef Martin Procházka prepares delicacies of traditional Czech and Moravian cuisine with a modern flair. The restaurant has plenty of room inside and out with its spacious summer garden and even boasts a covered podium, making it the ideal space for weddings, banquets, team building and private parties.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (103, 38, 'cs_rCZ', 'Vojanův Dvůr', 'Несколько сортов собственного пива', 'Pivovar a restaurace Vojanův dvůr se nachází na Malé Straně, v historických prostorách původního biskupského dvoru ze 13. století.', 'Pivovar a restaurace Vojanův dvůr se nachází na Malé Straně, v historických prostorách původního biskupského dvoru ze 13. století. V červenci 2018 byla slavnostně zahájena činnost vlastního pivovaru, čímž se Vojanův dvůr stal prvním minipivovarem na Malé Straně. Pivo zde vaří zkušený sládek ze sesterského pivovaru U tří růží, Robert Maňák. Těšit se můžete na pivní speciály odlišné od běžného sortimentu na trhu.

Šéfkuchař Martin Procházka připravuje delikatesy tradiční české a moravské kuchyně v moderním pojetí. Restaurace s kapacitou až 300 míst nabízí dostatek místa uvnitř i venku na prostorné letní zahrádce, nechybí ani kryté podium, je tedy ideálním prostorem pro svatby, rauty, teambuildingy nebo uzavřenou společnost.

', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (104, 39, 'ru_RU', 'Друзья', 'Несколько сортов собственного пива', 'Ресторан и пивоварня "Друзья" - это богатая кухня и более 15 сортов собственного пива.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (105, 39, 'en_US', 'Друзья', 'Несколько сортов собственного пива', 'Ресторан и пивоварня "Друзья" - это богатая кухня и более 15 сортов собственного пива.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (106, 39, 'cs_rCZ', 'Друзья', 'Несколько сортов собственного пива', 'Ресторан и пивоварня "Друзья" - это богатая кухня и более 15 сортов собственного пива.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (107, 40, 'ru_RU', 'Butler', 'Несколько сортов собственного пива', 'Butler (Батлер) - один из ресторанов крупной сети «Староместный пивовар» в самом центре Минска, с живым пивом собственного производства. Уже сейчас в ресторане 8 сортов своего пива.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (108, 40, 'en_US', 'Butler', 'Несколько сортов собственного пива', 'Butler (Батлер) - один из ресторанов крупной сети «Староместный пивовар» в самом центре Минска, с живым пивом собственного производства. Уже сейчас в ресторане 8 сортов своего пива.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (109, 40, 'cs_rCZ', 'Butler', 'Несколько сортов собственного пива', 'Butler (Батлер) - один из ресторанов крупной сети «Староместный пивовар» в самом центре Минска, с живым пивом собственного производства. Уже сейчас в ресторане 8 сортов своего пива.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (110, 41, 'ru_RU', 'Vinárna U sv. Anežky', 'Бакалар (Bakalář)', 'Маленький уютный винный бар в котором наливают пиво Бакалар.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (111, 41, 'en_US', 'Vinárna U sv. Anežky', 'Bakalar (Bakalář)', 'Маленький уютный винный бар в котором наливают пиво Бакалар.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (112, 41, 'cs_rCZ', 'Vinárna U sv. Anežky', 'Bakalář', 'Маленький уютный винный бар в котором наливают пиво Бакалар.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (113, 42, 'ru_RU', 'U Sadu', 'Пилснер Урквел (Plzeňský Prazdroj), Sádek, локальные сорта', 'Жижковский пивной бap с верандой. В асортименте не менее 10 видов пивa на разлив (Pilsen, Svijany, пшеничное, нефильтрованное и тд). Представленны местные небольшие пивоварни.', 'Кухня работает до 2 часов и предлагает чешские, международные и вегетарианские блюда, баранинy, завтраки и обеды. Регулярные кулинарные события. Mузыкальный автомат, спортивные трансляции, Wi-Fi. Bход с собаками. Подарочные пивные корзины. Oплата картaми.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (114, 42, 'en_US', 'U Sadu', 'Pilsner Urquell (Plzeňský Prazdroj),  Sádek, local beer', 'The beerhouse at Žižkov with a small garden and a section for non-smokers. At least 10 kinds of draught beer (Pilsner, Svijany, wheat & non-filtered beer). Regularly beers from small brewerys.', 'The kitchen offers (till up 2 hours AM!) the czech, international and vegetarian meals, lamb meat, breakfast and midday menus. Periodical culinary events. Jukebox, sports broadcasts, Wi-Fi. Entrance with dogs. Beer gift baskets. Sale of beer kegs and rental of refrigeration. Food, alcoholic and alcohol-free drinks delivery service in Prague. Catering. Credit card payment allowed.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (115, 42, 'cs_rCZ', 'U Sadu', 'Plzeňský Prazdroj, Sádek, místní pivo', 'Žižkovská pivnice se zahrádkou a nekuřáckou částí. Minimálně 10 druhů čepovaných piv (Plzeň tank, Sádek 11° - vařeno pouze pro naší pivnici!). Pravidelně piva z malých pivovarů.', 'Belgická trapistická piva a lahvové speciály. Kuchyně (do 4 hod.!) nabízí českou, mezinárodní i vegetariánskou kuchyni, jehněčí maso, snídaňová a polední menu. Pravidelné kulinářské akce. Jukebox, sportovní přenosy, Wi-Fi. Vstup se psy. Dárkové pivní koše a PIKNIK koše. Prodej sudů a půjčovna chlazení. Rozvoz jídel, alkoholu i nealko nápojů po Praze. Catering. Možnost platby kreditní kartou.', NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (116, 43, 'ru_RU', 'Пивной Ларёк', 'Камышинское пиво "Пегас"', 'Фирменная точка продаж Камышинского Пивзавода. В наличии весь ассортимент пива Пегас. Есть столик с навесом.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (117, 43, 'en_US', 'Пивной Ларёк', 'Камышинское пиво "Пегас"', 'Фирменная точка продаж Камышинского Пивзавода. В наличии весь ассортимент пива Пегас. Есть столик с навесом.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (118, 43, 'cs_rCZ', 'Пивной Ларёк', 'Камышинское пиво "Пегас"', 'Фирменная точка продаж Камышинского Пивзавода. В наличии весь ассортимент пива Пегас. Есть столик с навесом.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (119, 44, 'ru_RU', 'Пивной Ларёк', 'Камышинское пиво "Пегас"', 'Фирменная точка продаж Камышинского Пивзавода. В наличии весь ассортимент пива Пегас. Есть столик с навесом.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (120, 44, 'en_US', 'Пивной Ларёк', 'Камышинское пиво "Пегас"', 'Фирменная точка продаж Камышинского Пивзавода. В наличии весь ассортимент пива Пегас. Есть столик с навесом.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (121, 44, 'cs_rCZ', 'Пивной Ларёк', 'Камышинское пиво "Пегас"', 'Фирменная точка продаж Камышинского Пивзавода. В наличии весь ассортимент пива Пегас. Есть столик с навесом.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (122, 45, 'ru_RU', 'Продажа Пива', 'Камышинское пиво "Пегас"', 'Фирменная точка продаж Камышинского Пивзавода. В наличии весь ассортимент пива Пегас. Есть столик с навесом.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (123, 45, 'en_US', 'Продажа Пива', 'Камышинское пиво "Пегас"', 'Фирменная точка продаж Камышинского Пивзавода. В наличии весь ассортимент пива Пегас. Есть столик с навесом.', NULL, NULL);
INSERT INTO place_tr (_id, place_id, locale, name, comments, about, info, article) VALUES (124, 45, 'cs_rCZ', 'Продажа Пива', 'Камышинское пиво "Пегас"', 'Фирменная точка продаж Камышинского Пивзавода. В наличии весь ассортимент пива Пегас. Есть столик с навесом.', NULL, NULL);

-- Таблица: place_type
DROP TABLE IF EXISTS place_type;
CREATE TABLE place_type (_id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, name TEXT NOT NULL);
INSERT INTO place_type (_id, name) VALUES (1, 'Bar');
INSERT INTO place_type (_id, name) VALUES (2, 'Pub');
INSERT INTO place_type (_id, name) VALUES (3, 'Taproom');
INSERT INTO place_type (_id, name) VALUES (4, 'Brasserie');
INSERT INTO place_type (_id, name) VALUES (5, 'Restaurant');
INSERT INTO place_type (_id, name) VALUES (6, 'Beer Garden');
INSERT INTO place_type (_id, name) VALUES (7, 'Shot Glass');

-- Таблица: place_type_tr
DROP TABLE IF EXISTS place_type_tr;
CREATE TABLE place_type_tr (_id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, place_type_id INTEGER REFERENCES place_type (_id), locale TEXT REFERENCES locale (code) NOT NULL, name TEXT NOT NULL, info TEXT);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (1, 1, 'ru_RU', 'Бар', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (2, 2, 'ru_RU', 'Паб', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (3, 3, 'ru_RU', 'Пивная', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (4, 4, 'ru_RU', 'Брассерия', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (5, 5, 'ru_RU', 'Ресторан', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (6, 6, 'ru_RU', 'Пивной Сад', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (7, 1, 'en_US', 'Bar', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (8, 2, 'en_US', 'Pub', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (9, 3, 'en_US', 'Taproom', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (10, 4, 'en_US', 'Brasserie', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (11, 5, 'en_US', 'Rrestaurant', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (12, 6, 'en_US', 'Beer Garden', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (13, 1, 'cs_rCZ', 'Bar', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (14, 2, 'cs_rCZ', 'Výčep', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (15, 3, 'cs_rCZ', 'Pivnice', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (16, 4, 'cs_rCZ', 'Brasserie', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (17, 5, 'cs_rCZ', 'Restaurace', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (18, 6, 'cs_rCZ', 'Zahrádka', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (19, 7, 'ru_RU', 'Рюмочная', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (20, 7, 'en_US', 'Shot Glass', NULL);
INSERT INTO place_type_tr (_id, place_type_id, locale, name, info) VALUES (21, 7, 'cs_rCZ', 'Shot Glass', NULL);

-- Таблица: serving
DROP TABLE IF EXISTS serving;
CREATE TABLE serving (_id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, draft BOOLEAN NOT NULL, name TEXT);
INSERT INTO serving (_id, draft, name) VALUES (1, 'true', 'Keg');
INSERT INTO serving (_id, draft, name) VALUES (2, 'false', 'Bottle');
INSERT INTO serving (_id, draft, name) VALUES (3, 'true', 'Tank');
INSERT INTO serving (_id, draft, name) VALUES (4, 'true', 'Cask');

-- Таблица: serving_tr
DROP TABLE IF EXISTS serving_tr;
CREATE TABLE serving_tr (_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, serving_id INTEGER REFERENCES serving (_id) NOT NULL, locale INTEGER REFERENCES locale (code) NOT NULL, name TEXT NOT NULL, info TEXT);
INSERT INTO serving_tr (_id, serving_id, locale, name, info) VALUES (1, 1, 'ru_RU', 'Кег', 'Самый распространенный способ доставки пива. Привычная всем кега.');
INSERT INTO serving_tr (_id, serving_id, locale, name, info) VALUES (2, 1, 'en_US', 'Keg', 'The most common way to deliver beer. The usual keg.');
INSERT INTO serving_tr (_id, serving_id, locale, name, info) VALUES (3, 2, 'ru_RU', 'Бутылка', 'Просто бутылочное пиво.');
INSERT INTO serving_tr (_id, serving_id, locale, name, info) VALUES (4, 2, 'en_US', 'Bottle', 'Just bottled beer.');
INSERT INTO serving_tr (_id, serving_id, locale, name, info) VALUES (5, 3, 'ru_RU', 'Танк', 'Большая кега. Срок годности меньше - пиво свежее.');
INSERT INTO serving_tr (_id, serving_id, locale, name, info) VALUES (6, 3, 'en_US', 'Tank', 'Beer from a tank. Tank is a big keg. The expiration date is less, the beer is fresh.');
INSERT INTO serving_tr (_id, serving_id, locale, name, info) VALUES (7, 4, 'ru_RU', 'Каск', 'Бочковое пиво естественной газации. Обычно так разливают эли.');
INSERT INTO serving_tr (_id, serving_id, locale, name, info) VALUES (8, 4, 'en_US', 'Cask', 'Cask beer with natural gasification. Englist way for ales.');

-- Таблица: style
DROP TABLE IF EXISTS style;
CREATE TABLE style (_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, name TEXT NOT NULL DEFAULT 'Unknown', info TEXT);
INSERT INTO style (_id, name, info) VALUES (1, 'Unknown', NULL);
INSERT INTO style (_id, name, info) VALUES (2, 'Czech Pale Lager', NULL);
INSERT INTO style (_id, name, info) VALUES (3, 'Czech Premium Pale Lager', NULL);
INSERT INTO style (_id, name, info) VALUES (4, 'Czech Amber Lager', NULL);
INSERT INTO style (_id, name, info) VALUES (5, 'Czech Dark Lager', NULL);
INSERT INTO style (_id, name, info) VALUES (6, 'Czech Pilsner', NULL);
INSERT INTO style (_id, name, info) VALUES (7, 'Pale Ale', NULL);
INSERT INTO style (_id, name, info) VALUES (8, 'American Pale Ale (APA)', NULL);
INSERT INTO style (_id, name, info) VALUES (9, 'Indian Pale Ale (IPA)', NULL);
INSERT INTO style (_id, name, info) VALUES (10, 'Brown Ale', NULL);
INSERT INTO style (_id, name, info) VALUES (11, 'Czech Special Lager', NULL);

-- Таблица: style_tr
DROP TABLE IF EXISTS style_tr;
CREATE TABLE style_tr (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, style_id INTEGER NOT NULL DEFAULT 1 REFERENCES style (_id), locale INTEGER REFERENCES locale (code), name TEXT NOT NULL DEFAULT 'Unknown', info TEXT);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (1, 1, 'en_US', 'Unknown', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (2, 1, 'ru_RU', 'Неизвестный', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (3, 2, 'ru_RU', 'Светлый Чешский Лагер', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (4, 3, 'ru_RU', 'Светлый Премиальный Чешский Лагер', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (5, 4, 'ru_RU', 'Янтарный Чешский Лагер', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (6, 5, 'ru_RU', 'Темный Чешский Лагер', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (7, 2, 'en_US', 'Czech Pale Lager', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (8, 3, 'en_US', 'Czech Premium Pale Lager', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (9, 4, 'en_US', 'Czech Amber Lager', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (10, 5, 'en_US', 'Czech Dark Lager', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (11, 6, 'ru_RU', 'Чешский Пилснер', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (12, 6, 'en_US', 'Czech Pilsner', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (13, 7, 'ru_RU', 'Светлый Эль', 'Светлое пиво верхового брожения.');
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (14, 7, 'en_US', 'Pale Ale', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (15, 8, 'ru_RU', 'American Pale Ale (APA)', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (16, 8, 'en_US', 'American Pale Ale (APA)', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (17, 9, 'ru_RU', 'Indian Pale Ale (IPA)', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (18, 9, 'en_US', 'Indian Pale Ale (IPA)', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (19, 10, 'ru_RU', 'Коричневый Эль', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (20, 10, 'en_US', 'Brown Ale', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (21, 11, 'ru_RU', 'Чешский Специальный Лагер', NULL);
INSERT INTO style_tr (id, style_id, locale, name, info) VALUES (22, 11, 'en_US', 'Czech Special Lager', NULL);

-- Таблица: tourist_poi
DROP TABLE IF EXISTS tourist_poi;
CREATE TABLE tourist_poi (_id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, name TEXT NOT NULL, info TEXT, web TEXT, wiki TEXT, phone TEXT, email TEXT, address TEXT, location TEXT NOT NULL, google TEXT, mapsme TEXT, mapycz TEXT, comments TEXT);

-- Таблица: tourist_poi_tr
DROP TABLE IF EXISTS tourist_poi_tr;
CREATE TABLE tourist_poi_tr (_id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, tourist_poi_id INTEGER REFERENCES tourist_poi (_id) NOT NULL, name TEXT NOT NULL, about TEXT NOT NULL, article TEXT);

-- Таблица: tourist_route
DROP TABLE IF EXISTS tourist_route;
CREATE TABLE tourist_route (_id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, name TEXT NOT NULL, about TEXT NOT NULL, info TEXT);

-- Таблица: tourist_route_poi
DROP TABLE IF EXISTS tourist_route_poi;
CREATE TABLE tourist_route_poi (_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, tourist_route_id INTEGER REFERENCES tourist_route (_id) NOT NULL, tourist_poi_id INTEGER REFERENCES tourist_poi (_id) NOT NULL, number INTEGER DEFAULT (0) NOT NULL);

-- Триггер: delete_tr
DROP TRIGGER IF EXISTS delete_tr;
CREATE TRIGGER delete_tr AFTER DELETE ON country FOR EACH ROW BEGIN DELETE FROM country_tr WHERE country_tr.country_id = OLD.id; END;

-- Триггер: place_delete
DROP TRIGGER IF EXISTS place_delete;
CREATE TRIGGER place_delete BEFORE DELETE ON place FOR EACH ROW BEGIN DELETE FROM beer_place WHERE place_beer.place_id = OLD._id; END;

-- Представление: view_beer
DROP VIEW IF EXISTS view_beer;
CREATE VIEW view_beer AS SELECT beer._id,
       beer.brewery_id,
       beer_tr.locale,
       view_style.name AS style,
       beer.abv,
       brewery_tr.name AS brewery_name,
       brewery.name AS brewery_origin_name,
       beer_tr.name AS beer_name,
       beer_tr.info AS beer_info,
       beer.name AS origin_name,
       beer.info AS origin_info
  FROM beer,
       beer_tr,
       brewery,
       brewery_tr,
       view_style
 WHERE beer.brewery_id = brewery._id AND 
       beer_tr.beer_id = beer._id AND 
       brewery_tr.brewery_id = brewery._id AND 
       beer.style_id = view_style._id AND 
       view_style.locale = beer_tr.locale AND 
       beer_tr.locale = brewery_tr.locale
 ORDER BY beer_tr.locale,
          brewery_tr.name;

-- Представление: view_beer_city
DROP VIEW IF EXISTS view_beer_city;
CREATE VIEW view_beer_city AS SELECT DISTINCT view_beer._id,
                view_beer.brewery_id,
                view_place.city_id,
                view_beer.locale,
                view_place.country,
                view_place.city,
                view_beer.style,
                view_beer.brewery_name,
                view_beer.beer_name,
                view_beer.beer_info
  FROM beer_place,
       view_beer,
       view_place
 WHERE beer_place.beer_id = view_beer._id AND 
       beer_place.place_id = view_place._id AND 
       view_beer.locale = view_place.locale
 ORDER BY view_beer.beer_name;

-- Представление: view_beer_place
DROP VIEW IF EXISTS view_beer_place;
CREATE VIEW view_beer_place AS SELECT beer_place._id,
       beer_place.beer_id,
       beer_place.place_id,
       view_beer.brewery_id,
       view_place.city_id,
       view_beer.locale,
       view_place.country,
       view_place.city,
       view_place.name AS place_name,
       view_place.about AS place_about,
       view_place.info AS place_info,
       view_place.comments,
       view_beer.style,
       view_beer.brewery_name,
       view_beer.beer_name,
       view_beer.beer_info,
       view_place.phone,
       view_place.web,
       view_place.email,
       view_place.address,
       view_place.location
  FROM beer_place,
       view_beer,
       view_place
 WHERE beer_place.beer_id = view_beer._id AND 
       beer_place.place_id = view_place._id AND 
       view_beer.locale = view_place.locale
 ORDER BY view_beer.locale,
          view_place.name,
          view_beer.beer_name;

-- Представление: view_brewery
DROP VIEW IF EXISTS view_brewery;
CREATE VIEW view_brewery AS SELECT brewery._id,
       brewery_tr.locale,
       brewery_tr.name,
       brewery_tr.about,
       brewery_tr.info,
       brewery.name AS origin_name,
       brewery.info AS origin_info,
       brewery.small,
       brewery.phone,
       brewery.web,
       brewery.email,
       brewery.address,
       brewery.location,
       brewery.google,
       brewery.mapsme,
       brewery.mapycz,
       brewery.enabled
  FROM brewery,
       brewery_tr,
       locale
 WHERE brewery._id = brewery_tr.brewery_id AND 
       brewery_tr.locale = locale.code AND 
       brewery.enabled = 1
 ORDER BY brewery_tr.locale,
          brewery.name,
          brewery_tr.name;

-- Представление: view_city
DROP VIEW IF EXISTS view_city;
CREATE VIEW view_city AS SELECT city._id,
       city.country_id,
       city_tr.locale,
       country_tr.name AS country,
       city_tr.name,
       city_tr.about,
       city_tr.info,
       city.name AS origin_name,
       city.info AS origin_info,
       city.sku,
       city.location,
       city.google,
       city.mapsme,
       city.mapycz,
       city.enabled
  FROM city,
       country,
       city_tr,
       country_tr
 WHERE city.country_id = country._id AND 
       country._id = country_tr.country_id AND 
       city._id = city_tr.city_id AND 
       city_tr.locale = country_tr.locale AND 
       city.enabled = 1 AND 
       country.enabled = 1
 ORDER BY city_tr.locale;

-- Представление: view_country
DROP VIEW IF EXISTS view_country;
CREATE VIEW view_country AS SELECT country._id,
       country_tr.locale,
       country_tr.name,
       country_tr.about,
       country_tr.info,
       country.name AS origin_name,
       country.info AS origin_info,
       country.web,
       country.wiki,
       country.location,
       country.google,
       country.mapycz,
       country.mapsme,
       country.yandex,
       country.enabled
  FROM country,
       country_tr,
       locale
 WHERE country_tr.country_id = country._id AND 
       country_tr.locale = locale.code AND 
       country.enabled = 1 and locale.enabled = 1
 ORDER BY locale.code,
          country_tr.name;

-- Представление: view_place
DROP VIEW IF EXISTS view_place;
CREATE VIEW view_place AS SELECT place._id,
       place.city_id,
       place_tr.locale,
       view_city.country,
       view_city.name AS city,
       place_tr.name AS name,
       place.name AS origin_name,
       place_tr.about AS about,
       place_tr.info,
       place.info AS origin_info,
       place_tr.comments,
       place.phone,
       place.web,
       place.email,
       place.address,
       place.location,
       place.google,
       place.mapsme,
       place.mapycz,
       place.rating_beer,
       place.rating_food,
       place.rating_service,
       place.enabled
  FROM place,
       place_tr,
       view_city
 WHERE place_tr.place_id = place._id AND 
       place.city_id = view_city._id AND 
       place_tr.locale = view_city.locale AND 
       place.enabled = 1
 ORDER BY place_tr.locale,
          view_city.country,
          view_city.name,
          place_tr.name;

-- Представление: view_place_type
DROP VIEW IF EXISTS view_place_type;
CREATE VIEW view_place_type AS SELECT place_type._id,
       place_type.name AS origin_name,
       place_type_tr.locale,
       place_type_tr.name,
       place_type_tr.info
  FROM place_type,
       place_type_tr,
       locale
 WHERE place_type_tr.place_type_id = place_type._id AND 
       place_type_tr.locale = locale.code;

-- Представление: view_serving
DROP VIEW IF EXISTS view_serving;
CREATE VIEW view_serving AS SELECT serving._id,
       serving_tr.locale,
       serving.draft,
       serving_tr.name,
       serving_tr.info
  FROM serving,
       serving_tr,
       locale
 WHERE serving._id = serving_tr.serving_id AND 
       serving_tr.locale = locale.code
 ORDER BY locale.code,
          serving_tr.name;

-- Представление: view_style
DROP VIEW IF EXISTS view_style;
CREATE VIEW view_style AS SELECT style._id,
       style_tr.locale AS locale,
       style_tr.name AS name,
       style_tr.info AS info
  FROM style,
       style_tr,
       locale
 WHERE style_tr.style_id = style._id AND 
       style_tr.locale = locale.code;

-- Представление: view_test
DROP VIEW IF EXISTS view_test;
CREATE VIEW view_test AS SELECT *
  FROM view_beer_place
 WHERE view_beer_place.place_id = 6 AND 
       view_beer_place.locale = 'ru_RU';

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
