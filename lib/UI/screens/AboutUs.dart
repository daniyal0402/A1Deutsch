import 'package:flutter/material.dart';
import 'package:vocabulary_client/helpers/AppConstants.dart';
import 'package:easy_localization/easy_localization.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.blackColor,
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "About Us".tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                      " Inhaberin und Kursleitung\nMarlene Schachner\nehemals Abdel Aziz - Schachner\nMilena Vezjak\n\t\tDozentin Deutsch als Zweitsprache\n\t\tZugelassene Integrationskursleiterin\n\t\t2004 – 2010 im Auftrag BamF\n\t\tBundesamt für Migration und Flüchtlinge\n\n\t\t26.11.2005 Prüferschulung für die Prüfung\n\t\tTelc The European Language Certifikates\n\t\tCommunication & Competence\n\t\tZertifikat Deutsch\n\t\tPrüferlizenz ,,Mündliche Prüfungen“ \n\t\tin dem genannten Fach"),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Text(
                      "Seit Juni 1994 /VHS Darmstadt-Dieburg/ biete ich Deutsch-Intensivkurse an und bin mit Tausenden erfolgreichen Absolventen weit über die Grenzen Darmstadts hinaus ein Begriff für Qualität und Leistung als Dozentin für Deutsch als Zweitsprache geworden. Die langjährige Erfahrung als Kursleiterin auf dem Gebiet Deutsch als Zweitsprache / Deutsch als Fremdsprache sind hierfür ein Garant."),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Text(
                    "Mein Ziel ist es, dass meine Studierende / Kursteilnehmer/-innen",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                      "\t\t•	ein Studium in Deutschland erfolgreich absolvieren können\n\t\t•	am Arbeitsplatz auch in komplexen Diskussionen und Verhandlungen ihre Position - wie ein Muttersprachler - erfolgreich vertreten können.\n\t\t•	in Alltagssituationen (z.B. beim Einkaufen, bei Kontakt mit Behörden) und bei gesellschaftlichen Anlässen (z.B. bei Feiern, im Verein) sich gewandt ausdrücken und sicher an den Unterhaltungen beteiligen können."),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Text(
                      "Die Basis für Ihren Erfolg bildet dabei eine Lernumgebung, die sowohl auf eine angenehme Atmosphäre als auch auf höchst professionelle Organisation setzt:"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                      "\t\t\t•	erprobtes und zeitgemäßes Unterrichtsmodell / in Coronazeit ONLINE-Deutschkurse\n\t\t\t•	erfahrene und motivierte Dozentin, mir liegt Ihr Erfolg persönlich am Herzen \n\t\t\t•	kleine Lerngruppen mit internationalen Studierenden / Kursteilnehmer/-innen auf homogenen Sprach-Niveaus\n\t\t\t•	bei Vorkenntnissen Einstufung durch einen kostenlosen schriftlichen und mündlichen Test \n\t\t\t•	ausführliche persönliche Sprachberatung und Betreuung\n\t\t\t"),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Text("1. Mein Ziel"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                      "Ich konzentriere uns vollständig darauf, meine ausländischen Studierende / Kursteilnehmer/-innen in kürzester Zeit mit der deutschen Sprache und Kultur vertraut zu machen. Ich verfolgen das Ziel, dass meine Studierende / Kursteilnehmer/-innen"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                      "\t\t\t•	ein Studium in Deutschland erfolgreich absolvieren können\n\t\t\t•	am Arbeitsplatz auch in komplexen Diskussionen und Verhandlungen ihre Position - wie ein Muttersprachler - erfolgreich vertreten können.\n\t\t\t•	in Alltagssituationen (z.B. beim Einkaufen, bei Kontakt mit Behörden) und bei gesellschaftlichen Anlässen (z.B. bei Feiern, im Verein) sich gewandt ausdrücken und sicher an den Unterhaltungen beteiligen können"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                      "Die Basis für Ihren Erfolg bildet dabei eine Lernumgebung, die sowohl auf eine angenehme Atmosphäre als auch auf höchst professionelle Organisation setzt:"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                      "\t\t\t•	erprobtes und zeitgemäßes Unterrichtsmodell / in Coronazeit ONLINE-Deutschkurse\n\t\t\t•	erfahrene und motivierte Dozentin, mir liegt Ihr Erfolg persönlich am Herzen \n\t\t\t•	kleine Lerngruppen mit internationalen Teilnehmern auf homogenen Sprach-Niveaus\n\t\t\t•	bei Vorkenntnissen Einstufung durch einen kostenlosen schriftlichen und mündlichen Test\n\t\t\t•	ausführliche persönliche Sprachberatung und Betreuung"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                      "Die Sprachenschule Lady2000 versteht sich als Brückenbauer zwischen verschiedenen Kulturen und Sprachen. Alle an einer Sprachausbildung interessierten Personen können meine Kurse belegen. Ich fördere die Verständigung zwischen Menschen verschiedener Muttersprachen und lege dabei Wert auf kulturelle und gesellschaftliche Aspekte einer Sprache."),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(child: Text("2. Meine Werte und Standards")),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                      "Die Werte, die ich im Team sowie auch im Umgang mit meinen Studierende / Kursteilnehmer/-innen fördere, sind geprägt durch folgende Qualitäten: Menschlichkeit, Achtung voreinander und respektvoller Umgang miteinander, Wertschätzung und Förderung hervorragender Leistungen.\n\nIm Rahmen der Chancengleichheit verpflichte ich mich, dass keine unterschiedliche Behandlung von Teilnehmern und Mitarbeitern aufgrund des Geschlechts, der Rasse, einer Behinderung, der Herkunft, der Religion, des Alters oder der geschlechtlichen Ausrichtung erfolgt.\n\nAuf hohe Unterrichtsstandards lege ich großen Wert. Ich vermitteln Kursinhalte, die sich auf den geschäftlichen oder privaten Alltag der Studierenden anwenden lassen. Meine Unterrichtsgestaltung ist individuell und flexibel anpassbar.\n\nIch verfolgen einen lebendigen Unterrichtsstil, der eine aktive Teilnahme am Unterricht ermöglicht. Hervorragende Leistungen und die Lust am Lernen werden gefördert.\n\nGroßen Wert lege ich außerdem darauf, sinnvoll mit natürlichen Ressourcen umzugehen und mich im Rahmen meiner Arbeit gesellschaftlich und ehrenamtlich zu engagieren."),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child:
                      Text("3. Meine Organisationsziele und Bildungsangebote"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                      "Die Unternehmensidentität der Sprachenschule Lady2000 gründet sich auf eine besondere sozial- und bildungspolitische Verantwortung und das Selbstverständnis als ein kundenorientiertes Dienstleistungsunternehmen.\n\nMeine Organisationsziele stützen diese Grundsätze:\n\nMein differenziertes und vielfältiges Bildungsangebot im Bereich „Deutsch als Zweitsprache / Deutsch als Fremdsprache“ trägt den unterschiedlichen Qualifizierungsinteressen der Studierenden / Kursteilnehmer/-innen Rechnung. Bestehende Lehrgangskonzeptionen werden stetig an die sich wandelnden Anforderungen der Studierenden / Kursteilnehmer/-innen und Partner sowie des Arbeitsmarktes angepasst /siehe die neue Angeboten von App`s für Android wie Aple Handys wie auch Webbasierten Lehnportal Lady2000 /September 2021/ mit. Mein Dienstleistungsunternehmen zeichnet sich durch hohe Verlässlichkeit und Seriosität aus und verfolgt das Ziel eines immer gleichbleibend hohen Qualitätsstandard meiner Arbeit. Durch eine faire und vertrauensvolle Zusammenarbeit mit meinen Studierenden / Kursteilnehmer/-innen und Kooperationspartnern möchte ich meine Marktstellung als seit  1994 geschätzte Dozentin für Deutschkurse in der Region Südhessen und weltweit erhalten und ausbauen. \n\nEine kostenbewusste und an den Kriterien der Wirtschaftlichkeit orientierte Planung, Organisation und Durchführung meines Kursangebotes sowie eine flexible Anpassung meiner Angebote an die Bedürfnisse der Studierenden / Kursteilnehmer/-innen bilden für die Erreichung der Organisationsziele die notwendige Voraussetzung."),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Text("4. Meine Studierenden / Kursteilnehmer/-innen"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                      "Eine partnerschaftliche und vertrauensvolle Zusammenarbeit mit meinen Studierenden / Kursteilnehmer/-innen und Partnern /App und Web Programmieren/ prägt maßgeblich mein Ansehen und Vertrauen in der Öffentlichkeit. Die Zufriedenheit der Studierenden / Kursteilnehmer/-innen mit meinen Dienstleistungen ist entscheidend für meine Wettbewerbsfähigkeit.\n\nAm Anfang meiner Zusammenarbeit stehen das persönliche Beratungsgespräch und die individuelle Bedarfsanalyse. Dabei steht der Einzelne mit seinen persönlichen Interessen stets im Mittelpunkt meiner Bemühungen."),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                      "Studierenden / Kursteilnehmer/-innen sind für mich"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                      "\t\t\t•	die Studierende / Kursteilnehmer/-innen mit ihrem berechtigten Anspruch auf eine sorgfältige Beratung, Unterstützung und qualifizierte Durchführung der Lehrgänge\n\t\t\t•	alle Personen, die sich sprachlich qualifizieren möchten\n\t\t\t•	Studierender/-e, die sich auf eine Aufnahmeprüfung an einer deutschen Universität oder Hochschule vorbereiten möchte\n\t\t\t•	Arbeitnehmer, die ihre Sprachkenntnisse für den Beruf verbessern möchten\n\t\t\t•	Firmen und Institutionen, die effektive Sprachvermittlung für ihre Mitarbeiter/-innen wünschen\n\t\t\t•	Jugendliche, die im Rahmen eines Auslandsaufenthaltes ihre Deutschkenntnisse verbessern möchten und die deutsche Kultur kennenlernen möchten"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text("Partner sind für mich"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    "\t\t\t•	Mitarbeiter/-innen von Behörden, staatlichen und transnationalen Institutionen, \n\t\t\t•	Mitarbeiter/-innen der IT Firmen, die App`s und Webprojekt betreuen, mit denen ich vor allem in der IT-arbeit kooperiere",
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Text(
                    "5. Meine Mitarbeiterinnen und Mitarbeiter",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Text(
                        "Berufliche Bildung ist eine personalintensive Dienstleistung. Meine Studierende / Kursteilnehmer/-innen erwarten zu Recht hohe Qualität im Hinblick auf kundenorientierte Beratung, professionelle Lehrgangskonzeption sowie fachliche und pädagogische Kompetenz. Dies erfordert von allen meinen Honorarkräften ein großes Maß an Engagement und Identifikation mit den Zielen meines Unternehmens. Jeder Mitarbeiter und jede Mitarbeiterin trägt Mitverantwortung für den Erfolg unserer Arbeit.\n\nIch weiß, dass dies nur von Honorarkräften zu leisten ist, die über Freiräume für Kreativität und Eigeninitiative verfügen. Meine Zusammenarbeit basiert daher auf den Grundsätzen kooperativer Teamarbeit, transparenter und vertrauensvoller Kommunikation sowie der Förderung von meinen Honorarkräften. Diese Punkte gelten auch für meineuns „Ehrenamtlichen"))
              ],
            ),
          ),
        ));
  }
}
