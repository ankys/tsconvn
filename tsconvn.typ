
#let title = "二スケール収束とその周辺"
#let author = "中安淳"
#let date = datetime.today().display("[year]年[month]月[day]日")

#import "@preview/rubber-article:0.1.0": *
#show: article.with(lang: "ja")
// #set text(font: ("YuMincho", "Zen Old Mincho", "Zen Kaku Gothic New"))

#import "@preview/physica:0.9.3": dv, dd
#import "@preview/ctheorems:1.1.3": thmrules, thmplain, thmbox, thmproof

#show: thmrules.with()
#let theorem = thmbox("theorem", "定理", stroke: black)
#let proposition = thmbox("theorem", "命題", stroke: black)
#let definition = thmbox("theorem", "定義", stroke: black)
#let example = thmplain("theorem", "例");
#let xca = thmplain("theorem", "練習問題")
#let remark = thmplain("theorem", "注意")
// #let proof = thmproof("proof", "証明")
#let proof = (..args, body) => {
	let name = "証明"
	if args != none and args.pos().len() > 0 {
		name = args.pos().first()
	}
	return [
		【#name】#body #h(1fr)【証明終わり】
	]
}

#import "deps/autoeqnum.typ": autoeqnum

#show heading.where(level: 2): set heading(level: 1)
#show heading.where(level: 2): it => {
	counter(math.equation).update(0)
	it
}
#show: autoeqnum.with(numbering: it => {
	let count = counter(heading.where(level: 1)).get().first()
	numbering("(1.1)", count, it)
})

#let div = $op("div")$

#maketitle(
	title: title,
	authors: (author,),
	date: date,
)

== はじめに

このノートではある偏微分方程式の均質化を正当化するために二スケール収束と呼ばれる関数列の収束の概念とその性質を支える基本的定理に焦点を当てて解説する。
ここで二スケールとは二つのスケール(two-scale)ということで、巨視的なスケールと微視的なスケールのことを意味する。

均質化は微視的なスケールにおいて周期的になっている構造物が巨視的なスケールにおいてどのような性質を持つかという話題である。
巨視的なスケールに対して微視的なスケールの細かさを$epsilon > 0$として、$1$次元熱方程式の定常問題
$
cases(
	-dv(, x)(a_epsilon (x)dv(u_epsilon, x)(x)) = f(x) "in" (0, L)"," ,
	u_epsilon (0) = u_epsilon (L) = 0,
)
$
を例にとって説明しよう。
ここで熱伝導係数$a_epsilon (x)$は位置$x$に依存する周期$epsilon$の関数で$inf_(x, epsilon) a_epsilon (x) = : alpha > 0$とする。
均質化の数学的な定式化は方程式の係数$a_epsilon (x)$が
$
a_epsilon (x) = a(x / epsilon)
$
となる、より正確には周期$1$の関数$a$が存在して上のように書けたとするとき、
$epsilon -> 0$での解$u_epsilon$の挙動、つまり$u_epsilon$は収束するか極限方程式は何かというを考えることになる。

この定常問題に対して弱形式による弱解$u_epsilon$が構成できたとすると、$u_epsilon$自身を試験関数に用いることで
$
alpha integral_0^L dv(u_epsilon, x)(x)^2 dd(x)
<= integral_0^L a_epsilon (x)dv(u_epsilon, x)(x)^2 dd(x)
= integral_0^L f(x)u_epsilon (x) dd(x)
<= k integral_0^L u_epsilon (x)^2 dd(x)+1/(4 k) integral_0^L f(x)^2 dd(x)
$
であり($k > 0$)、ポアンカレの不等式より
$
integral_0^L u_epsilon (x)^2 dd(x)+integral_0^L dv(u_epsilon, x)(x)^2 dd(x)
<= C integral_0^L f(x)^2 dd(x)
$
を得る。
ここから部分列を取れば$u_epsilon$は$epsilon -> 0$である関数$u$に$H_0^1 ([0 , L])$ソボレフ空間の中で弱収束することがわかる。

次に問題になるのが極限方程式は何かという問題だが$u_epsilon (x)$の漸近展開
$
u_epsilon (x)
= u_0 (x, x/epsilon)+epsilon u_1 (x, x/epsilon)+epsilon^2 u_2 (x, x/epsilon)+dots.c
$
を考えることが有効である。
今回の方程式で重要なのは
$
u_epsilon (x) tilde.eq u(x)+epsilon v(x/epsilon)
$
の部分である。
この漸近展開にもとづくことで次の均質化の結果が成り立つことが知られている。
すなわち、まずいわゆるセル問題
$
dv(, y)(a(y)(dv(w, y)(y)+1)) = 0
$
に周期$1$の解$w(y)$が存在し、実効熱伝導係数
$
macron(a) = integral_0^1 a(y)(dv(w, y)(y)+1)^2 dd(y)
$
を定義すると、パラメータ付きの解$u_epsilon$は極限方程式
$
cases(
	-dv(, x)(macron(a)dv(u, x)(x)) = f(x) "in" (0, L)"," ,
	u(0) = u(L) = 0,
)
$
の一意解$u$に$H_0^1 ([0 , L])$弱収束する。

さらに今回のような空間$1$次元で$a$が微視的なスケールの変数$y$のみに依存して巨視的なスケールの変数$x$に依存しない場合は実効熱伝導係数$macron(a)$をさらに詳しく計算することができ、調和平均
$
macron(a) = (integral_0^1 a(y)^(-1) dd(y))^(-1)
$
で与えられることも知られている。

この最終的な結論は工学などの応用上非常に重要である。
その一方でセル問題の方法は高次元化などの拡張が知られている。
しかしながら、セル問題の方法をそのまま正当化しようとすると様々な困難を乗り越える必要がある。
そのような中で本ノートの主題である二スケール収束と二スケール均質化方程式系を用いた解析手法は次に述べる非常に簡単な議論を通して均質化を正当化できる。
誤解を恐れずに表現すると、調和平均による均質化の理解は工学的であり、セル問題による理解は物理学的であり、二スケール収束による方法は数学的といえる。

続く

== 二スケール収束の基本定理

$Omega$を$bb(R)^N$の（有界とは限らない）ボレル可測集合として、$f = f(x, y): Omega times bb(R)^N -> bb(R)$を$y$について$bb(Z)^N$-周期的つまり
$
f(x, y+z) = f(x, y) quad forall z in bb(Z)^N
$
を満たすとする。
このような関数を簡単のため平坦トーラス$bb(T)^N := bb(R)^N\/bb(Z)^N$を用いて$f: Omega times bb(T)^N -> bb(R)$と表す。
$square$を$bb(R)^N$の単位立方体、つまり$square = \[0, 1\)^N$とする。

この節の目標は$f$の何らかの仮定の下で次の極限に関する式
$
lim_(epsilon -> 0) integral_Omega f(x, x/epsilon) dd(x)
= lim_(n -> oo) integral_Omega f(x, n x) dd(x)
= integral_Omega lr(angle.l f(x, y) angle.r)_y dd(x)
= integral_Omega 1/abs(square) integral_square f(x, y) dd(y) dd(x)
$ <e_tsconv_p>
を示すことである。
ここで$lr(angle.l f(x, y) angle.r)_y = 1/abs(square) integral_square f(x, y) dd(y)$は$f(x, y)$の$y$変数に関する平均を表す。
$abs(square)$は$square$のルベーグ測度でありその値は$1$であるが、$bb(Z)^N$-周期的とは限らない場合のためにこのように書いている。
また、最左辺の$epsilon$は正の実数を、第2辺の$n$は正の整数を想定しているため、最左辺と最右辺が一致することを示せば十分である。
この@e_tsconv_p のことを本ノートでは_二スケール収束の基本公式_と呼ぶことにする。

この二スケール収束の基本公式は連続関数およびリーマン積分の枠組みだと示しやすい。
例えば簡単のために$Omega$を1次元の有界閉区間$[0 , M]$で$M$は正の整数、$f = f(x, y): [0, M] times bb(T) -> bb(R)$を連続関数として、二スケール収束の基本公式
$
lim_(n -> oo) integral_0^M f(x, n x) dd(x)
= integral_0^M integral_0^1 f(x, y) dd(y) dd(x)
$
を示す。 実際$y = n x$と置換して積分区間を周期に従って分割すると、
$
integral_0^M f(x, n x) dd(x)
= 1/n integral_0^(n M) f(y/n, y) dd(y)
= 1/n sum_(k = 1)^(n M) integral_(k-1)^k f(y/n, y) dd(y)
= integral_0^1 1/n sum_(k = 1)^(n M) f((y+k-1)/n, y) dd(y)
$
となる。 あとは区分求積法の式
$
lim_(n -> oo) 1/n sum_(k = 1)^(n M) f((y+k-1)/n, y)
= integral_0^M f(x, y) dd(x)
$
が実は$y$について一様収束になっていることを示せば、極限と積分の順序交換ができよい。
頑張ればこれも示すことができるので詳細省略。

このようにして連続関数の枠組みでは比較的容易に証明することができるが、偏微分方程式に応用することを考えると関数の入る空間をより拡張する必要がある。
しかしながら、@e_tsconv_p の右辺が$L^1(Omega times bb(T)^N)$なら定義できるからと言って、そのようにすると広げすぎであり、成り立たない反例もある
（@r_a92 のProposition 5.8参照）。
そのためどこまで拡張するかが問題になるが、今後の展開で重要なのが$L^1(Omega; C(bb(T)^N))$という空間である。
これは$x in Omega$ごとに$y$について$bb(Z)^N$-周期的な連続関数が対応し、
$
norm(f)_(L^1(Omega; C(bb(T)^N)))
:= integral_Omega sup_(y in square) abs(f(x, y)) dd(x)
< oo
$ <e_l1c>
を満たす関数$f$のなすボホナー空間である。

#theorem("二スケール収束の基本定理")[
$f in L^1(Omega; C(bb(T)^N))$とすると、$norm(f(x, x/epsilon))_(L^1(Omega)) <= norm(f)_(L^1(Omega; C(bb(T)^N)))$と@e_tsconv_p が成り立つ。
] <t_tsconv_p>

証明の前に$L^1(Omega; C(bb(T)^N))$の関数の特徴づけを思い出す。

#proposition[
関数$f$が$L^1(Omega; C(bb(T)^N))$に属することは、$Omega$のある測度零部分集合$E$が存在して以下の条件が成り立つことと同値である。
- 任意の$x in Omega\\E$に対して$y |-> f(x, y)$は連続で$bb(Z)^N$-周期的である。
- 任意の$y in square$に対して$x |-> f(x, y)$は可測である。
- @e_l1c が成り立つ。
]

この命題の証明は省略する。

#proof([@t_tsconv_p の証明])[
前半部分は簡単にわかるので、後半の式を示す。
まず、$f(x, y)$が変数分離された$f(x, y) = phi(x) g (y)$の場合を考える。
この時示すべき式は
$
lim_(epsilon -> 0) integral_Omega phi(x)g(x/epsilon) dd(x)
= integral_Omega phi(x)lr(angle.l g angle.r) dd(x)
$ <e_tsconv_p_sep>
とでき、$bb(Z)^N$-周期的な関数$g$に対して$L^oo (bb(R)^N)$関数の列$g(x/epsilon)$が$epsilon -> 0$で平均$lr(angle.l g angle.r)$に汎弱収束することを意味する。
この式も近似することを考えると$phi$,
$g$を区間の直積の指示関数の場合に示せばよく、次の1次元の場合に帰着される。
つまり、$L^oo (bb(T))$関数$g$と実数$a < b$に対して、
$
lim_(epsilon -> 0) integral_a^b g(x/epsilon) dd(x)
= (b-a) integral_0^1 g(y) dd(y).
$ <e_tsconv_p_sep1>
これは
$
integral_a^b g(x/epsilon) dd(x)
= epsilon integral_(a/epsilon)^(b/epsilon) g(y) dd(y)
$
と置換したうえで、区間$[a/epsilon, b/epsilon]$の間に長さ$1$の区間がいくつ取れるかを考えて、
$
integral_a^b g(x/epsilon) dd(x)
= epsilon (floor(b/epsilon)-floor(a/epsilon)) integral_0^1 g(y) dd(y)+epsilon integral_(floor(b/epsilon))^(b/epsilon) g(y) dd(y)+epsilon integral_(a/epsilon)^(floor(a/epsilon)) g(y) dd(y)
$
ここで一般に$x-1 <= floor(x) <= x$であることから、@e_tsconv_p_sep1 がわかる。
以上より変数分離された場合@e_tsconv_p_sep は示された。

一般の$f (x , y)$に対しては$y$変数の入る集合$square$の分割と代表点$Delta_n = (square_i, y_i)$を取って
$
f_n (x, y) = sum_i f(x, y_i)chi_(square_i)(y)
$
を定めると、$x |-> f(x, y_i)$は$L^1(Omega)$なので$f_n$は変数分離された関数の有限和より@e_tsconv_p が成り立つ。
ここで、
$
&abs(integral_Omega f(x, x/epsilon) dd(x)-integral_Omega lr(angle.l f(x, y) angle.r)_y dd(x)) \
&quad <= integral_Omega abs(f(x, x/epsilon)-f_n (x, x/epsilon)) dd(x)+integral_Omega abs(f_n (x, x/epsilon)-lr(angle.l f_n (x, y) angle.r)_y) dd(x)+integral_Omega abs(lr(angle.l f_n (x, y) angle.r)_y-lr(angle.l f (x, y) angle.r)_y) dd(x) \
&quad <= 2 norm(f_n-f)_(L^1(Omega; C(bb(T)^N)))+integral_Omega abs(f_n (x, x/epsilon)-lr(angle.l f_n (x, y) angle.r)_y) dd(x)
$
なので、$f_n$が$f$に$L^1(Omega; C(bb(T)^N))$で強収束を示せばよい。
ここで$g_n (x) = sup_(y in square) abs(f_n (x, y)-f(x, y))$とおくと、$x in Omega\\E$に対して$y |-> f(x, y)$は連続で一様連続でもあるので、分割を細かくするほど$g_n (x) -> 0$となる。
すなわちほとんどすべての点で$g_n -> 0$である。
また、$x in Omega\\E$ごとに
$
g_n (x)
<= sup_(y in square) abs(f_n (x, y))+sup_(y in square) abs(f(x, y))
<= 2 sup_(y in square) abs(f(x, y))
$
であり最右辺は$L^1(Omega)$に属する関数である。
よって、ルベーグの優収束定理が使えて、$norm(f_n-f)_(L^1(Omega; C(bb(T)^N))) -> 0$なので、@e_tsconv_p が示された。
]

証明の途中で示した変数分離での二スケール収束の基本公式は関数の仮定が異なるからその部分を以下に述べる。

#theorem([二スケール収束の基本定理（変数分離）])[
$f(x, y) = phi(x)g(y)$, $phi in L^1(Omega)$, $g in L^oo (bb(T)^N)$とすると、
@e_tsconv_p が成り立つ。
] <t_tsconv_p_sep>

== 二スケール収束とその性質

$Omega$を$bb(R)^N$の（有界とは限らない）ボレル可測集合とする。

#definition([二スケール収束])[
$L^2(Omega)$の関数列$u_epsilon (x)$を考える。

ここである$L^2(Omega times bb(T)^N)$関数$u$が存在して、
$
integral_Omega u_epsilon(x)phi(x, x/epsilon) dd(x)
-> integral_Omega lr(angle.l u(x, y)phi(x, y) angle.r)_y dd(x)
quad forall phi in L^2(Omega; C(bb(T)^N))
$
が成り立つとき、$u_epsilon (x)$は_二スケール弱収束_するといい、その時の$u(x, y)$を_二スケール極限_という。

上の条件に加えて
$
integral_Omega u_epsilon(x)^2 dd(x)
-> integral_Omega lr(angle.l u(x, y)^2 angle.r)_y dd(x)
$
が成立するとき、$u_epsilon (x)$は_二スケール強収束_するという。
]

#remark[
二スケール極限は存在したら一意である。
]

#example[
$u in L^2(Omega; C(bb(T)^N))$とするとき、$u(x, x/epsilon)$は$u(x, y)$に二スケール強収束する。
$phi in L^2(Omega; C(bb(T)^N))$に対して、$u(x, y)phi(x, y)$は$L^1(Omega; C(bb(T)^N))$関数なので、
二スケール収束の基本定理より
$
integral_Omega u(x, x/epsilon)phi(x, x/epsilon) dd(x)
-> integral_Omega lr(angle.l u(x, y)phi(x, y) angle.r)_y dd(x)
$
である。
$phi = u$とすれば二スケール強収束の条件も得られる。
]
#remark[
通常の$L^2$強収束での対応する主張は$u in L^2(Omega)$とするとき$u(x)$は$u(x)$に強収束であり、自明である。
]

二スケール弱収束と二スケール強収束は通常の弱収束と強収束の間の強さの収束性である。

#proposition[
$L^2(Omega)$の関数列$u_epsilon (x)$が$macron(u)(x)$に強収束するならば、$u_epsilon (x)$は$u(x, y) = macron(u)(x)$に二スケール強収束する。
]

#proof[
$phi in L^2(Omega; C(bb(T)^N))$に対して、
$
&abs(integral_Omega u_epsilon (x)phi(x, x/epsilon) dd(x)-integral_Omega lr(angle.l u(x, y)phi(x, y) angle.r)_y dd(x)) \
&quad <= integral_Omega abs(u_epsilon (x)phi(x, x/epsilon)-macron(u)(x)phi(x, x/epsilon)) dd(x)+integral_Omega abs(macron(u)(x)phi(x, x/epsilon)-lr(angle.l macron(u)(x)phi(x, y) angle.r)_y) dd(x) \
&quad <= norm(u_epsilon-u)_(L^2(Omega))norm(phi(x, x/epsilon))_(L^2(Omega))+integral_Omega abs(macron(u)(x)phi(x, x/epsilon)-lr(angle.l macron(u)(x)phi(x, y) angle.r)_y) dd(x)
$
ここで前半は$norm(phi(x, x/epsilon))_(L^2(Omega)) <= norm(phi)_(L^2(Omega; C(bb(T)^N))) < oo$より仮定から$0$に収束し、後半も二スケール収束の基本定理より$0$に収束する。
したがって、二スケール弱収束が言えて、二スケール強収束は通常の強収束からノルムが収束する$norm(u_epsilon)_(L^2(Omega)) -> norm(macron(u))_(L^2(Omega))$ことからわかる。
]

#proposition[
$L^2(Omega)$の関数列$u_epsilon (x)$が$u(x, y) in L^2(Omega times bb(T)^N)$に二スケール弱収束するならば、$u_epsilon (x)$は$macron(u)(x) = lr(angle.l u(x, y) angle.r)_y$に弱収束する。
]

#proof[
$phi in L^2(Omega)$に対して、$phi in L^2(Omega; C(bb(T)^N))$とみなせるので、
$
integral_Omega u_epsilon (x)phi(x) dd(x)
-> integral_Omega lr(angle.l u(x, y)phi(x) angle.r)_y dd(x)
= integral_Omega macron(u)phi(x) dd(x)
$
より成立する。
]

#proposition[
$L^2(Omega)$の関数列$u_epsilon (x)$が$u(x, y) in L^2(Omega times bb(T)^N)$に二スケール弱収束し$L^2(Omega)$の関数列$v_epsilon (x)$が$v(x, y) in L^2(Omega times bb(T)^N)$に二スケール強収束するとき、
$
integral_Omega u_epsilon (x)v_epsilon (x) dd(x)
-> integral_Omega lr(angle.l u(x, y)v(x, y) angle.r)_y dd(x)
$
が成り立つ。
]

#proof[
まず、$v_epsilon$は二スケール強収束することから$norm(v_epsilon (x)-v(x, x/epsilon))_(L^2(Omega)) -> 0$であることに注意する。
実際、
$
integral_Omega (v_epsilon (x)-v(x, x/epsilon))^2 dd(x)
&= integral_Omega (v_epsilon (x)^2-2 v_epsilon (x)v(x, x/epsilon)+v(x, x/epsilon)^2) dd(x) \
&-> integral_Omega lr(angle.l v(x, y)^2-2 v(x, y)v(x, y)+v(x, y)^2 angle.r)_y dd(x)
= 0
$
である。
ここで、
$
&abs(integral_Omega u_epsilon (x)v_epsilon (x) dd(x)-integral_Omega lr(angle.l u(x, y)v(x, y) angle.r)_y dd(x)) \
&quad <= integral_Omega abs(u_epsilon (x)v_epsilon (x)-u_epsilon (x)v(x, x/epsilon)) dd(x)+integral_Omega abs(u_epsilon (x)v(x, x/epsilon)-lr(angle.l u(x, y)v(x, y) angle.r)_y) dd(x) \
&quad <= norm(u_epsilon)_(L^2(Omega))norm(v_epsilon (x)-v(x, x/epsilon))_(L^2(Omega))+integral_Omega abs(u_epsilon (x)v(x, x/epsilon)-lr(angle.l u(x, y)v(x, y) angle.r)_y) dd(x)
$
であり、$u_epsilon (x)$は二スケール弱収束することから通常の弱収束してノルム有界であることに注意して、命題の主張が得られる。
]

バナッハ・アラオグルの定理によれば、$L^2(Omega)$の単位球は弱収束位相についてコンパクトであった。
それの二スケール弱収束版が次に示すこの節で最も重要な定理である。

#theorem[
$L^2(Omega)$の有界な関数列$u_epsilon (x)$に対して、必要なら部分列を取れば$u_epsilon (x)$はある$u(x, y) in L^2(Omega times bb(T)^N)$に二スケール弱収束する。
]

#remark[
上で示した通り二スケール弱収束の方が通常の弱収束より強い収束の概念なので、この定理は弱収束に対するものより強い内容になっている。
また、$u(x, y)$は$L^2(Omega; C(bb(T)^N))$に属するとまでは言っていないことに注意する。
]

#proof[
$C := sup_epsilon norm(u_epsilon)_(L^2(Omega)) < oo$とおくと、任意の$phi in L^2(Omega; C(bb(T)^N))$に対して、
$
abs(integral_Omega u_epsilon (x)phi(x, x/epsilon) dd(x))
<= norm(u_epsilon)_(L^2(Omega))norm(phi(x, x/epsilon))_(L^2(Omega))
<= C norm(phi(x, x/epsilon))_(L^2(Omega))
<= C norm(phi)_(L^2(Omega; C(bb(T)^N))).
$ <e_bddcpt_tsw>
このことは$epsilon$ごとに$L^2 (Omega ; C (bb(T)^N))$上の有界線形形式を与え双対空間の元$U_epsilon in L^2(Omega; C(bb(T)^N))^*$が対応し
$
lr(angle.l U_epsilon, phi angle.r)
= integral_Omega u_epsilon (x)phi(x, x/epsilon) dd(x)
quad forall phi in L^2(Omega; C(bb(T)^N))
$
となり、さらに$norm(U_epsilon) <= C$であることを表す（ここでの$lr(angle.l U_epsilon, phi angle.r)$は平均ではなく線形形式の値）。
ここで、$L^2(Omega; C(bb(T)^N))$は可分なバナッハ空間なので、バナッハ・アラオグルの定理より$U_epsilon$は必要なら部分列を取ればある$U in L^2(Omega; C(bb(T)^N))^*$に汎弱収束する、つまり
$
lr(angle.l U_epsilon, phi angle.r)
= integral_Omega u_epsilon (x)phi(x, x/epsilon) dd(x)
-> lr(angle.l U, phi angle.r)
quad forall phi in L^2(Omega; C(bb(T)^N))
$
である。
ここで@e_bddcpt_tsw の評価を二つ目の不等号で止めた
$
abs(lr(angle.l U_epsilon, phi angle.r))
<= C norm(phi(x, x/epsilon))_(L^2(Omega))
$
を考えると、$epsilon$についての極限を取り二スケール収束の基本定理から
$
abs(lr(angle.l U, phi angle.r))
<= C norm(phi)_(L^2(Omega times bb(T)^N))
quad forall phi in L^2(Omega; C(bb(T)^N))
$
ここで$L^2(Omega; C(bb(T)^N))$は$L^2(Omega times bb(T)^N)$の稠密な部分集合であることに注意すると、
リースの表現定理より$u = u(x, y) in L^2(Omega times bb(T)^N)$が存在して
$
lr(angle.l U_epsilon, phi angle.r)
= integral_Omega u_epsilon (x)phi(x, x/epsilon) dd(x)
-> lr(angle.l U, phi angle.r)
= integral_Omega lr(angle.l u(x, y)phi(x, y) angle.r)_y dd(x)
quad forall phi in L^2(Omega; C(bb(T)^N))
$
を得る。
]

この節の最後に微分についての二スケール収束の結果を紹介する。
ここからは$Omega$を$bb(R)^N$の有界領域とする。

#theorem[
$H_0^1(Omega)$の有界な関数列$u_epsilon (x)$がある関数$u(x) in H_0^1(Omega)$に弱収束しているとする。
このとき、$v(x, y) in L^2(Omega; H^1(bb(T)^N))$が存在して必要なら部分列を取れば$nabla u_epsilon (x)$は$nabla u(x)+nabla_y v(x, y)$に二スケール弱収束する。
]

#proof[
$u_epsilon$と$nabla u_epsilon$（の各成分）は$L^2(Omega)$で有界なので、必要なら部分列を取れば二スケール弱収束する、つまり$tilde(u)(x, y) in L^2(Omega times bb(T)^N)$と$p(x, y) in L^2(Omega times bb(T)^N)^N$が存在して、
$
integral_Omega u_epsilon (x)phi(x, x/epsilon) dd(x)
-> integral_Omega lr(angle.l tilde(u)(x, y)phi(x, y) angle.r)_y dd(x)
quad forall phi in L^2(Omega; C(bb(T)^N)),
$
$
integral_Omega nabla u_epsilon (x) dot Phi(x, x/epsilon) dd(x)
-> integral_Omega lr(angle.l p(x, y)Phi(x, y) angle.r)_y dd(x)
quad forall Phi in L^2(Omega; C(bb(T)^N))^N
$
が成り立つ。
ここでコンパクトな台をもつ滑らかな関数の集合$cal(D)(Omega times bb(T)^N)$が$L^2(Omega; C(bb(T)^N))$で稠密であることに注意して、部分積分をすると
$
integral_Omega nabla u_epsilon (x) dot Phi(x, x/epsilon) dd(x)
&= -integral_Omega u_epsilon (x) (div_x Phi(x, x/epsilon)+1/epsilon div_y Phi(x, x/epsilon)) dd(x) \
&= -integral_Omega u_epsilon (x)div_x Phi(x, x/epsilon) dd(x)-1/epsilon integral_Omega u_epsilon (x)div_y Phi(x, x/epsilon) dd(x)
$
$u_epsilon (x)$は$tilde(u)(x, y)$に二スケール弱収束することから、まず
$
-integral_Omega lr(angle.l tilde(u)(x, y)div_y Phi(x, x/epsilon) angle.r)_y dd(x) = 0
$
がわかる。
これは$tilde(u)(x, y)$が$y$変数によらないことを表していて、弱収束極限の一意性から$tilde(u)(x, y) = u(x)$である。
さらに$div_y Phi(x, y) = 0$を満たすような$Phi$に制限すると、
$
integral_Omega lr(angle.l p(x, y)Phi(x, y) angle.r)_y dd(x)
= -integral_Omega lr(angle.l tilde(u)(x, y)div_x Phi(x, x/epsilon) angle.r)_y dd(x)
$
もわかり、部分積分を戻すと
$
-integral_Omega lr(angle.l tilde(u)(x, y)div_x Phi(x, x/epsilon) angle.r)_y dd(x)
= -integral_Omega lr(angle.l u(x)div_x Phi(x, x/epsilon) angle.r)_y dd(x)
= integral_Omega lr(angle.l nabla u(x) dot Phi(x, x/epsilon) angle.r)_y dd(x)
$
なので、$div_y Phi(x, y) = 0$だったことから$v(x, y) in L^2(Omega; H^1(bb(T)^N))$が存在して$p(x, y) = nabla u(x)+nabla_y v(x, y)$を得る。
]

== 均質化への応用

$Omega$を$bb(R)^N$の有界領域として、熱方程式の定常問題
$
cases(
	-div(A(x, x/epsilon)nabla u_epsilon (x)) = f(x) "in" Omega"," ,
	u_epsilon = 0 "on" partial Omega,
)
$ <e_e_eq>
を考える。
ここで$A(x, y)$は各成分が$L^oo (Omega; C(bb(T)^N))$な$N$次正方行列として$alpha > 0$が存在して一様楕円性条件
$
A(x, y)xi dot xi >= alpha abs(xi)^2
quad forall x in Omega, y in bb(T)^N, xi in bb(R)^N
$
を満たすとする。
$f(x) in L^2(Omega)$とする。
このとき、序文に書いたような議論で方程式@e_e_eq は弱形式
$
integral_Omega A(x, x/epsilon) nabla u_epsilon (x) dot nabla phi(x) dd(x)
= integral_Omega f(x)phi(x) dd(x)
quad forall phi in H_0^1(Omega)
$ <e_e_eqw>
の意味で一意解$u_epsilon (x) in H_0^1(Omega)$を持ちアプリオリ評価$sup_epsilon norm(u_epsilon)_(H^1(Omega)) < oo$を満たす。
また、極限方程式（二スケール均質化方程式系）は
$
cases(
	-div_x (lr(angle.l A(x, y)(nabla u(x)+nabla_y v(x, y)) angle.r)) = f(x) "in" Omega"," ,
	-div_y (A(x, y)(nabla u(x)+nabla_y v(x, y))) = 0 "in" Omega times bb(T)^N"," ,
	u = 0 "on" partial Omega,
)
$ <e_lim_eq>
で弱形式
$
integral_Omega lr(angle.l A(x, y)(nabla u(x)+nabla_y v(x, y))dot(nabla phi(x)+nabla_y psi(x, y)) angle.r)_y dd(x)
= integral_Omega f(x)phi(x) dd(x) &\
forall phi in H^1_0(Omega), psi in L^2(Omega; H^1(bb(T)^N)) &
$ <e_lim_eqw>
の意味で一意解$u in H_0^1(Omega)$と$v in L^2(Omega; H^1(bb(T)^N))$を持つ。

#theorem[
$epsilon -> 0$で$u_epsilon (x)$は$u(x)$に$H_0^1(Omega)$弱収束し、$nabla u_epsilon (x)$は$nabla u(x)+nabla_y v(x , y)$に二スケール弱収束する。
]

#proof[
前節の定理より部分列を取れば$u$と$v$が存在して$u_epsilon (x)$は$u(x)$に$H_0^1(Omega)$弱収束し$nabla u_epsilon (x)$は$nabla u(x)+nabla_y v(x, y)$に二スケール弱収束する。
あとはこの$u, v$が二スケール均質化方程式系の解になっていることを示せば、解の一意性より結論が従う。

滑らかな試験関数$phi(x) in H_0^1(Omega)$と$psi in L^2(Omega; H^1(bb(T)^N))$を固定して、@e_e_eqw の$phi$として$phi_epsilon (x) = phi(x)+epsilon psi(x, x/epsilon)$を代入すると
$
integral_Omega A(x, x/epsilon)nabla u_epsilon (x) dot nabla phi_epsilon (x) dd(x)
= integral_Omega f(x) phi_epsilon (x) dd(x)
$
つまり
$
integral_Omega A(x, x/epsilon)nabla u_epsilon (x) dot (nabla phi(x)+epsilon nabla_x psi(x, x/epsilon)+nabla_y psi(x, x/epsilon)) dd(x)
= integral_Omega f(x) (phi(x)+epsilon psi(x, x/epsilon)) dd(x)
$ <e_e_phie>
ここで$A^t (x, y)(nabla phi(x)+nabla_y psi(x, y))$は$L^2(Omega; C(bb(T)^N))^N$に属するので、$A^t (x, x/epsilon)(nabla phi(x)+epsilon nabla_x psi(x, x/epsilon)+nabla_y psi(x, x/epsilon))$はそれに二スケール強収束する。
よって、@e_e_phie で$epsilon -> 0$とすると、
$
integral_Omega lr(angle.l A(x, y)(nabla u(x)+nabla_y v(x, y))dot(nabla phi(x)+nabla_y psi(x, y)) angle.r)_y dd(x)
= integral_Omega f(x)phi(x) dd(x)
$
つまり@e_lim_eqw を得る。
]

さらに、もし二スケール均質化方程式系の解の規則性が上がるとよりよい収束性が言える。

#theorem[
もし$v(x, y)$と$nabla_x v(x, y)$（の各成分）と$nabla_y v(x, y)$（の各成分）が$L^2(Omega; C(bb(T)^N))$に属するならば、
$u_epsilon (x)-u(x)-epsilon v(x, x/epsilon)$は$0$に$H^1(Omega)$強収束する。
]

#proof[
次の値
$
integral_Omega A(x, x/epsilon)(nabla(u_epsilon (x)-u(x)-epsilon v(x, x/epsilon))) dot (nabla(u_epsilon (x)-u(x)-epsilon v(x, x/epsilon))) dd(x)
$
を考える。
この項のうち一つは、方程式の弱形式@e_e_eqw で$phi$として$u_epsilon$を選ぶことで、
$
integral_Omega A(x, x/epsilon)nabla u_epsilon (x) dot nabla u_epsilon (x) dd(x)
= integral_Omega f(x)u_epsilon (x) dd(x)
-> integral_Omega f(x)u(x) dd(x)
$
である。
それ以外の項は二スケール収束性を使うことと一様楕円性条件より
$
&limsup_(epsilon -> 0) alpha norm(nabla(u_epsilon (x)-u(x)-epsilon v(x, x/epsilon)))_(L^2(Omega))^2 \
&quad <= integral_Omega f(x)u(x) dd(x)-integral_Omega lr(angle.l A(x, y)(nabla u(x)+nabla_y v(x, y)) dot (nabla u(x)+nabla_y v(x, y)) angle.r)_y dd(x)
$
となり、二スケール均質化方程式系の弱形式@e_lim_eqw で$(phi, psi) = (u, v)$とすることで、右辺は$0$であることがわかるので定理の証明が完成する。
]

== 種々の積分の計算

この節では二スケール収束の基本定理@e_tsconv_p を用いることで積分の極限に関する問題が簡単に解かれることを大学や大学院の入試問題を題材に紹介する。

#example[
1989年の東京工業大学の入試問題
$
lim_(n -> oo) integral_0^pi x^2 abs(sin n x) dd(x)
$
を考える。
この問題は$x^2 sin n x$の原始関数が計算できることから解くことができるが、部分積分を2回使ったりしてから$n$の極限を取る必要があり、計算が煩わしい。
二スケール収束の基本定理（@t_tsconv_p）が使えたとしたら、$g(y) = abs(sin y)$の周期は$pi$より、以下のように簡単に計算することができる。
$
lim_(n -> oo) integral_0^pi x^2 abs(sin n x) dd(x)
= integral_0^pi 1/pi integral_0^pi x^2 abs(sin y) dd(y) dd(x)
= 1/pi integral_0^pi x^2 dd(x) integral_0^pi sin y dd(y)
= 1/pi dot 1/3 pi^3 dot [-cos y]_0^pi
= 2/3 pi^2
$
]

次の問題は積分の計算ができない（あるいは非常に難しい）場合である。

#example[
1999年の東京工業大学の入試問題
$
lim_(n -> oo) integral_0^(pi/2) (sin^2 n x)/(1+x) dd(x)
$
を考える。
この問題の標準的な解法はとりあえず半角の公式から$sin^2 n x = (1-cos 2 n x)/2$として、第2項の積分はリーマン・ルベーグの補題から$0$に収束するので、第1項の積分に帰着されるというものである。
実際には高校範囲で解くので、第2項の収束の部分は部分積分を駆使して示すことになるだろうか。
しかしながらこの問題も二スケール収束の基本定理が使えたとしたら簡単に解ける。
実際、$g(y) = sin^2 y$の周期は$pi$より、
$
lim_(n -> oo) integral_0^(pi/2) (sin^2 n x)/(1+x) dd(x)
= integral_0^(pi/2) 1/(1+x) dd(x) 1/pi integral_0^pi sin^2 y dd(y)
= 1/2 log(1+pi/2).
$
ちなみにリーマン・ルベーグの補題も二スケール収束の基本定理から示される。
]

無限区間の積分の例としては次がある。

#example[
2001年の京都大学の入試問題
$
lim_(n -> oo) integral_0^(n pi) e^(-x)abs(sin n x) dd(x)
$
を考える。
この問題も最初の例同様積分が計算できるのでその極限を考えればよいが、計算量が非常に多い。
二スケール収束の基本定理を使うにしてもこの問題では積分区間が$n$に依存してしまっているが、実際には極限の区間$\[0, oo\)$のみ最初から考えれば十分である。
つまり、$f(x, y) = e^(-x)abs(sin y)$とおくと$y$について周期$pi$の連続関数であり、
$
integral_0^oo sup_(y in [0, pi]) abs(f(x, y)) dd(x)
= integral_0^oo e^(-x) dd(x)
= 1
< oo
$
を満たす。 よって、$n -> oo$で
$
abs(integral_0^oo f(x, n x) dd(x)-integral_0^(n pi) f(x, n x) dd(x))
<= integral_(n pi)^oo abs(f(x, n x)) dd(x)
<= integral_(n pi)^oo sup_(y in [0, pi]) abs(f(x, y)) dd(x)
-> 0
$
となるので、
$
lim_(n -> oo) integral_0^(n pi) e^(-x)abs(sin n x) dd(x)
= lim_(n -> oo) integral_0^oo e^(-x)abs(sin n x) dd(x)
$
がわかる。
よって、ルベーグ積分の枠組みだと二スケール収束の基本定理より直ちに
$
lim_(n -> oo) integral_0^oo e^(-x)abs(sin n x) dd(x)
= integral_0^oo e^(-x) dd(x) 1/pi integral_0^pi abs(sin y) dd(x)
= 2/pi
$
を得る。

なお、この積分をリーマン積分の枠組みでとらえて広義積分だと思っても同じ公式が成り立つ。
実際、$R > 0$に対して
$
&abs(integral_0^oo f(x, n x) dd(x)-integral_0^oo lr(angle.l f(x, y) angle.r)_y dd(x)) \
&quad <= abs((integral_0^oo-integral_0^R) f(x, n x) dd(x))+integral_0^R abs(f(x, n x)-lr(angle.l f(x, y) angle.r)_y) dd(x)+abs((integral_0^R-integral_0^oo) lr(angle.l f(x, y) angle.r)_y dd(x)) \
&quad <= 2 integral_R^oo sup_(y) abs(f(x, y)) dd(x)+integral_0^R abs(f(x, n x)-lr(angle.l f(x, y) angle.r)_y) dd(x)
$
と評価できるためである。
]

この問題をさらに難しくした次の問題を読者に出題する。

#xca[
次の値を求めよ。
$
lim_(n -> oo) integral_0^n 1/(1+e^x+sin 2 pi n x) dd(x).
$
]

最後に変数分離型の二スケール収束の基本定理を使う問題を紹介する。

#example[
2016年の京都大学大学院理学研究科の入試問題
$
lim_(n -> oo) integral_0^oo e^(-x)(n x-floor(n x))
$
を考える。
この問題では関数$g(y) = y-floor(y)$は$y$について周期$1$の関数であるが連続ではない。
しかしながら$L^oo (bb(T))$なので定理@t_tsconv_p_sep が使えて、
$
lim_(n -> oo) integral_0^oo e^(-x)(n x-floor(n x))
= integral_0^oo e^(-x) dd(x) integral_0^1 y dd(y)
= 1/2
$
である。
]

#bibliography("references.yml", style: "american-physics-society")
