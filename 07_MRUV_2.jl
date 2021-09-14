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

# ╔═╡ b97b14ae-fac3-11eb-0e21-95ed6e98a537
begin
	using Pkg
	Pkg.activate(".")
end

# ╔═╡ e4221b18-274a-4114-9f5f-bb9c2b443c05
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

# ╔═╡ 9d96643d-d414-4c52-bf87-8cdde91f4c95
md"""
### 1.6.3. Deslocamento em função do tempo no MRUV

Como vimos ao estudar MRU, em um gráfico de velocidade em função do tempo, a área entre a reta que indica a velocidade do objeto e o eixo do tempo, delimitada pelos instante de tempo ``t_1`` e ``t_2`` representa o deslocamento do objeto entre estes instantes. No caso do MRU, a figura da qual desejamos calcular a área é um retângulo. Já no caso do MRUV, a figura pode ser um triângulo ou um trapézio.

#### Aréa do gráfico de velocidade x tempo no MRUV

Para  objeto do exemplo que estamos estudando, cuja velocidade pode ser encontrada com:

```math
v(t) = 10{\rm \, \frac{m}{s}} + 3{,}0{\rm \, \frac{m}{s^2}} \cdot t,
```

temos o gráfico abaixo.
"""

# ╔═╡ 29512667-0484-48a7-b0e5-fb9bfe810dbc
md"""
Selecionar instante de tempo inicial em segundos (s):
$(@bind t1_ex01 PlutoUI.NumberField(0:19; default = 6))

Selecionar instante de tempo final em segundos (s):
$(@bind t2_ex01 PlutoUI.NumberField(1:20; default = 17))
"""

# ╔═╡ d5936e80-3c9a-4b6d-95e0-69eece2f586d
md"""
#### A equação de deslocamento em função do tempo no MRUV, ``\Delta s(t)``

O processo acima pode ser repetido para qualquer intervalo de tempo para obter o deslocamento do objeto naquele intervalo.

Utilizando o método acima podemos encontrar uma fórmula mais geral para calcular o deslocamento do objeto em função do tempo.

```math
\Delta s_{t_0, t_1} = \frac{(v_0 + v_1)(t_1 - t_0)}{2},
```

se ``t_0 = 0``, então ``v_0`` é a velocidade inicial e ``v_1`` é a velocidade no instante ``t_1``. ``\Delta s_{t_0, t_1}`` será o deslocamento de ``t_0 = 0`` até ``t_1``, que será nosso deslocamento em função de ``t_1``. Então:

```math
\Delta s(t_1) = \frac{(v_0 + v_1)\cdot t_1}{2}.
```

Sabemos que

```math
v_1 = v_0 + a \cdot t_1,
```

e podemos substituir esse valor de ``v_1`` na equação de ``\Delta s(t_1)``:

```math
\Delta s(t_1) = \frac{(v_0 + \overbrace{v_0 + a \cdot t_1}^{v_1})\cdot t_1}{2} = \frac{(2v_0 + a \cdot t_1) \cdot t_1}{2}.
```

Podemos simplificar a fórmula acima, e reescrevê-la como:

```math
\Delta s(t_1) = v_0 \cdot t_1 + \frac{a \cdot t_1^2}{2}.
```

Com essa fórmula podemos calcular o deslocamento de um objeto de ``t=0`` até um instante ``t_1`` qualquer. E para utilizá-la precisamos conhecer apenas a velocidade inicial e a aceleração do objeto, assim como na equação de ``v(t)``.

Ao invés de escrever o deslocamento em função de ``t_1``, podemos escrever como função de ``t``, e a equação terá sua forma final:

```math
\boxed{\Delta s(t) = v_0 \cdot t + \frac{a \cdot t^2}{2}.}
```

> A equação acima é uma equação de 2o. grau, também conhecida como equação quadrática.

"""

# ╔═╡ 7440b5b7-9f60-4254-88f7-cd49badcf3a0
md"""
Para o objeto do exemplo, podemos substituir sua velocidade inicial e aceleração pelos valores que já conhecemos, e então:

```math
\Delta s(t) = 10{\rm \, \frac{m}{s}} \cdot t + \frac{3{,}0}{2}\frac{m}{s^2} \cdot t^2
```

Podemos agora, calcular o deslocamento do objeto do exemplo em qualquer instante de tempo. Em todos os casos, o deslocamento será zero em ``t=0``:

```math
\Delta s(0) = 0.
```
"""

# ╔═╡ 425096eb-4cd5-4f52-bc26-2374b2682575
md"
Para ``t=1{\rm \, s}``:
"

# ╔═╡ db548d9f-34c0-436c-9458-9e9366056eca
md"
Para ``t=2{\rm \, s}``:
"

# ╔═╡ e22a4467-a239-4af4-9e2b-b99ad87b8664
md"
Para ``t=3{\rm \, s}``:
"

# ╔═╡ 1b349553-af5d-420e-ba5b-e81d13d6d009
md"""
Calculando o deslocamento de 0 a 20 s, e colocando em um gráfico encontramos o gráfico de deslocamento por tempo abaixo:
"""

# ╔═╡ 7aa79362-92e0-466d-9559-7ee48cf6e429
md"""
Mostrar linhas: $(@bind mostra_linhas_2 PlutoUI.CheckBox())
"""

# ╔═╡ aed82fc0-95d2-4957-a67a-a3d7da8f9a92
md"""
Os pontos não estão em uma linha reta como nos gráfico anteriores. A sequência de pontos forma um tipo de curva característica de funções quadráticas que é chamada de parábola.

"""

# ╔═╡ 759b278c-87f7-462a-a106-35da3153318c
md"""
### 1.6.4. Posição em função do tempo no MRUV

A equação da posição em função do tempo sempre pode ser escrita como

```math
s(t) = s_0 + \Delta s(t).
```

E acabamos de descobrir como achar ``\Delta s(t)`` no MRUV, então a equação de posição fica:

```math
s(t) = s_0 + v_0 \cdot t + \frac{1}{2} a \cdot t^2
```

Apesar de conhecermos a equação do deslocamento em função do tempo, apenas com essa equação não é possível descobrir a posição do objeto. Para encontrar a equação que descreve a posição do objeto em função do tempo, precisamos conhecer a posição do objeto em pelo menos um instante de tempo.

Por exemplo, para o caso que estamos analisando, não sabemos a posição inicial do objeto, mas podemos descobrí-la se soubermos a posição do objeto em um certo instante. **Vamos supor, então, que no instante ``t = 10{\rm \, s}`` o objeto do exemplo está na posição:**

```math
s(10{\rm \, s}) = 150{\rm \, m}.
```

Com essa informação é possível encontrar a posição inicial do objeto, e assim encontrar a equação que descreve sua posição.
"""

# ╔═╡ f0a1a0a0-f8cd-4dd8-8e71-fcc7cf8600ef
latexify(:(s_0 + $(Δs1u(10u"s")) = $(150u"m")))

# ╔═╡ 6f29f4f4-3772-4d4f-9417-198501166a79
latexify(:(s_0 = $(150u"m") - $(Δs1u(10u"s")) = $(150u"m" - Δs1u(10u"s"))))

# ╔═╡ da83b8b6-d851-4792-ae1e-5eef8ccb7af7
md"""
A equação de posição para o objeto é:

```math
s(t) = -100{\rm \, m} + 10{\rm \, \frac{m}{s}} \cdot t + \frac{3{,}0}{2}\frac{m}{s^2} \cdot t^2
```
"""

# ╔═╡ 3f8bc0fc-5a2b-402a-aed2-df18aa93291a
md"""
### 1.6.5. As equações do movimento

Para caracterizar completamente o movimento de um objeto, temos que ter a função que descreve sua posição em função do tempo, ``s(t)``; a função que descreve sua velocidade em função do tempo, ``v(t)``; e finalmente a função que descreve sua aceleração em função do tempo, ``a(t)``.

#### Exemplo 1

Temos todas as informações necessárias para descrever completamente o movimento do objeto do **Exemplo 1**:

```math
\boxed{s(t) = -100{\rm \, m} + 10{\rm \, \frac{m}{s}} \cdot t + \frac{3{,}0}{2}\frac{m}{s^2} \cdot t^2,}
```

```math
\boxed{v(t) = 10{\rm \, \frac{m}{s}} + 3{,}0{\rm \, \frac{m}{s^2}} \cdot t,}
```

```math
\boxed{a(t) = 3{,}0{\rm \, \frac{m}{s^2}}.}
```

Com todas essas informações, foi possível criar a animação abaixo que nos mostra como é o movimento desse objeto, e como sua posição e velocidade variam à medida que ele se movimenta:
"""

# ╔═╡ 1cf14f34-547d-4a71-929e-d3677bfe5206
md"""
#### Exemplo 2

No exemplo acima, a velocidade é crescente e é sempre positiva. Na próxima animação podemos ver o que acontece com o movimento de um objeto quando sua velocidade começa negativa e torna-se positiva após um tempo:
"""

# ╔═╡ 22aeea94-3366-4add-82d7-dabf8763cbe4
md"""
Podemos notar que no intervalo ``0 \leq t < 10{\rm \, s}``, a velocidade o objeto da animação é negativa. Durante esse intervalo o objeto move-se no sentido negativo, entretanto ele se move cada vez mais lentamente. Em ``t = ``, a velocidade do objeto também é zero, ou seja, o objeto está parado, e ele atinge sua menor posição. Após ``t=0``, sua velocidade torna-se positiva, e ele passa a se movimentar no sentido positivo de forma cada vez mais rápida.

Com os gráficos de posição e velocidade em função de ``t`` na animação, é possível descobrir as equações de movimento para o objeto. O gráfico de posição nos informa a posição inicial ``s_0 = 100{\rm \, m}``. Já o gráfico de velocidade nos mostra diretamente que a velocidade inicial ``v_0 = -40{\rm \, m\, s^{-1}}``, e pode ser utilizado para encontrar a aceleração ``a = 4{,}0{\rm \, m \, s^{-2}}``. Juntando todas essas três informações conseguimos obter as 3 equações de movimento:

```math
\boxed{s(t) = 100{\rm \, m} - 40{\rm \, \frac{m}{s}} \cdot t + \frac{4{,}0}{2}\frac{m}{s^2} \cdot t^2,}
```

```math
\boxed{v(t) = -40{\rm \, \frac{m}{s}} + 4{,}0{\rm \, \frac{m}{s^2}} \cdot t,}
```

```math
\boxed{a(t) = 4{,}0{\rm \, \frac{m}{s^2}}.}
```
"""

# ╔═╡ 060a3b0f-84fa-4abe-8677-f81ef48ddb61
md"""
O diagrama abaixo contém diversos gráficos de posição x tempo, mostrando o efeito da velocidade inicial (nula, positiva e negativa) e da aceleração (nula, positiva e negativa) no formato da curva ou reta obtida. Em todos eles, a posição inicial é positiva. 

>A unica mudança provocada pela variação da posição inicial é a elevação ou abaixamento das curvas (ou retas), sem que sua inclinação ou forma seja afetada.
"""

# ╔═╡ 66cec9c1-3900-462f-a3d0-f6b6a04ce5f7
begin
	vvector = [0, 10, -10]
	avector = [0, 10, -10]
	s0_matriz = 10
end;

# ╔═╡ 4627e185-e94b-4e39-9a08-667cf70175d4
md"""
Quando a velocidade inicial é zero, o vértice da parábola - seu ponto mais alto ou mais baixo - está na posição inicial.
"""

# ╔═╡ 68356482-aaf0-461d-91bb-e0f335e54a46
md"""
### 1.6.6. Equação de Torricelli

Uma outra equação bem útil que pode ser utilizada quando estamos estudando o MRUV é a *equação de Torricelli*:

```math
v_f^2 = v_0^2 + 2a \cdot \Delta s.
```

Note que nessa equação não temos o tempo ``t``, e ao invés temos a velocidade final ``v_f`` do objeto. Para obtê-la, partimos da equação do deslocamento em função do tempo ``\Delta s(t)``:

```math
\Delta s(t) = v_0 \cdot t + \frac{1}{2} \cdot a \cdot t^2,
```

mas precisamos reescrevê-la sem utilizar o tempo ``t``. Para isso utilizaremos a equação de ``v(t)``, e isolaremos o ``t`` nessa equação:

```math
v(t) = v_0 + a \cdot t \Rightarrow \boxed{t = \frac{v(t) - v_0}{a}}.
```

Substituindo o ``t`` na equação de ``\Delta s(t)`` pelo ``t`` encontrado utilizando ``v(t)``, temos:

```math
\Delta s(t) = v_0 \cdot \overbrace{\frac{v(t) - v_0}{a}}^{t} + \frac{1}{2} \cdot a \cdot \overbrace{\left(\frac{v(t) - v_0}{a}\right)^2}^{t^2}.
```

Podemos simplificar a notação, trocando ``\Delta s(t)`` por ``\Delta s``, e ``v_f`` por ``v(t)``. Nesse caso, ``v_f`` será a velocidade ``v`` do objeto no mesmo instante em que o objeto tem deslocamento ``\Delta s``.  Fazendo essa troca, e expandindo os termos da expressão podemos reescrevê-la como:

```math
\Delta s = \frac{v_0 \cdot \left(v_f - v_0\right)}{a} + \frac{\cancel{a}}{2} \cdot \frac{v_f^2 - 2 \cdot  v_f \cdot v_0 + v_0^2}{a^{\bcancel{2}}},
```

```math
\Delta s = \frac{v_0 \cdot v_f - v_0^2}{a} + \frac{v_f^2 - 2v_f \cdot v_0 + v_0^2}{2a}.
```

Após somar as frações, podemos simplificar ainda mais a expressão:

```math
\Delta s = \frac{\cancel{2v_0 \cdot v_f} - 2v_0^2 + v_f^2 \cancel{- 2v_f \cdot v_0} + v_0^2}{2a} = \frac{v_f^2 + v_0^2 - 2v_0^2}{a} = \frac{v_f^2 - v_0^2}{2a},
```

para finalmente encontrar a *equação de Torricelli*:

```math
\boxed{\Delta s = \frac{v_f^2 - v_0^2}{2a}} \therefore \boxed{v_f^2 = v_0^2 + 2a \cdot \Delta s}
```

> A equação de Torricelli é bem útil ao resolver problemas de MRUV, quando não temos nenhuma informação sobre o tempo que se passa, mas temos informações sobre o deslocamento do objeto, e suas velocidades inicial e final.
"""

# ╔═╡ 4c394698-91cf-48e6-92be-9844b762f992
md"""
### 1.6.7. As equações do MRUV

Juntando todas as equações que foram obtidas para o MRUV, temos:

**- Posição:**
```math
\boxed{s(t) = s_0 + v_0 \cdot t + \frac{1}{2}\cdot a t^2} 
```

**-Deslocamento:**
```math
\boxed{\Delta s(t) = s(t) - s_0 = v_0 \cdot t + \frac{1}{2}\cdot a t^2}
```
- Equação de Torricelli

```math
\boxed{\Delta s= \frac{v_f^2 - v_0^2}{2a}}
```

**-Velocidade:**
```math
\boxed{v(t) = v_0 + a \cdot t}
```
- Equação de Torricelli
```math
\boxed{v_f^2 = v_0^2 + 2a \cdot \Delta s}
```

**-Variação da velocidade:**
```math
\boxed{\Delta v(t) = v(t) - v_0 = a\cdot t}
```

**-Aceleração:**
```math
\boxed{a = \frac{\Delta v}{\Delta t} \rightarrow {\rm constante}}
```

- Equação de Torricelli
```math
\boxed{a = \frac{v_f^2 - v_0^2}{2 \Delta s}}
```

"""

# ╔═╡ 80986c5d-04e6-410c-842f-791872dcc9df
begin
	#função que calcula a velocidade em função do tempo no MRUV
	vel(t, v0, a) = v0 + a*t
	
	#função que calcula o deslocamento em função do tempo no MRUV
	Δs(t, v0, a) = v0*t + 0.5*a*t*t
	
	function trocarpontovirgtexto(x::Real; digits = 1)
		x_arr = (digits == 0 ? round(Int, x) : round(x; digits = digits))
		replace(string(x_arr), "." => ",")
	end
	
	function trocarpontovirglatex(x::Real; digits = 1)
		x_arr = (digits == 0 ? round(Int, x) : round(x; digits = digits))
		replace(string(x_arr), "." => "{,}")
	end
	
	fmt(x) = replace(string(x), "." => "{,}")
end;

# ╔═╡ 10256e98-a379-4434-aa82-ca0d68cdc01e
begin
	v_ex01(t) = vel(t, 10.0, 3.0)
	v1_t1 = v_ex01(t1_ex01)
	v1_t2 = v_ex01(t2_ex01)
	Δs1 = (v1_t1+v1_t2)*(t2_ex01 - t1_ex01)/2
	Δs_ex01(t) = Δs(t, 10.0, 3.0)
	xticks1 = unique([0,t1_ex01,t2_ex01,20])
	yticks1 = v_ex01.(xticks1)
end;

# ╔═╡ cebbb723-dc52-42e9-bd5e-3bb229707c08
begin
	xticks2 = 0:2:20
	fig02 = Figure(resolution = (800, 800))
	ax102 = fig02[1, 1] = Axis(fig02,
		title = "Deslocamento x tempo",
		xlabel = "tempo (s)",
		xticks = xticks2,
		ylabel = "deslocamento (m)",
		yticks = Δs_ex01.(xticks2))
	
	scatter!(ax102, 0:20, Δs_ex01,
		markersize = 15,
		color = (:red, 0.5))
	if mostra_linhas_2
		lines!(ax102, 0:0.1:20, Δs_ex01,
			linewidth = 2,
			color = :red)
	end
	
	limits!(ax102, 0, 20, 0, Δs_ex01(20))
	
	fig02
end

# ╔═╡ 2efdbe2b-e54a-4740-87f9-271979bca3aa
s1(t) = -100. + Δs_ex01(t)

# ╔═╡ eae7f006-0a17-4992-8286-a91fee24e53e
begin
	fig03 = Figure(resolution = (800, 800))
	ax301 = fig03[1, 1] = Axis(fig03,
		title = "Posição em função do tempo no MRUV",
		xlabel = "tempo(s)",
		xticks = 0:4:20,
		ylabel = "posição(m)",
		yticks = vcat(s1.(0:4:20), [0]))
	
	lines!(ax301, 0:20, s1,
		linewidth = 2,
		color = :red)
	hlines!(ax301, [0], color = :black)
	
	limits!(ax301, 0, 20, s1(0), s1(20))
	
	fig03
end

# ╔═╡ c4adbc8a-6bc7-4a95-b3b3-85b2c991f43e
begin	
	fig01 = Figure(resolution = (800, 800))
	ax101 = fig01[1, 1] = Axis(fig01,
		title = "Velocidade x tempo",
		xlabel = "tempo (s)",
		xticks = xticks1,
		ylabel = "velocidade (m/s)",
		yticks = yticks1)
	
	lines!(ax101, [0,20], v_ex01, linewidth = 2)
	scatter!(ax101, [t1_ex01, t2_ex01], [v1_t1, v1_t2],
		markersize = 15,
		color = (:dodgerblue, 0.7))
	
	vlines!(ax101, [t1_ex01], ymin = 0, ymax = v1_t1/yticks1[end],
		linewidth = 2,
		linestyle = :dash,
		color = :red)
	vlines!(ax101, [t2_ex01], ymin = 0, ymax = v1_t2/yticks1[end],
		linewidth = 2,
		linestyle = :dash,
		color = :red)
	
	band!(ax101, [t1_ex01, t2_ex01], [0, 0], [v1_t1, v1_t2],
		color = (:red, 0.3))
	
	text!(ax101, "Δs = $(trocarpontovirgtexto(Δs1)) m",
		position = ((t1_ex01 + t2_ex01)/2, 1),
		align = (:left, :center),
		rotation = π/2,
		textsize = 15,
		color = :red)
	
	limits!(ax101, 0, 20, 0, yticks1[end])
	
	fig01
end

# ╔═╡ 814fc816-5cc0-40ae-9d0d-02c7ce2ac0ac
md"""
A figura selecionada no gráfico acima é um trapézio. A área do trapézio pode ser calculada com a seguinte fórmula:

```math
A_{trap} = \frac{(B+b) \cdot h}{2},
```

sendo que ``B`` é a base maior do trapézio, ``b`` é sua base menor e ``h`` sua altura. 

No caso do trapézio acima, as bases menor e maior são as velocidades quando ``t_1 = `` $(t1_ex01) s, ``v_1 = `` $(trocarpontovirgtexto(v1_t1, digits = 0)) m/s; e quanto ``t_2 = `` $(t2_ex01) s, ``v_2 = `` $(trocarpontovirgtexto(v1_t2, digits = 0)) m/s. Já a altura é ``Δt_{12} = `` $(t2_ex01 - t1_ex01) s. Aplicando a fórmula da área temos
"""

# ╔═╡ 497d29f4-384d-4849-a6a5-5103c5d52b3d
begin
	v1t1u = v1_t1*1u"m/s"
	v1t2u = v1_t2*1u"m/s"
	Δt112u = (t2_ex01 - t1_ex01)*1u"s"
	latexify(:(A_trap = ($v1t1u + $v1t2u) * $Δt112u/2 = $(Δs1*1u"m")); fmt = fmt)
end

# ╔═╡ ae8025b6-1c87-44f3-88f9-9fdcefdea363
begin
	v10u = 10u"m/s"
	a1u = 3u"m/s^2"
	Δs1u(t) = Δs(t, v10u, a1u)
end

# ╔═╡ 5220e49d-0734-4610-b83c-3198aae40fda
latexify(:(Δs($(1u"s")) = $v10u * $(1u"s") + $a1u/2 * ($((1u"s")^2)) = $(Δs1u(1u"s"))); fmt = fmt)

# ╔═╡ 4a8fed1f-adef-4ac4-b9a4-f04266bc8c7d
latexify(:(Δs($(2u"s")) = $v10u * $(2u"s") + $a1u/2 * ($((2u"s")^2)) = $(Δs1u(2u"s"))); fmt = fmt)

# ╔═╡ 8535d187-f526-4982-830a-6f1d0b439dcd
latexify(:(Δs($(3u"s")) = $v10u * $(3u"s") + $a1u/2 * ($((3u"s")^2)) = $(Δs1u(3u"s"))); fmt = fmt)

# ╔═╡ e63ddedd-bddb-4992-9ce8-4441bfad8ad2
latexify(:(s($(10u"s")) = s_0 + $v10u * $(10u"s") + $a1u/2 * ($((10u"s")^2)) = $(150u"m")); fmt = fmt)

# ╔═╡ abfd6c2b-61f4-4b43-82fa-46926ce65dc5
begin
	framerate = 15
	nframes = framerate*21
	δt = 1/framerate
	
	t_ani = Node(zero(Float64))
	x01 = Node(s1(0))
	
	ani01 = Figure(resolution = (800, 800))
	axa01 = ani01[1, 1:2] = Axis(ani01,
		title = "Posição",
		xlabel = "Posição (m)",
		xticks = s1.(0:4:20))
	
	vlines!(axa01, [0], color = :black, linestyle = :dash)
	
	scatterlines!(axa01, @lift([Point2f0(s1(0), 0), Point2f0($x01, 0)]),
		linewidth =2,
		markersize = 12,
		color = :dodgerblue,
		markercolor = [(:dodgerblue, 0.5), (:dodgerblue, 1)])
	
	
	text!(axa01, @lift(string("t = ", trocarpontovirgtexto($t_ani, digits = 1), "s")),
		position = (600, 0.5),
		align = (:left, :center),
		color = :dodgerblue,
		textsize = 15)
	
	limits!(axa01, s1(0) - 10, s1(20), -1, 1)
	hideydecorations!(axa01)
	
	axa02 = ani01[2, 1] = Axis(ani01,
		title = "Posição x tempo",
		xlabel = "tempo (s)",
		xticks = 0:4:20,
		ylabel = "posição (m)",
		yticks = s1.(0:4:20))
	
	hlines!(axa02, [0], color = :black)
	
	lines!(axa02, @lift(0:δt:$t_ani), s1,
		linewidth = 2,
		color = (:dodgerblue, 0.7))
	
	scatter!(axa02, @lift(Point2f0($t_ani, s1($t_ani))),
		markersize = 12,
		color = :dodgerblue)
	
	limits!(axa02, 0, 20, s1(0), s1(20))
	hidespines!(axa02, :t, :b, :r)
	
	axa03 = ani01[2, 2] = Axis(ani01,
		title = "Velocidade x tempo",
		xlabel = "tempo (s)",
		xticks = 0:4:20,
		ylabel = "velocidade (m/s)",
		yticks = v_ex01.(0:4:20))
	
	lines!(axa03, @lift([0, $t_ani]), v_ex01,
		linewidth = 2,
		color = (:red, 0.7))
	
	scatter!(axa03, @lift(Point2f0($t_ani, v_ex01($t_ani))),
		color = :red,
		markersize = 12)
	
	limits!(axa03, 0, 20, 0, v_ex01(20))
	hidespines!(axa03, :t, :r)
	
	#gerando animação
	CairoMakie.Makie.Record(ani01, 1:nframes; framerate = framerate) do i
		global t_ani[] += δt
		x01[] = s1(t_ani[])
	end
	
	#ani01
end

# ╔═╡ cc2bb1a0-ec9f-4374-8b2b-8b20f7929b21
begin
	s2(t) = 100 + Δs(t, -40.0, 4.0)
	v_ex02(t) = vel(t, -40.0, 4.0)
end

# ╔═╡ f98046de-3246-46b5-bf8f-36c8a9f9453f
begin
	t_ani2 = Node(zero(Float64))
	x02 = Node(s2(0))
	x02_traj = Node([s2(0)])
	nframes2 = framerate*31
	
	ani02 = Figure(resolution = (800, 800))
	axa201 = ani02[1, 1:2] = Axis(ani02,
		title = "Posição",
		xlabel = "Posição (m)",
		xticks = unique(s2.(0:5:30)))
	
	vlines!(axa201, [0], color = :black, linestyle = :dash)
	
	scatter!(axa201, @lift([Point2f0(s2(0), 0), Point2f0($x02, 0)]),
		linewidth =2,
		markersize = 12,
		color = [(:dodgerblue, 0.4), (:dodgerblue, 1)])
	
	lines!(axa201, x02_traj, @lift(zeros(length($x02_traj))),
			color = (:dodgerblue, 0.6),
			linestyle = :dash)
		
	text!(axa201,
		@lift(string("t = ", trocarpontovirgtexto($t_ani2, digits = 1), "s")),
		position = (600, 0.5),
		align = (:left, :center),
		color = :dodgerblue,
		textsize = 15)
	
	limits!(axa201, s2(10) - 20, s2(30) + 20, -1, 1)
	hideydecorations!(axa201)
	
	axa202 = ani02[2, 1] = Axis(ani02,
		title = "Posição x tempo",
		xlabel = "tempo (s)",
		xticks = 0:5:30,
		ylabel = "posição (m)",
		yticks = unique(s2.(0:5:30)))
	
	hlines!(axa202, [0], color = :black)
	
	lines!(axa202, @lift(0:δt:$t_ani2), s2,
		linewidth = 2,
		color = (:dodgerblue, 0.7))
	
	scatter!(axa202, @lift(Point2f0($t_ani2, s2($t_ani2))),
		markersize = 12,
		color = :dodgerblue)
	
	limits!(axa202, 0, 31, s2(10) - 20, s2(30) + 20)
	hidespines!(axa202, :t, :b, :r)
	
	axa203 = ani02[2, 2] = Axis(ani02,
		title = "Velocidade x tempo",
		xlabel = "tempo (s)",
		xticks = 0:5:30,
		ylabel = "velocidade (m/s)",
		yticks = v_ex02.(0:5:30))
	
	hlines!(axa203, [0], color = :black)
	
	lines!(axa203, @lift([0, $t_ani2]), v_ex02,
		linewidth = 2,
		color = (:red, 0.7))
	
	scatter!(axa203, @lift(Point2f0($t_ani2, v_ex02($t_ani2))),
		color = :red,
		markersize = 12)
	
	limits!(axa203, 0, 30, v_ex02(0) - 10, v_ex02(30) + 10)
	hidespines!(axa203, :b, :t, :r)
	
	
	#gerando animação
	CairoMakie.Makie.Record(ani02, 1:nframes2; framerate = framerate) do i
		global t_ani2[] += δt
		x02[] = s2(t_ani2[])
		x02_traj[] = push!(x02_traj[], x02[])
	end
end

# ╔═╡ 6c67ca22-47cf-42f0-b56e-0bc647f02870
begin
	fig04 = Figure(resolution = (800, 900))
	
	#Label(fig04[1, 1], L"s(t)", textsize = 30)
	Label(fig04[1, 2], L"v_0 = 0", textsize = 25, tellwidth = false)
	Label(fig04[1, 3], L"v_0 > 0", textsize = 25, tellwidth = false)
	Label(fig04[1, 4], L"v_0 < 0", textsize = 25, tellwidth = false)
	Label(fig04[2, 1], L"a = 0", textsize = 25, tellheight = false)
	Label(fig04[3, 1], L"a > 0", textsize = 25, tellheight = false)
	Label(fig04[4, 1], L"a < 0", textsize = 25, tellheight = false)
	
	axs = []
	
	for i ∈ 1:3, j ∈ 1:3
		sij(t) = s0_matriz + Δs(t, vvector[i], avector[j])
		axtemp = Axis(fig04[j+1, i+1])
		lines!(axtemp, 0:0.2:3, sij)
		hlines!(axtemp, [0], color = :black)
		if j == 3 
			axtemp.xlabel = "tempo"
		end
		
		if i == 1
			axtemp.ylabel = "posição"
		end
		xlims!(axtemp, [0, 3])
		hidedecorations!(axtemp, label = false)
		hidespines!(axtemp, :b, :r, :t)
		push!(axs, axtemp)
		
	end
	
	Label(fig04[0, 1:4], "Posição x tempo", textsize = 30)
	fig04
end

# ╔═╡ Cell order:
# ╟─b97b14ae-fac3-11eb-0e21-95ed6e98a537
# ╟─e4221b18-274a-4114-9f5f-bb9c2b443c05
# ╟─9d96643d-d414-4c52-bf87-8cdde91f4c95
# ╟─29512667-0484-48a7-b0e5-fb9bfe810dbc
# ╟─10256e98-a379-4434-aa82-ca0d68cdc01e
# ╟─c4adbc8a-6bc7-4a95-b3b3-85b2c991f43e
# ╟─814fc816-5cc0-40ae-9d0d-02c7ce2ac0ac
# ╟─497d29f4-384d-4849-a6a5-5103c5d52b3d
# ╟─d5936e80-3c9a-4b6d-95e0-69eece2f586d
# ╟─7440b5b7-9f60-4254-88f7-cd49badcf3a0
# ╟─ae8025b6-1c87-44f3-88f9-9fdcefdea363
# ╟─425096eb-4cd5-4f52-bc26-2374b2682575
# ╟─5220e49d-0734-4610-b83c-3198aae40fda
# ╟─db548d9f-34c0-436c-9458-9e9366056eca
# ╟─4a8fed1f-adef-4ac4-b9a4-f04266bc8c7d
# ╟─e22a4467-a239-4af4-9e2b-b99ad87b8664
# ╟─8535d187-f526-4982-830a-6f1d0b439dcd
# ╟─1b349553-af5d-420e-ba5b-e81d13d6d009
# ╟─7aa79362-92e0-466d-9559-7ee48cf6e429
# ╟─cebbb723-dc52-42e9-bd5e-3bb229707c08
# ╟─aed82fc0-95d2-4957-a67a-a3d7da8f9a92
# ╟─759b278c-87f7-462a-a106-35da3153318c
# ╟─e63ddedd-bddb-4992-9ce8-4441bfad8ad2
# ╟─f0a1a0a0-f8cd-4dd8-8e71-fcc7cf8600ef
# ╟─6f29f4f4-3772-4d4f-9417-198501166a79
# ╟─da83b8b6-d851-4792-ae1e-5eef8ccb7af7
# ╟─2efdbe2b-e54a-4740-87f9-271979bca3aa
# ╟─eae7f006-0a17-4992-8286-a91fee24e53e
# ╟─3f8bc0fc-5a2b-402a-aed2-df18aa93291a
# ╟─abfd6c2b-61f4-4b43-82fa-46926ce65dc5
# ╟─1cf14f34-547d-4a71-929e-d3677bfe5206
# ╟─cc2bb1a0-ec9f-4374-8b2b-8b20f7929b21
# ╟─f98046de-3246-46b5-bf8f-36c8a9f9453f
# ╟─22aeea94-3366-4add-82d7-dabf8763cbe4
# ╟─060a3b0f-84fa-4abe-8677-f81ef48ddb61
# ╟─66cec9c1-3900-462f-a3d0-f6b6a04ce5f7
# ╟─6c67ca22-47cf-42f0-b56e-0bc647f02870
# ╟─4627e185-e94b-4e39-9a08-667cf70175d4
# ╟─68356482-aaf0-461d-91bb-e0f335e54a46
# ╟─4c394698-91cf-48e6-92be-9844b762f992
# ╟─80986c5d-04e6-410c-842f-791872dcc9df
