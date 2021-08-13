### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ a2ab3cc0-f51d-11eb-2754-0f0cc09b54d5
begin
	using Pkg
	Pkg.activate(".")
end

# ╔═╡ 9166f85a-d7aa-4c0f-850b-29037e38ffe1
begin
	using CairoMakie
	using Unitful
	using LaTeXStrings
	using Latexify
	using UnitfulLatexify
	using PlutoUI
	using HypertextLiteral
	TableOfContents(title = "Índice", depth = 4)
end

# ╔═╡ e4a32b50-e6a8-4e8c-b5af-dc8903374abf
md"""
## 1.6. Movimento Retilíneo Uniformemente Variado (MRUV)

Dizemos que um objeto tem movimento retilíneo uniformemente variado, quando sua velocidade varia de maneira uniforme. Vamos começar a análise desse tipo de movimento, a partir da análise de como a velocidade varia com o tempo. 

### 1.6.1. Velocidade em função do tempo no MRUV

No MRUV, a velocidade do objeto varia com o tempo de modo uniforme, da mesma forma que a posição de um objeto em MRU também varia de modo uniforme. 

> Isso quer dizer, que para todo intervalo de tempo determinado e igual a ``\Delta t``, a velocidade terá a mesma variação ``\Delta v``.

Portanto, o gráfico que representa a velocidade em função do tempo no MRUV é o mesmo tipo de gráfico que representa a posição em função do tempo no MRU. 

##### Exemplo 1

O gráfico abaixo nos mostra um exemplo de como a velocidade varia com o tempo no MRUV:
"""

# ╔═╡ 361ca368-d960-4416-87ba-58e0a71e27fc
md"""
O gráfico acima no mostra que:

- a velocidade inicial do objeto (em ``t = 0``) é ``v_0 = 10\,``m/s;
- a velocidade do objeto está sempre aumentanto no intervalo entre ``0`` e ``20\,``s;
- a velocidade do objeto aumenta sempre da mesma forma no intervalo mostrado: ``6\,``m/s a cada ``2\,``s, ou ``3\,``m/s a cada ``1\,``s.

Podemos ver que o tipo de função que representada no gráfico acima é uma função de ``1^{\circ}``. grau ou função afim, que pode ser escrita na forma: 

``f(x) = ax + b``.

No caso acima, temos a velocidade em função do tempo ou ``v(t)``. O coeficiente ``b`` é o valor de ``v`` quando ``t=0``, ou seja, é a velocidade inicial do objeto ``v_0``. Já o coeficiente ``a`` é o coeficiente angular (ou inclinação) da reta. Mas antes de calculá-lo, vamos entender melhor o significado da inclinação da reta. 

#### A inclinação da reta em um gráfico de velocidade x tempo

A próxima figura mostra como a velocidade de vários objetos varia com o tempo. Todos as retas na figura tem inclinações diferentes.
"""

# ╔═╡ 7d0f9474-2aca-4380-89af-34f87ef29f44
md"""
Selecionar instante de tempo t em segundos no qual se deseja visualizar as velocidades:

$(@bind tslider1 PlutoUI.Slider(0:20; default=10, show_value=true))
"""

# ╔═╡ 49268f24-07e3-4397-8217-7a5e4a2ed573
md"""
O gráfico acima nos mostra que:
- todos os objetos mostrados no gráfico têm a mesma velocidade inicial positiva ``v_0 = 10\,``m/s; 
- os objetos 1, 2 e 3 têm suas velocidades sempre positivas e aumentando com o tempo de forma uniforme - retas com inclinações positivas;
- dentre os objetos 1, 2 e 3, o que tem a velocidade aumentando mais rapidamente é o objeto 2, que possui a reta mais inclinada; e o objeto que tem a velocidade aumentando mais lentamente é o objeto 3, que possui a reta menos inclinada;
- o objeto 4 tem velocidade constante, ou seja, está em MRU;
- os objetos 5 e 6 começam com velocidades positivas, mas têm as velocidades sempre diminuindo de maneira uniforme com o tempo - retas com inclinações negativas;
- a velocidade do objeto 6 diminui de forma mais rápida que a velocidade do objeto 5 - a reta do objeto 6 é mais inclinada negativamente que a reta do objeto 5.

A inclinação das retas estão, portanto, diretamente relacionadas à rapidez com que as velocidades variam positivamente ou negativamente. 

>A grandeza que representa a variação da velocidade com o tempo é a aceleração, e ela representa a rapidez com que a velocidade aumenta ou diminui com o passar do tempo!

Assim sendo, a inclinação da reta em um gráfico de velocidade x tempo de um certo objeto representa a **aceleração** (``a``) deste objeto. Na imagem acima, temos então:

- os objetos 1, 2 e 3 têm aceleração positiva, sendo que: ``a_2 > a_1 > a_3 > 0``;
- o objeto 4 tem aceleração nula: ``a_4 = 0``;
- os objetos 5 e 6 têm acelerações negativas, sendo que: ``a_6 < a_5 < 0``.
"""

# ╔═╡ ae26a5dd-95eb-4bae-b480-745fe55009e2
md"""
#### Calculando a aceleração (inclinação) a partir do gráfico de velocidade x tempo
"""

# ╔═╡ bbf30093-cf7c-4df5-b9b5-3a2160950b03
@bind sortear01 PlutoUI.Button("Sortear pontos!")

# ╔═╡ 6b18aba3-1562-4d49-b68f-0618ee1038fd
begin 
	sortear01
	
	t_rand_ex1 = sort(rand(0:20, 2))
	while t_rand_ex1[1] == t_rand_ex1[2]
		t_rand_ex1 = sort(rand(0:20, 2))
	end
	xticks_ex3 = unique(sort(vcat(collect(0:10:20), t_rand_ex1)))
end;

# ╔═╡ a4ce99fc-34de-4ede-99f6-ac44b6f6f36f
md"""
A aceleração é a inclinação da reta acima. Para encontrá-la devemos selecionar dois pontos quaisquer da reta, descobrir a variação da velocidade ``\Delta v`` entre esses dois pontos, e dividir a variação da velocidade pelo tempo que passou ``\Delta t`` entre os dois instantes de tempo. Por exemplo, utilizando os dois pontos indicados na figura acima:
"""

# ╔═╡ 5241c460-4ff3-4174-a632-2186bb668e94
md"""
Utilizando a equação da velocidade instantânea conseguimos descobrir a velocidade em qualquer instante de tempo ``t`` que se queira. Por exemplo, no instante
"""

# ╔═╡ c88d0990-f3f9-4918-ae97-330094055b62
md"""
a velocidade do objeto do exemplo 1 será:
"""

# ╔═╡ 443192a9-999c-4263-87a4-de232cc700ca
md"""
### 1.6.2. A aceleração em função do tempo no MRUV

Já vimos que a aceleração no MRUV é constante e não varia com o tempo. Dessa forma, o gráfico que representa a aceleração em função do tempo é o mesmo gráfico de uma função constante. Para o exemplo com que estamos trabalhando, temos o gráfico abaixo:
"""

# ╔═╡ f32e93b4-d8bb-408d-b5ef-63b1002f87f2
md"""
A função que representa a aceleração em função do tempo é:

```math
a(t) = a_0,
```

onde ``a_0`` é a **aceleração** do objeto que é **constante!** Para o caso acima:
"""

# ╔═╡ 28f6cc46-05a7-46f3-8c09-e5710b9fdcef
md"""
Como vimos anteriormente, o gráfico de velocidade em função do tempo para o MRU também é o gráfico de uma função constante. E a área do gráfico de velocidade x tempo, delimitada por dois instantes ``t_1`` e ``t_2`` representa o deslocamento do objeto (``\Delta S``) entre ``t_1`` e ``t_2``.

No gráfico de aceleração por tempo, a área delimitada pela reta que representa a aceleração, o eixo do tempo, e os instantes ``t_1`` e ``t_2`` também tem um significado físico. Para descobrir esse signifcado vamos calcular essa área.

#### A área no gráfico de aceleração x tempo
"""

# ╔═╡ 5337dcf1-9de7-4dfd-9389-bc93e145fe73
md"""
que é exatamente a mesma variação de velocidade ``\Delta v`` entre ``t_1`` e ``t_2`` encontrada no gráfico de ``v(t)``. 
"""

# ╔═╡ 0b585fae-3a3a-4630-8b8c-0fc3a0bdcf48
md"""
Com a ajuda desse gráfico conseguimos encontrar a variação da velocidade entre quaisquer dois instantes de tempo dentro de seu domínio. Entretanto, ele não nos fornece as informações necessárias para calcular a velocidade em nenhum instante de tempo. Lembre-se

```math
v(t) = v_0 + a \cdot t,
```

e o gráfico nos fornece apenas o valor de ``a`` e não temos nenhuma informação sobre a velocidade inicial ``v_0``, o que nos impede de encontrar uma equação de ``v(t)``. Mas, por exemplo, se sabemos que
"""

# ╔═╡ 707593a9-9503-43ec-95d5-eaaf88158a58
md"""
e conhecendo o valor de ``a``, podemos encontrar o valor de ``v_0`` para a equação:
"""

# ╔═╡ 4292155c-eae0-4317-bebf-6734e58ba146
begin
	#função que calcula a velocidade em função do tempo no MRUV
	vel(t, v0, a) = v0 + a*t
	
	function trocarpontovirgtexto(x::Real; digits = 1)
		x_arr = (digits == 0 ? round(Int, x) : round(x; digits = digits))
		replace(string(x_arr), "." => ",")
	end
	
	function trocarpontovirglatex(x::Real; digits = 1)
		x_arr = (digits == 0 ? round(Int, x) : round(x; digits = digits))
		replace(string(x_arr), "." => "{,}")
	end
end

# ╔═╡ c9b8b4ff-da94-4dfb-826b-4be6e2d1682a
begin
	#velocidade inicial: exemplo 1
	v0_ex1 = 10
	
	#aceleração: exemplo 1
	ac_ex1 = 3.0
	
	#velocidade em função do tempo para o exemplo 1
	v_ex1(t) = vel(t, v0_ex1, ac_ex1)
end;

# ╔═╡ 44bcbefd-1544-468f-8fbc-c7bd42285d03
begin
	fig_ex1 = Figure(resolution = (800, 800))
	ax_ex1 = fig_ex1[1, 1] = Axis(fig_ex1,
		title = "Velocidade em função do tempo",
		xlabel = "Tempo (s)",
		xticks = 0:2:20,
		ylabel = "velocidade (m/s)",
		yticks = v_ex1.(0:2:20))
	
	lines!(ax_ex1, 0:10:20, v_ex1,
		color = :dodgerblue,
		linewidth = 2)
	
	limits!(ax_ex1, 0, 20, 0, v_ex1(20))
	
	fig_ex1
end

# ╔═╡ 263b70a6-3c7d-46a3-9132-2fe9a31af7d8
begin
	fig_ex4 = Figure(resolution = (800, 800))
	ax_ex4 = fig_ex4[1, 1] = Axis(fig_ex4,
		title = "Aceleração em função do tempo",
		xlabel = "Tempo (s)",
		xticks = 0:2:20,
		ylabel = "aceleração (m/s²)",
		yticks = 0:1:(ac_ex1+2))
	
	lines!(ax_ex4, [0, 20], [ac_ex1, ac_ex1],
		color = :green,
		linewidth = 2)
	
	limits!(ax_ex4, 0, 20, 0, ac_ex1 + 2)
	
	fig_ex4
end

# ╔═╡ 78f6a4b5-fcbd-4bb4-8ebf-1044870a0a15
begin
	a_ex1_arr = [ac_ex1, 2*ac_ex1, 0.5*ac_ex1, 0.0, -ac_ex1, -1.5*ac_ex1]
	v_ex2(t) = vel(t, v0_ex1, 2*ac_ex1)
	fig_ex2 = Figure(resolution = (800, 800))
	ax_ex2 = fig_ex2[1, 1] = Axis(fig_ex2,
		title = "Comparando as inclinações das retas \n em um gráfico de velocidade em função do tempo",
		xlabel = "Tempo (s)",
		xticks = 0:2:20,
		ylabel = "velocidade (m/s)",
		yticks = -80:10:80)
	hlines!(ax_ex2, [0], color = :black, linewidth = 2)
	vlines!(ax_ex2, [tslider1], color = :black, linestyle = :dash, linewidth = 2)
	
	cc_obj = 1
	for aa ∈ a_ex1_arr
		vv = vel.([0, 10, 20], v0_ex1, aa)
		llabel = "Objeto " * string(cc_obj)
		lines!(ax_ex2, 0:10:20, vv, linewidth = 3, label = llabel)
		scatter!(ax_ex2, Point2(tslider1, vel(tslider1, v0_ex1, aa)), markersize = 12)
		global cc_obj += 1
	end
	
	axislegend(ax_ex2, position = :lb)
	limits!(ax_ex2, 0, 20, -80, 80)
	
	fig_ex2
end

# ╔═╡ 21cd9ece-7a09-4915-a1d9-417f103d67e0
begin
	v_trand_ex1 = v_ex1.(t_rand_ex1)
	Δv_ex3 = v_trand_ex1[2] - v_trand_ex1[1]
	Δv_str = "Δv = $(trocarpontovirgtexto(Δv_ex3; digits = 0)) m/s"
	Δt_str = "Δt = $(trocarpontovirgtexto(t_rand_ex1[2] - t_rand_ex1[1]; digits = 0)) s"
	
	fig_ex3 = Figure(resolution = (800, 800))
	ax_ex3 = fig_ex3[1, 1] = Axis(fig_ex3,
		title = "Velocidade em função do tempo",
		xlabel = "Tempo (s)",
		xticks = xticks_ex3,
		ylabel = "velocidade (m/s)",
		yticks = v_ex1.(xticks_ex3))
	
	lines!(ax_ex3, 0:10:20, v_ex1,
		color = :dodgerblue,
		linewidth = 2)
	scatter!(ax_ex3, t_rand_ex1, v_ex1, 
		color = :red,
		markersize = 12)
	hlines!(ax_ex3, [v_trand_ex1[1]],
		color = (:red, 0.7), linewidth = 2,
		linestyle = :dash, 
		xmin = (t_rand_ex1[1]/20), xmax = (t_rand_ex1[2]/20))
	vlines!(ax_ex3, [t_rand_ex1[2]],
		color = (:red, 0.7), linewidth = 2,
		linestyle = :dash,
		ymin = (v_trand_ex1[1]/v_ex1(20)),
		ymax = (v_trand_ex1[2]/v_ex1(20)))
	
	text!(ax_ex3, Δv_str,
		position = (t_rand_ex1[2] + 0.2, (v_trand_ex1[1] + v_trand_ex1[2])/2),
		align = (:center, :baseline),
		color = :red,
		rotation = -π/2,
		textsize = 18)
	
	text!(ax_ex3, Δt_str,
		position = ((t_rand_ex1[1] + t_rand_ex1[2])/2, v_trand_ex1[1] - 1),
		align = (:center, :top),
		color = :red,
		textsize = 18)
	
	limits!(ax_ex3, 0, 20, 0, v_ex1(20))
	
	fig_ex3
end

# ╔═╡ cc8979b5-ad64-42c1-8fa8-995ba54881a1
latexstring("a = \\frac{\\Delta v}{\\Delta t} = \\frac{$(trocarpontovirglatex(Δv_ex3; digits = 0))\\,{\\rm m/s}}{$(trocarpontovirglatex(t_rand_ex1[2] - t_rand_ex1[1]; digits = 0))\\,{\\rm s}} = $(trocarpontovirglatex(ac_ex1; digits = 1))\\,{\\rm \\frac{m}{s^2}}.")

# ╔═╡ 9c3e22d9-ce21-4d02-8909-72c9f3b02a4d
md"""
E é possível notar, sorteando os pontos, que no caso do MRUV a aceleração é sempre a mesma, independente dos pontos sorteados para calculá-la, por isso não importa os dois pontos escolhidos. **No MRUV a aceleração é constante!**

> A unidade de aceleração no Sistema Internacional de Unidades é o ``{\rm m \, s^{-2}}`` ou ``{\rm m/s^2}``.

A aceleração de $(trocarpontovirgtexto(ac_ex1, digits = 1))``\, {\rm m/s^2}`` encontrada no exemplo acima significa que a velocidade varia $(trocarpontovirgtexto(ac_ex1, digits = 1))``\,{\rm m/s}`` a cada 1``\,{\rm s}`` (1 segundo) que passa.

#### Velocidade instantânea, ``v(t)``

Agora, temos todas as informações necessárias para encontrar a equação da velocidade instantânea ou ``v(t)`` para o objeto do exemplo 1. A equação tem a seguinte forma:

```math
v(t) = v_0 + a \cdot t,
```

onde, como já dissemos anteriormente, ``v_0`` é a velocidade inicial do objeto e ``a`` é o coeficiente angular ou inclinação da reta, que no caso do gráfico de velocidade por tempo é igual a aceleração do objeto ``a``. Assim sendo a equação da velocidade para o caso do **exemplo 1** é:
"""

# ╔═╡ c881dd52-f6e6-4332-80cd-c4b4507c6812
latexstring("\\boxed{v(t) = $v0_ex1 {\\rm \\, \\frac{m}{s}} + $(trocarpontovirglatex(ac_ex1)) {\\rm \\, \\frac{m}{s^2}} \\cdot t}")

# ╔═╡ ccef033e-ae22-4863-9743-97021f24aef4
begin
	tt_ex1 = rand(0:0.1:20)*1u"s"
	vel(tt_ex1, v0_ex1*1u"m/s", ac_ex1*1u"m/s^2")
	fmt(x) = replace(string(x), "." => "{,}")
	latexify(:(t = $tt_ex1); fmt = fmt)
end

# ╔═╡ d532bfe6-cf83-48f9-9ed1-ba3e06d83e6b
latexstring("v($(trocarpontovirglatex(ustrip(tt_ex1))){\\rm \\, s}) = $v0_ex1 {\\rm \\, \\frac{m}{s}} + $(trocarpontovirglatex(ac_ex1)) {\\rm \\, \\frac{m}{s^2}} \\cdot $(trocarpontovirglatex(ustrip(tt_ex1))){\\rm \\, s},")

# ╔═╡ 1944bdfa-80db-4778-ad58-8e85aa670e61
latexstring("v($(trocarpontovirglatex(ustrip(tt_ex1))){\\rm \\, s}) = $v0_ex1 {\\rm \\, \\frac{m}{s}} + $(trocarpontovirglatex(ac_ex1 * ustrip(tt_ex1))){\\rm \\, \\frac{m}{s}} = $(trocarpontovirglatex(v_ex1(ustrip(tt_ex1)))){\\rm \\, \\frac{m}{s}}.")

# ╔═╡ 44159ff5-078a-457c-9200-bd423f7ac92c
latexstring("a(t) = $(trocarpontovirglatex(ac_ex1)) {\\rm \\, \\frac{m}{s^{2}}}.")

# ╔═╡ e5e3c53d-9fb7-43ef-9fa8-889e082a92c6
md"""
A figura delimitada pela reta que representa a aceleração constante, o eixo do tempo, e ``t_1 =`` $(t_rand_ex1[1]) s e ``t_2 =`` $(t_rand_ex1[2]) s é um retângulo. A base do retângulo vale ``\Delta t = t_2 - t_1 =`` $(t_rand_ex1[2] - t_rand_ex1[1]) s, e sua altura vale ``a = `` $(trocarpontovirgtexto(ac_ex1)) m/s². Assim sendo, a área desse retângulo é: 

```math
{\rm área} = a \cdot \Delta t,
```

mas já vimos que

```math
a = \frac{\Delta v}{\Delta t} \therefore \Delta v = a \cdot \Delta t,
```

ou seja, a área do gráfico acima representa a variação da velocidade ``\Delta v`` entre os instantes ``t_1`` e ``t_2``: 
"""

# ╔═╡ 438f587e-b2cc-4cc2-bf77-2eda8e7944a2
begin
	Δv_area = ac_ex1 * (t_rand_ex1[2] - t_rand_ex1[1])
	fig_ex5 = Figure(resolution = (800, 800))
	ax_ex5 = fig_ex5[1, 1] = Axis(fig_ex5,
		title = "Aceleração em função do tempo",
		xlabel = "Tempo (s)",
		xticks = xticks_ex3,
		ylabel = "aceleração (m/s²)",
		yticks = 0:1:(ac_ex1+2))
	
	lines!(ax_ex5, [0, 20], [ac_ex1, ac_ex1],
		color = :green,
		linewidth = 2)
	band!(ax_ex5, t_rand_ex1, [0, 0], [ac_ex1, ac_ex1],
		color = (:dodgerblue, 0.5))
	vlines!(ax_ex5, [t_rand_ex1[1]], ymin = 0, ymax = (ac_ex1/(ac_ex1+2)),
		color = :green, linestyle = :dash, linewidth = 2)
	vlines!(ax_ex5, [t_rand_ex1[2]], ymin = 0, ymax = (ac_ex1/(ac_ex1+2)),
		color = :green, linestyle = :dash, linewidth = 2)
	
	text!(ax_ex5, "Δt = $(diff(t_rand_ex1)[1]) s",
		position = ((t_rand_ex1[1] + t_rand_ex1[2])/2, 1.01*ac_ex1),
		align = (:center, :bottom),
		color = :green)
	
	text!(ax_ex5, "área = Δv = $(trocarpontovirgtexto(Δv_area; digits = 0)) m/s", 
		position = ((t_rand_ex1[1] + t_rand_ex1[2])/2, ac_ex1/2),
		rotation = π/4,
		align = (:center, :center),
		color = :blue)
	
	limits!(ax_ex5, 0, 20, 0, ac_ex1 + 2)
	
	fig_ex5
end

# ╔═╡ f6e581ba-324f-4380-84ce-2617679b9806
latexstring("\\Delta v_{1,2} = a \\cdot \\Delta t_{1,2} = $(trocarpontovirglatex(ac_ex1)) {\\rm \\, \\frac{m}{s^{\\bcancel{2}}}} \\cdot $(trocarpontovirglatex(t_rand_ex1[2] - t_rand_ex1[1]; digits = 0)) {\\rm \\, \\cancel{s}} = $(trocarpontovirglatex(Δv_area; digits = 0)) {\\rm \\, \\frac{m}{s}},")

# ╔═╡ 4f8b1493-b666-4e68-ae96-112d4196c04b
latexstring("v($(trocarpontovirglatex(ustrip(tt_ex1))){\\rm \\, s}) = $(trocarpontovirglatex(v_ex1(ustrip(tt_ex1)))){\\rm \\, \\frac{m}{s}},")

# ╔═╡ 65d25cba-b773-4f46-a21a-05114cdd99da
latexstring("v($(trocarpontovirglatex(ustrip(tt_ex1))){\\rm \\, s}) = v_0 + $(trocarpontovirglatex(ac_ex1)) {\\rm \\, \\frac{m}{s^2}} \\cdot $(trocarpontovirglatex(ustrip(tt_ex1))){\\rm \\, s} = $(trocarpontovirglatex(v_ex1(ustrip(tt_ex1)))){\\rm \\, \\frac{m}{s}}")

# ╔═╡ acaf5d72-cb9a-414e-bc23-ce0aae923f36
latexstring("v_0 + $(trocarpontovirglatex(ac_ex1 * ustrip(tt_ex1))){\\rm \\, \\frac{m}{s}} = $(trocarpontovirglatex(v_ex1(ustrip(tt_ex1)))){\\rm \\, \\frac{m}{s}},")

# ╔═╡ bc0f2216-6180-493c-a7ed-e95ea1448cb6
latexstring("v_0 = $(trocarpontovirglatex(v_ex1(ustrip(tt_ex1)))){\\rm \\, \\frac{m}{s}} - $(trocarpontovirglatex(ac_ex1 * ustrip(tt_ex1))){\\rm \\, \\frac{m}{s}} = $(trocarpontovirglatex(v0_ex1)) {\\rm \\, m/s}.")

# ╔═╡ Cell order:
# ╟─a2ab3cc0-f51d-11eb-2754-0f0cc09b54d5
# ╟─9166f85a-d7aa-4c0f-850b-29037e38ffe1
# ╟─e4a32b50-e6a8-4e8c-b5af-dc8903374abf
# ╟─c9b8b4ff-da94-4dfb-826b-4be6e2d1682a
# ╟─44bcbefd-1544-468f-8fbc-c7bd42285d03
# ╟─361ca368-d960-4416-87ba-58e0a71e27fc
# ╟─78f6a4b5-fcbd-4bb4-8ebf-1044870a0a15
# ╟─7d0f9474-2aca-4380-89af-34f87ef29f44
# ╟─49268f24-07e3-4397-8217-7a5e4a2ed573
# ╟─ae26a5dd-95eb-4bae-b480-745fe55009e2
# ╟─bbf30093-cf7c-4df5-b9b5-3a2160950b03
# ╟─6b18aba3-1562-4d49-b68f-0618ee1038fd
# ╟─21cd9ece-7a09-4915-a1d9-417f103d67e0
# ╟─a4ce99fc-34de-4ede-99f6-ac44b6f6f36f
# ╟─cc8979b5-ad64-42c1-8fa8-995ba54881a1
# ╟─9c3e22d9-ce21-4d02-8909-72c9f3b02a4d
# ╟─c881dd52-f6e6-4332-80cd-c4b4507c6812
# ╟─5241c460-4ff3-4174-a632-2186bb668e94
# ╟─ccef033e-ae22-4863-9743-97021f24aef4
# ╟─c88d0990-f3f9-4918-ae97-330094055b62
# ╟─d532bfe6-cf83-48f9-9ed1-ba3e06d83e6b
# ╟─1944bdfa-80db-4778-ad58-8e85aa670e61
# ╟─443192a9-999c-4263-87a4-de232cc700ca
# ╟─263b70a6-3c7d-46a3-9132-2fe9a31af7d8
# ╟─f32e93b4-d8bb-408d-b5ef-63b1002f87f2
# ╟─44159ff5-078a-457c-9200-bd423f7ac92c
# ╟─28f6cc46-05a7-46f3-8c09-e5710b9fdcef
# ╟─e5e3c53d-9fb7-43ef-9fa8-889e082a92c6
# ╟─f6e581ba-324f-4380-84ce-2617679b9806
# ╟─5337dcf1-9de7-4dfd-9389-bc93e145fe73
# ╟─438f587e-b2cc-4cc2-bf77-2eda8e7944a2
# ╟─0b585fae-3a3a-4630-8b8c-0fc3a0bdcf48
# ╟─4f8b1493-b666-4e68-ae96-112d4196c04b
# ╟─707593a9-9503-43ec-95d5-eaaf88158a58
# ╟─65d25cba-b773-4f46-a21a-05114cdd99da
# ╟─acaf5d72-cb9a-414e-bc23-ce0aae923f36
# ╟─bc0f2216-6180-493c-a7ed-e95ea1448cb6
# ╟─4292155c-eae0-4317-bebf-6734e58ba146
