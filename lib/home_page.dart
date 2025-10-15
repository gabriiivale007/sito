import 'dart:ui';
import 'package:flutter/material.dart';

// Palette di colori moderna e tech
class ModernAppColors {
  static const Color background = Color(0xFF0A0A14); // Nero quasi puro
  static const Color primaryText = Color(0xFFF0F0F0); // Bianco sporco
  static const Color secondaryText = Color(0xFFa0a0a0); // Grigio chiaro
  static const Color accent = Color(0xFF00BFFF); // Deep Sky Blue / Ciano
  static const Color accentPurple = Color(0xFF6A0DAD); // Viola acceso
}

class ModernHomePage extends StatefulWidget {
  const ModernHomePage({super.key});

  @override
  State<ModernHomePage> createState() => _ModernHomePageState();
}

class _ModernHomePageState extends State<ModernHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usiamo uno Stack per sovrapporre il contenuto allo sfondo animato
      body: Stack(
        children: [
          // 1. Sfondo "Liquido" Animato
          _LiquidBackground(animation: _animation),
          
          // 2. Contenuto scrollabile sopra lo sfondo
          SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _HeaderSection(),
                      SizedBox(height: 32),
                      _CtaButtons(),
                      SizedBox(height: 64),
                      _IntroductionText(),
                      SizedBox(height: 64),
                      _SkillsSection(),
                      SizedBox(height: 80),
                      _FinalCtaSection(),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// WIDGET PER LO SFONDO LIQUIDO
class _LiquidBackground extends StatelessWidget {
  const _LiquidBackground({required this.animation});
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
            color: ModernAppColors.background,
          ),
          child: Stack(
            children: [
              // Gradiente principale
              Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(-1.0, -1.0),
                    radius: 1.5,
                    colors: [
                      ModernAppColors.accentPurple,
                      ModernAppColors.background,
                    ],
                  ),
                ),
              ),
              // "Blob" di luce animato
              Positioned.fill(
                child: Transform.translate(
                  offset: Offset(0, 300 * (animation.value - 0.5)),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(0.5, 1.0),
                        radius: 1.2,
                        colors: [
                          ModernAppColors.accent,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// WIDGET "VETRO LIQUIDO" RIUTILIZZABILE
class GlassmorphicCard extends StatelessWidget {
  final Widget child;
  const GlassmorphicCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.0,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

// SEZIONI DELLA PAGINA (RIVISITATE CON IL NUOVO STILE)
class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Gabriele Valente',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.displayMedium?.fontSize,
            fontWeight: FontWeight.bold,
            color: ModernAppColors.primaryText,
            shadows: [
              Shadow(blurRadius: 10.0, color: ModernAppColors.accent.withOpacity(0.5)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Sviluppatore Full-Stack | Trasformo la curiosità in codice funzionante.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
            color: ModernAppColors.secondaryText,
            fontFamily: 'RobotoMono', // Un font monospace per un tocco "tech"
          ),
        ),
      ],
    );
  }
}

class _CtaButtons extends StatelessWidget {
  const _CtaButtons();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      alignment: WrapAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: ModernAppColors.accent,
            foregroundColor: ModernAppColors.background,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          child: const Text('Guarda i miei progetti'),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: ModernAppColors.primaryText,
            side: const BorderSide(color: ModernAppColors.accent, width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          child: const Text('Contattami'),
        ),
      ],
    );
  }
}

class _IntroductionText extends StatelessWidget {
  const _IntroductionText();

  @override
  Widget build(BuildContext context) {
    return GlassmorphicCard(
      child: Text(
        "Sono uno studente di Informatica, uno stagista in STMicroelectronics e, soprattutto, uno sviluppatore spinto da una fame insaziabile di conoscenza. Esploro il mondo del software per creare soluzioni intuitive ed efficienti. Scopri cosa può fare la mia curiosità per il tuo progetto.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
          color: ModernAppColors.secondaryText,
          height: 1.6,
        ),
      ),
    );
  }
}

class _SkillsSection extends StatelessWidget {
  const _SkillsSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 800;
        final skillCards = [
          _SkillCard(
            icon: Icons.web_outlined,
            title: 'Sviluppo Web',
            description: "Creo esperienze web complete e performanti, curando ogni dettaglio dall'interfaccia utente alla logica del server.",
          ),
          _SkillCard(
            icon: Icons.code_outlined,
            title: 'Sviluppo Software',
            description: "Progetto e implemento soluzioni software su misura, scrivendo codice pulito, scalabile e manutenibile.",
          ),
          _SkillCard(
            icon: Icons.emoji_events_outlined,
            title: 'Problem Solving',
            description: "Partecipo a competizioni e hackathon per allenare il pensiero logico e trovare soluzioni creative a problemi complessi.",
          ),
        ];

        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: skillCards
                .map((card) => Expanded(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: card,
                    )))
                .toList(),
          );
        } else {
          return Column(
            children: skillCards
                .map((card) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: card,
                    ))
                .toList(),
          );
        }
      },
    );
  }
}

class _SkillCard extends StatelessWidget {
  const _SkillCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return GlassmorphicCard(
      child: Column(
        children: [
          Icon(icon, size: 40, color: ModernAppColors.accent),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ModernAppColors.primaryText),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(color: ModernAppColors.secondaryText, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _FinalCtaSection extends StatelessWidget {
  const _FinalCtaSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Ti incuriosisce il mio approccio?',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
            fontWeight: FontWeight.bold,
            color: ModernAppColors.primaryText,
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Visita il mio portfolio',
            style: TextStyle(
              fontSize: 18,
              color: ModernAppColors.accent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}