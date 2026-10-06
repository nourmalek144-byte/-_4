
import 'package:flutter/material.dart';

void main() {
  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VYRA Music',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050505),
        fontFamily: 'sans',
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          surface: Color(0xFF0C0C0E),
        ),
        useMaterial3: true,
      ),
      home: const MusicHome(),
    );
  }
}

class Song {
  final String title;
  final String artist;
  final String image;
  final String duration;

  const Song({
    required this.title,
    required this.artist,
    required this.image,
    required this.duration,
  });
}

const songs = [
  Song(
    title: 'Wegz - ElBakht',
    artist: 'Wegz',
    image: 'https://i.ytimg.com/vi/_wZfYtYxY4Y/hqdefault.jpg',
    duration: '3:24',
  ),
  Song(
    title: 'Marwan Pablo - Free',
    artist: 'Marwan Pablo',
    image: 'https://i.ytimg.com/vi/5qap5aO4i9A/hqdefault.jpg',
    duration: '3:11',
  ),
  Song(
    title: 'Cairokee - Telk Qadeya',
    artist: 'Cairokee',
    image: 'https://i.ytimg.com/vi/7wtfhZwyrcc/hqdefault.jpg',
    duration: '4:02',
  ),
  Song(
    title: 'TUL8TE - Habibi Leh',
    artist: 'TUL8TE',
    image: 'https://i.ytimg.com/vi/60ItHLz5WEA/hqdefault.jpg',
    duration: '3:05',
  ),
];

class MusicHome extends StatefulWidget {
  const MusicHome({super.key});

  @override
  State<MusicHome> createState() => _MusicHomeState();
}

class _MusicHomeState extends State<MusicHome> {
  int page = 0;
  Song? currentSong;
  bool playing = false;
  bool liked = false;
  bool muted = false;
  final TextEditingController search = TextEditingController();

  void playSong(Song song) {
    setState(() {
      currentSong = song;
      playing = true;
    });
  }

  void changePage(int index) {
    setState(() => page = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(-0.8, -0.9),
                    radius: 1.5,
                    colors: [
                      Color(0x221D4ED8),
                      Color(0x00050505),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                _topBar(),
                Expanded(
                  child: IndexedStack(
                    index: page,
                    children: [
                      _homePage(),
                      _historyPage(),
                      _likesPage(),
                      _communityPage(),
                      _profilePage(),
                    ],
                  ),
                ),
              ],
            ),
            if (currentSong != null)
              Positioned(
                left: 10,
                right: 10,
                bottom: 78,
                child: _miniPlayer(),
              ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigation(),
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
      child: Row(
        children: [
          const Text(
            'VYRA',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w900,
              letterSpacing: 5,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF0D0D0F),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white10),
              ),
              child: TextField(
                controller: search,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search_rounded, color: Colors.white54),
                  hintText: 'Search for a song, artist...',
                  hintStyle: TextStyle(color: Colors.white38),
                  contentPadding: EdgeInsets.symmetric(vertical: 11),
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Searching for "$value"')),
                    );
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () => changePage(4),
            icon: const Icon(Icons.account_circle_outlined, size: 31),
            color: Colors.white70,
          ),
        ],
      ),
    );
  }

  Widget _homePage() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 170),
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white10),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF18181D),
                Color(0xFF08080A),
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x331E3A8A),
                blurRadius: 40,
              ),
            ],
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'YOUR MUSIC SPACE',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Listen.\nEnjoy.',
                style: TextStyle(
                  fontSize: 48,
                  height: .98,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -2,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Music, videos and your favorite artists in one fast player.',
                style: TextStyle(
                  color: Colors.white54,
                  height: 1.6,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 26),
        _sectionTitle('Quick picks', 'Made for you'),
        const SizedBox(height: 12),
        SizedBox(
          height: 39,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _chip('All', true),
              _chip('Egyptian', false),
              _chip('Rap', false),
              _chip('Pop', false),
              _chip('K-Pop', false),
            ],
          ),
        ),
        const SizedBox(height: 26),
        _sectionTitle('Trending now', 'Popular'),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: songs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            childAspectRatio: .78,
          ),
          itemBuilder: (_, i) => _songCard(songs[i]),
        ),
      ],
    );
  }

  Widget _songCard(Song song) {
    return InkWell(
      borderRadius: BorderRadius.circular(17),
      onTap: () => playSong(song),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0C0C0E),
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: Colors.white10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    song.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFF18181C),
                      child: const Icon(
                        Icons.music_note_rounded,
                        size: 48,
                        color: Colors.white24,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 7,
                    left: 7,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        song.duration,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 9,
                    bottom: 9,
                    child: Container(
                      width: 39,
                      height: 39,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    song.artist,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniPlayer() {
    final song = currentSong!;
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      decoration: BoxDecoration(
        color: const Color(0xF50D0D0F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
        boxShadow: const [
          BoxShadow(color: Colors.black54, blurRadius: 25),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.network(
              song.image,
              width: 52,
              height: 52,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 52,
                height: 52,
                color: Colors.white10,
                child: const Icon(Icons.music_note_rounded),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 3),
                Text(
                  song.artist,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => setState(() => liked = !liked),
            icon: Icon(
              liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: liked ? const Color(0xFFFF3855) : Colors.white70,
            ),
          ),
          IconButton(
            onPressed: () => setState(() => playing = !playing),
            icon: Icon(
              playing
                  ? Icons.pause_circle_filled_rounded
                  : Icons.play_circle_filled_rounded,
              size: 34,
            ),
          ),
          IconButton(
            onPressed: () => setState(() => muted = !muted),
            icon: Icon(
              muted
                  ? Icons.volume_off_rounded
                  : Icons.volume_up_rounded,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavigation() {
    final items = [
      (Icons.home_rounded, 'Home'),
      (Icons.history_rounded, 'History'),
      (Icons.favorite_rounded, 'Likes'),
      (Icons.forum_outlined, 'Community'),
      (Icons.person_outline_rounded, 'Profile'),
    ];

    return NavigationBar(
      height: 70,
      backgroundColor: const Color(0xF50F0F11),
      indicatorColor: Colors.white12,
      selectedIndex: page,
      onDestinationSelected: changePage,
      destinations: [
        for (final item in items)
          NavigationDestination(
            icon: Icon(item.$1),
            selectedIcon: Icon(item.$1),
            label: item.$2,
          ),
      ],
    );
  }

  Widget _historyPage() {
    return _simplePage(
      Icons.history_rounded,
      'History',
      'Your recently played songs will appear here.',
    );
  }

  Widget _likesPage() {
    return _simplePage(
      Icons.favorite_border_rounded,
      'Likes',
      'Your liked songs and artists will appear here.',
    );
  }

  Widget _communityPage() {
    return _simplePage(
      Icons.forum_outlined,
      'Community',
      'Music community and information.',
    );
  }

  Widget _profilePage() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 150),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF0C0C0E),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white10),
          ),
          child: const Column(
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: Color(0xFF202024),
                child: Icon(
                  Icons.person_rounded,
                  size: 52,
                  color: Colors.white38,
                ),
              ),
              SizedBox(height: 13),
              Text(
                'Your Profile',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Music account',
                style: TextStyle(color: Colors.white54),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _profileButton(Icons.palette_outlined, 'Themes'),
        _profileButton(Icons.settings_outlined, 'Settings'),
        _profileButton(Icons.logout_rounded, 'Log out'),
      ],
    );
  }

  Widget _profileButton(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Colors.white10),
        ),
        tileColor: const Color(0xFF0C0C0E),
        leading: Icon(icon, color: Colors.white70),
        title: Text(text),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: Colors.white38,
        ),
        onTap: () {},
      ),
    );
  }

  Widget _simplePage(IconData icon, String title, String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 58, color: Colors.white24),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white.withOpacity(0.45),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white.withOpacity(0.45),
          ),
        ),
      ],
    );
  }

  Widget _chip(String text, bool active) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? Colors.white : const Color(0xFF0D0D0F),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(
          color: active ? Colors.white : Colors.white10,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: active ? Colors.black : Colors.white70,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}