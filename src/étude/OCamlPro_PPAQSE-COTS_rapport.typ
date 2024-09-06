#import "@local/ocamlpro:0.1.0": *

#show: report.with(
  title: [COTS de qualité : \ logiciels critiques et temps réel],
  version: sys.inputs.at("git_version", default: "<unknown>"),
  authors: (
    (
      firstname: "Julien",
      lastname: "Blond",
      email: "julien.blond@ocamlpro.com"
    ),
  )
)

#let todo(t) = par(text(red)[TODO: #t])


#let absint = link("https://www.absint.com/index.html", "AbsInt")
#let aiT = link("https://www.absint.com/ait/", "aiT")
#let altergo = link("https://alt-ergo.ocamlpro.com/", "Alt-Ergo")
#let aocc = link("https://www.amd.com/en/developer/aocc.html", "AOCC")
#let api_sanity_checker = link(
  "https://lvc.github.io/api-sanity-checker/",
  "API Sanity Checker"
)
#let apple = link("https://www.apple.com", "Apple")
#let armlink = {
  link("https://developer.arm.com/tools-and-software/embedded/arm-compiler",
  "Arm Linker")
}
#let astree = link("https://www.absint.com/astree/", "Astree")
#let boost = link("https://live.boost.org/", "Boost")
#let bound-T = link("https://www.bound-t.com", "Bound-T")
#let cadna = link("https://cadna.lip6.fr/index.php", "CADNA")
#let cantata = link("https://www.qa-systems.com/products/cantata", "Cantata")
#let chronos = link("https://www.comp.nus.edu.sg/~rpembed/chronos/", "Chronos")
#let clang = link("https://clang.llvm.org", "Clang")
#let compcert = link("https://compcert.org", "CompCert")
#let coq = link("https://coq.inria.fr", "Coq")
#let criterion = link("https://criterion.readthedocs.io", "Criterion")
#let cvc5 = link("https://cvc5.github.io/", "CVC5")
#let fluctuat = {
  link("https://www.lix.polytechnique.fr/~putot/fluctuat.html", "Fluctuat")
}

#let framac = link("https://frama-c.com", "Frama-C")
#let gappa = link(
  "https://gappa.gitlabpages.inria.fr/gappa/index.html",
  "Gappa"
)
#let gcc = link("https://gcc.gnu.org", "GCC")
#let gliwa = link("https://www.gliwa.com/", "Gliwa")
#let haskell = link("https://www.haskell.org", "Haskell")
#let icx = link(
  "https://www.intel.com/content/www/us/en/developer/tools/oneapi/dpc-compiler.html",
  "ICX"
)
#let intel = link("https://www.intel.com", "Intel")
#let iris = link("https://iris-project.org/", "Iris")
#let isabelle = link("https://isabelle.in.tum.de", "Isabelle")
#let lean = link("https://lean-lang.org", "Lean")
#let libcester = link(
  "https://exoticlibraries.github.io/libcester/index.html",
  "LibCester"
)
#let mpfi = link("https://gitlab.inria.fr/mpfi/mpfi", "MPFI")
#let mpfr = link("https://www.mpfr.org", "MPFR")
#let msvc = link("https://docs.microsoft.com/en-us/cpp/", "MSVC")
#let novaprova = link("https://novaprova.org/", "NovaProva")
#let ocaml = link("https://ocaml.org", "OCaml")
#let opmock = link("https://opmock.com", "Opmock")
#let otawa = link("https://www.tracesgroup.net/otawa/?page_id=361", "Otawa")
#let parasoft = link(
  "https://www.parasoft.com/products/parasoft-c-ctest/",
  "Parasoft"
)
#let polyspace = {
  link("https://www.mathworks.com/products/polyspace.html", "Polyspace")
}
#let pvs = link("https://pvs.csl.sri.com", "PVS")
#let rapidtime = {
  link("https://www.rapitasystems.com/products/rapidtime", "RapidTime")
}
#let redefinedc = link("https://gitlab.mpi-sws.org/iris/refinedc", "RefinedC")
#let stackanalyser = {
  link("https://www.absint.com/stackanalyzer/", "StackAnalyzer")
}
#let sweet = link("http://www.mrtc.mdh.se/projects/wcet/sweet.html", "SWEET")
#let t1stack = link("https://www.gliwa.com/products/t1stack/", "T1.stack")
#let TPT = link("https://piketec.com/tpt/", "TPT")
#let vercors = link("https://vercors.ewi.utwente.nl/", "VerCors")
#let vectorcast = link(
  "https://www.vector.com/int/en/products/products-a-z/software/vectorcast/vectorcast-c/",
  "VectorCAST/C++"
)
#let viper = link("https://viper.ethz.ch", "Viper")

#let xsc = link(
  "https://www2.math.uni-wuppertal.de/wrswt/xsc/cxsc/apidoc/html/index.html",
  "XSC"
)
#let z3 = link("https://github.com/Z3Prover/z3", "Z3")









= Introduction

== Identification

Ce rapport présente une étude des langages C, C++, Ada, Scade, OCaml et Rust
du point de vue de la sûreté. Il suit les clauses techniques #cite(<ctcots>)
relatives au projet
COTS de qualité : logiciels critiques et temps réel du CNES.

== Terminologie

#align(
  center,
  table(
    columns: (auto, auto),
    [*Terme*], [*Définition*],
    [COTS], [_Commercial Off-The-Shelf_ ou produit sur étagère],
    [WCET], [
      _Worst Case Execution Time_ ou temps d'exécution du pire cas
      (_i.e._ maximal)
    ],
  )
)

== Organisation du document

Le document présente tout d'abord la méthodologie utilisée pour l'étude en
détaillant les points abordés pour chaque langage. Ensuite, chaque langage
est étudié individuellement en respectant le plan défini.

= Méthodologie

La méthodologie utilisée pour l'étude des langages reprend les points abordés
dans les clauses techniques #cite(<ctcots>) en les détaillant.

== Paradigme

#let paradigme(p) = text(blue, p)

À chaque langage de programmation vient sa manière de decrire les solutions
algorithmiques au problèmes posés. Cette manière d'aborder les problèmes est
ce qu'on appelle le _paradigme_ du langage.

Les paradigmes les plus courants des langages informatiques sont la plupart du
temps les suivants:
- #paradigme[impératif];
- #paradigme[fonctionnel];
- #paradigme[objet];
- #paradigme[déclaratif].

Notons que les paradigmes ne sont pas exclusifs : un langage peut être
composer plusieurs paradigmes et c'est même le cas général dans les langages
généralistes récents. Toutefois, même en composant plusieurs paradigmes, il y
en a souvent un qui se dégage plus que les autres à l'usage.

=== Le paradigme impératif

Le paradigme impératif consiste à exprimer les calculs sous une forme
structurée d'instructions modifiant un état mémoire. Les instructions
emblématiques de ce paradigme sont
- l'affectation;
- le branchement conditionnel (si .. alors .. sinon ..);
- les sauts.

Les sauts ne sont pas toujours disponibles explicitement mais ils sont
utilisés implicitement dans les boucles (`for` ou `while`) que l'on
trouve dans tous les langages impératifs. Par exemple, en C, on peut
calculer la longueur d'une liste chainée de la manière indiquée
dans le #ref(<ex_C_length>) :

#figure(
  ```c
  struct list {
    int value;
    struct list *next;
  };

  int length(struct list *l)
  {
    int len = 0;
    while (NULL != l) {
      len++;
      l = l->next;
    }
    return len;
  }
  ```,
  caption: [Calcul de la longueur d'une liste chainée en C],
  supplement: [Source],
) <ex_C_length>

En considérant que `NULL` représente la liste vide, la fonction `length`
parcourt la liste en incrémentant un compteur `len` à chaque élément de la
liste. Lorsque la liste est vide, la fonction retourne la longueur obtenue.

Le style impératif est le plus répandu dans les langages informatiques. Il est
relativement proche de la machine mais propice aux erreurs de
programmation car il n'est pas toujours évident de suivre l'état d'un système
lorsque plusieurs morceaux de programme le modifient.

=== Le paradigme fonctionnel

Le paradigme fonctionnel consiste à exprimer les calculs sous la forme d'une
composition de fonctions mathématiques. Dans sa forme dite _pure_, les
changements de l'état du système sont interdits. En conséquence, il n'y a pas
d'affectations ni de sauts.

Les branchements conditionnels existent mais les boucles sont remplacées par la
récursivité, c'est-à-dire la possibilité pour une fonction de s'appeller
elle-même. Par exemple, pour calculer la longueur d'une liste en OCaml, on
procède récursivement :

```ocaml
let rec length (l : 'a list) : int = match l with
  | [] -> 0
  | _ :: tl -> 1 + length tl
```

Dans cet exemple, la fonction `length` prend en paramètre une liste et procède
par cas sur la structure de la liste. Si la liste est vide (`[]`), la longueur
est 0. Sinon on analyse la tête et la queue (`tl`) de la liste et on ajoute 1 à
la longueur de `tl`.

Le style fonctionnel est considéré comme plus sûr que le style impératif.
Chaque fonction est une boite noire qui ne produit pas d'effets de bord, ce qui
la rend plus facile à tester et à paralléliser. En contre-partie,
le style fonctionnel nécessite beaucoup d'allocations dynamiques et donc un
rammasse-miettes pour les gérer automatiquement. Cela peut avoir un impact
négatif sur les performances et les capacités temps réel.

Un langage fonctionnel qui accepte la mutabilité est dit _impur_. Les langages
fonctionnels impurs partagent les avantages et les inconvénients des deux
mondes : ils permettent un gain en performances en évitant potentiellement
beaucoup de copies de données mais héritent
également de la difficulté de gérer un état mutable de manière sûre.

=== Le paradigme objet

Le paradigme objet (ou POO#footnote[Programmation Orientée Objet]) consiste à
traiter les données comme des entités, les
_objets_, ayant leur propre état et des méthodes pour leur passer des messages.
Chaque problème informatique est vu comme l'interaction d'un objet avec un ou
plusieurs autres objets via les appels de méthode.

En POO, on distingue les classes, qui sont des modèles d'objets, et les objets
eux-mêmes, qui sont des _instances_ de classes. Par exemple, on peut représenter
un point d'un espace bidimensionnel en C++ de la manière suivante :

```cpp
class Point2D
{
protected:
    uint32_t pos_x = 0;
    uint32_t pos_y = 0;
public:
    Point2D(uint32_t x, uint32_t y) : pos_x(x), pos_y(y) {}

    uint32_t get_x(void) const { return pos_x; }

    uint32_t get_y(void) const { return pos_y; }

    virtual void print(void) const {
        std::cout << "Point2D(" << pos_x << ", " << pos_y << ")" << std::endl;
    }
};
```

Le mot clé `class`, présent dans pratiquement tous les langages orientés objet,
permet de déclarer un « patron » d'objet. Ici, le patron `Point2D` prend en
paramètre
de construction deux entiers `x` et `y` qui représentent les coordonnées du
point. Ces coordonnées sont enregistrées dans les attributs `pos_x` et
`pos_y` qui représentent l'état interne d'un objet `Point2D`.
Les méthodes `get_x` et `get_y` permettent de récupérer les coordonnées
du point et la méthode `print` permet d'afficher les coordonnées du point.

On peut alors créer une instance de `Point2D` de la manière suivante :

```cpp
Point2D p(1, 2);
```

et afficher les coordonnées du point avec l'appel de la méthode `print` de
l'objet `p` :

```cpp
p.print()
// affiche "Point2D(1, 2)"
```

La POO introduit également la notion d'héritage qui permet de partager du code
de manière concise. Par exemple, on peut étendre la classe `Point2D` pour les
points d'un espace tridimensionnel :

```cpp
class Point3D : protected Point2D
{
protected:
    uint32_t pos_z = 0;
public:
    Point3D(uint32_t x, uint32_t y, uint32_t z) : Point2D(x, y), pos_z(z) {}

    uint32_t get_z(void) const { return pos_z; }

    void print(void) const override {
        std::cout <<
        "Point3D(" << pos_x << ", " << pos_y << ", " << pos_z << ")" <<
        std::endl;
    }
};

int main(void)
{
    Point3D p(1, 2, 3);
    p.print(); // affiche "Point3D(1, 2, 3)"
    return 0;
}
```

Ici, la classe `Point3D` hérite de `Point2D` en en récupérant toutes les
méthodes et ajoute un attribut `pos_z`
pour la coordonnée en profondeur. La méthode `print` est redéfinie pour
afficher les trois coordonnées du point.

Le succès des langages objets (C++, Java, Javascript, ...) indique que le
paradigme est très populaire dans les domaines applicatifs et le Web où
la réutilisabilité est un critère de production déterminant.

Généralement, les objets ont un état interne mutable caractérisé par des
méthodes _setter_ ou d'autres méthodes modifiant leur état interne. De fait, le
paradigme objet va intrinsèquement souffrir des mêmes défauts que le paradigme
impératif sur la difficulté de suivre l'état réel d'un programme.

Par ailleurs, la hierarchie des classes forme une structure arborescente
qu'il est rapidement difficile de tracer mentalement. Au delà d'une certaine
profondeur, comprendre le flux de contrôle d'un programme sans outillage peut
être une gageure.

=== Le paradigme déclaratif

Le paradigme déclaratif consiste à décrire le problème à résoudre sans
préciser comment le résoudre. Il s'agit ici de décrire le _quoi_ et non le
_comment_.

Les langages déclaratifs sont généralement orientés vers la description de
données (XML, LaTeX, ...) mais il existe également des langages de
programmation
déclaratifs. Par exemple, Prolog est un langage de programmation qui
permet de décrire un problème de manière logique et de laisser le moteur
d'inférence résoudre le problème. Par exemple, on peut décrire un ensemble de
faits:

```prolog
animal(chat).
animal(chien).
```

et demander à Prolog quels sont les animaux possibles :

```prolog
?- animal(X).
X = chat ;
X = chien.
```

Cette abstraction permet généralement une programmation plus concise mais
cela va induire :
- soit une perte de performances : le _comment_ doit être retrouvé
  dynamiquement par le programme (Prolog) ;
- soit un modèle de compilation moins optimal (comme pour les langages fonctionnels
purs comme Haskell)
- soit par une perte d'expressivité
en restraignant le langage à un sous-ensemble plus facilement optimisable
(Lustre).

== Analyse statique

Pour chaque langage étudié dans ce rapport, nous présentons des outils d'analyse
statique permettant de déduire de l'information par une
interprétation abstraite du programme.

Les analyseurs statiques peuvent établir des métriques sur le code ou faire
de la rétro-ingénierie pour en déduire des propriétés (et en vérfier). Ils
peuvent également détecter des erreurs de programmation et, étant donné le
volume d'analyseurs sur le marché, nous nous concentrerons sur cette dernière
catégorie et en particulier sur ceux qui sont _corrects_.

Un analyseur statique est dit _correct_ s'il ne donne pas de faux-positifs
pour un programme sans _bug_. _A contrario_, il indiquera au moins un _bug_
pour un programme qui en comporte.

Chaque analyseur est étudié par rapport aux ressources publiques disponibles.
Cela comprend le manuel utilisateur, les publications scientifiques, les
brochures commerciales ou le site internet dédié.

Les types d'erreurs détectées dépendent des analyses effectuées par chaque
outils et tous n'utilisent pas toujours la même terminologie pour désigner un
type d'erreur. Nous avons donc regroupé les erreurs en catégories générales
et indiqué pour chaque outil s'il couvre au moins une partie des erreurs
d'une catégorie avec un symbole `✓`. Notons que l'absence de symbole ne
signifie pas forcément
que l'outil ne détecte pas l'erreur mais simplement que nous n'avons pas
trouvé d'information explicite à ce sujet sur les ressources publiques.

Les catégories d'erreurs sont les suivantes :

=== Arithmétique entière

Les erreurs d'arithmétique entière sont des erreurs qui surviennent lors de
calculs sur des entiers machine. Il s'agit là des entiers que l'on trouve dans
la plupart des langages de programmation et souvent désignés par le mot clé
`int`.

La taille des entiers manipulables dépend de l'architecture du processeur
utilisé. Sur la plupart des architectures, elle correspond aux puissances de 2
entre 8 et 64. Par exemple, un entier (machine) de 8 bits non signé (uniquement
positif) peut représenter un entier (mathématique) de 0 à 255. Les formes
signées utilisent un bit pour indiquer si l'entier est positif ou négatif; ce
qui permet de représenter les entiers mathématiques de -128 à +127.

Dès lors que les entiers machines ont une taille finie, il est possible de
réaliser des opérations qui dépassent cette taille. Par exemple, calculer
$200 + 100$ sur un entier non signé de 8 bits donnera 44 (300 modulo 256). Ce
résultat est correct dans une arithmétique modulo 256 mais il est rare
que le programmeur pense dans cette arithmétique et il est plus probable qu'il
s'agisse d'une erreur involontaire. Ce type d'erreur est appelé _overflow_
(ou dépassement de capacité).

Ce genre d'erreur peut être assez subtil car
bien qu'il soit détecté par le processeur qui positionne un drapeau
signalant le dépassement, il nécessite que le programmeur vérifie ce drapeau
explicitement pour en tenir compte; ce qu'il ne fait généralement pas.

Il y a aussi des opérations qui peuvent conduire à des comportements indéfinis
par le langage. Les langages dont la sémantique n'est pas complètement
standardisée donnent une certaine liberté aux compilateurs pour interprétter
certaines constructions. C'est ce qu'on appelle les _undefined behavior_.
Cela peut être problématique lorsque le comportement du compilateur n'est pas
celui imaginé par le développeur ou quand le programme est compilé avec un
autre compilateur. Ce genre d'erreur doit également être relevé car il
est susceptible de conduire à des erreurs d'exécution.

Une autre erreur couverte par l'analyse de l'arithmétique entière
est la division par 0. Celle-ci n'est pas plus autorisée en informatique que
dans les mathématiques générales et provoque une erreur fatale à l'exécution.


=== Arithmétique flottante

L'arithmétique flottante est basée sur une représentation binaire des nombres
réels. Les nombres flottants sont représentés par
trois valeurs : le _signe_, la _mantisse_ et l'_exposant_.
La mantisse est la partie
significative du nombre, l'exposant est la puissance de 2 ou de 10 à laquelle
il faut multiplier la mantisse et le signe indique si le nombre est
positif ou négatif.

Comme pour les nombres entiers, il existe plusieurs tailles de flottants et
la norme #cite(<ieee:754-2008>) définit plusieurs formats en fonction
de la base (2 ou 10) et le nombre de bits utilisés (en puissance de 2 de
16 à 128).

Bien que les nombres flottants permettent de représenter des nombres
plus grands que leur équivalent entier, ils n'en sont pas moins sujet à des
dépassement de capacité. Cela étant, le calcul flottant est complet et en cas
de dépassement ou de calcul impossible (comme la division par 0), le résultat
est donné par des nombres spéciaux comme $+infinity$ ou $-infinity$ ou
_NaN_#footnote[_Not A Number_ (pas un nombre), utilisé pour les opérations
invalides].

Le fait que l'arithmétique flottantte soit standardisée et complète en font
parfois un choix de prédilection pour les calculs en général. Certains
langages de programmation (comme Lua) ont un seul type numérique qui est,
par défaut, représenté par un flottant.

D'un point de vue mathématique, l'arithmétique flottante a cependant
un soucis d'arrondi inhérant au fait que la décomposition binaire d'un
nombre peut être supérieure à sa capacité. Elle est même d'ailleurs infinie
si le dénominateur du nombre n'est pas une puissance de 2. Par exemple, le
nombre décimal 0.5 a une représentation flottante exacte car c'est
$#text(red)[2]^(-1) = 1/#text(red)[2]$. En revanche 0.1 ($1/#text(red)[10]$)
n'a pas de représentation exacte car sa décomposition
binaire donne $0,0overline(0011)$ (où 0011 se répète à l'infini). Pour pouvoir
représenter ce nombre, il faut l'arrondir à une certaine précision et
généralement 0.1 vaut en 0.10000000000000000555 en flottant.

Ces arrondis donnent lieu à des approximations qui peuvent s'accumuler et
devenir problématiques lorsqu'on enchaîne les opérations. Elles peuvent
également donner lieu à des résultat contre-intuitifs. Par exemple, en calcul
flottant, l'égalité $0.1 + 0.2 = 0.3$ est fausse ! Avec les
arrondis, $0.1 + 0.2$ vaut 0.30000000000000004441 tandis que 0.3 vaut
0.29999999999999998890. Dans ce contexte, écrire des algorithmes numériques
fiables peut être très délicat.

Les analyses statiques sur l'arithmétique flottante peuvent détecter
les opérations ambiguës comme la comparaison ci-dessus et vérifier la marge
d'erreur en effectuant un calcun abtrait sur les intervalles possibles.

=== Gestion des pointeurs

Les pointeurs sont des valeurs représentant l'adresse en mémoire d'une autre
valeur. Ils sont couramment utilisés pour passer des valeurs par référence, et
par conséquent, éviter de copier ces valeurs à chaque fois qu'on les utilise
dans le flôt de contrôle.

La manipulation des pointeurs est plus ou moins explicite suivant les langages.
En C, les pointeurs sont des valeurs de première classe et peuvent être
manipulés directement. À l'inverse, en OCaml, les pointeurs n'apparaissent
jamais directement dans le code source mais sont utilisés implicitement par
le compilateur.

Lorsque les pointeurs sont explicites, il y a trois type d'erreurs courantes
qui peuvent survenir :
- le débordement;
- le déréférencement de NULL;
- le _dangling pointer_

Le débordement survient lorsqu'on écrit ou lit en mémoire à une adresse
qui n'est pas celle prévue à la base. Typiquement, cela arrive lorsqu'on
adresse un tableau en dehors de ses limites. Par exemple, si on a un tableau
de 10 éléments et qu'on accède à l'élément 11, on accède à une zone pouvant
contenir n'importe quelle donnée et _a priori_ pas celle qui était imaginée.

Le déréférencement de NULL, ou plus généralement le déréférencement invalide,
consiste à utiliser une adresse invalide et à tenter de lire ou écrire à
cette adresse. Quand un programme est lancé par un système d'exploitation,
ce dernier lui octroit une zone mémoire pour son usage exclusif. Si le programme
tente d'accéder à une zone mémoire qui ne lui appartient pas, une erreur
d'accès mémoire est levée et le programme est arrêté.

Le cas le plus courant
est celui du déréférencement de NULL. NULL est une valeur particulière qui est
utilisée pour dénoter des valeurs particulières dans les structures de données
usuelles. Par exemple, une liste chaînée se termine souvent par un pointeur
NULL pour indiquer la fin de la liste. Dans la plupart des systèmes, NULL vaut
techniquement 0 et ce n'est pas une adresse valide.

Le _dangling pointer_ survient lorsqu'on utilise un pointeur sur une
valeur qui n'a jamais été allouée ou été préalablement libérée. Dans les deux
cas, la valeur pointée est indéterminée et l'utilisation de cette valeur
peut conduire à des comportements indéfinis. Par exemple, en C le code suivant
pose problème :

```c
int *p = malloc(sizeof(int)); /* allocation d'un entier dans le tas */
*p = 42;                      /* écriture de 42 à l'adresse pointée */
free(p);                      /* libération de la mémoire */
printf("%d\n", *p);           /* utilisation de la valeur pointée */
```

Après le `free(p)`, l'adresse mémoire pointée par `p` peut être réutilisée
par une autre partie du programme et contenir n'importe quelle valeur. Il n'est
donc pas possible de prédire la valeur affichée par le `printf`.

Notons que le _dangling pointer_ apparaît généralement dans les situations
où l'allocation dynamique se fait manuellement (C, C++, ...) mais il peut très
bien arriver sans allocations dynamiques par l'echappement de portée :

```c
int *p;
{
  int x = 42;
  p = &x;
}
printf("%d\n", *p);
```

ou plus généralement :
```c
int *func(void)
{
    int n = 42;
    /* ... */
    return &n;
}
```

Dans les deux cas, le pointeur (`p` ou `&n`) pointe sur une valeur qui n'est
plus définie lorsque le pointeur est utilisé.


=== Concurrence

L'utilisation du calcul parallèle au sein d'un même programme se fait
généralement par l'utilisation des _threads_ fournis par le système
d'exploitation sous-jacent. Les threads permettent de lancer plusieurs
fonctions en parallèle en exploitant éventuellement la multiplicité des coeurs
de calcul de la machine. En toute théorie, cela permet d'accélérer le calcul
et de rendre le programme plus réactif.

Pour raisonner avec du calcul parallèle, il est nécessaire de mettre en place
des mécanismes de partage d'information entre les _threads_. Ces mécanismes
sont généralement des variables partagées ou des files de messages. Lorsque
plusieurs _threads_ accèdent à une même variable, il est possible que les
valeurs lues ou écrites soient incohérentes si les _threads_ ne sont pas
synchronisés. Par exemple, si un _thread_ écrit une valeur dans une variable
et que l'autre _thread_ lit cette valeur avant que l'écriture ne soit terminée,
il est possible que le second _thread_ lise une valeur intermédiaire qui n'est
pas celle attendue.

Pour éviter ce genre de problème, il est nécessaire de synchroniser les
_threads_ entre eux. Les mécanismes de synchronisation les plus courants sont
les _mutex_ (verrous) et les _sémaphores_. Toutefois, ces mécanismes se
mettent en place manuellement en fonction de ce que le programmeur imagine
comme étant le bon ordonnancement des _threads_. Or cet ordonnancement n'est
pas toujours celui qui est effectivement réalisé par le système d'exploitation,
ce qui rend les problèmes de concurrence très difficiles à reproduire et à
corriger.

Certaines analyses statiques peuvent détecter des erreurs de concurrence en
simulant les ordonnancements possibles et en vérifiant que les valeurs lues
et écrites sont cohérentes. En fonction de l'analyse effectuée, il est possible
de détecter deux types d'erreurs :
- les _data races_ (courses critique) qui surviennent lorsqu'un _thread_ lit ou
  écrit une valeur partagée sans synchronisation;
- les _deadlocks_ (interblocages) qui surviennent lorsqu'un _thread_ attend une
  ressource qui est détenue par un autre _thread_ qui lui-même attend une
  ressource détenue par le premier.

=== Gestion de la mémoire

Un programme utilise deux zones de mémoire : une zone statique et une zone
dynamique. La zone statique est prédéfinie à la compilation et contient les
données globales (ou explicitement statiques avec le mot clé `static` du C) et
ne peut être modifiée. La zone dynamique est réservée à l'éxécution du programme
et contient deux sous-zones : la pile et le tas.

La _pile_ est une zone de mémoire avec une taille maximale définie par le
système et qui se remplit automatiquement en fonction du modèle d'execution
du langage. En général, elle se remplit à chaque appel de fonction avec les
données locales et l'adresse de retour des fonctions, puis se vide lorsque les
fonctions terminent. Un dépassement de pile (_stack overflow_) peut survenir
lorsque qu'on cumule trop d'appel de fonction; ce qui peut arriver facilement
avec une récursion mal maîtrisée. Un dépassement de pile est une erreur fatale
au programme.

Le _tas_ est une zone libre de mémoire dans laquelle on peut allouer des
données dynamiquement. L'allocation dynamique est réalisée par l'appel de
fonctions spécifiques qui demandent au système d'exploitation de réserver une
zone de mémoire de taille donnée. Lorsque la mémoire n'est plus utilisée, il
est nécessaire de la libérer pour éviter les _fuites mémoire_. Si trop
de mémoire est allouée sans être libérée, le programme peut consommer toute
la mémoire disponible et être arrêté par le système d'exploitation dans le
meilleur des cas. Dans le pire des cas, le système entier est paralysé car privé
des ressources mémoires nécessaires à son fonctionnement nominal.

Dans la bibliothèque standard du C, la fonction `malloc` peut être utilisée
pour allouer et `free` pour libérer la mémoire. Pour éviter les fuites mémoires,
il faut donc un `free` pour chaque `malloc` réalisé. Cependant, les programmes
non triviaux mettent en oeuvre des structures de données complexes dont
certaines parties sont allouées dynamiquement et savoir quand faire le `free`
peut être délicat. Il peut arriver que le programmeur pêche par exces de
prudence et se retrouve à libérer deux fois une même allocation (_double free_).

La double libération a un comportement indéterminé et peut conduire à une
corruption de l'allocateur de mémoire entrainant des allocations incohérentes
et difficiles à diagnosiquer.

Certaines analyses statiques peuvent détecter les fuites mémoires et les
doubles libérations en suivant le flôt de contrôle du programme et en
vérifiant que chaque allocation est bien libérée une et une seule fois.

Notons que les langages à gestion automatique de la mémoire ne sont pas exempt
de fuites mémoires. La gestion automatique de la mémoire
est basée sur un ramasse-miettes qui libère la mémoire automatiquement
lorsqu'elle n'est plus utilisée. Toutefois, lorsque le ramasse-miettes ne peut
pas déterminer si une donnée est encore utilisée ou non, il peut décider de
la conserver alors qu'elle n'est plus utilisée. C'est le cas des
ramasse-miettes dits «conservatifs».

=== WCET

Le calcul du WCET est important sur les systèmes temps réel pour garantir
que les tâches critiques se terminent dans un temps donné. Le WCET est le
temps maximal que peut prendre une tâche pour se terminer. Il est calculé
en fonction des temps d'exécution des instructions, des branchements et des
accès mémoire.

Il existe deux méthodes pour calculer le WCET : la méthode dynamique et
la méthode statique. La méthode dynamique consiste à exécuter le programme
dans l'environnement cible et à mesurer le temps d'exécution un nombre de fois
jugé suffisant pour établir un WCET statistique. Cette
méthode est fiable mais coûteuse en temps et en ressources.

La méthode statique consiste à analyser le programme sans l'exécuter et à
déduire le WCET à partir de cette analyse. Le problème de cette méthode est
qu'il est difficile de calculer un WCET précis du fait des optimisations
réalisées par le compilateur et de la complexité des architectures modernes.
La prédiction de branchement ou l'utilisation des caches peut faire varier le
le temps d'exécution de manière importante et rendre le WCET difficile à
calculer sans le majorer excessivement.

=== Analyse de la pile

L'analyse de la pile consiste à calculer la taille maximale de la pile
utilisée par un programme. La plupart du temps, cette analyse se fait
directement sur le binaire car le langage source ne contient pas forcémement
les informations adéquates pour réaliser cette analyse. Ces informations sont
ajoutées par le compilateur lors de la génération du binaire.

Connaître la taille maximale de la pile utilisée est important pour dimensionner
et optimiser les systèmes embarqués qui peuvent être très contraints en mémoire.
Cela permet d'éviter les dépassements de pile (_stack overflow_) qui sont des
erreurs fatales.

L'analyse de la pile peut ne pas être décidable lorsque le programme utilise
des pointeurs de fonctions car il n'est pas forcément possible de déterminer
la suite d'appels de fonctions à l'avance. Dans ce cas, l'analyse de la pile
peut demander à annoter le code source pour avoir plus d'informations.

=== Notes sur les analyseurs statiques

==== Frama-C


Parmi les analyseurs statiques étudiés, #framac#cite(<framac>) a la
particularité de
fonctionner avec des _plugins_ dédiés à un type d'analyse particulier. La
complétion de l'analyse globale considérée dans les comparatifs du document
suppose que les _plugins_ usuels soient utilisés, notamment :
- Eva ;
- Wp ;
- Mthread.

Certaines analyses complémentaires peuvent être proposées par l'outil via des
plugins payants ou réalisés _ad hoc_.

==== Polyspace

Polyspace désigne une gamme de produit de la société MathWorks
#footnote[#link("https://fr.mathworks.com")] qui propose différentes solutions
autour de l'analyse statique.

Dans le cadre de cette étude, nous désignons par Polyspace la solution
_Polyspace Code Prover_.

==== TIS Analyser

_TrustInSoft Analyser_ est un outil d'analyse statique développé par la société
_TrustInSoft_#footnote[#link("https://trust-in-soft.com")]. C'est un _fork_
de Frama-C qui utilise un ancien plugin _value_ basé sur le calcul
d'intervalles. _TrustInSoft_ a amélioré le plugin, la traçabilité des erreurs
et l'expérience utilisateur.

== Meta formalisation

Pour certains langages, il est possible d'utiliser des outils de formalisation
pour spécifier des programmes et prouver que ces propriétés sont respectées.
Il existe globalement trois stratégies pour développement formel pour les
langages cibles:
- l'extraction de code;
- la génération de code;
- la vérification de code.


L'extraction de code consiste à écrire un programme dans un langage de
spécification (comme #coq ou #isabelle par exemple) et à extraire un programme
exécutable dans un langage cible. Ce dernier peut être soit le langage voulu
soit un langage compatible avec le langage voulu. Par exemple, on peut
extraire un programme #ocaml de #coq et compiler ce programme en un fichier
objet pouvant être lié à un programme C. C'est l'approche la plus simple pour
faire des développements formels intégrables dans des systèmes existants mais
elle a plusieurs inconvénients :
- elle nécessite un personnel très qualifié pour manipuler les langages formels;
- elle suppose que l'extraction de programme est correcte;
- elle intègre généralement un rammasse-miettes qui peut être problématique
  pour des systèmes embarqués.

#todo[ajouter un schéma]

La génération de code consiste à injecter le langage cible dans le langage
formel (qui devient un langage hôte). Cette injection se fait en décrivant
la sémantique du langage cible dans langage hôte, ce qui permet de décrire à la
fois des programmes dans le langage cible en utilisant la syntaxe du langage
hôte mais également de profiter des capacités du langage hôte pour la
description et la vérification des propriétés. Au final, cette approche permet
de décrire des programmes idiomatique au langage cible dans une syntaxe
plus ou moins proche de celui-ci suivant les capacités du langage hôte et de
démontrer des propriétés sur ces programmes. L'inconvénient de cette approche
réside essentiellement dans la travail nécessaire pour décrire une injection
complète du langage cible dans le langage hôte qui peut se compter en années de
travail.

#todo[ajouter un schéma]

La vérification de code consiste partir du programme à vérifier dans le
langage cible et à décrire
des propriétés sur ce programme par le biais d'annotations (la plupart du
temps dans les commentaires). Ces propriétés sont ensuite vérifiées par un
outil de vérification tiers. Cette approche est la plus pratique d'un point de
vue opérationnel car elle ne nécessite pas de manipuler des langages formels
directement. Les équipes de développement peuvent continuer à travailler
dans leur langage habituel et l'ajout des annotations peut se faire par d'autres
personnes. Toutefois, cette approche a des limites car les propriétés vérifiables
sont limitées par les capacités de l'outil de vérification et les annotations
doivent être suffisamment précises pour être utiles. Cela demande souvent une
connaissance assez fine de l'outil de vérification pour être efficace. Par
ailleurs, et comme pour la solution précédente, l'outil doit avoir un modèle
sémantique du langage cible, ce qui nécessite beaucoup de travail.

#todo[exemple]

Etant donné que que l'extraction de code ne donne pas un résultat propice à une
utilisation critique, nous nous concentrerons dans ce rapport sur les outils
de génération de code et les outils de vérification lorsqu'ils existent et sont
jugés suffisamment matures.

== Compilateurs

Pour chaque langage étudié, nous présentons les compilateurs disponibles et
les plateformes supportées, notamment les architectures les plus courantes:
- x86;
- x86_64;
- ARM.

== Test

Il y a plusieurs type d'outils pour tester un programme que l'on peut diviser
en trois catégories qui ne sont pas forcément exclusives:
- les outils d'écriture de tests;
- les outils de génération de tests;
- les outils de gestion des tests.

Les outils d'écriture de tests permettent de décrire les tests à réaliser. Ils
sont souvent fournis sous la forme de bibliothèques logicielles qui fournissent
des fonctions, des macros ou des annotations pour décrire les tests à
l'intérieur du programme lui même ou d'un programme de test.

L'écriture des tests étant souvent fastidieuse et laborieuse, il existe des
générateurs de tests qui offrent la possibilité de réaliser une bonne partie des
test unitaire ou fonctionnels de manière automatique. Ces générateurs peuvent
être basés sur des techniques de génération aléatoire (_fuzzing_),
de génération de modèle (_model checking_) ou de génération de cas de test aux
limites. La génération de test nécessite généralement une part de spécification
manuelle pour éviter de générer trop de cas de tests dont l'intérêt est limité
et gaspiller des ressources inutilement.

Les outils de gestion des tests engloblent les outils qui vont ajouter de
l'intelligence dans l'éxécution des tests et factoriser le plus possible
les exécutions qui peuvent être coûteuses en temps et en ressources.

Notons que certains outils proposent également la générations de méta données
utilise pour la certification ou qualification de logiciels. Certains peuvent
engendrer des matrices de tracabilités et des rapports préformatés pour les
processus idoines.

Étant donné qu'il existe pléthore de cadres logiciels pour uniquement écrire
des tests et que la plus-value de ces cadres dans le processus d'édition
de logiciel critique est limitée, nous nous concentrerons essentiellement sur
les outils qui offrent un minimum de génération et de gestion de tests qui
offrent le plus de valeur ajoutée pour les logiciels critiques.

Par ailleurs, il faut aussi distinguer quels type de test l'outil peut gérer.
Dans la suite de ce document, nous distinguerons le type de test avec une
lettre majuscule qui servira à l'identifier dans les tableaux :

#figure(
  table(
    columns: (auto, auto, auto),
    [*Type*], [*Description*], [*Identifiant*],
    [*Unitaire*], [
      Teste une unité de code (fonction, module, classe, ...)
    ], [U],
    [*Fonctionnel*], [
      Teste une fonctionnalité du programme
      ], [F],
    [*Intégration*], [
      Teste l'intégration de plusieurs unités de code
    ], [I],
    [*Non régression*], [
      Teste que les modifications n'ont pas introduit de régression
    ], [N],
    [*Robustesse*], [
      Teste une unité de code ou une fonctionnalité avec des valeurs aux
      limites, voir hors limites
    ], [R],
    [*Couverture*], [
      Teste la couverture du code par les tests
    ], [C],
  )
)

Les critères d'analyse seront la capacité de
- générer des tests automatiquement
- de gérer efficacement les tests (factorisation, parallélisation,
  rapports, ...)
- faire du _mocking_, c'est-à-dire de la simulation de dépendances.

= C

Le langage C est un langage de programmation créé en 1972 par Dennis
Ritchie pour le développement du système d'exploitation Unix. Il est
un des langages les plus utilisés dans le monde de l'informatique et
est souvent utilisé pour écrire des systèmes d'exploitation, des
compilateurs, des interpréteurs et des logiciels embarqués.

Le langage a été normalisé par l'ANSI#footnote[_American National
Standard Insitute_, le service de standardisation des États-Unis.] en
1989 #cite(<c89>) puis par l'ISO#footnote[_International Organization for
Standardization_, l'organisation internationale de standardisation.] en
1990 #cite(<c90>). Le standard a été à plusieurs reprises jusqu'à la dernière
version en 2018 #cite(<c18>).

Il existe par ailleurs plusieurs référentiels de
programmation pour garantir une certaine qualité de code. Le plus connu est le
référentiel MISRA-C #cite(<misra>) qui est utilisé dans l'industrie pour
aider à fiabiliser les logiciels embarqués.

== Paradigme

Le langage C est un langage de programmation essentiellement
#paradigme[impératif]. Il est possible, dans une certaine mesure, de programmer
dans un style #paradigme[fonctionnel]. Par exemple, l'exemple du
#ref(<ex_C_length>) peut aussi s'écrire de manière récursive :

```c
int length(struct list *l)
{
  return (NULL == l) ? 0 : 1 + length(l->next);
}
```

mais cela reste limité par rapport aux langages explicitement fonctionnels.
Le style idiomatique est plutôt procédural à la manière de l'exemple
#ref(<ex_C>).

#figure(
  ```c
  int add_value(struct state *s, int v)
  {
    int code = KO;
    if (NULL != s) {
      s->value += v;
      code = OK;
    }
    return code;
  }
  ```,
  caption: [Exemple de code C idiomatique],
) <ex_C>

Dans cet exemple, on déclare une fonction `add_value` qui prend en paramètre
un pointeur vers une structure `struct state` et un entier `v`. Si le pointeur
n'est pas `NULL`, on ajoute la valeur `v` à la valeur de la structure et on
retourne `OK`. Sinon, on retourne `KO`.

Le code est clairement impératif avec la séquence d'instructions, le `if` et
les effets de bord `s->value += v` et `code = OK`.

Sauf pour les fonctions simples et totales comme avec `length`, le code de
retour est généralement utilisé comme un code indiquant si l'appel
a été fructeux ou s'il y a eu une erreur. En pratique, cela donne des appels
en séquence avec un style dit
_défensif_ comme dans le #ref(<defensif_C>).

#figure(
  ```c
  int add_values(struct state *s) {
    int code = KO;
    if (KO == add_value(s, 42)) {
      /* traitement d'erreur 1 ...*/
    }
    if (KO == add_value(s, 24)) {
      /* traitement d'erreur 2 ...*/
    }
    code = OK;
    return code;
  }
  ```,
  caption: [Exemple de code C défensif],
) <defensif_C>


== Modélisation & vérification

=== Analyse statique

==== _Runtime Errors_

Nous avons comparés plusieurs analyseurs statiques permettant de
détecter des erreurs au _runtime_ pour le langage C. Parmi ceux-ci, nous
en avons les cinq qui ont la propriété d'être _corrects_ et de ne pas donner
de faux positifs : _Astree_, _ECLAIR_, _Frama-C_, _Polyspace_ et _TIS Analyser_.

Comme indiqué dans la méthodologie, nous avons indiqué les erreurs détectées
d'après les documents publiques. Toutefois, ceux-ci ne sont pas forcément
complets et il est possible que les outils détectent d'autres erreurs non
mentionnées ici. Les cases cochées indiquent que l'outil détecte _au moins_
le type d'erreur correspondant.

#figure(

  table(
    columns: (auto, auto, auto, auto, auto, auto),
    [*Erreur*],                      [*Astrée*], [*ECLAIR*], [*Frama-C*], [*Polyspace*], [*TIS Analyser*],
    [*Division par 0*],              [✓],        [✓],         [✓],          [✓],            [✓],
    [*Débordement de tampon*],       [✓],        [✓],         [✓],          [✓],            [✓],
    [*Déréférencement de NULL*],     [✓],        [✓],         [],           [✓],            [],
    [*Dangling pointer*],            [✓],        [✓],         [✓],          [],             [✓],
    [*Data race*],                   [✓],        [✓],         [],           [],              [],
    [*Interblocage*],                [✓],        [✓],         [✓],          [],             [],
    [*Vulnérabilités de sécurité*],  [✓],        [✓],         [],           [],              [],
    [*Arithmétique entière*],        [✓],        [],          [✓],          [],              [✓],
    [*Arithmétique flottante*],      [✓],        [],          [✓],          [],              [],
    [*Code mort*],                   [✓],        [✓],         [✓],          [✓],            [],
    [*Initialisation*],              [✓],        [✓],         [✓],          [✓],            [✓],
    [*Flot de données*],             [✓],        [✓],         [✓],          [],              [],
    [*Contrôle de flôt*],            [✓],        [],          [✓],          [✓],             [],
    [*Flôt de signaux*],             [✓],        [],          [],           [],              [],
    [*Non-interférence*],            [✓],        [],          [],           [],              [],
    [*Fuites mémoire*],              [],         [✓],         [],           [],              [],
    [*Double `free`*],               [],         [✓],         [],           [],              [],
    [*Coercions avec perte*],        [],         [✓],         [✓],          [],              [✓],
    [*Mémoire superflue*],           [],         [✓],         [],           [],              [],
    [*Arguments variadiques*],       [],         [✓],         [✓],          [],              [],
    [*Chaînes de caractères*],       [],         [✓],         [],           [],              [],
    [*Contrôle d'API*],              [],         [✓],         [],           [✓],             [],
  )
)


==== WCET

La complexité du calcul statique du WCET fait qu'il y a peu d'outil
disponibles. Nous en avons comparés six: #chronos, #bound-T,
#aiT, #sweet, #otawa et #rapidtime. #chronos, #sweet et #otawa sont des outils
académiques tandis que #aiT et #rapidtime sont des outils commerciaux.
#bound-T est à la base un outil commercial mais qui n'est plus maintenu et qui
a été rendu _open source_.

#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    [*Outil*],     [*WCET statique*], [*WCET dynamique*], [*WCET hybride*], [*Architecture cible*],
    [*Chronos*],   [✓],               [✓],               [],               [
    ],
    [*Bound-T*],   [✓],               [],                [],               text(size: 8pt)[
      - Analog Devices ADSP21020
      - ARMv7 TDMI
      - Atmel AVR (8-bit)
      - Intel 8051 (MCS-51) series
      - Renesas H8/300
      - SPARC v7 / ERC32
    ],
    [*aiT*],       [✓],               [],                [],               text(size: 8pt)[
      - Am486, IntelDX4
      - ARM
      - C16x/ST10
      - C28x
      - C33
      - ERC32
      - HCS12
      - i386DX
      - LEON2, LEON3
      - M68020, ColdFire MCF5307
      - PowerPC
      - TriCore
      - V850E
    ],
    [*SWEET*],     [✓],               [],                [],               [
    ],
    [*Otawa*],     [✓],               [],                [],               text(size: 8pt)[
      - ARM v5,
      - ARM v7,
      - PowerPC (including VLE mode),
      - Sparc,
      - TriCore,
      - Risc-V
    ],
    [*RapidTime*], [],                [],                 [✓],              text(size: 8pt)[
      - ARM (7, 9, 11, Cortex-A, Cortex-R, Cortex-M)
      - Analog Devices
      - Atmel
      - Cobham Gaisler
      - ESA
      - Freescale (NXP)
      - IBM
      - Infineon
      - Texas Instruments
    ],
  )
)

Notons que #chronos et #sweet ne ciblent pas d'architecture particulière mais
se basent sur une
représentation intermédiaire, respectivement un sur-ensemble MIPS et
ALF, pour
effectuer leur analyse. L'avantage est
qu'il est techniquement possible de cibler n'importe quelle architecture dès
lors qu'il y a un traducteur du langage source vers la représentation
intermédiaire. Comme celle-ci ne tient pas compte de toutes les spécificités de
l'architecture ciblée, le WCET calculé est _a priori_ moins précis.

#otawa fonctionne avec des fichiers décrivant l'architecture cible; ce qui
le rend a priori compatible avec toutes les architectures modulo le temps
d'écrire ces descriptions si elles n'existent pas déjà. Les architectures
indiquées sont celles dont les descriptions sont déjà disponibles.


==== Pile

Il existe plusieurs outils pour analyser statiquement la pile utilisée par un
programme. Parmi ceux-ci, nous avons comparé #gcc, #stackanalyser, #t1stack et
#armlink.

#gcc propose une option `-fstack-usage` qui permet de générer un fichier
décrivant l'utilisation de la pile par le programme. Le fichier généré contient
la taille de pile utilisée par fonction et peut
être analysé par un outil tiers pour en extraire des informations sur la
taille maximale de la pile utilisée.

#stackanalyser est un outil commercial développé par #absint qui semble offrir
une vue plus précise (et graphique) de l'utilisation de la pile par le
programme et propose des rapports orienté vers la qualification logicielle.
L'outil supporte une gamme précise de couple compilateur-architecture qui,
pour des raisons de lisibilité, n'est pas indiquée explicitement ici mais
un lien vers page idoine de l'outil est donné. Les architectures communes
(Intel, ARM, PowerPC, RISC-V, ...) sont supportées.


#t1stack est un outil commercial développé par #gliwa qui propose une analyse
statique de la pile pour des architectures spécifiques. L'outil peut utiliser
des annotations pour résoudre les appels utilisant des pointeurs de fonctions
à l'exécution. Ces annotations peuvent être manuelles ou générées
automatiquement par des mesures dynamiques.

Le _linker_ #armlink d'ARM propose une option `--callgraph` qui engendre un
ficher HTML contenant l'arbre d'appels du programme et l'utilisation de la
pile. Comme pour #t1stack, il est possible d'ajouter une analyse dynamique
pour obtenir des informations plus précises en cas d'utilisation de pointeurs
de fonction.

#figure(
  table(
    columns: (auto, auto, auto),
    [*Outil*],         [*Annotations*],   [*Architectures*],
    [*#gcc*], [], [Toutes celles supportées par GCC],
    [*#stackanalyser*], [], [
      Liste exhaustive sur le site de l'outil :
      https://www.absint.com/stackanalyzer/targets.htm
    ],
    [*#t1stack*], [✓], [
      - Infineon TC1.6.X, TC1.8
      - NXP/STM e200z0-z4, z6, z7
      - ARM (v7-M, v7-R, V8-R)
      - Renesas RH850, G3K/G3KH/G3M/G3MH
      - Intel x86-64
    ],
    [*#armlink*], [], [ARM],
  )
)


==== Qualité numérique

La qualité numérique peut être analysée de deux manières: statiquement et
dynamiquement. Les outils #fluctuat, #astree et #polyspace font partie
des outils d'analyse statique. #polyspace détecte essentiellement des
erreurs à _runtime_ comme la division par 0, les dépassements de capacité et
les débordements de buffer. #astree détecte également les erreurs de
runtime mais réaliste également un calcul d'intervalles permettant d'évaluer
les erreurs d'arrondis. #fluctuat est un outil académique qui est spécifiquement
dédié à l'analyse numérique flottante par interprétation abstraite en utilisant
un domaine basé sur l'arithmétique affine.

L'outil #gappa fonctionne également
par analyse statique mais en utilisant un programme annoté (via #framac) par
les propriétés à vérifier sur les calculs flottants.

Les analyses dynamiques fonctionnent en instrumentant le code avec des
bibliothèques logicielles dédiées. Parmi celles-ci, on trouve #cadna qui
utilise une approche par estimation stochastique des arrondis de calculs.

Une autre approche consiste à utiliser directement des bibliothèques proposant
des calculs flottants plus précis comme la bibliothèque #mpfr qui réalise un
calcul par intervalles.


=== Meta formalisation

Les outils permettant de formaliser un programme C sont peu nombreux et
fonctionnent tous sur le même principe d'annotations du code source avec
une contractualisation utilisant une logique de séparation. Parmi ceux-ci,
nous avons comparé #framac, #redefinedc et #vercors.

La différence entre ces outils réside principalement dans la syntaxe des
annotations et la manière dont les spécifications sont vérifiées. #framac
utilise une syntaxe E-ACSL qui est un sous-ensemble du langage
_ANSI/ISO C Specificiation Language_ (ACSL). Les spécifications et un modèle
sémantique du C sont ensuite traduites en un problème SMT#footnote[
  _Satisfiability Modulo Theories_
] soumis à plusieurs solveurs (#z3, #cvc5, #altergo) qui déterminent, ou pas, si
les contraintes sont satisfaites. Dans certains
cas, il est également possible de générer des contre-exemples. En cas d'échec
dans la preuve, il est possible de raffiner la spécification pour découper
les preuves en sous-problèmes plus simples.

#redefinedc utilise un langage de spécification déclaratif qui a peu ou prou
la même expressité que E-ACSL. En revanche, la vérification du programme se fait
de manière déductive en utilisant Coq et un modèle sémantique du C écrit en Coq
avec le cadre théorique #iris. L'expressivité du modèle permet d'exprimer des
problématiques arbitrairement complexes (comme par exemple l'_ownership_) tant
que cela reste prouvable. En cas d'échec de la preuve, il est possible
d'écrire directement les preuves en Coq.

#vercors utilise un langage de spécification nommé PVL#footnote[
  _Prototypal Verification Language_
] qui ressemble un peu à celui de #framac. L'outil est en fait basé sur
un autre cadre logiciel appelé #viper qui permet de vérifier des programmes
en utilisant la logique de séparation mais également la logique de
permission, ce qui permet d'exprimer des propriétés d'_ownership_. #viper
utilise le solveur SMT #z3 pour décharger les preuves.


=== Mécanismes intrinsèques de protection

Le C est dispose de très peu de mécanismes de protection. Il existe un système
de type mais qui est très rudimentaire et ne permet pas de garantir la
sécurité mémoire. Les pointeurs peuvent être manipulés de manière très libre
et il est possible de déréférencer un pointeur n'importe où dans la mémoire.

Les mécanismes de protection disponibles pour le C viennent essentiellement des
compilateurs qui ajoutent, ou pas, des analyses complémentaires. La plupart du
temps, il est
recommandé d'activer tous les avertissements du compilateur et de les traiter
comme des erreurs pour assurer un maximum de vérifications.

=== Tests

Nous avons comparés plusieurs outils de tests pour le langage C. Parmi ceux-ci,
se dégagent #cantata, #parasoft, #TPT et #vectorcast qui offent un support de
test étendu pour le C. Ils fournissent également de la génération de test à des
degré divers et une bonne gestion des tests à travers diverses configurations
et la génération de rapports nécessaires aux qualifications/certifications.

#criterion, #libcester, #novaprova et #opmock tiennent plus des usuels cadres
logiciels de tests et offrent une génération de test plus limitée. Cependant,
ils offrent du _mocking_ ou un support pour des interfacages avec des outils
tiers qui peuvent être utiles dans les cas d'intégrations avec des outils tiers.

#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    [*Outil*],               [*Tests*], [*Generation*], [*Gestion*], [_*mocking*_],
    [*#cantata*],            [UFIRC],   [+++],          [✓],         [],
    [*#criterion*],          [UF],      [+],            [],          [],
    [*#libcester*],          [UF],      [+],            [✓],         [✓],
    [*#novaprova*],          [UF],      [+],            [✓],         [✓],
    [*#opmock*],             [UF],      [++],           [],           [✓],
    [*#parasoft*],           [UFC],    [++],            [✓],         [],
    [*#TPT*],                [UFINC],  [+++],           [✓],         [],
    [*#vectorcast*],         [UFC],    [++],            [✓],         [✓],
  )
)

== Compilateurs & outils

=== Compilation

#let llvm = link("https://llvm.org/", "LLVM")
#let microsoft = link("https://www.microsoft.com", "Microsoft")
#let inria = link("https://www.inria.fr", "INRIA")

Il existe beaucoup de compilateurs pour le langage C pour des raisons
à la fois historiques et de compatibilité. Historique car
le langage C est né a une époque où l'_open source_ n'existait pas vraiment et
les seules organisations capables de produire des compilateurs étaient des
entreprises ou des grands laboratoires. Ces entreprises développaient souvent
leur propre compilateur adapté à leur architecture ou au système qu'ils
proposaient par ailleurs, d'où la compatibilité.

Nous ne citerons donc que les principaux compilateurs modernes qui sont les
plus utilisés ou qui ont une caractéristique particulière qui peut les
distinguer dans le contexte de l'embarqué critique.

#figure(
  table(
    columns: (auto, auto, auto),
    [*Compilateur*], [*Architectures*], [*Licence*],
    [*#aocc*], [AMD x86 (32 et 64 bits)], [Gratuit],
    [*#clang*], [AArch64, ARMv7, IA-32, x86-64,  ppc64le], [Apache 2.0],
    [*#compcert*], [x86, x86_64, ARM, PowerPC, SPARC], [Gratuit pour un usage non commercial],
    [*#gcc*], [IA-32, x86_64, ARM, PowerPC, SPARC, ...], [GPLv3+],
    [*#icx (#intel C/C++ Compiler)*], [IA32, x86-64], [Propriétaire, Gratuit],
    [*#msvc*], [IA-32, x86_64, ARM], [Propriétaire],
  )
)

Notons que le compilateur #aocc est basé sur #clang/#llvm mais y ajoute
des optimisations spécifiques aux processeurs AMD. #clang est la partie frontale
de #llvm et les deux forment un compilateur modulaire inité par #apple pour
remplacer #gcc dans les années 2000. Aujourd'hui, ces deux compilateurs offrent
des performances équivalentes.

#gcc est le compilateur de référence pour le langage C depuis les années 1990.
Il est très complet et supporte un grand nombre d'architecture dont seulement
une petite partie est indiquée dans le tableau, une liste plus exhaustive
peut être consultée sur la page https://gcc.gnu.org/install/specific.html.

#icx est le compilateur d'#intel spécifique à aux processeurs et FPGA de la
marque. Depuis 2021, il utilise le _backend_ #llvm. Enfin, #msvc est le
compilateur de #microsoft pour les systèmes Windows.

Le compilateur #compcert est un peu à part car il s'agit d'un compilateur
écrit en grande partie en #coq par l'#inria et qui est formellement prouvé
comme étant correct par rapport à la sémantique du langage C. Il offre des
performances équivalentes à #gcc avec un niveau d'optimisation léger (-O1).
L'utilisation commerciale est pourvue par la société #absint. L'absence
d'optimisations aggressives que l'on peut trouver dans #gcc ou #clang est due
au fait qu'il est difficile de démontrer que ces optimisations sont correctes
d'un point de vue sémantique. Le projet se concentre sur les optimisations
vérifiées afin de produire un code conforme à la spécification du langage C
propre à une utilisation dans les domaines critiques.


=== Déboggeur

Comme pour les compilateurs, il existe une multitude de déboggueurs en fonction
des systèmes d'exploitation et des architectures. Pour simplifier la lecture
de ce document, nous le listons ici que les principaux déboggueurs connus.

#let linaro = link("https://www.linaroforge.com/linaro-ddt", "Linaro DDT")
#let gdb = link("https://www.gnu.org/software/gdb/", "GDB")
#let lldb = link("https://lldb.llvm.org/", "LLDB")
#let totalview = link("https://totalview.io/", "TotalView")
#let undo = link("https://undo.io/", "Undo")
#let valgrind = link("https://www.valgrind.org/", "Valgrind")
#let vsd = link("https://www.visualstudio.com/", "Visual Studio Debugger")

#figure(
  table(
    columns: (auto, auto, auto),
    [*Debugueur*], [*Architectures*], [*License*],
    [*#linaro*], [x86-64, ARM, PowerPC, Intel Xeon Phi, CUDA], [Propriétaire],
    [*#gdb*], [x86, x86-64, ARM, PowerPC, SPARC, ...], [GPLv3],
    [*#lldb*], [i386, x86-65, AArch64, ARM], [Apache v2],
    [*#totalview*], [x86-64, ARM64, CUDA], [Propriétaire],
    [*#undo*], [?], [Propriétaire],
    [*#valgrind*], [x86, x86-64, PowerPC, ARMv7], [GPL],
    [*#vsd*], [x86, x86-64], [Propriétaire],
  )
)

#linaro et #totalview sont plutôt dédiés aux systèmes de calculs intensifs
qu'aux systèmes embarqués mais ils supportent les architectures CUDA qui
peuvent être utilisés dans l'embarqués pour du traitement vidéo.

#let ddd = link("https://www.gnu.org/software/ddd/", "DDD")

#gdb est le déboggeur de référence pour le langage C car il va en général de
pair avec l'utilisation de #gcc. Il dispose des fonctionnalités classiques pour
un déboggueur (breakpoints, pas à pas, ...). La version de base ne comporte
qu'un outil en ligne de commande mais des interfaces graphiques existent pour
le compléter, le plus connu étant probablement #ddd.

#lldb est le déboggeur associé à #clang/#llvm comme #gdb l'est à #gcc. Etant
plus jeune, il supporte moins d'architecture mais plus de système
d'exploitation (notamment MacOS et iOS).


#valgrind est un outil d'analyse dynamique qui permet de détecter des erreurs
liées à l'utilisation de la mémoire. Il est particulièrement utile pour détecter
les fuites mémoires sur les langages comme le C. Il fonctionne en compilant le
_bytecode_ à la volée en y ajoutant de l'instrumentation.

#undo est un deboggeur récent compatible avec les commandes de #gdb et proposant
une interface graphique plus moderne que #ddd. Il propose aussi une interface
de navigation dans les historiques d'exécution en séquentiel ou parallèle en
plus d'un déboggue mémoire. En revance, il n'est disponible que sous Linux
et les architectures supportées ne sont pas clairement indiquées. Il est
probable que l'outil fonctionne par compilation à la volée du _bytecode_ et
qu'il soit donc compatible avec toutes les architectures supportées par #gcc.

#let visualstudio = link(
  "https://visualstudio.microsoft.com/fr/vs/",
  "Visual Studio"
)

#vsd est le développeur associé à la suitre de développement #visualstudio
de #microsoft. Il est propriétaire et ne fonctionne que sous Windows mais
offre un support avancé de tous les langages supportés par #visualstudio.

=== Meta programmation

Il n'y a pas, a proprement parler, de support pour la métaprogrammation en C.
Dans la pratique cependant, le preprocesseur du C
(CPP#footnote[C PreProcessor]) est souvent utilisé pour introduire une forme
archaïque de métaprogrammation syntaxique.

CPP utilise un système de macros et d'expansions permettant de générer du code
C par substitution de texte. Un exemple courant est l'utilisation de macros
pour rendre des parties de code conditionnelles :

```c
#include <stdio.h>

#ifdef DEBUG
# define TRACE(...) printf(__VA_ARGS__)
#else
# define TRACE(...)
#endif

int main()
{
  TRACE("Hello, world!\n");
  return 0;
}
```

Dans cet exemple, la macro `TRACE` est définie en fonction de la macro `DEBUG`.
Si `DEBUG` est définie, la macro `TRACE` est expansée en un appel à `printf`
avec les arguments passés. Dans ce cas, la fonction `main` affichera
`Hello, world!`. Si `DEBUG` n'est pas défini, la macro `TRACE` est expansée
en un contenu vide et la fonction `main` n'affichera rien.

L'expansion des macros n'est pas récursive et ne permet donc pas de calculer des
des valeurs arbitrairement complexes. Il est toutefois possible de jouer
subtilement avec l'expansion des macros pour obtenir une récursion bornée
et prégénérer des expressions constantes que le compilateur optimisera en
les calculant à la compilation.

Par exemple, on peut calculer la somme des entiers de 1 à N avec la macro
suivante :

```c
#include <stdio.h>

#define SUM(N) (((N) * ((N) + 1)) / 2)

int main()
{
  printf("%d\n", SUM(10));
  return 0;
}
```

Comme elle sera expansée dans le code, le compilateur y vera une expression
constante et la calculera à la compilation, ce qui donnera le résultat 55
immédiatement à l'exécution. Il est même possible d'obtenir une récursion
finie en exploitant de manière astucieuse les règles d'expansion des macros
mais cela reste une pratique très avancée, peu lisible, peu maintenable et
surtout généralement inutile puisque les fonction déclarées `inline` (et
même parfois celles qui ne le sont pas) sont optimisées de manière similaire
par le compilateur. Ainsi, le resultat constant précédent pourrait être obtenu
plus simplement avec une fonction `inline` :

```c
#include <stdio.h>

inline int sum(int n)
{
  return (n * (n + 1)) / 2;
}

int main()
{
  printf("%d\n", sum(10));
  return 0;
}
```

=== Générateurs de code

==== _Parsing_

On peut distinguer les parseurs en fonction du type de langage considéré et
du type de parseur:
- les langages réguliers
- les langages algébriques
- les PEG#footnote[
  _Parsing Expression Grammars_, ou grammaire d'expression de _parsing_.
]
- de langages réguliers des parseurs de
langage context

==== Dérivation



== Bibliothèques & COTS

=== Gestionnaire de paquets

Aucun, OS dépendant.

=== Communauté

=== Assurances

== Adhérence au système

== Interfaçage

== Utilisation dans le critique






= C++

Le C++ est une extension du langage C créée par Bjarne Stroustrup en 1979. Il
ajoute au C les concepts de la programmation orientée objet et la
généricité (les _templates_). Pleinement compatible avec le C, le C++ peut
s'utiliser dans les mêmes contextes que le C mais il est plus souvent utilisé
pour écrire des applications complexes nécessitant une certaine abstraction.

Il est standardisé pour la première fois en 1998 #cite(<cpp98>) puis
régulièrement mis-à-jour jusqu'à la dernière version en 2020 #cite(<cpp20>).
Comme pour le C, il existe des référentiels de programmation pour garantir
une certaine qualité de code. Le plus connu est le
référentiel MISRA-C++ #cite(<misra_cpp>).


== Paradigme

Le C++ est un langage de programmation #paradigme[objet] et
#paradigme[impératif].

== Modélisation & vérification

=== Analyse statique

==== _Runtime Errors_

- Astree
- ECLAIR
- Polyspace
- TISAnalyser

==== WCET

https://www.tracesgroup.net/otawa/

==== Pile

==== Qualité numérique

- #xsc
- #boost

=== Meta formalisation

=== Mécanismes intrinsèques de protection

=== Tests

== Compilateurs & outils

=== Compilation

=== Débuggeur

=== Meta programmation

=== Générateurs de code

==== _Parsing_

==== Dérivation

== Bibliothèques & COTS

=== Gestionnaire de paquets

=== Communauté

=== Assurances

== Adhérence au système

== Interfaçage

== Utilisation dans le critique


= Ada

== Paradigme

== Modélisation & vérification

=== Analyse statique

==== _Runtime Errors_

- CodePeer
- Polyspace (MathWorks)
- SPARK Toolset

==== WCET

==== Pile

==== Qualité numérique

=== Meta formalisation

=== Mécanismes intrinsèques de protection

=== Tests

== Compilateurs & outils

=== Compilation

=== Débuggeur

=== Meta programmation

=== Générateurs de code

==== _Parsing_

==== Dérivation

== Bibliothèques & COTS

=== Gestionnaire de paquets

=== Communauté

=== Assurances

== Adhérence au système

== Interfaçage

== Utilisation dans le critique


= Scade

== Paradigme

== Modélisation & vérification

=== Analyse statique

==== _Runtime Errors_

- KCG

==== WCET

==== Pile

==== Qualité numérique

=== Meta formalisation

=== Mécanismes intrinsèques de protection

=== Tests

== Compilateurs & outils

=== Compilation

=== Débuggeur

=== Meta programmation

=== Générateurs de code

==== _Parsing_

==== Dérivation

== Bibliothèques & COTS

=== Gestionnaire de paquets

=== Communauté

=== Assurances

== Adhérence au système

== Interfaçage

== Utilisation dans le critique


= OCaml

== Paradigme

OCaml est un langage de programmation multiparadigme. Il est conçu comme étant
avant tout un langage #paradigme[fonctionnel] mais il est dit _impur_ dans le
sens où la mutabilité est autorisée. L'intégration des boucles (`while`, `for`)
en font tout aussi bien un langage #paradigme[impératif] dans lequel on peut
très bien programmer de manière
procédurale. Le O de OCaml signifie _Objective_ et fait référence au
fait que le langage est également #paradigme[objet]. Ce trait est toutefois
relativement peu usité en pratique.




== Modélisation & vérification

=== Analyse statique

==== _Runtime Errors_

Initiative gospell ?

==== WCET

Néant.

==== Pile

==== Qualité numérique

=== Meta formalisation

=== Mécanismes intrinsèques de protection

=== Tests

== Compilateurs & outils

=== Compilation

=== Débuggeur

=== Meta programmation

=== Générateurs de code

==== _Parsing_

==== Dérivation

== Bibliothèques & COTS

=== Gestionnaire de paquets

=== Communauté

=== Assurances

== Adhérence au système

== Interfaçage

== Utilisation dans le critique


= Rust

== Paradigme

== Modélisation & vérification

=== Analyse statique

==== _Runtime Errors_

==== WCET

==== Pile

==== Qualité numérique

=== Meta formalisation

=== Mécanismes intrinsèques de protection

=== Tests

== Compilateurs & outils

=== Compilation

=== Débuggeur

=== Meta programmation

=== Générateurs de code

==== _Parsing_

==== Dérivation

== Bibliothèques & COTS

=== Gestionnaire de paquets

=== Communauté

=== Assurances

== Adhérence au système

== Interfaçage

== Utilisation dans le critique

= Conclusions

= Références

#bibliography("bibliography.yml")

