---
plugins: ["numbered-headings"]
output:
  pdf_document:
    extra_dependencies: ["physics"]
---

# 二スケール収束とその周辺

$$\def\e{\varepsilon}\newcommand{\e}{\varepsilon}$$

## はじめに

このノートではある偏微分方程式の均質化を正当化するために二スケール収束と呼ばれる関数列の収束の概念とその性質を支える原理的定理に焦点を当てて解説する。
ここで二スケールとは二つのスケール(two-scale)ということで、巨視的なスケールと微視的なスケールのことを意味する。

均質化は微視的なスケールにおいて周期的になっている構造物が巨視的なスケールにおいてどのような性質を持つかという話題である。 巨視的なスケールに対して微視的なスケールの細かさを$$\e > 0$$として、 $$1$$次元熱方程式の定常問題

$$
\begin{cases} -\dv{x}\qty(a_\e(x)\dv{u_\e}{x}{(x)}) = f(x) & \text{in $(0, L)$,} \\ u_\e(0) = u_\e(L) = 0 \\ \end{cases}
$$

を例にとって説明しよう。 ここで熱伝導係数$$a_\e(x)$$は位置$$x$$に依存する周期$$\e$$の関数で$$\inf_{x, \e}a_\e(x) =: \alpha > 0$$とする。 均質化の数学的な定式化は方程式の係数$$a_\e(x)$$が

$$
a_\e(x) = a(\frac{x}{\e})
$$

となる、より正確には周期$$1$$の関数$$a$$が存在して上のように書けたとするとき、 $$\e \to 0$$での解$$u\_\e$$の挙動、つまり$$u\_\e$$は収束するか極限方程式は何かというを考えることになる。

この定常問題に対して弱形式による弱解$$u\_\e$$が構成できたとすると、$$u\_\e$$自身を試験関数に用いることで

$$
\alpha\int_0^L \dv{u_\e}{x}{(x)}^2\dd{x} \le \int_0^L a_\e(x)\dv{u_\e}{x}{(x)}^2\dd{x} = \int_0^L f(x)u_\e(x)\dd{x} \le K\int_0^L f(x)^2\dd{x}+\frac{1}{4 K}\int_0^L u_\e(x)^2\dd{x}
$$

であり($$K > 0$$)、ポアンカレの不等式より

$$
\int_0^L u_\e(x)^2\dd{x}+\int_0^L \dv{u_\e}{x}{(x)}^2\dd{x} \le C\int_0^L f(x)^2\dd{x}
$$

を得る。 ここから部分列を取れば$$u\_\e$$は$$\e \to 0$$である関数$$u$$に$$H^1\_0(\[0, L])$$ソボレフ空間の中で弱収束することがわかる。

次に問題になるのが極限方程式は何かという問題だが$u\_\e(x)$の漸近展開

$$
u_\e(x) = u_0(x, \frac{x}{\e})+\e u_1(x, \frac{x}{\e})+\e^2 u_2(x, \frac{x}{\e})+\cdots
$$

を考えることが有効である。 今回の方程式で重要なのは

$$
u_\e(x) \simeq u(x)+\e v(\frac{x}{\e})
$$

の部分である。 この漸近展開にもとづくことで次の均質化の結果が成り立つことが知られている。 すなわち、まずいわゆるセル問題

$$
-\dv{y}\qty(a(y)(\dv{w}{y}{(y)}+1)) = 0
$$

に周期$1$の解$w(y)$が存在し、実効熱伝導係数

$$
\bar{a} = \int_0^1 a(y)(\dv{w}{y}{(y)}+1)^2\dd{y}
$$

を定義すると、パラメータ付きの解$u\_\e$は極限方程式

$$
\begin{cases} -\dv{x}\qty(\bar{a}\dv{u}{x}{(x)}) = f(x) & \text{in $(0, L)$,} \\ u(0) = u(L) = 0 \\ \end{cases}
$$

の一意解$u$に$H^1\_0(\[0, L])$弱収束する。

さらに今回のような空間$1$次元で$a$が微視的なスケールの変数$y$のみに依存して巨視的なスケールの変数$x$に依存しない場合は実効熱伝導係数$\bar{a}$をさらに詳しく計算することができ、調和平均

$$
\bar{a} = \qty(\int_0^1 \frac{1}{a(y)}\dd{y})^{-1}
$$

で与えられることも知られている。

この最終的な結論は工学などの応用上非常に重要である。 その一方でセル問題の方法は高次元化などの拡張が知られている。 しかしながら、セル問題の方法をそのまま正当化しようとすると様々な困難を乗り越える必要がある。 そのような中で本ノートの主題である二スケール収束と二スケール均質化方程式系を用いた解析手法は次に述べる非常に簡単な議論を通して均質化を正当化できる。 誤解を恐れずに表現すると、調和平均による均質化の理解は工学的であり、セル問題による理解は物理学的であり、二スケール収束による方法は数学的といえる。

続く

\section{二スケール収束の原理}

$\Omega$を$\RN$の（有界とは限らない）ボレル可測集合として、$f = f(x, y): \Omega\times\RN \to \R$を$y$について$\ZN$-周期的つまり

$$
f(x, y+z) = f(x, y) \quad \forall z \in \ZN
$$

を満たすとする。 このような関数を簡単のため平坦トーラス$\TN := \RN/\ZN$を用いて$f: \Omega\times\TN \to \R$と表す。 $\square$を$\RN$の単位立方体、つまり$\square = \[0, 1)^N$とする。

この節の目標は$f$の何らかの仮定の下で次の極限に関する式 \begin{equation} \label{e\_tsconv\_p} \lim\_{\e \to 0}\int\_\Omega f(x, \frac{x}{\e})\dd{x} = \lim\_{n \to \infty}\int\_\Omega f(x, n x)\dd{x} = \int\_\Omega \lrangle{f(x, y)}_y\dd{x} = \int_\Omega \frac{1}{\abs{\square\}}\int\_\square f(x, y)\dd{y}\dd{x} \end{equation} を示すことである。 ここで$\lrangle{f(x, y)}_y = \frac{1}{\abs{\square\}}\int_\square f(x, y)\dd{y}$は$f(x, y)$の$y$変数に関する平均を表す。 $\abs{\square}$は$\square$のルベーグ測度でありその値は$1$であるが、$\ZN$-周期的とは限らない場合のためにこのように書いている。 また、最左辺の$\e$は正の実数を、第2辺の$n$は正の整数を想定しているため、最左辺と最右辺が一致することを示せば十分である。 この式\eqref{e\_tsconv\_p}のことを本ノートでは\emph{二スケール収束の原理}と呼ぶことにする。

この二スケール収束の原理は連続関数およびリーマン積分の枠組みだと示しやすい。 例えば簡単のために$\Omega$を1次元の有界閉区間$\[0, M]$で$M$は正の整数、$f = f(x, y): \[0, M]\times\T \to \R$を連続関数として、二スケール収束の原理

$$
\lim_{n \to \infty}\int_0^M f(x, n x)\dd{x} = \int_0^M \int_0^1 f(x, y)\dd{y}\dd{x}
$$

を示す。 実際$y = n x$と置換して積分区間を周期に従って分割すると、

$$
\int_0^M f(x, n x)\dd{x} = \frac{1}{n}\int_0^{n M} f(\frac{y}{n}, y)\dd{y} = \frac{1}{n}\sum_{k = 1}^{n M}\int_{k-1}^k f(\frac{y}{n}, y)\dd{y} = \int_0^1 \frac{1}{n}\sum_{k = 1}^{n M}f(\frac{y+k-1}{n}, y)\dd{y}
$$

となる。 あとは区分求積法の式

$$
\lim_{n \to \infty}\frac{1}{n}\sum_{k = 1}^{n M}f(\frac{y+k-1}{n}, y) = \int_0^M f(x, y)\dd{x}
$$

が実は$y$について一様収束になっていることを示せば、極限と積分の順序交換ができよい。 頑張ればこれも示すことができるので詳細省略。

このようにして連続関数の枠組みでは比較的容易に証明することができるが、偏微分方程式に応用することを考えると関数の入る空間をより拡張する必要がある。 しかしながら、\eqref{e\_tsconv\_p}の右辺が$L^1(\Omega\times\TN)$なら定義できるからと言って、そのようにすると広げすぎであり、成り立たない反例もある（\cite\[Proposition 5.8]{A92}参照）。 そのためどこまで拡張するかが問題になるが、今後の展開で重要なのが$L^1(\Omega; C(\TN))$という空間である。 これは$x \in \Omega$ごとに$y$について$\ZN$-周期的な連続関数が対応し、 \begin{equation} \label{e\_l1c} \norm{f}_{L^1(\Omega; C(\TN))} := \int_\Omega \sup\_{y \in \square}\abs{f(x, y)}\dd{x} < \infty \end{equation} を満たす関数$f$のなすボホナー空間である。

\begin{theorem}\[二スケール収束の原理] \label{t\_tsconv\_p} $f \in L^1(\Omega; C(\TN))$とすると、 $ \norm{f(x, \frac{x}{\e})}_{L^1(\Omega)} \le \norm{f}_{L^1(\Omega; C(\TN))} $ と\eqref{e\_tsconv\_p}が成り立つ。 \end{theorem}

証明の前に$L^1(\Omega; C(\TN))$の関数の特徴づけを思い出す。

\begin{proposition} 関数$f$が$L^1(\Omega; C(\TN))$に属することは、$\Omega$のある測度零部分集合$E$が存在して以下の条件が成り立つことと同値である。 \begin{itemize} \item\[(a)] 任意の$x \in \Omega\setminus E$に対して$y \mapsto f(x, y)$は連続で$\ZN$-周期的である。 \item\[(b)] 任意の$y \in \square$に対して$x \mapsto f(x, y)$は可測である。 \item\[(c)] \eqref{e\_l1c}が成り立つ。 \end{itemize} \end{proposition}

この命題の証明は省略する。

\begin{proof}\[定理\ref{t\_tsconv\_p}の証明] 前半部分は簡単にわかるので、後半の式を示す。 まず、$f(x, y)$が変数分離された$f(x, y) = \phi(x)g(y)$の場合を考える。 この時示すべき式は \begin{equation} \label{e\_tsconv\_p\_sep} \lim\_{\e \to 0}\int\_\Omega \phi(x)g(\frac{x}{\e})\dd{x} = \int\_\Omega \phi(x)\lrangle{g}\dd{x} \end{equation} とでき、$\ZN$-周期的な関数$g$に対して$L^\infty(\RN)$関数の列$g(\frac{x}{\e})$が$\e \to 0$で平均$\lrangle{g}$に汎弱収束することを意味する。 この式も近似することを考えると$\phi$, $g$を区間の直積の指示関数の場合に示せばよく、次の1次元の場合に帰着される。 つまり、$L^\infty(\T)$関数$g$と実数$a < b$に対して、 \begin{equation} \label{e\_tsconv\_p\_sep1} \lim\_{\e \to 0}\int\_a^b g(\frac{x}{\e})\dd{x} = (b-a)\int\_0^1 g(y)\dd{y}. \end{equation} これは

$$
\int_a^b g(\frac{x}{\e})\dd{x} = \e \int_{\frac{a}{\e}}^{\frac{b}{\e}} g(y)\dd{y}
$$

と置換したうえで、区間$\[\frac{a}{\e}, \frac{b}{\e}]$の間に長さ$1$の区間がいくつ取れるかを考えて、

$$
\int_a^b g(\frac{x}{\e})\dd{x} = \e\qty(\lrfloor*{\frac{b}{\e}}-\lrfloor*{\frac{a}{\e}})\int_0^1 g(y)\dd{y}+\e\int_{\lrfloor*{\frac{b}{\e}}}^{\frac{b}{\e}}g(y)\dd{y}+\e\int_{\frac{a}{\e}}^{\lrfloor*{\frac{a}{\e}}}g(y)\dd{y}.
$$

ここで一般に$x-1 \le \lrfloor{x} \le x$であることから、\eqref{e\_tsconv\_p\_sep1}がわかる。 以上より変数分離された場合\eqref{e\_tsconv\_p\_sep}は示された。

一般の$f(x, y)$に対しては$y$変数の入る集合$\square$の分割と代表点$\Delta\_n = (\square\_i, y\_i)$を取って

$$
f_n(x, y) = \sum_i f(x, y_i)\chi_{\square_i}(y)
$$

を定めると、$x \mapsto f(x, y\_i)$は$L^1(\Omega)$なので$f\_n$は変数分離された関数の有限和より\eqref{e\_tsconv\_p}が成り立つ。 ここで、

$$
\begin{aligned} &\abs{\int_\Omega f(x, \frac{x}{\e})\dd{x}-\int_\Omega \lrangle{f(x, y)}_y\dd{x}} \\ &\le \abs{\int_\Omega f(x, \frac{x}{\e})\dd{x}-\int_\Omega f_n(x, \frac{x}{\e})\dd{x}} +\abs{\int_\Omega f_n(x, \frac{x}{\e})\dd{x}-\int_\Omega \lrangle{f_n(x, y)}_y\dd{x}} +\abs{\int_\Omega \lrangle{f_n(x, y)}_y\dd{x}-\int_\Omega \lrangle{f(x, y)}_y\dd{x}} \\ &\le 2\norm{f_n-f}_{L^1(\Omega; C(\TN))}+\abs{\int_\Omega f_n(x, \frac{x}{\e})\dd{x}-\int_\Omega \lrangle{f_n(x, y)}_y\dd{x}} \end{aligned}
$$

なので、$f\_n$が$f$に$L^1(\Omega; C(\TN))$で強収束を示せばよい。 ここで$g\_n(x) = \sup\_{y \in \square}\abs{f\_n(x, y)-f(x, y)}$とおくと、$x \in \Omega\setminus E$に対して$y \mapsto f(x, y)$は連続で一様連続でもあるので、分割を細かくするほど$g\_n(x) \to 0$となる。 すなわちほとんどすべての点で$g\_n \to 0$である。 また、$x \in \Omega\setminus E$ごとに

$$
g_n(x) \le \sup_{y \in \square}\abs{f_n(x, y)}+\sup_{y \in \square}\abs{f(x, y)} \le 2\sup_{y \in \square}\abs{f(x, y)}
$$

であり最右辺は$L^1(\Omega)$に属する関数である。 よって、ルベーグの優収束定理が使えて、$\norm{f\_n-f}\_{L^1(\Omega; C(\TN))} \to 0$なので、\eqref{e\_tsconv\_p}が示された。 \end{proof}

証明の途中で示した変数分離での二スケール収束の原理は関数の仮定が異なるからその部分を以下に述べる。

\begin{theorem}\[二スケール収束の原理（変数分離）] \label{t\_tsconv\_p\_sep} $f(x, y) = \phi(x)g(y)$, $\phi \in L^1(\Omega)$, $g \in L^\infty(\TN)$とすると、 \eqref{e\_tsconv\_p}が成り立つ。 \end{theorem}

\section{二スケール収束とその性質}

$\Omega$を$\RN$の（有界とは限らない）ボレル可測集合とする。

\begin{definition}\[二スケール収束] $L^2(\Omega)$の関数列$u\_\e(x)$を考える。

ここである$L^2(\Omega\times\TN)$関数$u$が存在して、

$$
\int_\Omega u_\e(x)\phi(x, \frac{x}{\e})\dd{x} \to \int_\Omega \lrangle{u(x, y)\phi(x, y)}_y\dd{x} \quad \forall \phi \in L^2(\Omega; C(\TN))
$$

が成り立つとき、$u\_\e(x)$は\emph{二スケール弱収束}するといい、$u(x, y)$をその時の\emph{二スケール極限}という。

上の条件に加えて

$$
\int_\Omega u_\e(x)^2\dd{x} \to \int_\Omega \lrangle{u(x, y)^2}_y\dd{x}
$$

が成立するとき、$u\_\e(x)$は\emph{二スケール強収束}するという。 \end{definition}

\begin{remark} 二スケール極限は存在したら一意である。 \end{remark}

\begin{example} $u \in L^2(\Omega; C(\TN))$とするとき、$u(x, \frac{x}{\e})$は$u(x, y)$に二スケール強収束する。 $\phi \in L^2(\Omega; C(\TN))$に対して、$u(x, y)\phi(x, y)$は$L^1(\Omega; C(\TN))$関数なので、 二スケール収束の原理より

$$
\int_\Omega u(x, \frac{x}{\e})\phi(x, \frac{x}{\e})\dd{x} \to \int_\Omega \lrangle{u(x, y)\phi(x, y)}_y\dd{x}
$$

である。 $\phi = u$とすれば二スケール強収束の条件も得られる。 \end{example}

\begin{remark} 通常の$L^2$強収束での対応する主張は$u \in L^2(\Omega)$とするとき$u(x)$は$u(x)$に強収束であり、自明である。 \end{remark}

二スケール弱収束と二スケール強収束は通常の弱収束と強収束の間の強さの収束性である。

\begin{proposition} $L^2(\Omega)$の関数列$u\_\e(x)$が$\bar{u}(x)$に強収束するならば、$u\_\e(x)$は$u(x, y) = \bar{u}(x)$に二スケール強収束する。 \end{proposition}

\begin{proof} $\phi \in L^2(\Omega; C(\TN))$に対して、

$$
\begin{aligned} &\abs{\int_\Omega u_\e(x)\phi(x, \frac{x}{\e})\dd{x}-\int_\Omega \lrangle{u(x, y)\phi(x, y)}_y\dd{x}} \\ &\le \abs{\int_\Omega u_\e(x)\phi(x, \frac{x}{\e})\dd{x}-\int_\Omega \bar{u}(x)\phi(x, \frac{x}{\e})\dd{x}}+\abs{\int_\Omega \bar{u}(x)\phi(x, \frac{x}{\e})\dd{x}-\int_\Omega \lrangle{\bar{u}(x)\phi(x, y)}_y\dd{x}} \\ &\le \norm{u_\e-\bar{u}}_{L^2(\Omega)}\norm{\phi(x, \frac{x}{\e})}_{L^2(\Omega)}+\abs{\int_\Omega \bar{u}(x)\phi(x, \frac{x}{\e})\dd{x}-\int_\Omega \lrangle{\bar{u}(x)\phi(x, y)}_y\dd{x}} \end{aligned}
$$

ここで前半は$\norm{\phi(x, \frac{x}{\e})}_{L^2(\Omega)} \le \norm{\phi}_{L^2(\Omega; C(\TN))} < \infty$より仮定から$0$に収束し、後半も二スケール収束の原理より$0$に収束する。 したがって、二スケール弱収束が言えて、二スケール強収束は通常の強収束からノルムが収束する$\norm{u\_\e}_{L^2(\Omega)} \to \norm{\bar{u\}}_{L^2(\Omega)}$ことからわかる。 \end{proof}

\begin{proposition} $L^2(\Omega)$の関数列$u\_\e(x)$が$u(x, y) \in L^2(\Omega\times\TN)$に二スケール弱収束するならば、$u\_\e(x)$は$\bar{u}(x) = \lrangle{u(x, y)}\_y$に弱収束する。 \end{proposition}

\begin{proof} $\phi \in L^2(\Omega)$に対して、$\phi \in L^2(\Omega; C(\TN))$とみなせるので、

$$
\int_\Omega u_\e(x)\phi(x)\dd{x} \to \int_\Omega \lrangle{u(x, y)\phi(x)}_y\dd{x} = \int_\Omega \bar{u}(x)\phi(x)\dd{x}
$$

より成立する。 \end{proof}

\begin{proposition} $L^2(\Omega)$の関数列$u\_\e(x)$が$u(x, y) \in L^2(\Omega\times\TN)$に二スケール弱収束し$L^2(\Omega)$の関数列$v\_\e(x)$が$v(x, y) \in L^2(\Omega\times\TN)$に二スケール強収束するとき、

$$
\int_\Omega u_\e(x)v_\e(x)\dd{x} \to \int_\Omega \lrangle{u(x, y)v(x, y)}_y\dd{x}
$$

が成り立つ。 \end{proposition}

\begin{proof} まず、$v\_\e$は二スケール強収束することから$\norm{v\_\e(x)-v(x, \frac{x}{\e})}\_{L^2(\Omega)} \to 0$であることに注意する。 実際、

$$
\begin{aligned} \int_\Omega \qty(v_\e(x)-v(x, \frac{x}{\e}))^2\dd{x} &= \int_\Omega v_\e(x)^2-2 v_\e(x)v(x, \frac{x}{\e})+v(x, \frac{x}{\e})^2\dd{x} \\ &\to \int_\Omega \lrangle{v(x, y)^2-2 v(x, y)v(x, y)+v(x, y)^2}_y\dd{x} = 0 \end{aligned}
$$

である。 ここで、

$$
\begin{aligned} &\abs{\int_\Omega u_\e(x)v_\e(x)\dd{x}-\int_\Omega \lrangle{u(x, y)v(x, y)}_y\dd{x}} \\ &\le \abs{\int_\Omega u_\e(x)v_\e(x)\dd{x}-\int_\Omega u_\e(x)v(x, \frac{x}{\e})\dd{x}}+\abs{\int_\Omega u_\e(x)v(x, \frac{x}{\e})\dd{x}-\int_\Omega \lrangle{u(x, y)v(x, y)}_y\dd{x}} \\ &\le \norm{u_\e}_{L^2(\Omega)}\norm{v_\e(x)-v(x, \frac{x}{\e})}_{L^2(\Omega)}+\abs{\int_\Omega u_\e(x)v(x, \frac{x}{\e})\dd{x}-\int_\Omega \lrangle{u(x, y)v(x, y)}_y\dd{x}} \end{aligned}
$$

であり、$u\_\e(x)$は二スケール弱収束することから通常の弱収束してノルム有界であることに注意して、命題の主張が得られる。 \end{proof}

バナッハ・アラオグルの定理によれば、$L^2(\Omega)$の単位球は弱収束位相についてコンパクトであった。 それの二スケール弱収束版が次に示すこの節で最も重要な定理である。

\begin{theorem} $L^2(\Omega)$の有界な関数列$u\_\e(x)$に対して、必要なら部分列を取れば$u\_\e(x)$はある$u(x, y) \in L^2(\Omega\times\TN)$に二スケール弱収束する。 \end{theorem}

\begin{remark} 上で示した通り二スケール弱収束の方が通常の弱収束より強い収束の概念なので、この定理は弱収束に対するものより強い内容になっている。 また、$u(x, y)$は$L^2(\Omega; C(\TN))$に属するとまでは言っていないことに注意する。 \end{remark}

\begin{proof} $C := \sup\_\e \norm{u\_\e}_{L^2(\Omega)} < \infty$とおくと、任意の$\phi \in L^2(\Omega; C(\TN))$に対して、 \begin{equation} \label{e\_bddcpt\_tsw} \abs{\int_\Omega u\_\e(x)\phi(x, \frac{x}{\e})\dd{x\}} \le \norm{u\_\e}_{L^2(\Omega)}\norm{\phi(x, \frac{x}{\e})}_{L^2(\Omega)} \le C\norm{\phi(x, \frac{x}{\e})}_{L^2(\Omega)} \le C\norm{\phi}_{L^2(\Omega; C(\TN))}. \end{equation} このことは$\e$ごとに$L^2(\Omega; C(\TN))$上の有界線形形式を与え双対空間の元$U\_\e \in L^2(\Omega; C(\TN))^\*$が対応し

$$
\lrangle{U_\e, \phi} = \int_\Omega u_\e(x)\phi(x, \frac{x}{\e})\dd{x} \quad \forall \phi \in L^2(\Omega; C(\TN))
$$

となり、さらに$\norm{U\_\e} \le C$であることを表す（ここでの$\lrangle{U\_\e, \phi}$は平均ではなく線形形式の値）。 ここで、$L^2(\Omega; C(\TN))$は可分なバナッハ空間なので、バナッハ・アラオグルの定理より$U\_\e$は必要なら部分列を取ればある$U \in L^2(\Omega; C(\TN))^\*$に汎弱収束する、つまり

$$
\lrangle{U_\e, \phi} = \int_\Omega u_\e(x)\phi(x, \frac{x}{\e})\dd{x} \to \lrangle{U, \phi} \quad \forall \phi \in L^2(\Omega; C(\TN))
$$

である。 ここで\eqref{e\_bddcpt\_tsw}の評価を二つ目の不等号で止めた

$$
\abs{\lrangle{U_\e, \phi}} \le C\norm{\phi(x, \frac{x}{\e})}_{L^2(\Omega)}
$$

を考えると、$\e$についての極限を取り二スケール収束の原理から

$$
\abs{\lrangle{U, \phi}} \le C\norm{\phi}_{L^2(\Omega\times\TN)} \quad \forall \phi \in L^2(\Omega; C(\TN))
$$

ここで$L^2(\Omega; C(\TN))$は$L^2(\Omega\times\TN)$の稠密な部分集合であることに注意すると、 リースの表現定理より$u = u(x, y) \in L^2(\Omega\times\TN)$が存在して

$$
\lrangle{U_\e, \phi} = \int_\Omega u_\e(x)\phi(x, \frac{x}{\e})\dd{x} \to \lrangle{U, \phi} = \int_\Omega \lrangle{u(x, y)\phi(x, y)}_y\dd{x} \quad \forall \phi \in L^2(\Omega; C(\TN))
$$

を得る。 \end{proof}

この節の最後に微分についての二スケール収束の結果を紹介する。 ここからは$\Omega$を$\RN$の有界領域とする。

\begin{theorem} $H^1\_0(\Omega)$の有界な関数列$u\_\e(x)$がある関数$u(x) \in H^1\_0(\Omega)$に弱収束しているとする。 このとき、$v(x, y) \in L^2(\Omega; H^1(\TN))$が存在して必要なら部分列を取れば$\D u\_\e(x)$は$\D u(x)+\D\_y v(x, y)$に二スケール弱収束する。 \end{theorem}

\begin{proof} $u\_\e$と$\D u\_\e$（の各成分）は$L^2(\Omega)$で有界なので、必要なら部分列を取れば二スケール弱収束する、つまり$\tilde{u}(x, y) \in L^2(\Omega\times\TN)$と$p(x, y) \in L^2(\Omega\times\TN)^N$が存在して、

$$
\int_\Omega u_\e(x)\phi(x, \frac{x}{\e})\dd{x} \to \int_\Omega \lrangle{\tilde{u}(x, y)\phi(x, y)}_y\dd{x} \quad \forall \phi \in L^2(\Omega; C(\TN)),
$$

$$
\int_\Omega \D u_\e(x)\cdot\Phi(x, \frac{x}{\e})\dd{x} \to \int_\Omega \lrangle{p(x, y)\cdot\Phi(x, y)}_y\dd{x} \quad \forall \Phi \in L^2(\Omega; C(\TN))^N
$$

が成り立つ。 ここでコンパクトな台をもつ滑らかな関数の集合$\mathcal{D}(\Omega\times\TN)$が$L^2(\Omega; C(\TN))$で稠密であることに注意して、部分積分をすると

$$
\e\int_\Omega \D u_\e(x)\cdot\Phi(x, \frac{x}{\e})\dd{x} = -\int_\Omega u_\e(x)\qty(\e\div_x\Phi(x, \frac{x}{\e})+\div_y\Phi(x, \frac{x}{\e}))\dd{x}.
$$

$u\_\e(x)$は$\tilde{u}(x, y)$に二スケール弱収束することから、まず

$$
-\int_\Omega \lrangle{\tilde{u}(x, y)\div_y\Phi(x, y)}_y\dd{x} = 0
$$

がわかる。 これは$\tilde{u}(x, y)$が$y$変数によらないことを表していて、弱収束極限の一意性から$\tilde{u}(x, y) = u(x)$である。 さらに$\div\_y\Phi(x, y) = 0$を満たすような$\Phi$に制限すると、

$$
-\int_\Omega \lrangle{\tilde{u}(x, y)\div_x\Phi(x, y)}_y\dd{y}\dd{x} = \int_\Omega \lrangle{p(x, y)\cdot\Phi(x, y)}_y\dd{x}
$$

もわかり、部分積分を戻すと

$$
-\int_\Omega \lrangle{\tilde{u}(x, y)\div_x\Phi(x, y)}_y\dd{y}\dd{x} = -\int_\Omega \lrangle{u(x)\div_x\Phi(x, y)}_y\dd{x} = \int_\Omega \lrangle{\D u(x)\cdot\Phi(x, y)}_y\dd{x}
$$

なので、$\div\_y\Phi(x, y) = 0$だったことから$v(x, y) \in L^2(\Omega; H^1(\TN))$が存在して$p(x, y) = \D u(x)+\D\_y v(x, y)$を得る。 \end{proof}

\section{均質化への応用}

$\Omega$を$\RN$の有界領域として、熱方程式の定常問題 \begin{equation} \label{e\_e\_eq} \begin{cases} -\div\qty(A(x, \frac{x}{\e})\D u\_\e) = f(x) & \text{in $\Omega$,} \ u\_\e = 0 & \text{on $\partial\Omega$,} \ \end{cases} \end{equation} を考える。 ここで$A(x, y)$は各成分が$L^\infty(\Omega; C(\TN))$な$N$次正方行列として$\alpha > 0$が存在して一様楕円性条件

$$
A(x, y)\xi\cdot\xi \ge \alpha\abs{\xi} \quad \forall x \in \Omega, y \in \TN, \xi \in \RN
$$

を満たすとする。 $f(x) \in L^2(\Omega)$とする。 このとき、序文に書いたような議論で方程式\eqref{e\_e\_eq}は弱形式 \begin{equation} \label{e\_e\_eqw} \int\_\Omega A(x, \frac{x}{\e})\D u\_\e(x)\cdot\D \phi(x)\dd{x} = \int\_\Omega f(x)\phi(x)\dd{x} \quad \forall \phi(x) \in H^1\_0(\Omega) \end{equation} の意味で一意解$u\_\e(x) \in H^1\_0(\Omega)$を持ちアプリオリ評価$\sup\_\e \norm{u\_\e(x)}\_{H^1(\Omega)} < \infty$を満たす。 また、極限方程式（二スケール均質化方程式系）は \begin{equation} \label{e\_lim\_eq} \begin{cases} -\div\_x\qty(\lrangle{A(x, y)(\D u(x)+\D\_y v(x, y))}_y) = f(x) & \text{in $\Omega$,} \ -\div\_y\qty(A(x, y)(\D u(x)+\D\_y v(x, y))) = 0 & \text{in $\Omega\times\TN$,} \ u = 0 & \text{on $\partial\Omega$,} \ \end{cases} \end{equation} で弱形式 \begin{equation} \label{e\_lim\_eqw} \begin{aligned} \int_\Omega \lrangle{A(x, y)(\D u(x)+\D\_y v(x, y))\cdot(\D \phi(x)+\D\_y \psi(x, y))}_y\dd{x} = \int_\Omega f(x)\phi(x)\dd{x}& \ \forall \phi(x) \in H^1\_0(\Omega), \psi \in L^2(\Omega; H^1(\TN))& \end{aligned} \end{equation} の意味で一意解$u \in H^1\_0(\Omega)$と$v \in L^2(\Omega; H^1(\TN))$を持つ。

\begin{theorem} $\e \to 0$で$u\_\e(x)$は$u(x)$に$H^1\_0(\Omega)$弱収束し、$\D u\_\e(x)$は$\D u(x)+\D\_y v(x, y)$に二スケール弱収束する。 \end{theorem}

\begin{proof} 前節の定理より部分列を取れば$u$, $v$が存在して$u\_\e(x)$は$u(x)$に$H^1\_0(\Omega)$弱収束し$\D u\_\e(x)$は$\D u(x)+\D\_y v(x, y)$に二スケール弱収束する。 あとはこの$u$, $v$が二スケール均質化方程式系の解になっていることを示せば、解の一意性より結論が従う。 滑らかな試験関数$\phi(x) \in H^1\_0(\Omega)$と$\psi \in L^2(\Omega; H^1(\TN))$を固定して、\eqref{e\_e\_eqw}の$\phi$として$\phi\_\e(x) = \phi(x)+\e\psi(x, y)$を代入すると

$$
\int_\Omega A(x, \frac{x}{\e})\D u_\e(x)\cdot\D \phi_\e(x)\dd{x} = \int_\Omega f(x)\phi_\e(x)\dd{x}
$$

つまり \begin{equation} \label{e\_e\_phie} \int\_\Omega A(x, \frac{x}{\e})\D u\_\e(x)\cdot(\D \phi(x)+\e\D\_x \psi(x, \frac{x}{\e})+\D\_y \psi(x, \frac{x}{\e}))\dd{x} = \int\_\Omega f(x)(\phi(x)+\e\psi(x, \frac{x}{\e}))\dd{x} \end{equation} ここで$A^t(x, y)(\D \phi(x)+\D\_y \psi(x, y))$は$L^2(\Omega; C(\TN))^N$に属するので、$A^t(x, \frac{x}{\e})(\D \phi(x)+\e\D\_x \psi(x, \frac{x}{\e})+\D\_y \psi(x, \frac{x}{\e}))$はそれに二スケール強収束する。 よって、\eqref{e\_e\_phie}で$\e \to 0$とすると、

$$
\int_\Omega \lrangle{A(x, y)(\D u(x)+\D_y v(x, y))\cdot(\D \phi(x)+\D_y \psi(x, y))}_y\dd{x} = \int_\Omega f(x)\phi(x)\dd{x}
$$

つまり\eqref{e\_lim\_eqw}を得る。 \end{proof}

さらに、もし二スケール均質化方程式系の解の規則性が上がるとよりよい収束性が言える。

\begin{theorem} もし$v(x, y)$と$\D\_x v(x, y)$（の各成分）と$\D\_y v(x, y)$（の各成分）が$L^2(\Omega; C(\TN))$に属するならば、 $u\_\e(x)-u(x)-\e v(x, \frac{x}{\e})$は$0$に$H^1(\Omega)$強収束する。 \end{theorem}

\begin{proof} 次の値

$$
\int_\Omega A(x, \frac{x}{\e})(\D(u_\e(x)-u(x)-\e v(x, \frac{x}{\e})))\cdot(\D(u_\e(x)-u(x)-\e v(x, \frac{x}{\e})))\dd{x}
$$

を考える。 この項のうち一つは、方程式の弱形式\eqref{e\_e\_eqw}で$\phi$として$u\_\e$を選ぶことで、

$$
\int_\Omega A(x, \frac{x}{\e})\D u_\e(x)\cdot\D u_\e(x)\dd{x} = \int_\Omega f(x)u_\e(x)\dd{x} \to \int_\Omega f(x)u(x)\dd{x}
$$

である。 それ以外の項は二スケール収束性を使うことと一様楕円性条件より

$$
\begin{aligned} &\limsup_{\e \to 0}\alpha\norm{\D(u_\e(x)-u(x)-\e v(x, \frac{x}{\e}))}_{L^2(\Omega)} \\ &\le \int_\Omega f(x)u(x)\dd{x}-\int_\Omega \lrangle{A(x, y)(\D u(x)+\D_y v(x, y))\cdot(\D u(x)+\D_y v(x, y))}_y\dd{x} \end{aligned}
$$

となり、二スケール均質化方程式系の弱形式\eqref{e\_lim\_eqw}で$(\phi, \psi) = (u, v)$とすることで、右辺は$0$であることがわかるので定理の証明が完成する。 \end{proof}

\section{種々の積分の計算}

この節では二スケール収束の原理\eqref{e\_tsconv\_p}を用いることで積分の極限に関する問題が簡単に解かれることを大学や大学院の入試問題を題材に紹介する。

\begin{example} 1989年の東京工業大学の入試問題

$$
\lim_{n \to \infty}\int_0^\pi x^2\abs{\sin n x}\dd{x}
$$

を考える。 この問題は$x^2 \sin n x$の原始関数が計算できることから解くことができるが、部分積分を2回使ったりしてから$n$の極限を取る必要があり、計算が煩わしい。 二スケール収束の原理（定理\ref{t\_tsconv\_p}）が使えたとしたら、$g(y) = \abs{\sin y}$の周期は$\pi$より、以下のように簡単に計算することができる。

$$
\lim_{n \to \infty}\int_0^\pi x^2\abs{\sin n x}\dd{x} = \int_0^\pi \frac{1}{\pi}\int_0^\pi x^2\abs{\sin y}\dd{y}\dd{x} = \frac{1}{\pi}\int_0^\pi x^2\dd{x}\int_0^\pi \sin y\dd{y} = \frac{1}{\pi}\cdot \frac{1}{3}\pi^3\cdot\lreval*{-\cos y}_0^\pi = \frac{2}{3}\pi^2.
$$

\end{example}

次の問題は積分の計算ができない（あるいは非常に難しい）場合である。

\begin{example} 1999年の東京工業大学の入試問題

$$
\lim_{n \to \infty}\int_0^{\frac{\pi}{2}} \frac{\sin^2 n x}{1+x}\dd{x}
$$

を考える。 この問題の標準的な解法はとりあえず半角の公式から$\sin^2 n x = \frac{1-\cos 2 n x}{2}$として、第2項の積分はリーマン・ルベーグの補題から$0$に収束するので、第1項の積分に帰着されるというものである。 実際には高校範囲で解くので、第2項の収束の部分は部分積分を駆使して示すことになるだろうか。 しかしながらこの問題も二スケール収束の原理が使えたとしたら簡単に解ける。 実際、$g(y) = \sin^2 y$の周期は$\pi$より、

$$
\lim_{n \to \infty}\int_0^{\frac{\pi}{2}} \frac{\sin^2 n x}{1+x}\dd{x} = \int_0^{\frac{\pi}{2}} \frac{1}{1+x}\dd{x}\frac{1}{\pi}\int_0^\pi \sin^2 y\dd{y} = \frac{1}{2}\log(1+\frac{\pi}{2}).
$$

ちなみにリーマン・ルベーグの補題も二スケール収束の原理から示される。 \end{example}

無限区間の積分の例としては次がある。

\begin{example} 2001年の京都大学の入試問題

$$
\lim_{n \to \infty}\int_0^{n \pi} e^{-x}\abs{\sin n x}\dd{x}
$$

を考える。 この問題も最初の例同様積分が計算できるのでその極限を考えればよいが、計算量が非常に多い。 二スケール収束の原理を使うにしてもこの問題では積分区間が$n$に依存してしまっているが、実際には極限の区間$\[0, \infty)$のみ最初から考えれば十分である。 つまり、$f(x, y) = e^{-x}\abs{\sin y}$とおくと$y$について周期$\pi$の連続関数であり、

$$
\int_0^\infty \sup_{y \in [0, \pi]}\abs{f(x, y)}\dd{x} = \int_0^\infty e^{-x}\dd{x} = 1 < \infty
$$

を満たす。 よって、

$$
\abs{\int_0^\infty f(x, n x)\dd{x}-\int_0^{n \pi} f(x, n x)\dd{x}} \le \int_{n \pi}^\infty \abs{f(x, n x)}\dd{x} \le \int_{n \pi}^\infty \sup_{y \in [0, \pi]}\abs{f(x, y)}\dd{x} \to 0 \quad (n \to \infty)
$$

となるので、

$$
\lim_{n \to \infty}\int_0^{n \pi} e^{-x}\abs{\sin n x}\dd{x} = \lim_{n \to \infty}\int_0^\infty e^{-x}\abs{\sin n x}\dd{x}
$$

がわかる。 よって、ルベーグ積分の枠組みだと二スケール収束の原理より直ちに

$$
\lim_{n \to \infty}\int_0^\infty e^{-x}\abs{\sin n x}\dd{x} = \int_0^\infty e^{-x}\dd{x}\frac{1}{\pi}\int_0^\pi \abs{\sin y}\dd{x} = \frac{2}{\pi}
$$

を得る。

なお、この積分をリーマン積分の枠組みでとらえて広義積分だと思っても同じ公式が成り立つ。 実際、$R > 0$に対して

$$
\begin{aligned} &\abs{\int_0^\infty f(x, n x)\dd{x}-\int_0^\infty \lrangle{f(x, y)}_y\dd{x}} \\ &\le \abs{\int_0^\infty f(x, n x)\dd{x}-\int_0^R f(x, n x)\dd{x}} +\abs{\int_0^R f(x, n x)\dd{x}-\int_0^R \lrangle{f(x, y)}_y\dd{x}} +\abs{\int_0^R \lrangle{f(x, y)}_y\dd{x}-\int_0^\infty \lrangle{f(x, y)}_y\dd{x}} \\ &\le 2\int_R^\infty \sup_{y \in [0, 1]}\abs{f(x, y)}\dd{x}+\abs{\int_0^R f(x, n x)\dd{x}-\int_0^R \lrangle{f(x, y)}_y\dd{x}} \end{aligned}
$$

と評価できるためである。 \end{example}

この問題をさらに難しくした次の問題を読者に出題する。

\begin{xca} 次の値を求めよ。

$$
\lim_{n \to \infty}\int_0^n \frac{1}{1+e^x+\sin 2\pi n x}\dd{x}.
$$

\end{xca}

最後に変数分離型の二スケール収束の原理を使う問題を紹介する。

\begin{example} 2016年の京都大学大学院理学研究科の入試問題

$$
\lim_{n \to \infty}\int_0^\infty e^{-x}(n x-\lrfloor{n x})\dd{x}
$$

を考える。 この問題では関数$g(y) = y-\lrfloor{y}$は$y$について周期$1$の関数であるが連続ではない。 しかしながら$L^\infty(\T)$なので定理\ref{t\_tsconv\_p\_sep}が使えて、

$$
\lim_{n \to \infty}\int_0^\infty e^{-x}(n x-\lrfloor{n x})\dd{x} = \int_0^\infty e^{-x}\dd{x}\int_0^1 y\dd{y} = \frac{1}{2}
$$

である。 \end{example}



## 内容

1. はじめに
2. 二スケール収束の原理
3. 二スケール収束とその性質
4. 均質化への応用
5. 種々の積分の計算
6. 参考文献
