import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  LeaderboardPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> leaderboard = [
    {
      "name": "Sourav",
      "worksDone": 35,
      "avatarUrl": "https://i.pravatar.cc/150?img=1",
    },
    {
      "name": "Arina",
      "worksDone": 30,
      "avatarUrl": "https://i.pravatar.cc/150?img=2",
    },
    {
      "name": "Mahfuz",
      "worksDone": 28,
      "avatarUrl": "https://i.pravatar.cc/150?img=3",
    },
    {
      "name": "Muntaha",
      "worksDone": 25,
      "avatarUrl": "https://i.pravatar.cc/150?img=4",
    },
    {
      "name": "Gupta",
      "worksDone": 22,
      "avatarUrl": "https://i.pravatar.cc/150?img=5",
    },
  ];

  Color rankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey;
      case 3:
        return Colors.brown;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3d4d6f),
      appBar: AppBar(
        title: const Text('Volunteer Leaderboard'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: leaderboard.length,
        itemBuilder: (context, index) {
          final player = leaderboard[index];
          final rank = index + 1;
          final circleColor = rankColor(rank);

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(player["avatarUrl"]),
              ),
              title: Text(
                player["name"],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Works done: ${player["worksDone"]}'),
              trailing: CircleAvatar(
                radius: 16,
                backgroundColor: circleColor,
                child: Text(
                  '$rank',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
