import 'package:lindenhofpark/BiologicalFacts/model/biolocial_fact.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/leaf_type.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/tree.dart';
import 'package:lindenhofpark/resources/resources.dart';

final List<Tree> trees = [
  // Sofia
  Tree("Rotbuche", TreeImage.ganzerBaumRotbuche, "Fagus sylvatica", 28,
      DateTime(1973, 01, 01), "Mitteleuropa", LeafType.broud, [
    BiologicalFact(
        title: "Borke",
        content:
            """Die Borke, in den jungen Jahren des Baumes, erscheint graubraun und glatt, was einem Elefantenfuß ähnelt. Im älteren Stadium des Baumes ist der Baum gefleckt und erscheint silbergrau.""",
        images: [
          BiologicalFactImage.borkeAussehenRotbuche,
          BiologicalFactImage.borkeRotbuchemehr
        ]),
    BiologicalFact(
        title: "Blattform",
        content:
            """Das Blatt der Rotbuche ist elliptisch geformt mit welligen Rändern. Die Blätter haben ein hell- bis dunkelgrün und glänzendes Erscheinungsbild. Die Unterseite ist dabei heller als die Oberseite.""",
        images: [
          BiologicalFactImage.blattRotbuche,
          BiologicalFactImage.blattAstRotbuche
        ]),
    BiologicalFact(
        title: "Blütezeit",
        content: """Die Blütezeit findet zwischen April und Mai statt.""",
        images: []),
    BiologicalFact(
        title: "Frucht",
        content:
            """Buchheckern (Nussfrüchte) Reifen meistens im September bzw. Oktober. Diese Nussfrüchte sind lang, dreikantig, braun und befinden sich meist zu zweit in einem rauen, stacheligen Cupalus. Da die Samen sehr Ölhaltig sind, nutzen sie verschiedenste Tiere, besonders im Herbst, als Nahrungsgrundlage.""",
        images: [
          BiologicalFactImage.fruchtVonRotbuche,
          BiologicalFactImage.fruchtRotbucheBoden
        ]),
    BiologicalFact(
        title: "Fortpflanzung",
        content:
            """Die Samen der Rotbuche vermehren sich durch Windbestäubung, bei dem der Wind den Pollen der männlichen Blüte zur weiblichen Blüte weht. Dadurch findet die Befruchtung statt.""",
        images: []),
    BiologicalFact(
        title: "Durchschnittliches Alter",
        content:
            """Durchschnittlich wird die Rotbuche 200 Jahre Alt, in Einzelfällen kann die Rotbuche auch bis zu 1000 Jahre alt werden.""",
        images: []),
    BiologicalFact(
        title: "Fledermauskasten",
        content:
            """Wenn sie nach oben gucken, erkennen sie, dass an dem Baum ein Fledermauskasten hängt. Diese bieten den Tieren einen guten Unterschlupf und können auch als Überwinterungsquartier genutzt werden.""",
        images: [
          BiologicalFactImage.fledermauskastenRotbuche,
          TreeImage.ganzerBaumRotbuche
        ])
  ]),
  // David
  Tree(
      "Urweltmammutbaum",
      TreeImage.ganzerBaumUrweltmamutbaum,
      "Metasequoia glyptostroboides",
      24,
      DateTime(1971, 01, 01),
      "China",
      LeafType.needle, [
    BiologicalFact(
        title: "Blütezeit",
        content:
            """Die Blütezeit des Urweltmammutbaums ist im späten Winter bis zum frühen Frühjahr, meist von Februar bis März.""",
        images: []),
    BiologicalFact(
        title: "Blatt/Nadelform",
        content:
            """Die Blätter des Urweltmammutbaums sind nadelförmig, weich und hellgrün. Sie sind gegenständig an den Zweigen angeordnet und werden im Herbst braun, bevor sie abfallen.""",
        images: []),
    BiologicalFact(
        title: "Nadeln",
        content: """Die Nadeln sind etwa 1-3 cm lang und flach.""",
        images: []),
    BiologicalFact(
        title: "Frucht",
        content:
            """Der Urweltmammutbaum produziert holzige, eiförmige Zapfen, die etwa 2-3 cm lang sind. Diese Zapfen reifen im Herbst und enthalten kleine Samen.""",
        images: []),
    BiologicalFact(
        title: "Fortpflanzung",
        content:
            """Die Fortpflanzung erfolgt sowohl durch Samen als auch vegetativ durch Stecklinge. Die Samen befinden sich in den reifen Zapfen und werden durch den Wind verbreitet. Die vegetative Vermehrung durch Stecklinge ist in der Kultivierung weit verbreitet.""",
        images: []),
    BiologicalFact(
        title: "Borke",
        content:
            """Die Borke des Urweltmammutbaums ist rötlich-braun bis graubraun, faserig und schuppig. Sie schält sich in langen Streifen oder Platten ab und wird mit dem Alter dicker und tiefer gefurcht.""",
        images: []),
    BiologicalFact(
        title: "Durchschnittliches Alter",
        content:
            """Der Urweltmammutbaum kann unter optimalen Bedingungen ein Alter von mehreren Hundert Jahren erreichen. Einige Exemplare sind bekannt, die über 600 Jahre alt sind.""",
        images: []),
    BiologicalFact(
        title: "Lebensraum",
        content:
            """Der Urweltmammutbaum ist ein wichtiger Bestandteil seines Ökosystems und bietet Lebensraum für verschiedene Arten von Tieren und Pflanzen. Vögel nutzen die Zweige zum Nisten, während kleine Säugetiere und Insekten in der Borke vorzufinden sind.""",
        images: []),
  ]),
  // Janne
  Tree("Schwarzkiefer", TreeImage.ganzerBaumSchwarzkiefer, "Pinus nigra", 18,
      DateTime(1846, 01, 01), "Europa", LeafType.needle, [
    BiologicalFact(
        title: "Blütezeit",
        content:
            """Die Blütezeit der Schwarzkiefer erstreckt sich von April bis Anfang Juni.""",
        images: []),
    BiologicalFact(
        title: "Nadelform",
        content:
            """Die Nadelblätter sind dunkelgrün, gerade und können eine Länge von bis zu 18 cm erreichen.""",
        images: []),
    BiologicalFact(
        title: "Frucht",
        content:
            """Die Blüten der Schwarzkiefer manifestieren sich als kurz gestielte Zapfen.""",
        images: []),
    BiologicalFact(
        title: "Fortpflanzung",
        content: """Die Fortpflanzung erfolgt durch Bestäubung mittels Wind.""",
        images: []),
    BiologicalFact(
        title: "Borke",
        content:
            """Die Borke der Schwarzkiefer ist bräunlich-grau und schuppig. Mit zunehmendem Alter reißt die Stammborke auf, was dem Baum ein charakteristisches Aussehen verleiht.""",
        images: []),
    BiologicalFact(
        title: "Alter",
        content:
            """Schwarzkiefern können ein erstaunliches Alter von bis zu 800 Jahren erreichen und somit viele Generationen überdauern.""",
        images: []),
  ]),
  // Emi
  Tree("Winterlinde", TreeImage.ganzerBaumWinterlinde, "Tilia Cordata", 24,
      null, "Europa", LeafType.broud, [
    BiologicalFact(
        title: "Borke",
        content:
            """Die Winterlinde hat eine dicht gerippte, schwärzlichgraue Borke. Diese kann sich mit dem Alter ändern, meistens werden sie braungrau.""",
        images: [
          BiologicalFactImage.borkeWinterlinde,
          TreeImage.ganzerBaumWinterlinde
        ]),
    BiologicalFact(
        title: "Blattform",
        content:
            """Die Blätter sind Herzförmig mit einem Durchmesser von 5-6 cm und haben eine dunkelgrüne Farbe auf der Oberseite, als auch eine blaugrüne Unterseite.""",
        images: [
          BiologicalFactImage.blattWinterlinde,
          BiologicalFactImage.blaetterWinterlinde
        ]),
    BiologicalFact(
        title: "Blütezeit",
        content:
            """Die Blütezeit der Winterlinde ist von Juni bis Juli, ein Monat später als die Sommerlinde.""",
        images: [
          BiologicalFactImage.blaetterWinterlinde,
          BiologicalFactImage.bluetenWinterlinde
        ]),
    BiologicalFact(
        title: "Frucht",
        content:
            """Die Frucht der Winterlinde ist eine kleine, kugeliges Nüsschen, diese ist ca. 5-7 mm groß. Sie reifen im September aber bleiben oft den Winter über am Baum.""",
        images: []),
    BiologicalFact(
        title: "Fortpflanzung",
        content:
            """Man nennt sowohl Sommer- als auch Winterlinden Zwitterblüten. Das heißt die Blüte hat sowohl männliche als auch weibliche Geschlechtsorgane. Die Blüte an sich wird jedoch von Insekten wie z. B. Bienen bestäubt.""",
        images: []),
    BiologicalFact(
        title: "Durchschnittliches Alter",
        content: """Die Winterlinde kann bis zu 1000 Jahre alt werden.""",
        images: []),
    BiologicalFact(
        title: "Leben am Baum",
        content: """Neben Insekten leben auch Fledermäuse an diesem Baum.""",
        images: [
          TreeImage.ganzerBaumWinterlinde,
          BiologicalFactImage.vogelhausWinterlinde
        ]),
    BiologicalFact(
        title: "Besonderheiten",
        content:
            """Das Holz der Winterlinde ist sehr weich und leicht, es wird häufig für den Musikinstrumentenbau und Bildhauerei verwendet. Die Winterlinde war auch Baum des Jahres in Deutschland in 2016.""",
        images: [
          BiologicalFactImage.borkeWinterlinde,
          BiologicalFactImage.blaetterWinterlinde
        ]),
  ]),
  // Mika
  Tree("Weihrauchzeder", TreeImage.ganzerBaumWeihrauchzeder,
      "Calocedrus decurrens", 24, null, "USA, Kalefornien", LeafType.needle, [
    BiologicalFact(
        title: "Borke",
        content:
            """Die Borke alter Stämme ist orangefarben und längsrissig. Bei älteren Bäumen ist sie dick und löst sich in Platten ab.""",
        images: [
          BiologicalFactImage.borkeAstWeihrauchzeder,
          TreeImage.ganzerBaumWeihrauchzeder
        ]),
    BiologicalFact(
        title: "Nadelform",
        content:
            """Schuppenförmige Blätter, die kreuzgegenständig in vierzähligen Wirteln angeordnet sind. Die Kantenblätter sind herablaufend, gekielt und linealisch-lanzettförmig, während die Flächenblätter etwas kürzer und breit spatelförmig sind. Die Blätter sind etwa 2-15 mm lang und 1,5-3 mm breit.""",
        images: [
          BiologicalFactImage.blattWeihrauchzeder,
          BiologicalFactImage.blattFruchtWeihrauchzeder
        ]),
    BiologicalFact(
        title: "Blütezeit",
        content:
            """Die Blütezeit der Weihrauchzeder ist von Januar, bzw. März bis April.""",
        images: []),
    BiologicalFact(
        title: "Frucht",
        content:
            """Längliche Zapfen, die aus 6 Schuppen aufgebaut sind. Die Zapfen werden als gelbbraun oder braun beschrieben.""",
        images: [
          BiologicalFactImage.blattFruchtWeihrauchzeder,
          BiologicalFactImage.blattWeihrauchzeder
        ]),
    BiologicalFact(
        title: "Fortpflanzung",
        content:
            """Die Weihrauchzeder pflanzt sich durch Samen fort, die in den Zapfen gebildet werden.""",
        images: []),
    BiologicalFact(
        title: "Durchschnittliches Alter",
        content: """Die Weihrauchzeder kann bis zu 800 Jahr alt werden.""",
        images: []),
  ]),
];
