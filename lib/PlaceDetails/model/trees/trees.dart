import 'package:lindenhofpark/BiologicalFacts/model/biolocial_fact.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/leaf_type.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/tree.dart';
import 'package:lindenhofpark/resources/resources.dart';

final List<Tree> trees = [
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
          BiologicalFactImage.ganzerBaumRotbuche
        ])
  ]),
  Tree("Bergahorn", "sample_tree.jpeg", "Acer pseudoplatanos", 30,
      DateTime(1846, 01, 01), "Schneehalde", LeafType.needle, []),
  Tree("Roteiche", "sample_tree.jpeg", "Quercus rubra", 21,
      DateTime(1846, 01, 01), "Schneehalde", LeafType.needle, []),
];
