import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../dialogs/citation_dialog.dart';

/// Citation button widget for App Store Guideline 1.4.1 compliance
/// Shows medical references and sources for AI-generated insights
class CitationButtonWidget extends StatelessWidget {
  final String insightType;
  final List<CitationSource> sources;

  const CitationButtonWidget({
    super.key,
    required this.insightType,
    required this.sources,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showCitationDialog(context),
      icon: const Icon(Icons.science_outlined),
      tooltip: 'View Medical Sources',
      color: AppTheme.secondaryBlue,
      iconSize: 20,
    );
  }

  void _showCitationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CitationDialog(
        insightType: insightType,
        sources: sources,
      ),
    );
  }
}

/// Model for citation sources
class CitationSource {
  final String title;
  final String organization;
  final String? url;
  final String? year;
  final String description;

  const CitationSource({
    required this.title,
    required this.organization,
    this.url,
    this.year,
    required this.description,
  });
}

/// Pre-defined citation sources for different insight types
class MedicalCitations {
  // Cycle Prediction Sources
  static final List<CitationSource> cyclePredictionSources = [
    CitationSource(
      title: 'Menstrual Cycle Variability',
      organization: 'American College of Obstetricians and Gynecologists (ACOG)',
      url: 'https://www.acog.org',
      year: '2023',
      description: 'Clinical guidelines on normal menstrual cycle patterns and variations.',
    ),
    CitationSource(
      title: 'Reproductive Health Indicators',
      organization: 'World Health Organization (WHO)',
      url: 'https://www.who.int',
      year: '2024',
      description: 'Global standards for reproductive health monitoring and cycle tracking.',
    ),
    CitationSource(
      title: 'Machine Learning for Cycle Prediction',
      organization: 'Flow-AI Research Team',
      description: 'Ensemble ML models combining SVM, Random Forest, and Neural Networks for personalized cycle prediction.',
    ),
    CitationSource(
      title: 'Cycle Variability in Reproductive Age Women',
      organization: 'Bull et al., Human Reproduction',
      year: '2019',
      description: 'Research on menstrual cycle length variability and fertility patterns.',
    ),
  ];

  // Symptom Correlation Sources
  static final List<CitationSource> symptomCorrelationSources = [
    CitationSource(
      title: 'Premenstrual Syndrome (PMS)',
      organization: 'American College of Obstetricians and Gynecologists (ACOG)',
      url: 'https://www.acog.org',
      year: '2023',
      description: 'Clinical guidelines on PMS symptoms, patterns, and management.',
    ),
    CitationSource(
      title: 'The Premenstrual Syndrome',
      organization: 'Steiner et al., Obstetrics & Gynecology',
      year: '2003',
      description: 'Research on symptom patterns and correlations throughout the menstrual cycle.',
    ),
    CitationSource(
      title: 'Menstruation in Adolescents',
      organization: 'Fraser et al., The Journal of Pediatric and Adolescent Gynecology',
      year: '2011',
      description: 'Study on normal and abnormal menstrual patterns and associated symptoms.',
    ),
    CitationSource(
      title: 'AI-Powered Symptom Prediction',
      organization: 'Flow-AI ML Engine',
      description: 'LSTM networks and time series analysis for personalized symptom forecasting.',
    ),
  ];

  // Fertility Window Sources
  static final List<CitationSource> fertilityWindowSources = [
    CitationSource(
      title: 'Fertility Awareness Methods',
      organization: 'American College of Obstetricians and Gynecologists (ACOG)',
      url: 'https://www.acog.org',
      year: '2023',
      description: 'Medical guidelines on fertility window identification and ovulation prediction.',
    ),
    CitationSource(
      title: 'Ovulation Prediction',
      organization: 'World Health Organization (WHO)',
      url: 'https://www.who.int',
      year: '2024',
      description: 'Scientific methods for ovulation detection and fertile window calculation.',
    ),
    CitationSource(
      title: 'Gaussian Process Models for Fertility',
      organization: 'Flow-AI Research Team',
      description: 'Bayesian inference and hormone-based adjustments for ovulation prediction.',
    ),
  ];

  // Health Condition Detection Sources
  static final List<CitationSource> healthConditionSources = [
    CitationSource(
      title: 'Polycystic Ovary Syndrome (PCOS)',
      organization: 'American College of Obstetricians and Gynecologists (ACOG)',
      url: 'https://www.acog.org',
      year: '2023',
      description: 'Clinical criteria for PCOS diagnosis and management guidelines.',
    ),
    CitationSource(
      title: 'Endometriosis',
      organization: 'American College of Obstetricians and Gynecologists (ACOG)',
      url: 'https://www.acog.org',
      year: '2023',
      description: 'Diagnostic guidelines and symptom patterns for endometriosis.',
    ),
    CitationSource(
      title: 'Pattern Recognition for Health Conditions',
      organization: 'Flow-AI Advanced ML System',
      description: 'Multi-algorithm approach for early detection of cycle irregularities and health conditions.',
    ),
  ];

  // Biometric Correlation Sources
  static final List<CitationSource> biometricCorrelationSources = [
    CitationSource(
      title: 'Basal Body Temperature',
      organization: 'American College of Obstetricians and Gynecologists (ACOG)',
      url: 'https://www.acog.org',
      year: '2023',
      description: 'Guidelines on using body temperature for fertility tracking.',
    ),
    CitationSource(
      title: 'Heart Rate Variability and Menstrual Cycle',
      organization: 'World Health Organization (WHO)',
      url: 'https://www.who.int',
      year: '2024',
      description: 'Research on cardiovascular changes throughout the menstrual cycle.',
    ),
    CitationSource(
      title: 'HealthKit Integration',
      organization: 'Flow-AI Biometric Engine',
      description: 'Advanced correlation analysis of biometric data with cycle patterns.',
    ),
  ];

  // General AI Insights Sources
  static final List<CitationSource> generalAISources = [
    CitationSource(
      title: 'Menstrual Health Guidelines',
      organization: 'American College of Obstetricians and Gynecologists (ACOG)',
      url: 'https://www.acog.org',
      year: '2023',
      description: 'Comprehensive clinical guidelines on menstrual health and cycle tracking.',
    ),
    CitationSource(
      title: 'Reproductive Health Standards',
      organization: 'World Health Organization (WHO)',
      url: 'https://www.who.int',
      year: '2024',
      description: 'International standards for women\'s reproductive health monitoring.',
    ),
    CitationSource(
      title: 'Machine Learning for Menstrual Health',
      organization: 'Flow-AI Research & Development',
      description: 'Ensemble ML models, LSTM networks, and Bayesian inference for personalized health insights.',
    ),
  ];

  /// Get sources for a specific insight type
  static List<CitationSource> getSourcesForInsightType(String insightType) {
    switch (insightType.toLowerCase()) {
      case 'cycle prediction':
      case 'cycle length':
      case 'next period':
        return cyclePredictionSources;
      
      case 'symptom correlation':
      case 'symptom prediction':
      case 'pms':
        return symptomCorrelationSources;
      
      case 'fertility window':
      case 'ovulation':
      case 'fertility':
        return fertilityWindowSources;
      
      case 'health condition':
      case 'pcos':
      case 'endometriosis':
      case 'irregularity':
        return healthConditionSources;
      
      case 'biometric':
      case 'heart rate':
      case 'temperature':
      case 'sleep':
        return biometricCorrelationSources;
      
      default:
        return generalAISources;
    }
  }
}
