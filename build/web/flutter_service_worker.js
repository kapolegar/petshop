'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "e7c891e4f75acbe65570d2c487e260b8",
"assets/AssetManifest.bin.json": "8f266a1b7eb7c8238c1b4a4f4701fbdf",
"assets/AssetManifest.json": "d9556453af5c2a3d8c3a124145611eec",
"assets/assets/data/horarios_banho_e_tosa.json": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/data/horarios_consulta.json": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/data/pets.json": "b2df5691456f20c920b7eee228200a1e",
"assets/assets/data/products.json": "bdbb14d466a94947935ef3816655cb45",
"assets/assets/fonts/NunitoSans.ttf": "e7f409eb0d8afdc0e025cc2bd0987e4f",
"assets/assets/fonts/NunitoSansBold.ttf": "5eca7f02cd39e97bdb62f4fd6221c4ce",
"assets/assets/images/account.png": "4980891be302d18a0f7de61570e56e14",
"assets/assets/images/banners/banner1.png": "e8a7a2fa739fa4a60cc2056546b0bc3a",
"assets/assets/images/banners/banner2.png": "fde7ffff29af7e94cedd4e75d974d1f0",
"assets/assets/images/banners/banner3.png": "8f8a5a3cee040bf28f263ef7a94fc81b",
"assets/assets/images/banners/banner4.png": "21be77517a6237bfa6dd86993af2ad9d",
"assets/assets/images/cart.png": "c7a0780ae68fc5c09884112c547da871",
"assets/assets/images/contact.png": "e71c36aa124b587bca76bb4ebfae5016",
"assets/assets/images/pets/anya.png": "1961b338666f269e1f769cfa07969b31",
"assets/assets/images/pets/gigi.png": "1c5497c7a9c109fd3192552797c1f968",
"assets/assets/images/pets/mia.png": "6027f1bd897a7fa244564e6d40129b67",
"assets/assets/images/pets/pepper.png": "dc19672a060e3af6b5bbc980d395914f",
"assets/assets/images/petshop_logo.png": "fb045a41d94395d71fc0aea18e553fcb",
"assets/assets/images/petshop_logo_old.png": "75b46a2b155abd771f02cef270e72d9d",
"assets/assets/images/products/aquario1.jpg": "33beda74fe5e66ea830d925b2923d6d9",
"assets/assets/images/products/aquario2.jpg": "b04daefcf959303c3d8753105d477c25",
"assets/assets/images/products/aquario3.jpg": "13d265e36a93f04a94214ceaeda94fb4",
"assets/assets/images/products/aquario4.jpg": "bc107990faf5c5b27e1637fe29dc7513",
"assets/assets/images/products/aquario5.jpg": "ba74448881e6c9fed613f1e3fb6f6b73",
"assets/assets/images/products/areia1.jpg": "781e36a3a117472882da31323860cd4c",
"assets/assets/images/products/areia10.jpg": "af9b7474b8f5fd3b490b6347b34f7d3a",
"assets/assets/images/products/areia2.jpg": "a710764d38e3ad9bdb1d7d2f2c79b2ab",
"assets/assets/images/products/areia3.jpg": "87744debfa451ef5c51c05cfbbf7f9d0",
"assets/assets/images/products/areia4.jpg": "1df77e72a5581743ba111406b53e78a1",
"assets/assets/images/products/areia5.jpg": "bc82b9aab6183191e48f167cad5726a2",
"assets/assets/images/products/areia6.jpg": "4d0acf0deeb26c7eeba045a5d4f977ab",
"assets/assets/images/products/areia7.jpg": "1a341a6c9caf6a0bcd9ff4b3995b757b",
"assets/assets/images/products/areia8.jpg": "8121d26a32ba83a233f969e846e68794",
"assets/assets/images/products/areia9.jpg": "8a49db50d53cadffe4f9c0096a8b438c",
"assets/assets/images/products/arranhador1.jpg": "9a5102b7dd22088f5122e4d677807c38",
"assets/assets/images/products/arranhador10.jpg": "ad3ab7c11ae28fa3644ab31140132faf",
"assets/assets/images/products/arranhador2.jpg": "b48f2030d84b820917a1e942c8b92c4c",
"assets/assets/images/products/arranhador3.jpg": "6ddc8a52c3102e555312339e2322e98e",
"assets/assets/images/products/arranhador4.jpg": "b0e264dfd6d2222fd79202756be71897",
"assets/assets/images/products/arranhador5.jpg": "1d39db19ebd55888f08f2c3f6c0c2c12",
"assets/assets/images/products/arranhador6.jpg": "9800d5fea82a5a327d0fbd9e891b7377",
"assets/assets/images/products/arranhador7.jpg": "f7b5d1b09a4fcde2e1a3d2da17709bd1",
"assets/assets/images/products/arranhador8.jpg": "0d9f355c52aec0b4e330ce350a1f2fe6",
"assets/assets/images/products/arranhador9.jpg": "f6341cf7121a2e747b3e977a74cd606c",
"assets/assets/images/products/brinquedo1.jpg": "63655a52014b2254cb956a0d383abb06",
"assets/assets/images/products/brinquedo10.jpg": "5427651f61da61718b5272482f8b49cc",
"assets/assets/images/products/brinquedo2.jpg": "9a807f32675271fa56a03f15a2923619",
"assets/assets/images/products/brinquedo3.jpg": "354aa07b56dc50a0582d2b17f9e09ce2",
"assets/assets/images/products/brinquedo4.jpg": "fb9632d28908b67632ab0b0378680dbc",
"assets/assets/images/products/brinquedo5.jpg": "41d7839eb12be25638bac459533c6eea",
"assets/assets/images/products/brinquedo6.jpg": "211f02e55d1025306858c79e9246da4b",
"assets/assets/images/products/brinquedo7.jpg": "df47385ed58eae01e8bda7cce95959f5",
"assets/assets/images/products/brinquedo8.jpg": "29bdd78cb13883de11d57d142789c541",
"assets/assets/images/products/brinquedo9.jpg": "695311811a07281b209b2a63899f8969",
"assets/assets/images/products/brinquedo_passaro1.jpg": "ef5e562c1543033d37a0c1aa4f62d2ff",
"assets/assets/images/products/brinquedo_passaro10.jpg": "2edc0f27977241f67400c17276a02e8a",
"assets/assets/images/products/brinquedo_passaro2.jpg": "22d71bcbc7399d05942693c3425cd1fb",
"assets/assets/images/products/brinquedo_passaro3.jpg": "3a6665e38a56ba5844f2192fed3ef846",
"assets/assets/images/products/brinquedo_passaro4.jpg": "f26aa1415cdf37c467dc65fc57894a76",
"assets/assets/images/products/brinquedo_passaro5.jpg": "ef69a824d88f4f89edd8dc1dac0261c8",
"assets/assets/images/products/brinquedo_passaro6.jpg": "4126476226b10b121e13e26d154b9b2b",
"assets/assets/images/products/brinquedo_passaro7.jpg": "299055a9b7f0dea67c61f262ffcce3ad",
"assets/assets/images/products/brinquedo_passaro8.jpg": "2a3fa1c3ad61a707dd6372c39a595fa3",
"assets/assets/images/products/brinquedo_passaro9.jpg": "6d6a10f3678686e17b7287d940b2a131",
"assets/assets/images/products/cama1.jpg": "2ed82543b63468e37ba0d938b933ca66",
"assets/assets/images/products/cama10.jpg": "ac8e06de4c8482198b42e512f40a18ff",
"assets/assets/images/products/cama2.jpg": "76090fc96bdf4fd8dd801c7be2aff347",
"assets/assets/images/products/cama3.jpg": "12c2c19e294a1706411b9e70001c06bd",
"assets/assets/images/products/cama4.jpg": "3187d771e7a40928890c31805a4f5a4d",
"assets/assets/images/products/cama5.jpg": "ade032c4adb9e9ce4c7efefca22813e4",
"assets/assets/images/products/cama6.jpg": "195da22eaf2d14cab5e5fa88c91f7ffe",
"assets/assets/images/products/cama7.jpg": "c1da87df4bb827f3a4fefc24fdc8d1dc",
"assets/assets/images/products/cama8.jpg": "1ab1b2ba64d5d03c22eb024ad3ec2edb",
"assets/assets/images/products/cama9.jpg": "3a9782d6d2d3ba87ea66d033cc7aba5b",
"assets/assets/images/products/coleira1.jpg": "d3d029b71fe2e7fb6f6bb3c5f534386a",
"assets/assets/images/products/coleira10.jpg": "871e7caa706429640486ac6e823367b1",
"assets/assets/images/products/coleira2.jpg": "192da7bacd4bc0f7be05a21ec25494a1",
"assets/assets/images/products/coleira3.jpg": "449e785cf70fa72361a1cacdefe83522",
"assets/assets/images/products/coleira4.jpg": "ca7a896e78de4065c42e78f46977ef79",
"assets/assets/images/products/coleira5.jpg": "eee0aa47c296d8d4a6092875f0f67d89",
"assets/assets/images/products/coleira6.jpg": "056ed69fbed682ff34046974afb19f3e",
"assets/assets/images/products/coleira7.jpg": "4b442f6ce28570cd16f23e377e3e79d2",
"assets/assets/images/products/coleira8.jpg": "1b6662e669955811b16acce48f90e4e3",
"assets/assets/images/products/coleira9.jpg": "69620fc9824bec63022e2cff5d0280fa",
"assets/assets/images/products/comedouro1.jpg": "c1fdf8c97954f029110ee1a98424b8a2",
"assets/assets/images/products/comedouro2.jpg": "620b68d0ae38873498f76c3b445536a2",
"assets/assets/images/products/comedouro3.jpg": "f80257cde4374a2dfbbcb552d64f98fa",
"assets/assets/images/products/comedouro_gatos1.jpg": "5d2161b236f458eeaed375a79acbc786",
"assets/assets/images/products/comedouro_gatos2.jpg": "52395469b9b4720f9d30efb532c18f24",
"assets/assets/images/products/comedouro_gatos3.jpg": "f2e5a265a51b817c0969ad3b53c86849",
"assets/assets/images/products/fonte1.jpg": "994fc9a4b4a8067c65c3757a9c46ee7e",
"assets/assets/images/products/fonte2.jpg": "bca5a98d60d4842c1325515e227e88d9",
"assets/assets/images/products/fonte3.jpg": "415572f44f1234f8b3b70b7d2a788f22",
"assets/assets/images/products/gaiola1.jpg": "a36832462430c29f9d616b0a896b39b1",
"assets/assets/images/products/gaiola10.jpg": "18a32062465aad32c0757b43a8fbff53",
"assets/assets/images/products/gaiola2.jpg": "e3865e469371549cee384e57276e26e5",
"assets/assets/images/products/gaiola3.jpg": "7a2ac1c443a2403899321f688aacb1ad",
"assets/assets/images/products/gaiola4.jpg": "c6f14188dfac35fd24187d4e8d837844",
"assets/assets/images/products/gaiola5.jpg": "1c6ad945338ec49c1f20da909f76f3b3",
"assets/assets/images/products/gaiola6.jpg": "3ac89597b2c1c3c54b6259312c849d57",
"assets/assets/images/products/gaiola7.jpg": "6cd12044ded2c2929dcdedd951994c26",
"assets/assets/images/products/gaiola8.jpg": "d6669fe7f36302a9611c8f7fc33b80bb",
"assets/assets/images/products/gaiola9.jpg": "3eeec7cedceb6f0260617492bb4cf05c",
"assets/assets/images/products/gaiola_roedores1.jpg": "c26af9e482e19cac7d4704e477c2e1cb",
"assets/assets/images/products/gaiola_roedores2.jpg": "2dfc3289cc49dca23042c2ff1577bb93",
"assets/assets/images/products/gaiola_roedores3.jpg": "4d71df74e2db3629befee5dd790862cc",
"assets/assets/images/products/gaiola_roedores4.jpg": "ac8cfaf47786c848aaba56adbad9d2db",
"assets/assets/images/products/gaiola_roedores5.jpg": "9b28ecd588dd998d5bf4190c70d69bee",
"assets/assets/images/products/racao1.jpg": "d7cf101adb5c5e67a157d00462975e47",
"assets/assets/images/products/racao10.jpg": "dda711db5ad9c3e42bfef7ddadfe2b03",
"assets/assets/images/products/racao2.jpg": "6f0a8dbc13b2f4dd9d9893fa5e4d7931",
"assets/assets/images/products/racao3.jpg": "b06b7e4a2c6aed0b90269d4cc61f33db",
"assets/assets/images/products/racao4.jpg": "f47078b406b56456e03754f3b2aa86b6",
"assets/assets/images/products/racao5.jpg": "cabd2d6ff27584c95ec2edbe1968d820",
"assets/assets/images/products/racao6.jpg": "3aea85934635c1a485c831df3a70f149",
"assets/assets/images/products/racao7.jpg": "37f2c3ae54bd07284dafeff1061ce370",
"assets/assets/images/products/racao8.jpg": "142a94d3f222709fac30f0883483d0ba",
"assets/assets/images/products/racao9.jpg": "0ec9583b55d9fc4851866ad2db2cce48",
"assets/assets/images/products/racao_gato1.jpg": "7889e63818c16883cef5767db906fd3b",
"assets/assets/images/products/racao_gato10.jpg": "134754f0cea2df67f015e9b242085df8",
"assets/assets/images/products/racao_gato2.jpg": "a8dbe1ff16edea5914d29ef3b85d76a2",
"assets/assets/images/products/racao_gato3.jpg": "5ab7cc6193b6d565db749865f60facba",
"assets/assets/images/products/racao_gato4.jpg": "58bc8d6aecaed6de64f6bd52038f7e75",
"assets/assets/images/products/racao_gato5.jpg": "952fffd5f4b934bab9f1a5049719d27c",
"assets/assets/images/products/racao_gato6.jpg": "7fb8a00d64bb45ad19352b0155927558",
"assets/assets/images/products/racao_gato7.jpg": "e472c4aaeeabaafc72ebcb787a002756",
"assets/assets/images/products/racao_gato8.jpg": "41979bba6510b064d6b89809e73f8ccc",
"assets/assets/images/products/racao_gato9.jpg": "68184d2c3c1d22b43ee6930ce715132b",
"assets/assets/images/products/racao_passaro1.jpg": "60bdd73cfff2e5358f26a1576dd50f3f",
"assets/assets/images/products/racao_passaro10.jpg": "cae459c4430affec78b52488a2480db7",
"assets/assets/images/products/racao_passaro2.jpg": "db3f5587a55394185849217450a130d3",
"assets/assets/images/products/racao_passaro3.jpg": "fe8051a2a26d1a771102bbc6193ad189",
"assets/assets/images/products/racao_passaro4.jpg": "309c2309c78a000fb182a6c372c08a9c",
"assets/assets/images/products/racao_passaro5.jpg": "e8d6977c7cda0915eb59ae6f3faea113",
"assets/assets/images/products/racao_passaro6.jpg": "f282b7c36434f3554b735d67edf30039",
"assets/assets/images/products/racao_passaro7.jpg": "b952a724dbad329eaca93f42ead3013b",
"assets/assets/images/products/racao_passaro8.jpg": "a750faa91ff87ba7be6849029055d337",
"assets/assets/images/products/racao_passaro9.jpg": "9ff34e0c018d5063bdd90e43881d9a64",
"assets/assets/images/products/racao_peixe1.jpg": "f9c1a679b135b6f540c6e439c4103b5b",
"assets/assets/images/products/racao_peixe10.jpg": "c6b1ad6e0ce94f4b80c4f8c0488dba56",
"assets/assets/images/products/racao_peixe2.jpg": "96e9b73ea80910fe5a8b53c513166284",
"assets/assets/images/products/racao_peixe3.jpg": "43c20032d721f33f573ecdf88275fe03",
"assets/assets/images/products/racao_peixe4.jpg": "92b1c0c90d804f110ceeda04235db82c",
"assets/assets/images/products/racao_peixe5.jpg": "5fa41cdca3d3baac6ad6f487c4fa91bb",
"assets/assets/images/products/racao_peixe6.jpg": "09a30f0bcb0eba5b1aaa65ce737770bf",
"assets/assets/images/products/racao_peixe7.jpg": "44f39c43b77782ff4a16c5e583ce4203",
"assets/assets/images/products/racao_peixe8.jpg": "cea14f845dd5e9535c0912d3696ff035",
"assets/assets/images/products/racao_peixe9.jpg": "d0a9e16fa7698342a413228b8a5427da",
"assets/assets/images/products/repelente1.jpg": "cae2ea6a2622af6516488870f1bf6b75",
"assets/assets/images/products/repelente2.jpg": "296c5b0592de39f7b4984605116974e2",
"assets/assets/images/products/repelente3.jpg": "c4b3e0e928547c38d876523e45614180",
"assets/assets/images/products/repelente4.jpg": "637d9be103e5cf4f0a236dc257caff1e",
"assets/assets/images/products/roda_roedores1.jpg": "b6c448e85b77643e86b18f78a9d3f386",
"assets/assets/images/products/roda_roedores2.jpg": "3c878216e802e2d141c07d40c08fb8b9",
"assets/assets/images/products/roda_roedores3.jpg": "0d174a83ae9b7b11ee305bd3bb6e5c4c",
"assets/assets/images/products/roda_roedores4.jpg": "66514bcfd0308769b755c789c06b2a30",
"assets/assets/images/products/roda_roedores5.jpg": "063604bb0361445fa51770346f30def0",
"assets/assets/images/products/substrato1.jpg": "e545d61e6dd5492659242b72129fd343",
"assets/assets/images/products/substrato2.jpg": "7e8e91b62e86fa31cd04d9f31b8af7d6",
"assets/assets/images/products/substrato3.jpg": "7f6c7191ad4cbbcf58bc2151f1178746",
"assets/assets/images/products/vaso1.jpg": "8d9cc72ae7c7c0eac941c68dbb87a0b1",
"assets/assets/images/products/vaso2.jpg": "f95db31c6fe5e3e4002100af2599aaae",
"assets/assets/images/products/vaso3.jpg": "150c9f51a31f7384b339b06863519b74",
"assets/assets/images/products/vaso4.jpg": "40f52d769e4221ca90f6ff00eee7857c",
"assets/FontManifest.json": "bfce726e88900155986e0b07e2ea603b",
"assets/fonts/MaterialIcons-Regular.otf": "77ef8bdff6beea86264f26ae585578db",
"assets/NOTICES": "d05ea694cdc99787e340f27b083edfae",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "fee281264bfefb23869fbcab9b590954",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "43e78351341deb648f1f98711e488307",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "3ca5dc7621921b901d513cc1ce23788c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "a2eb084b706ab40c90610942d98886ec",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "d2f9e42814ae91ef15e508e44c5f924f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "2258faac06f40631b36accc406b2df0c",
"/": "2258faac06f40631b36accc406b2df0c",
"main.dart.js": "4aadf978e02f507dd0538ec667fcda08",
"manifest.json": "23c33b3d812fc8927bd3d6b47852d013",
"version.json": "e67068bd6637b1bba0835c65d752b692"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
