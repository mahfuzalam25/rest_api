import 'package:flutter/material.dart';

class GuideDetailPage extends StatelessWidget {
  final String title;
  GuideDetailPage({required this.title});

  // 💡 Easy English Descriptions for Each Guide
  final Map<String, List<String>> guideDetails = {
    'How to Give First Aid': [
      'First, try to stay calm. Panic can make the situation worse.',
      'If someone is hurt, call the emergency number (like 999 or 112) immediately.',
      'Check if the person is breathing and conscious. If not, try to gently wake them up.',
      'If the person is bleeding, press a clean cloth on the wound to stop the bleeding.',
      'If you are trained, you can give CPR by pressing the chest and giving mouth-to-mouth breaths.',
      'Keep the person warm and comfortable until help arrives.',
      'Do not give the person food or drink if they are unconscious.',
    ],
    'How to Control High Blood Pressure': [
      'Sit in a quiet place and take deep breaths to calm yourself.',
      'Try to relax your body and mind. Stress can make blood pressure worse.',
      'Drink a glass of water. Staying hydrated can help.',
      'Avoid salty foods, tea, coffee, or energy drinks for now.',
      'If you have blood pressure medicine, take it as your doctor told you.',
      'If the pressure stays high or you feel chest pain, get medical help quickly.',
      'Try not to lie down flat — instead, keep your head raised.',
    ],
    'How to Stay Safe During Earthquake': [
      'If you are inside, stay inside. If you are outside, stay outside.',
      'Drop down to your hands and knees. This helps protect you from falling.',
      'Cover your head and neck under a table or desk if possible.',
      'Stay away from windows, glass, and heavy things that can fall.',
      'If you’re in bed, stay there and protect your head with a pillow.',
      'Once the shaking stops, go to a safe open place.',
      'Do not use elevators. Be careful of broken glass and electrical wires.',
    ],
    'Fire Safety Tips at Home': [
      'Keep matches and lighters away from children.',
      'Do not leave the kitchen when cooking on a stove.',
      'Install smoke detectors and check batteries monthly.',
      'Do not overload electric sockets or use damaged wires.',
      'If a fire starts, use a fire extinguisher if it is safe.',
      'If smoke fills the room, crawl low under it to escape.',
      'Have an escape plan and practice it with your family.',
    ],
    'Electric Shock First Response': [
      'Do not touch the person directly if they’re still connected to electricity.',
      'Turn off the power source if possible, or unplug it.',
      'Call emergency services immediately.',
      'Use a non-metal object (like a wooden stick) to move the person away.',
      'If the person is not breathing, start CPR if trained.',
      'Cover burns with a clean cloth, but don’t use ointment.',
      'Keep the person warm and wait for medical help.',
    ],
    // You can add more guides here...
  };

  @override
  Widget build(BuildContext context) {
    final List<String> content =
        guideDetails[title] ?? ['No detailed information available.'];

    return Scaffold(
      backgroundColor: Color(0xFF2e3a59),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: ListView.builder(
            itemCount: content.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "• ",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Expanded(
                      child: Text(
                        content[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
