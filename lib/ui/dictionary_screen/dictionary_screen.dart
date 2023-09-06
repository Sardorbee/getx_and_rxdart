import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_and_rxdart/data/getx/dictionary_controller.dart';
import 'package:getx_and_rxdart/data/models/dictionary_model.dart';
import 'package:getx_and_rxdart/data/network/api_service.dart';
import 'package:getx_and_rxdart/data/repository/dictionary_repo/dictionary_repo.dart';

class DictionaryScreen extends StatelessWidget {
  DictionaryScreen({super.key});
  final TextEditingController dictionaryController = TextEditingController();
  final DictionaryController controller = Get.put(
    DictionaryController(
      dictionaryRepository: DictionaryRepository(
        apiService: ApiService(),
      ),
    ),
  );
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dictionary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: dictionaryController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      controller.getWordList(query: dictionaryController.text);
                    },
                    icon: const Icon(Icons.search)),
                labelText: 'Enter text to translate',
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.users.length,
                  itemBuilder: (context, index) {
                    DictionaryModel word = controller.users[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              word.word,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                for (final phonetic in word.phonetics) {
                                  if (phonetic.audio.isNotEmpty) {
                                    await audioPlayer
                                        .play(UrlSource(phonetic.audio));
                                    break; // Stop searching once you've found and played the first audio
                                  }
                                }
                              },
                              icon: const Icon(
                                Icons.volume_up,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Phonetic: ${word.phonetic}",
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Definitions:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Use a ListView.builder for nested definitions
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: word.meanings.length,
                          itemBuilder: (context, meaningIndex) {
                            Meaning meaning = word.meanings[meaningIndex];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  meaning.partOfSpeech,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // Use another ListView.builder for nested definitions
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: meaning.definitions.length,
                                  itemBuilder: (context, definitionIndex) {
                                    Definition definition =
                                        meaning.definitions[definitionIndex];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "- ${definition.definition}",
                                        ),
                                        const SizedBox(height: 10),
                                        if (definition.example != null)
                                          Text(
                                            "  Example: ${definition.example}",
                                          ),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
