### A Pluto.jl notebook ###
# v0.19.4

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 0d61cb90-db3a-11eb-116b-3b8d57786ec7
begin
	using Pkg
	Pkg.activate(".")
end

# ╔═╡ 3bdd4c91-2d0d-49a8-ac0c-22285cb54ef6
begin
	using CairoMakie
	using PlutoUI
	using LaTeXStrings
	using Unitful, UnitfulLatexify, Latexify
	using LinearAlgebra
	using HypertextLiteral
end

# ╔═╡ 7c441144-dd5f-454b-b017-e6e644db6758
html"""
<style>
	main {
		margin: 0 auto;
		max-width: 2000px;
    	padding-left: max(160px, 20%);
    	padding-right: max(160px, 20%);
	}
</style>
"""

# ╔═╡ 84496be3-9062-494c-bdad-12736c9d9dba
TableOfContents(title = "Índice", depth = 4)

# ╔═╡ 4927e0e0-1574-4d17-b9a0-a09a297593a1
md"""
## 1.5. Movimento Retilíneo Uniforme (MRU)

Quando um objeto se move em linha reta e com velocidade constante, dizemos que ele se encontra em Movimento Retilíneo e Uniforme (MRU). Nessa situação, o objeto sempre realiza o mesmo deslocamento ``\overrightarrow{\Delta S}`` a cada unidade de tempo, ou seja, em qualquer instante de tempo, sua velocidade é igual à sua velocidade média.

```math
\vec{v} = \vec{v}_{\rm med} = \frac{\overrightarrow{\Delta S}}{\Delta t} = \rm{constante}.
```

Como o objeto move-se em uma linha reta, o movimento ocorre em apenas uma dimensão, ou seja, precisamos de apneas um valor para indicar o deslocamento do objeto e, portanto, apenas um valor para indicar a velocidade média do objeto.

"""

# ╔═╡ e636d5a4-8814-4494-a628-7b6ab3b6f680
begin
	#definindo posição inicial
	s01d = rand(10:5:90)
	s01du = s01d * 1u"m"
	
	#sorteando posição final
	s11d = rand(200:10:500)
	s11du = s11d * 1u"m"
	
	#sorteando tempo decorrido
	Δt1d = rand(16:4:32)
	Δt1du = Δt1d * 1u"s"
	
	#calculando deslocamento
	Δs1d = s11d - s01d
	Δs1du = Δs1d * 1u"m"
	
	#calculando a velocidade média
	vm1d = Δs1d/Δt1d
	vm1du = vm1d * 1u"m/s"
	
	#função que define a posição em função do tempo
	ss01(s0, v, t) = s0 + v*t
end;

# ╔═╡ 6f8b9370-dae0-46b2-b2a5-e1518d6148e5
begin
	#definindo observáveis
	#posição no instante t
	xt1d = Observable(Float64(s01d))
	
	#marcação do instante t
	cron1d = Observable(zero(Float64))
	
	#marcações da posição
	xticks_vec = Observable([0, Float64(s01d)])
	
	#texto das marcações de tempo
	tstr_vec = Observable([string("t = 0 s")])
	
	#posições das marcações de tempo
	posstr_vec = Observable([Point2f(s01d, 1.5)])
	
	#definindo dados e posições para a animação
	framerate = 12
	nframes = Int64(ceil(Δt1d*framerate, digits = 0))
		
	#criando a figura 1 - MRU
	fig_01 = Figure(resolution = (800, 800), backgroundcolor = :gray90)
	
	#animação do movimento retilíneo uniforme 
	ax_01 = fig_01[1, 1] = Axis(fig_01, 
		backgroundcolor = :Gray70,
		xlabel = "Posição x (m)",
		xticks = xticks_vec,
		xtickformat = "{:.1f}",
		xticklabelsize = 12,
		title = "Movimento retilíneo uniforme")
	
	
	hlines!(ax_01, 0, linestyle = :dash, color = :white, linewidth = 1)
	#vlines!(ax_01, 0, color = :black, linewidth = 1)
	
	#posição do ponto de referência 
	scatter!(ax_01, Point2(0), markersize = 15, marker = :rect, color = :black)
	
	#linha e pontos que representam a trajetória até o instante t
	scatterlines!(ax_01, @lift([s01d, $xt1d]), [0, 0], color = :red, linewidth = 2,
		markercolor = :dodgerblue, markersize = 15)
	
	#texto com as marcações de tempo
	text!(ax_01, tstr_vec, position = posstr_vec,
		align = (:center, :bottom), color = :red, textsize = 12)
	
	#características dos eixos	
	limits!(ax_01, -20, floor(s11d, digits = -1),  -20, 20)
	hideydecorations!(ax_01)
	hidespines!(ax_01)
	
	#texto marcando a posição no instante t
	text!(ax_01, @lift(string("S₁ = ", round($xt1d, digits = 1), " m")), 
		position = @lift(Point2($xt1d, -2)),
		align = (:left, :top), color = :red, textsize = 12)
	
	#cronomêtro da animação	
	text!(ax_01, @lift(latexstring("t = ", round($cron1d, digits = 1), " s")),
		position = (floor(s11d, digits = -1) -10 , -19),
		align = (:right, :bottom),
		color = :black,
		textsize = 15)
	
	#animação no gráfico de posição x tempo
	ax_02 = fig_01[2,1] = Axis(fig_01,
		title = "Posição x tempo",
		xlabel = "Tempo decorrido (s)",
		xticks = 0:4:Δt1d,
		ylabel = "Posição (m)",
		yticks = xticks_vec,
		ytickformat = "{:.1f}",
		yticklabelsize = 12)
	
	#desenhando eixo na posição 0.
	hlines!(ax_02, 0, linewidth = 1, color = :black)
	
	#reta que representa a variação da posição com o tempo até o instante t
	scatterlines!(ax_02, @lift([0.0, $cron1d]), @lift([s01d, $xt1d]),
		linewidth = 2, color = :red, markercolor = :dodgerblue,
		markersize = 15)
	
	#características do gráfico
	limits!(ax_02, 0, Δt1d - 2, -20, floor(s11d, digits = -1))
	hidespines!(ax_02, :b, :t, :r)

	#gerando animação
	record(fig_01, "mru_01.mp4", 1:nframes; framerate = framerate) do i
		ttemp = (i-1)/framerate
		xtemp = ss01(s01d, vm1d, ttemp)
		xt1d[] =  i < nframes ? xtemp : s11d
		cron1d[] = i < nframes ? ttemp : Δt1d
		if (i-1) % (4*framerate) == 0 && i ≠ 1
			xticks_vec[] = push!(xticks_vec[], xtemp)
			tstr_vec[] = push!(tstr_vec[], string("t = ", ttemp, " s"))
			posstr_vec[] = push!(posstr_vec[], Point2f(xtemp, 1.5))
		end
	end
	LocalResource("./mru_01.mp4")
end

# ╔═╡ 77da6859-b932-4555-b06f-9223d72c977d
begin
	#sorteando posição final para objeto 2
	s21d = rand(-400:10:-100)
	s21du = s11d * 1u"m"
	
	#sorteando tempo decorrido
	Δt21d = rand(16:4:32)
	Δt21du = Δt1d * 1u"s"
	
	#calculando deslocamento
	Δs21d = s21d - s01d
	Δs21du = Δs21d * 1u"m"
	
	#calculando a velocidade média
	vm21d = Δs21d/Δt21d
	vm21du = vm21d * 1u"m/s"
end;

# ╔═╡ 05838771-f76a-47ba-a446-3ad7552ce5c3
begin
	#definindo observáveis
	#posição no instante t
	xt1d2 = Observable(Float64(s01d))
	
	#marcação do instante t
	cron1d2 = Observable(zero(Float64))
	
	#marcações da posição
	xticks_vec2 = Observable([0, Float64(s01d)])
	
	#texto das marcações de tempo
	tstr_vec2 = Observable([string("t = 0 s")])
	
	#posições das marcações de tempo
	posstr_vec2 = Observable([Point2f(s01d, 1.5)])
	
	#definindo dados e posições para a animação
	nframes2 = Int64(ceil(Δt21d*framerate, digits = 0))
		
	#criando a figura 1 - MRU
	fig_02 = Figure(resolution = (800, 800), backgroundcolor = :gray90)
	
	#animação do movimento retilíneo uniforme 
	ax1_2 = fig_02[1, 1] = Axis(fig_02, 
		backgroundcolor = :Gray70,
		xlabel = "Posição x (m)",
		xticks = xticks_vec2,
		xtickformat = "{:.1f}",
		xticklabelsize = 12,
		title = "Movimento retilíneo uniforme")
	
	
	hlines!(ax1_2, 0, linestyle = :dash, color = :white, linewidth = 1)
	#vlines!(ax1_2, 0, color = :black, linewidth = 1)
	
	#posição do ponto de referência 
	scatter!(ax1_2, Point2(0), markersize = 15, marker = :rect, color = :black)
	
	#linha e pontos que representam a trajetória até o instante t
	scatterlines!(ax1_2, @lift([s01d, $xt1d2]), [0, 0], color = :green, 
		linewidth = 2, marker = :diamond, markersize = 20,
		markercolor = :red)
	
	#texto com as marcações de tempo
	text!(ax1_2, tstr_vec2, position = posstr_vec2,
		align = (:center, :bottom), color = :green, textsize = 12)
	
	#características dos eixos	
	limits!(ax1_2, floor(s21d, digits = -1),  s01d + 20, -20, 20)
	hideydecorations!(ax1_2)
	hidespines!(ax1_2)
	
	#texto marcando a posição no instante t
	text!(ax_01, @lift(string("S₁ = ", round($xt1d2, digits = 1), " m")), 
		position = @lift(Point2($xt1d2, -2)),
		align = (:left, :top), color = :red, textsize = 12)
	
	#cronomêtro da animação	
	text!(ax_01, @lift(string("t = ", round($cron1d2, digits = 1), " s")),
		position = (floor(s01d, digits = -1) +10 , -19),
		align = (:right, :bottom),
		color = :black,
		textsize = 15)
	
	#animação no gráfico de posição x tempo
	ax2_2 = fig_02[2,1] = Axis(fig_02,
		title = "Posição x tempo",
		xlabel = "Tempo decorrido (s)",
		xticks = 0:4:Δt21d,
		ylabel = "Posição (m)",
		yticks = xticks_vec2,
		ytickformat = "{:.1f}",
		yticklabelsize = 12)
	
	#desenhando eixo na posição 0.
	hlines!(ax2_2, 0, linewidth = 1, color = :black)
	
	#reta que representa a variação da posição com o tempo até o instante t
	scatterlines!(ax2_2, @lift([0.0, $cron1d2]), @lift([s01d, $xt1d2]),
		marker = :diamond, linewidth = 2, color = :green, markersize = 20,
		markercolor = :red)
	
	#características do gráfico
	limits!(ax2_2, 0, Δt21d - 2, floor(s21d, digits = -1) + 20, s01d)
	hidespines!(ax2_2, :b, :t, :r)

	#gerando animação
	record(fig_02, "mru_02.mp4", 1:nframes2; framerate = framerate) do i
		ttemp = (i-1)/framerate
		xtemp = ss01(s01d, vm21d, ttemp)
		xt1d2[] =  i < nframes2 ? xtemp : s21d
		cron1d2[] = i < nframes2 ? ttemp : Δt21d
		if (i-1) % (4*framerate) == 0 && i ≠ 1
			xticks_vec2[] = push!(xticks_vec2[], xtemp)
			tstr_vec2[] = push!(tstr_vec2[], string("t = ", ttemp, " s"))
			posstr_vec2[] = push!(posstr_vec2[], Point2f(xtemp, 1.5))
		end
	end

	LocalResource("./mru_02.mp4")
end

# ╔═╡ 53bf7f54-d841-483c-8538-0f69d8f5bc64
md"""
#### Comparando os dois exemplos

A imagem a seguir compara como a posição dos dois ojetos dos exemplos 1 e 2 varia com o tempo, desde ``t = 0`` s até ``t = 30`` s. A análise inicial da inclinação do gráfico já nos informa qual o sentido de movimento do objeto sobre o eixo ``x`` (para direita ou esquerda, para frente ou para trás, para cima ou para baixo). Enquanto a posição do *objeto 1* aumenta com o tempo (movimento para a direita), a posição do *objeto 2* diminui com o tempo (movimento para a esquerda).

A gráfico também mostra uma reta que descreve o que acontece com a posição do *objeto 3*, que permanece parado na mesma posição durante todo o intervalo de tempo mostrado.

"""

# ╔═╡ 178e894b-0be2-403c-8b89-4bfca612dc05
begin
	t_fim = 30
	ex1_fim = ss01(s01d, vm1d, t_fim)
	ex2_fim = ss01(s01d, vm21d, t_fim)
	
	marcacoesy = vcat(collect(s01d:50:ex1_fim), collect(s01d:-50:ex2_fim))
	marcacoesy = sort(unique(vcat(marcacoesy, 0)))
	
	fig_03 = Figure(resolution = (800, 800), backgroundcolor = :gray90)
	ax3_1 = fig_03[1, 1] = Axis(fig_03, 
		title = "Gráfico de posição em função do tempo",
		xlabel = "Tempo (s)",
		xticks = range(0, t_fim, length = 11),
		ylabel = "Posição no eixo x (m)",
		yticks = marcacoesy)
	
	hlines!(ax3_1, 0, linewidth =2, color = :black)
	
	lines!(ax3_1, [0, 30], [s01d, ex1_fim], color = :red,
		linewidth = 2, label = "Objeto 1: velocidade positiva")
	lines!(ax3_1, [0, 30], [s01d, ex2_fim], color = :green,
		linewidth = 2, label = "Objeto 2: velocidade negativa")
	lines!(ax3_1, [0, 30], [s01d, s01d], color = :orange,
		linewidth = 2, label = "Objeto 3: parado")
	axislegend(ax3_1, position = :lt)
	
	limits!(ax3_1, 0, t_fim, ex2_fim, ex1_fim)
	hidespines!(ax3_1, :b, :t, :r)
	
	fig_03
end

# ╔═╡ e3e5d70c-99dd-47ae-9737-5afdb34b96cc
md"""
Um inclinação positiva indica que a posição do objeto aumenta com o tempo, logo, o objeto se movimento no sentido escolhido como positivo. Já uma inclinação negativa indica o contrário, a posição diminui com o tempo, ou seja, o objeto se movimenta no sentido negativo. O movimento do *objeto 3* está representado com uma reta horizontal (paralela ao eixo do tempo), que indica que o objeto está parado na posição $s01du.
"""

# ╔═╡ 17e26fd8-bd6c-4fba-b4d8-9c2aa93783f3
md"""
### 1.5.2. Inclinação da reta no gráfico de posição x tempo

Além de nos indicar se um objeto está se movimentando com velocidade positiva (inclinação positiva), velocidade negativa (inclinação negativa) ou se o objeto está parado (inclinação nula), a inclinação pode nos mostrar também qual dos objetos está se movimentando mais rápido.

A imagem abaixo mostra as retas que representam o movimento de 6 objetos, cada reta com uma inclinação diferente. Através da inclinação podemos dizer que os os *objetos 1, 4 e 6* têm velocidades positivas, o *objeto 3* está parado e  os *objetos 2 e 5* têm velocidades negativas.
"""

# ╔═╡ 42cde057-93ff-48f8-80a9-7a0dba452984
md"""
Além disso, podemos descobrir qual dos objetos é o mais rápido e qual o mais devagar.
Todos os objetos partiram da mesma posição inicial em ``\vec{S}_0 = `` $s01du. Temos uma linha vertical marcando o instante de tempo ``t = 12`` s. Entre os 3 objetos com velocidade positiva (1, 4 e 6), o objeto que se afastou mais da posição inicial para a direita até os 12 s foi o *objeto 4*, logo depois foi o *objeto 1*, e o que menos se afastou para a direita foi o *objeto 6*. Já entre os objetos com velocidade negativa, o *objeto 6* foi o que teve o maior deslocamento para a esquerda e o *objeto 2* teve o menos deslocamento para a esquerda.

Isso nos mostra que, quanto mais inclinada está a reta, tanto para cima quanto para baixo, maior é a rapidez com que o objeto se afasta da posição inicial. Quanto mais inclinada para cima, maior é a rapidez com que o objeto move-se para a direita, e quanto mais inclinada para baixo, maior é a rapidez com que o objeto se move para a esquerda.
"""

# ╔═╡ 49db3430-0ee7-4b18-b7d5-04129fca2aed
md"""
Utilizando as posições iniciais e as posições em ``t = 12\,``s de cada objeto podemos calcular os deslocamentos de cada um:
"""

# ╔═╡ c7494bc0-d6c4-4915-b3f1-6a96cba18360
md"""
As velocidades médias de cada objeto no intervalo entre 0 e 12 s podem ser calculadas a partir de seus respectivos deslocamentos:
"""

# ╔═╡ 9f1a7d8a-26e8-464c-81da-8fab79c31398
md"""
As velocidades médias calculadas confirmam a análise das inclinações. A reta com maior inclinação positiva é a do objeto com a maior velocidade positiva: *objeto 4*. A reta com a maior inclinação negativa é a do *objeto 5*, que tem a velocidade negativa com o maior módulo. A velocidade calculada do *objeto 3* foi zero, e o *objeto 6* que tem a reta com a menor inclinação positiva também tem a menor velocidade calculada.

Podemos calcular a velocidade média entre quaisquer duas posições selecionadas sobre a reta que indica a posição em função do tempo. Vamos sortear dois pontos quaisquer sobre a reta que representa o movimento do *objeto 1*, e calcular novamente a velocidade média entre essas duas posições:
"""

# ╔═╡ 8c57cc8b-7f4b-4dbe-ad90-09de311f9757
@bind sortear_ponto PlutoUI.Button("Sortear pontos")	

# ╔═╡ 6b17416d-48c1-49c5-8c40-cdc457b731cd
begin
	sortear_ponto
	
	trand1 = rand(1:0.1:30)
	trand2 = rand(1:0.1:30)
	
	if trand1 < trand2
		px_01 = Point2f(trand1, ss01(s01d, vm1d, trand1))
		px_02 = Point2f(trand2, ss01(s01d, vm1d, trand2))
	elseif trand1 > trand2
		px_01 = Point2f(trand2, ss01(s01d, vm1d, trand2))
		px_02 = Point2f(trand1, ss01(s01d, vm1d, trand1))
	else
		px_01 = Point2f(trand1, ss01(s01d, vm1d, trand1))
		px_02 = Point2f(trand2, ss01(s01d, vm1d, trand2 + 2))
	end
end;	

# ╔═╡ e09262f4-141c-465c-b8fa-ef9c44a64f2b
md"""
### 1.5.3. Posição instantânea : ``S(t)`` 

Toda função que é representada como uma reta no plano cartesiano é do tipo

```math
f(x) = ax + b.
```

Dessa forma, para o MRU, a função que representa a posição em função do tempo deve ser uma função do mesmo tipo

```math
S(t) = at + b,
```

onde ``S`` é a posição do objeto em MRU, ``t`` é o instante em que queremos saber a posição o objeto, e ``a`` e ``b`` são os coeficientes da equação. Para descobrir quais são os coeficientes ``a`` e ``b`` e o que eles significam, primeiro temos que calculá-los através da análise de um dos gráficos de posição em função do tempo. 

>Para simplificar a notação, quando estivermos trabalhando com movimento em apenas 1 dimensão vamos deixar de colocar a seta flutuante sobre a posição e a velocidade.

#### Equação da posição para o *objeto 1*

Sabemos que a posição do *objeto 1* no instante ``t = 0`` é ``S(0) = `` $s01du. Dessa forma, podemos substituir esses valores na função ``S(t)``:
"""

# ╔═╡ 54cf9f31-83f9-4017-b6a9-0325f744c1f4
latexstring("S(0) = a\\cdot 0 + b \\Rightarrow $(s01d) {\\rm \\, m} = \\underbrace{a \\cdot 0}_{0} + b \\Rightarrow \\boxed{b = $(s01d) {\\rm \\, m}.}")

# ╔═╡ a609b608-2f93-4750-991f-d98e7dd151c3
md"""
O coeficiente ``b`` é igual à posição inicial do *objeto 1*. Precisamos de outro ponto, para descobrir agora o valor do coeficiente ``a``. De acordo com a figura anterior, sabemos que no instante :
"""

# ╔═╡ 1e00806d-4710-4f67-ad93-f4d1e38a625e
md"""
Substituindo esses valores na função S(t):
"""

# ╔═╡ 213eb1a1-8935-4fd8-bb7b-08264631f51f
md"""
mas já sabemos que ``b = `` $s01du. Substituindo b, então:
"""

# ╔═╡ b358e7d6-93c3-49d3-b9d2-ea58d201b337
md"""
O coeficiente ``a`` é igual à velocidade do *objeto 1*. Então a equação da posição em função do tempo para o *objeto 1* é:
"""

# ╔═╡ a996261a-f23f-4d82-9672-9ec13724a233
md"""
#### Equação da posição para o *objeto 2*

Vamos aplicar o mesmo método acima para encontrar a equação da posição em função do tempo para o *objeto 2*.
"""

# ╔═╡ ab8bcfab-a5d4-4052-b7a4-bd2f74445d08
md"""
A posição inicial do *objeto 2* é a mesma do *objeto 1*: ``S_0 = `` $(s01d) m. Substituindo na equação da reta ``S_{2}(t) = at + b``, temos:
"""

# ╔═╡ 368a3e6f-6fb3-4f2d-a1ef-8e455762f514
latexstring("S_{2}(0) = a\\cdot 0 + b \\Rightarrow $(s01d) {\\rm \\, m} = \\underbrace{a \\cdot 0}_{0} + b \\Rightarrow \\boxed{b = $(s01d) {\\rm \\, m}.}")

# ╔═╡ cbeeae6f-b123-4144-89f3-aa536677e14d
md"""
Iremos utilizar a posição do *objeto 2* no instante ``t = 12\\,``s para descobrir o valor do coeficiente ``b``: 
"""

# ╔═╡ b0d6d7f3-cf52-4503-9094-81975c159569
md"""
Novamente encontramos que o valor do coeficiente ``b`` foi a posição inicial ``S(0)`` do objeto, e o coeficiente ``a`` foi sua velocidade. A equação de ``S(t)`` para o *objeto 2* é:
"""

# ╔═╡ 6c335625-12ef-4b10-9b06-1f40f7970df9
md"""
A equação horária da posição para o MRU é sempre uma equação da forma:

```math
\boxed{{S}(t) = {S}_0 + v \cdot t,}
```

sendo que ``S_0`` é a posição inicial do objeto, ou seja a posição no instante ``t = 0``,  e ``v`` é a sua velocidade. Essa equação também pode ser reescrita da seguinte forma:

```math
\underbrace{S(t) - S_0}_{\Delta S(t)} = v \cdot t \Rightarrow \boxed{\Delta S(t) = v \cdot t}
```

Se partirmos da equação utilizada para calcular a velocidade média:

```math
v_{\rm med} = \frac{\Delta S(t)}{\Delta t} = \frac{S(t) - S_0}{t - 0} \Rightarrow S(t) -  S_0 = v_{\rm med} \cdot t. 
```

```math
S(t) = S_0 + v_{\rm med} \cdot t.
```

>A equação da posição em função do tempo para o MRU é equivalente à equação da velocidade média!
"""

# ╔═╡ fbe398d1-4615-400a-85fe-593a767515fc
md"""
### 1.5.4. Velocidade instantânea : ``v(t)``

Vamos, a partir do gráfico de posição em função do tempo para o *objeto 1*, criar o gráfico de velocidade em função do tempo.

Através do gráfico de velocidade em função do tempo podemos encontrar a velocidade do objeto em qualquer instante de tempo ``v(t)``. A velocidade do objeto é um determinado instante é chamada de *velocidade instantânea*, e no caso do MRU é sempre constante e igual à velocidade média.

#### Gráfico da velocidade em função do tempo
No caso de MRU, a reta que representa a velocidade no *gráfico de velocidade x tempo* é uma reta horizontal (paralela ao eixo do tempo), como pode ser vista na imagem abaixo.

"""

# ╔═╡ 03054abe-0973-44e0-ae08-2fee4b0c356e
md"""
A função ``v_1(t)`` que representa a *velocidade instantânea* do *objeto 1* é:
"""

# ╔═╡ 1adc6aeb-68b8-4ec8-a4af-24d4c2c182b8
md"""
ou seja, a velocidade não depende (não varia) do tempo!

Os mesmos instantes marcados no gráfico de posição x tempo, estão marcados no gráfico de velocidade x tempo. E utilizamos esses pontos para delimitar um retângulo no segundo gráfico. Utilizando as dimensões do retângulo, podemos calcular sua área. A área do retângulo pode ser calculada com a fórmula:

```math
A_{\rm retângulo} = b \times h,
```

sendo ``b`` o comprimento da base do retângulo e ``h`` sua altura. No caso do retângulo acima, o comprimento de sua base está dado em unidades de tempo (s), já a altura ``h`` está dada em unidades de velocidade (m/s).

A área do retângulo será:
"""

# ╔═╡ 6bc3f7e5-af9e-48aa-9b61-3697b95dc3aa
md"""
O valor da área do retângulo no *gráfico de velocidade x tempo* é igual ao deslocamento entre os dois instantes marcados (como visto no *gráfico de posição x tempo*).

A área do retângulo pode ser reescrita como:

```math
A_{\rm retângulo} = \underbrace{v}_{altura} \times \overbrace{\Delta t}^{base},
```

mas vimos que para objetos em MRU, ``\Delta S = v \, \Delta t``, ou seja, a área do retângulo é o próprio deslocamento do objeto.

Fazendo o mesmo tipo de análise para o *objeto 2*, montamos os dois gráficos abaixo.
"""

# ╔═╡ 1c833bb8-5369-4d3b-aad9-0a384eaf40ee
md"""
Desta vez, como a velocidade é negativa, a área do retângulo delimitado por ``t_1`` e ``t_2`` no *gráfico de velocidade x tempo* também será negativa.
"""

# ╔═╡ 5bc22efb-fa0f-42e0-9ede-f59eecd518f3
md"""
Que também corresponde ao deslocamento indicado pelo *gráfico de posição por tempo*.

A área de uma curva ou reta no plano cartesiano é sempre a área entre esta curva e o eixo das abscissas. A área precisa estar limitada por um intervalo nas abscissas. Se a curva está acima do eixo das abscissas, a área é positiva. Já se a curva está abaixo do eixo das abscissas, a área será negativa!

No caso do gráfico de velocidade em função do tempo, o significado da área calculada é o deslocamento. Para outros tipos de gráficos, as áreas também terão outros significados.

"""

# ╔═╡ 3d144c31-6647-4c4e-8930-ee58f8adce2f
begin
	function escrever_cal_desl_2d(s0::Point2, s1::Point2; digits = 0, unidade = "m")

		trocar_ponto_virgula(x) = replace(string(x), "." => "{,}")

		adicionar_unidade(x) = string(trocar_ponto_virgula(x), "\\rm{\\,", 
			unidade, "}")

		s0_arr = (digits == 0 ? round.(Int, s0) : round.(s0; digits = digits))
		s1_arr = (digits == 0 ? round.(Int, s1) : round.(s1; digits = digits))

		s01_str = s0[1] < 0 ? string("+", adicionar_unidade(abs(s0_arr[1]))) : string("-", adicionar_unidade(s0_arr[1]))
		s02_str = s0[2] < 0 ? string("+", adicionar_unidade(abs(s0_arr[2]))) : string("-", adicionar_unidade(s0_arr[2]))

		latexstring("\\overrightarrow{\\Delta S} = (", adicionar_unidade(s1_arr[1]),
			s01_str,", \\,", adicionar_unidade(s1_arr[2]), s02_str, ") = (",
			adicionar_unidade(s1_arr[1] - s0_arr[1]), ",\\,", 
			adicionar_unidade(s1_arr[2] - s0_arr[2]), ")")
	end	

	function escrever_cal_vmed_2d(ΔS::Point2, Δt; digits = 2, ucomp = "m", utemp = "s")

		trocar_ponto_virgula(x) = replace(string(x), "." => "{,}")
		ad_ucomp(x) = string(trocar_ponto_virgula(x), "\\rm{\\,", ucomp, "}")
		ad_utemp(x) = string(trocar_ponto_virgula(x), "\\rm{\\,", utemp, "}")
		ad_uvel(x) = string(trocar_ponto_virgula(x), "\\rm{\\,", ucomp, 
			"\\,", utemp,"^{-1}}")
		
		vmed = ΔS/Δt
		
		ΔS_arr = (digits == 0 ? round.(Int, ΔS) : round.(ΔS; digits = digits))
		Δt_arr = (digits == 0 ? round(Int, Δt) : round(Δt; digits = digits))
		vmed_arr = (digits == 0 ? round.(Int, vmed) : round.(vmed; digits = digits))
		
		
		
		latexstring("\\vec{v}_{\\rm med} = 
			\\frac{\\overrightarrow{\\Delta S}}{\\Delta t} = 
			\\left( \\frac{", ad_ucomp(ΔS_arr[1]),"}{", ad_utemp(Δt_arr),
			"},\\frac{", ad_ucomp(ΔS_arr[2]), "}{", ad_utemp(Δt_arr),
			"}\\right) = \\left(", ad_uvel(vmed_arr[1]), ",\\,",
			ad_uvel(vmed_arr[2]),"\\right)")
	end
	
	function trocarpontovirgtexto(x::Real; digits = 1)
		x_arr = (digits == 0 ? round(Int, x) : round(x; digits = digits))
		replace(string(x_arr), "." => ",")
	end
	
	function trocarpontovirglatex(x::Real; digits = 1)
		x_arr = (digits == 0 ? round(Int, x) : round(x; digits = digits))
		replace(string(x_arr), "." => "{,}")
	end
end

# ╔═╡ 99bae866-78ac-45fd-9c22-e68c096e2d01
md"""
### 1.5.1. Posição em função do tempo no MRU

#### Exemplo 1
Na animação abaixo, temos um exemplo onde o círculo azul está em MRU. Nesse exemplo, o objeto parte de sua posição inicial ``\vec{S}_0 = `` $s01du, e movimenta-se para a direita sempre se deslocando $(trocarpontovirgtexto(vm1d*4, digits = 2)) m a cada intervalo de 4,0 s. Como o objeto move-se para a direita, seu deslocamento é positivo e, logo, sua velocidade também é positiva!

Abaixo temos um gráfico mostrando como a posição do objeto está variando com o tempo, com sua posição sendo marcada a cada 4,0 s. E está claro como a posição em ``x`` está aumentando a medida que o tempo passa - a reta tem inclinação positiva (em relação ao eixo do tempo).
"""

# ╔═╡ 78ce3df7-4d56-4dd6-9972-b181089e8b74
md"""
#### Exemplo 2

Na animação abaixo temos um outro exemplo de um objeto em MRU, mas agora com velocidade negativa. O objeto parte da posição inicial ``\vec{S}_0 = `` $s01du, e se desloca $(trocarpontovirgtexto(abs(vm21d * 4), digits = 1)) m para a esquerda a cada 4,0 s, ou seja, sua posição varia $(trocarpontovirgtexto(vm21d * 4, digits = 1)) m a esquerda a cada 4,0 s. O deslocamento e a velocidade são negativas.

O gráfico de posição em função do tempo mostra uma reta com inclinação negativa (em relação ao eixo do tempo). A posição do objeto diminui à medida que o tempo passa.

"""

# ╔═╡ aaf34a91-abc0-4af9-b8b4-cf62211d8bfb
begin
	vobj1d = [vm1d, vm21d, 0.0, 2*vm1d, 1.5*vm21d, 0.5*vm1d]
	exx_fim = ss01.(s01d, vobj1d, t_fim)
	exx_t12 = ss01.(s01d, vobj1d, 12)
	ccor = [:red, :green, :darkorange, :dodgerblue, :magenta, :blue]
	mmark = [:circle, :diamond, :rect, :pentagon, :hexagon, :utriangle]
	
	fig_04 = Figure(resolution = (800, 800), backgroundcolor = :gray90)
	ax4_1 = fig_04[1, 1] = Axis(fig_04, 
		title = "Gráfico de posição x tempo",
		xlabel = "Tempo (s)",
		xticks = range(0, t_fim, length = 11),
		ylabel = "Posição no eixo x (m)",
		yticks = marcacoesy)
	
	hlines!(ax4_1, 0, linewidth = 2, color = :black)
	vlines!(ax4_1, 12, linestyle = "..", linewidth = 3, color = :black)
	
	for i ∈ 1:size(vobj1d, 1)
		
		if vobj1d[i] > 0
			simbm = ">"
			valinh = :top
		elseif vobj1d[i] < 0
			simbm = "<"
			valinh = :bottom
		else
			simbm = "="
			valinh = :top
		end
		
		str_label = string("Objeto $i: v $simbm 0")
		
		lines!(ax4_1, [Point2f(0, s01d), Point2f(t_fim, exx_fim[i])], linewidth = 2, 
				color = ccor[i], label = str_label)
		scatter!(ax4_1, Point2f(12, exx_t12[i]), markersize = 20, color = ccor[i],
			marker = mmark[i])
		text!(ax4_1, 
			string("S(12 s) = $(trocarpontovirgtexto(exx_t12[i], digits = 2)) m"),
			position = (12.5, exx_t12[i]),
			align = (:left, valinh),
			color = ccor[i],
			textsize = 14)
	end
	
	axislegend(ax4_1, position = :lt)
	
	limits!(ax4_1, 0, t_fim, ex2_fim, ex1_fim)
	hidespines!(ax4_1, :t, :r)
	
	fig_04
end

# ╔═╡ 2867c8a3-6add-4383-8b98-a7b134baff52
begin
	ex_Δs = exx_t12 .- s01d
	ex_Δsu = 1u"m".* ex_Δs
end;

# ╔═╡ facde294-a7b7-417e-a3c8-177e375d3af4
begin
	exx_vm = ex_Δs/12
	exx_vmu = 1u"m/s" .* exx_vm
end;

# ╔═╡ 97806392-17ba-464d-b1a2-8083c4388af6
latexstring("{\\rm Objeto \\: 1: \\:}\\overrightarrow{\\Delta S}_1(12\\,{\\rm s}) = \\vec{S}_1(12\\,{\\rm s}) - \\vec{S}_0 = ", 
	trocarpontovirglatex(exx_t12[1], digits = 2), "{\\rm \\, m} -", 
	trocarpontovirglatex(s01d, digits = 1), "{\\rm \\, m} = ", 
	trocarpontovirglatex((exx_t12[1] - s01d), digits = 2), "{\\rm \\, m}")

# ╔═╡ 28bd3d84-cedf-4e46-9f6d-6e47c116e3eb
latexstring("{\\rm Objeto \\: 2: \\:}\\overrightarrow{\\Delta S}_2(12\\,{\\rm s}) = \\vec{S}_2(12\\,{\\rm s}) - \\vec{S}_0 = ", 
	trocarpontovirglatex(exx_t12[2], digits = 2), "{\\rm \\, m} -", 
	trocarpontovirglatex(s01d, digits = 1), "{\\rm \\, m} = ", 
	trocarpontovirglatex((exx_t12[2] - s01d), digits = 2), "{\\, \\rm m}")

# ╔═╡ 164795b3-a517-48c7-ac7d-b2b064028f6f
latexstring("{\\rm Objeto \\: 3: \\:}\\overrightarrow{\\Delta S}_3(12\\,{\\rm s}) = \\vec{S}_3(12\\,{\\rm s}) - \\vec{S}_0 = ", 
	trocarpontovirglatex(exx_t12[3], digits = 2), "{\\rm \\, m} -", 
	trocarpontovirglatex(s01d, digits = 1), "{\\rm \\, m} = ", 
	trocarpontovirglatex((exx_t12[3] - s01d), digits = 2), "{\\, \\rm m}")

# ╔═╡ 46a5bd16-f718-409e-97f1-48e816fa4a7d
latexstring("{\\rm Objeto \\: 4: \\:}\\overrightarrow{\\Delta S}_4(12\\,{\\rm s}) = \\vec{S}_4(12\\,{\\rm s}) - \\vec{S}_0 = ", 
	trocarpontovirglatex(exx_t12[4], digits = 2), "{\\rm \\, m} -", 
	trocarpontovirglatex(s01d, digits = 1), "{\\rm \\, m} = ", 
	trocarpontovirglatex((exx_t12[4] - s01d), digits = 2), "{\\, \\rm m}")

# ╔═╡ 1691fad4-2bb7-4703-9b7f-ea967115b5b1
latexstring("{\\rm Objeto \\: 5: \\:}\\overrightarrow{\\Delta S}_5(12\\,{\\rm s}) = ", 
	trocarpontovirglatex((exx_t12[5] - s01d), digits = 2), "{\\, \\rm m}")

# ╔═╡ f448046b-bca7-432b-b544-a08b2dae46fb
latexstring("{\\rm Objeto \\: 6: \\:}\\overrightarrow{\\Delta S}_6(12\\,{\\rm s}) = ", 
	trocarpontovirglatex((exx_t12[6] - s01d), digits = 2), "\\,{\\rm m}")

# ╔═╡ 0c54aa50-381f-4172-96c8-2a4109ef32fb
latexstring("{\\rm Objeto} \\: 1: \\: \\vec{v}_1 = \\frac{\\overrightarrow{\\Delta S}_1}{\\Delta t} = \\frac{",
	trocarpontovirglatex(ex_Δs[1], digits = 2), "\\rm{\\, m}}{ 12{\\rm \\, s}} =",
	trocarpontovirglatex(exx_vm[1], digits = 2), "\\rm{\\, m\\,s^{-1}}")

# ╔═╡ 963c47ba-07d7-46cb-9851-c106b4a5f7c8
latexstring("{\\rm Objeto \\: 2:}\\: \\vec{v}_2 = \\frac{\\overrightarrow{\\Delta S}_2}{\\Delta t} = \\frac{",
	trocarpontovirglatex(ex_Δs[2], digits = 2), "{\\rm \\, m}}{ 12{\\rm \\, s}} =",
	trocarpontovirglatex(exx_vm[2], digits = 2), "{\\rm \\, m\\,s^{-1}}")

# ╔═╡ e5dde675-e2d4-4c59-b362-b0f0d0ecce51
latexstring("{\\rm Objeto \\: 3:}\\: \\vec{v}_3 = \\frac{\\overrightarrow{\\Delta S}_3}{\\Delta t} = \\frac{",
	trocarpontovirglatex(ex_Δs[3], digits = 2), "{\\rm \\, m}}{ 12{\\rm \\, s}} =",
	trocarpontovirglatex(exx_vm[3], digits = 2), "{\\rm \\, m\\,s^{-1}}")

# ╔═╡ 50af2531-d505-4e0a-90e7-6b01dcca31b5
latexstring("{\\rm Objeto \\: 4:}\\: \\vec{v}_4 = 
	\\frac{\\overrightarrow{\\Delta S}_4}{\\Delta t} = ",
	trocarpontovirglatex(exx_vm[4], digits = 2), "{\\rm \\, m\\,s^{-1}}")

# ╔═╡ 3e4c3b2f-0816-4942-a4eb-27e81d9cdf3c
latexstring("{\\rm Objeto \\: 5:}\\: \\vec{v}_5 = 
	\\frac{\\overrightarrow{\\Delta S}_5}{\\Delta t} = ",
	trocarpontovirglatex(exx_vm[5], digits = 2), "{\\rm \\, m\\,s^{-1}}")

# ╔═╡ 501952b3-cd9c-44c5-9087-34e2123ad243
latexstring("{\\rm Objeto \\: 6:}\\: \\vec{v}_6 = 
	\\frac{\\overrightarrow{\\Delta S}_6}{\\Delta t} = ",
	trocarpontovirglatex(exx_vm[6], digits = 2), "{\\rm \\, m\\,s^{-1}}")

# ╔═╡ 09064159-c8b9-4b20-93ef-ca16e2db3ed4
begin
	fig_05 = Figure(resolution = (800, 800), backgroundcolor = :gray90)
	ax5_1 = fig_05[1, 1] = Axis(fig_05, 
		title = "Gráfico da posição em função do tempo (objeto 1)",
		xlabel = "Tempo (s)",
		xticks = 0:3:36,
		ylabel = "Posição no eixo x (m)",
		yticks = 0:25:exx_fim[1])
	
	hlines!(ax5_1, 0, linewidth = 2, color = :black)
	
	lines!(ax5_1, [0, 30], [s01d, exx_fim[1]], color = :red, linewidth = 2)
	
	lines!(ax5_1, [px_01[1], px_02[1], px_02[1]], [px_01[2], px_01[2], px_02[2]],
		linestyle = :dash, linewidth = 2, color = :blue)
	
	scatter!(ax5_1, [px_01, px_02], color = :red, markersize = 15)
			
	text!(ax5_1, 
		string("S($(trocarpontovirgtexto(px_01[1], digits = 1)) s)  = $(trocarpontovirgtexto(px_01[2], digits = 2)) m"),
		position = (px_01[1], px_01[2] - 3),
		align = (:left, :top),
		color = :red,
		textsize = 15)
	
	text!(ax5_1, 
		string("S($(trocarpontovirgtexto(px_02[1], digits = 1)) s)  = $(trocarpontovirgtexto(px_02[2], digits = 2)) m"),
		position = (px_02[1] + 0.7, px_02[2]),
		align = (:left, :center),
		color = :red,
		textsize = 15)
	
	text!(ax5_1, 
		string("ΔS = $(trocarpontovirgtexto(px_02[2] - px_01[2], digits = 2)) m"),
		position = (px_02[1] + 0.3, (px_02[2] + px_01[2])/2),
		align = (:left, :center),
		color = :blue,
		textsize = 15)
	
	text!(ax5_1, 
		string("Δt = $(trocarpontovirgtexto(px_02[1] - px_01[1], digits = 1)) s"),
		position = ((px_02[1] + px_01[1])/2, px_01[2] + 1),
		align = (:center, :bottom),
		color = :blue,
		textsize = 15)
	
	limits!(ax5_1, 0, 36, 0, exx_fim[1])
	hidespines!(ax5_1, :t, :r)
	
	fig_05
end	

# ╔═╡ 2991d3de-86c7-4d2c-b0c6-84833520fe11
latexstring("\\vec{v} = \\frac{", 
	trocarpontovirglatex(px_02[2] - px_01[2], digits = 2),"{\\rm \\, m}}{",
	trocarpontovirglatex(px_02[1] - px_01[1], digits = 1),"{\\rm \\, s}} =",
	trocarpontovirglatex((px_02[2] - px_01[2])/(px_02[1] - px_01[1]), digits = 2),
	"{\\rm \\, m \\, s^{-1}}")

# ╔═╡ 870b42fc-227b-4ef2-8ce9-3a3b38ca1a19
md"""
Podemos escolher quaisquer dois pontos sobre a reta, que a velocidade média calculada para o *objeto 1* é sempre a mesma $(trocarpontovirgtexto(vobj1d[1], digits = 2)) m/s.
Isso quer dizer que, quando um objeto está em MRU sua velocidade é sempre constante e é sempre igual à sua velocidade média."""

# ╔═╡ 7b39da40-375e-47d7-a5c9-0f92469ee641
latexstring("t = ", trocarpontovirglatex(px_01[1]), "{\\rm \\, s} 
	\\rightarrow S(", trocarpontovirglatex(px_01[1]), "{\\rm \\, s} ) = ",
	trocarpontovirglatex(px_01[2], digits = 2), "{\\rm \\, m}.")

# ╔═╡ af28f7de-585b-4a0d-8982-56a1e57318e7
latexstring("S(", trocarpontovirglatex(px_01[1]), 
	"{\\rm \\, s} ) = a \\cdot ", trocarpontovirglatex(px_01[1]), 
	"{\\rm \\, s} + b \\Rightarrow ", trocarpontovirglatex(px_01[2], digits = 2), 
	"{\\rm \\, m} = a \\cdot ", trocarpontovirglatex(px_01[1]), 
	"{\\rm \\, s} + b,")

# ╔═╡ a951898e-a555-4aed-9883-5d379bd582f4
latexstring("a \\cdot ", trocarpontovirglatex(px_01[1]), "{\\rm \\, s} +", 
	s01d, "{\\rm \\, m} = ", trocarpontovirglatex(px_01[2], digits = 2), 
	"{\\rm \\, m} \\Rightarrow  a = \\frac{", 
	trocarpontovirglatex(px_01[2], digits = 2), "{\\rm \\, m} - ", s01d, 
	"{\\rm \\, m}}{",trocarpontovirglatex(px_01[1]), "{\\rm \\, s}}" )

# ╔═╡ 3e1b1ada-3fcc-4499-9ae8-5a39569c1bd2
latexstring("a = \\frac{", trocarpontovirglatex(px_01[2] - s01d, digits = 2),
	"{\\rm \\, m}}{", trocarpontovirglatex(px_01[1]), "{\\rm \\, s}} = ",
	trocarpontovirglatex((px_01[2] - s01d)/px_01[1], digits = 2), 
	"{\\rm \\, m \\, s^{-1}}.")

# ╔═╡ ba3c6ca7-0621-4aeb-9d37-c8cf5556adf4
latexstring("\\boxed{S_{1}(t) = ", trocarpontovirglatex(vobj1d[1], digits = 2), "{\\rm \\, m \\, s^{-1}} \\cdot t +", s01d,
	"{\\rm m}.}")

# ╔═╡ eb53aeba-4e45-4835-a5da-ef7eee7d207e
begin
	fig_06 = Figure(resolution = (800, 800), backgroundcolor = :gray90)
	ax6_1 = fig_06[1, 1] = Axis(fig_06, 
		title = "Gráfico da posição em função do tempo (objeto 2)",
		xlabel = "Tempo (s)",
		xticks = 0:3:36,
		ylabel = "Posição no eixo x (m)",
		yticks = s01d:-50:exx_fim[2])
	
	hlines!(ax6_1, 0, linewidth = 2, color = :black)
	
	lines!(ax6_1, [0, 30], [s01d, exx_fim[2]], color = :green, linewidth = 2)
	
	scatter!(ax6_1, [Point2f(0.0, s01d), Point2f(12.0, exx_t12[2])], color = :green,
		marker = :diamond, markersize = 20)
	
	text!(ax6_1, 
		string("S(12 s) = $(trocarpontovirgtexto(exx_t12[2], digits = 2)) m"),
		position = (13.0, exx_t12[2]),
		align = (:left, :center),
		color = :green,
		textsize = 15)
	
	limits!(ax6_1, 0, 36, exx_fim[2], s01d + 10)
	hidespines!(ax6_1, :b, :t, :r)
	
	fig_06
end

# ╔═╡ 9bbaa2c0-f3b0-45e9-886a-6c354fc63abc
latexstring("S_{2}(12{\\rm \\, s}) = ", trocarpontovirgtexto(exx_t12[2], digits = 2), 
	"{\\rm \\, m}")

# ╔═╡ d878bf8c-981e-47e4-97b7-89db5665ce30
latexstring("S_{2}( 12{\\rm \\, s}) = a \\cdot 12{\\rm \\, s} + ", 
	s01d, "{\\rm \\, m} = ", trocarpontovirglatex(exx_t12[2], digits = 2),
	"{\\rm \\, m}")

# ╔═╡ 02e26762-ae42-499b-a3c4-7be635e889aa
latexstring("a = \\frac{", 
	trocarpontovirglatex(exx_t12[2], digits = 2), "{\\rm \\, m} - ", s01d, 
	"{\\rm \\, m}}{12 {\\rm \\, s}} = \\frac{",  
	trocarpontovirglatex(exx_t12[2] - s01d, digits = 2),
	"{\\rm \\, m}}{12 {\\rm \\, s}} \\Rightarrow a = ",
	trocarpontovirglatex((exx_t12[2] - s01d)/12, digits = 2),
	"{\\rm \\, m \\, s^{-1}}")

# ╔═╡ 8527cd21-e094-4479-a33c-fbaccffe7513
latexstring("S_{2}(t) = ", trocarpontovirglatex(vobj1d[2], digits = 2),
	"{\\rm m \\, s^{-1}} \\cdot t +", s01d, "{\\rm \\, m}")

# ╔═╡ 2b680e02-98f6-407f-806c-c9e8233b9492
begin
	fig_07 = Figure(resolution = (800, 800), backgroundcolor = :gray90)
	ax7_1 = fig_07[1, 1] = Axis(fig_07, 
		title = "Gráfico da posição em função do tempo (objeto 1)",
		xlabel = "Tempo (s)",
		xticks = 0:3:36,
		ylabel = "Posição no eixo x (m)",
		yticks = 0:50:exx_fim[1])
	
	hlines!(ax7_1, 0, linewidth = 2, color = :black)
	
	lines!(ax7_1, [0, 30], [s01d, exx_fim[1]], color = :red, linewidth = 2)
	
	lines!(ax7_1, [px_01[1], px_02[1], px_02[1]], [px_01[2], px_01[2], px_02[2]],
		linestyle = :dash, linewidth = 2, color = :blue)
	
	scatter!(ax7_1, [px_01, px_02], color = :red, markersize = 15)
		
	text!(ax7_1, string("S₁(t) = ", trocarpontovirgtexto(vobj1d[1], digits = 2),
	" m/s ⋅ t +", s01d, " m"),
		position = (3, 300),
		align = (:left, :center),
		color = :red,
		textsize = 16)
	
	text!(ax7_1, 
		string("S($(trocarpontovirgtexto(px_01[1], digits = 1)) s)  = $(trocarpontovirgtexto(px_01[2], digits = 2)) m"),
		position = (px_01[1], px_01[2] - 7),
		align = (:left, :top),
		color = :red,
		textsize = 16)
	
	text!(ax7_1, 
		string("S($(trocarpontovirgtexto(px_02[1], digits = 1)) s)  = $(trocarpontovirgtexto(px_02[2], digits = 2)) m"),
		position = (px_02[1] + 0.7, px_02[2]),
		align = (:left, :top),
		color = :red,
		textsize = 16)
	
	text!(ax7_1, 
		string("ΔS = $(trocarpontovirgtexto(px_02[2] - px_01[2], digits = 2)) m"),
		position = (px_02[1] + 0.3, (px_02[2] + px_01[2])/2),
		align = (:left, :center),
		color = :blue,
		textsize = 16)
	
	text!(ax7_1, 
		string("Δt = $(trocarpontovirgtexto(px_02[1] - px_01[1], digits = 1)) s"),
		position = ((px_02[1] + px_01[1])/2, px_01[2] + 1),
		align = (:center, :bottom),
		color = :blue,
		textsize = 16)
	
	limits!(ax7_1, 0, 36, 0, exx_fim[1])
	hidespines!(ax7_1, :t, :r)
	
	ax7_2 = fig_07[2, 1] = Axis(fig_07,
		title = "Gráfico da velocidade em função do tempo (objeto 1)",
		xlabel = "Tempo (s)",
		xticks = 0:3:36,
		ylabel = "Velocidade no eixo x (m/s)",
		yticks = 0:vobj1d[1]:2*vobj1d[1])
	
	hlines!(ax7_2, vobj1d[1], linewidth = 2, color = :red)
	
	band!(ax7_2, [px_01[1], px_02[1]], [0, 0], [vobj1d[1], vobj1d[1]],
		color = (:dodgerblue, 0.5))
	
	scatter!(ax7_2, [px_01[1], px_02[1]], [vobj1d[1], vobj1d[1]],
		color = :red, markersize = 15)
	
	vlines!(ax7_2, px_01[1], ymin = 0,  ymax = 0.5, 
		linestyle = :dash, color = :red, linewidth = 2)
	vlines!(ax7_2, px_02[1], ymin = 0,  ymax = 0.5, 
		linestyle = :dash, color = :red, linewidth = 2)
	
	text!(ax7_2, 
		string("t₁ = $(trocarpontovirgtexto(px_01[1], digits = 2)) s"),
		position = (px_01[1], 13),
		align = (:center, :top),
		color = :red,
		textsize = 16)
	
	text!(ax7_2, 
		string("t₂ = $(trocarpontovirgtexto(px_02[1], digits = 2)) s"),
		position = (px_02[1], 13),
		align = (:center, :top),
		color = :red,
		textsize = 16)
	
	text!(ax7_2, string("v₁(t) = ", trocarpontovirgtexto(vobj1d[1], digits = 2),
	" m/s"),
		position = (18, 20),
		align = (:center, :center),
		color = :red,
		textsize = 16)
	
	text!(ax7_2, 
		string("Área =  $(trocarpontovirgtexto(vobj1d[1] * (px_02[1] - px_01[1]), digits = 2)) m"), 
		position = ((px_02[1]+px_01[1])/2, vobj1d[1]/2),
		align = (:center, :center),
		color = :blue,
		textsize = 16)
	
	limits!(ax7_2, 0, 36, 0, 2*vobj1d[1])
	hidespines!(ax7_2, :t, :r)
	
	linkxaxes!(ax7_1, ax7_2)
	
	
	
	fig_07
end

# ╔═╡ 7c93c7a6-54d9-42b8-98a9-2ca4da196de5
latexstring("v(t) = $(trocarpontovirglatex(vobj1d[1], digits = 1)) 
	{\\rm \\, m \\, s^{-1}},")

# ╔═╡ 668155e6-939b-4e1e-aace-921fc93cc2bc
latexstring("A_{\\rm retângulo} = 
	$(trocarpontovirglatex(px_02[1] - px_01[1], digits = 1)) {\\rm \\, s} \\times
	$(trocarpontovirglatex(vobj1d[1], digits = 1)) {\\rm \\, m \\, s^{-1}}")

# ╔═╡ 5939e7c9-a3c0-4bf4-b706-6e5b91868094
latexstring("A_{\\rm retângulo} = $(trocarpontovirglatex(vobj1d[1] * (px_02[1] - px_01[1]), digits = 1)) {\\rm \\, m}")

# ╔═╡ ebaa5fe4-3d29-4cec-a200-922e439154d7
begin
	px2_01 = Point2f(px_01[1], ss01(s01d, vobj1d[2], px_01[1]))
	px2_02 = Point2f(px_02[1], ss01(s01d, vobj1d[2], px_02[1]))
	
	fig_08 = Figure(resolution = (800, 800), backgroundcolor = :gray90)
	ax8_1 = fig_08[1, 1] = Axis(fig_08, 
		title = "Gráfico da posição em função do tempo (objeto 2)",
		xlabel = "Tempo (s)",
		xticks = 0:3:36,
		ylabel = "Posição no eixo x (m)",
		yticks = s01d:-50:exx_fim[2])
	
	hlines!(ax8_1, 0, linewidth = 2, color = :black)
	
	lines!(ax8_1, [0, 30], [s01d, exx_fim[2]], color = :green, linewidth = 2)
	
	lines!(ax8_1, [px2_01[1], px2_02[1], px2_02[1]], 
		[px2_01[2], px2_01[2], px2_02[2]],
		linestyle = :dash, linewidth = 2, color = :blue)
	
	scatter!(ax8_1, [px2_01, px2_02], color = :green, markersize = 15)
		
	text!(ax8_1, string("S₂(t) = ", trocarpontovirgtexto(vobj1d[2], digits = 2),
	" m/s ⋅ t +", s01d, " m"),
		position = (3, -400),
		align = (:left, :center),
		color = :green,
		textsize = 16)
	
	text!(ax8_1, 
		string("S₂($(trocarpontovirgtexto(px2_01[1], digits = 1)) s)  = $(trocarpontovirgtexto(px2_01[2], digits = 2)) m"),
		position = (px2_01[1], px2_01[2] + 10),
		align = (:left, :bottom),
		color = :green,
		textsize = 16)
	
	text!(ax8_1, 
		string("S₂($(trocarpontovirgtexto(px2_02[1], digits = 1)) s)  = $(trocarpontovirgtexto(px2_02[2], digits = 2)) m"),
		position = (px2_02[1] + 0.7, px2_02[2]),
		align = (:left, :bottom),
		color = :green,
		textsize = 16)
	
	text!(ax8_1, 
		string("ΔS = $(trocarpontovirgtexto(px2_02[2] - px2_01[2], digits = 2)) m"),
		position = (px2_02[1] + 0.3, (px2_02[2] + px2_01[2])/2),
		align = (:left, :center),
		color = :blue,
		textsize = 16)
	
	text!(ax8_1, 
		string("Δt = $(trocarpontovirgtexto(px2_02[1] - px2_01[1], digits = 1)) s"),
		position = ((px2_02[1] + px2_01[1])/2, px2_01[2] - 10),
		align = (:center, :top),
		color = :blue,
		textsize = 16)
	
	limits!(ax8_1, 0, 36, exx_fim[2], s01d)
	hidespines!(ax8_1, :t, :b, :r)
	
	ax8_2 = fig_08[2, 1] = Axis(fig_08,
		title = "Gráfico da velocidade em função do tempo (objeto 2)",
		xlabel = "Tempo (s)",
		xticks = 0:3:36,
		ylabel = "Velocidade no eixo x (m/s)",
		yticks = 0:vobj1d[2]:2*vobj1d[2])
	
	hlines!(ax8_2, vobj1d[2], linewidth = 2, color = :green)
	
	band!(ax8_2, [px_01[1], px_02[1]], [vobj1d[2], vobj1d[2]], [0, 0],
		color = (:dodgerblue, 0.5))
	
	scatter!(ax8_2, [px_01[1], px_02[1]], [vobj1d[2], vobj1d[2]],
		color = :green, markersize = 15)
	
	vlines!(ax8_2, px_01[1], ymin = 0.5,  ymax = 1, 
		linestyle = :dash, color = :green, linewidth = 2)
	vlines!(ax8_2, px_02[1], ymin = 0.5,  ymax = 1, 
		linestyle = :dash, color = :green, linewidth = 2)
	
	text!(ax8_2, 
		string("t₁ = $(trocarpontovirgtexto(px2_01[1], digits = 2)) s"),
		position = (px2_01[1], vobj1d[2]-1.5),
		align = (:center, :top),
		color = :green,
		textsize = 16)
	
	text!(ax8_2, 
		string("t₂ = $(trocarpontovirgtexto(px2_02[1], digits = 2)) s"),
		position = (px2_02[1], vobj1d[2]-1.5),
		align = (:center, :top),
		color = :green,
		textsize = 16)
	
	text!(ax8_2, string("v₂(t) = ", trocarpontovirgtexto(vobj1d[2], digits = 2),
	" m/s"),
		position = (18, vobj1d[2]-15),
		align = (:center, :center),
		color = :green,
		textsize = 16)
	
	text!(ax8_2, 
		string("Área =  $(trocarpontovirgtexto(vobj1d[2] * (px2_02[1] - px2_01[1]), digits = 2)) m"), 
		position = ((px2_02[1]+px2_01[1])/2, vobj1d[2]/2),
		align = (:center, :center),
		color = :blue,
		textsize = 16)
	
	limits!(ax8_2, 0, 36, 2*vobj1d[2], 0)
	hidespines!(ax8_2, :b, :r)
	
	fig_08
end

# ╔═╡ 9ec41f9e-d7ab-4ea4-9cf1-cf474b34809a
latexstring("A_{\\rm retângulo} = 
	$(trocarpontovirglatex(px2_02[1] - px2_01[1], digits = 1)) {\\rm \\, s} \\times
	($(trocarpontovirglatex(vobj1d[2], digits = 1)) {\\rm \\, m \\, s^{-1}})")

# ╔═╡ d894166f-a621-4526-ba3c-835b65935fb8
latexstring("A_{\\rm retângulo} = $(trocarpontovirglatex(vobj1d[2] * (px2_02[1] - px2_01[1]), digits = 1)) {\\rm \\, m}")

# ╔═╡ Cell order:
# ╟─7c441144-dd5f-454b-b017-e6e644db6758
# ╟─0d61cb90-db3a-11eb-116b-3b8d57786ec7
# ╟─3bdd4c91-2d0d-49a8-ac0c-22285cb54ef6
# ╟─84496be3-9062-494c-bdad-12736c9d9dba
# ╟─4927e0e0-1574-4d17-b9a0-a09a297593a1
# ╟─e636d5a4-8814-4494-a628-7b6ab3b6f680
# ╟─99bae866-78ac-45fd-9c22-e68c096e2d01
# ╟─6f8b9370-dae0-46b2-b2a5-e1518d6148e5
# ╟─77da6859-b932-4555-b06f-9223d72c977d
# ╟─78ce3df7-4d56-4dd6-9972-b181089e8b74
# ╟─05838771-f76a-47ba-a446-3ad7552ce5c3
# ╟─53bf7f54-d841-483c-8538-0f69d8f5bc64
# ╟─178e894b-0be2-403c-8b89-4bfca612dc05
# ╟─e3e5d70c-99dd-47ae-9737-5afdb34b96cc
# ╟─17e26fd8-bd6c-4fba-b4d8-9c2aa93783f3
# ╟─aaf34a91-abc0-4af9-b8b4-cf62211d8bfb
# ╟─42cde057-93ff-48f8-80a9-7a0dba452984
# ╟─49db3430-0ee7-4b18-b7d5-04129fca2aed
# ╟─2867c8a3-6add-4383-8b98-a7b134baff52
# ╟─97806392-17ba-464d-b1a2-8083c4388af6
# ╟─28bd3d84-cedf-4e46-9f6d-6e47c116e3eb
# ╟─164795b3-a517-48c7-ac7d-b2b064028f6f
# ╟─46a5bd16-f718-409e-97f1-48e816fa4a7d
# ╟─1691fad4-2bb7-4703-9b7f-ea967115b5b1
# ╟─f448046b-bca7-432b-b544-a08b2dae46fb
# ╟─facde294-a7b7-417e-a3c8-177e375d3af4
# ╟─c7494bc0-d6c4-4915-b3f1-6a96cba18360
# ╟─0c54aa50-381f-4172-96c8-2a4109ef32fb
# ╟─963c47ba-07d7-46cb-9851-c106b4a5f7c8
# ╟─e5dde675-e2d4-4c59-b362-b0f0d0ecce51
# ╟─50af2531-d505-4e0a-90e7-6b01dcca31b5
# ╟─3e4c3b2f-0816-4942-a4eb-27e81d9cdf3c
# ╟─501952b3-cd9c-44c5-9087-34e2123ad243
# ╟─9f1a7d8a-26e8-464c-81da-8fab79c31398
# ╟─8c57cc8b-7f4b-4dbe-ad90-09de311f9757
# ╟─6b17416d-48c1-49c5-8c40-cdc457b731cd
# ╟─09064159-c8b9-4b20-93ef-ca16e2db3ed4
# ╟─2991d3de-86c7-4d2c-b0c6-84833520fe11
# ╟─870b42fc-227b-4ef2-8ce9-3a3b38ca1a19
# ╟─e09262f4-141c-465c-b8fa-ef9c44a64f2b
# ╟─54cf9f31-83f9-4017-b6a9-0325f744c1f4
# ╟─a609b608-2f93-4750-991f-d98e7dd151c3
# ╟─7b39da40-375e-47d7-a5c9-0f92469ee641
# ╟─1e00806d-4710-4f67-ad93-f4d1e38a625e
# ╟─af28f7de-585b-4a0d-8982-56a1e57318e7
# ╟─213eb1a1-8935-4fd8-bb7b-08264631f51f
# ╟─a951898e-a555-4aed-9883-5d379bd582f4
# ╟─3e1b1ada-3fcc-4499-9ae8-5a39569c1bd2
# ╟─b358e7d6-93c3-49d3-b9d2-ea58d201b337
# ╟─ba3c6ca7-0621-4aeb-9d37-c8cf5556adf4
# ╟─a996261a-f23f-4d82-9672-9ec13724a233
# ╟─eb53aeba-4e45-4835-a5da-ef7eee7d207e
# ╟─ab8bcfab-a5d4-4052-b7a4-bd2f74445d08
# ╟─368a3e6f-6fb3-4f2d-a1ef-8e455762f514
# ╟─cbeeae6f-b123-4144-89f3-aa536677e14d
# ╟─9bbaa2c0-f3b0-45e9-886a-6c354fc63abc
# ╟─d878bf8c-981e-47e4-97b7-89db5665ce30
# ╟─02e26762-ae42-499b-a3c4-7be635e889aa
# ╟─b0d6d7f3-cf52-4503-9094-81975c159569
# ╟─8527cd21-e094-4479-a33c-fbaccffe7513
# ╟─6c335625-12ef-4b10-9b06-1f40f7970df9
# ╟─fbe398d1-4615-400a-85fe-593a767515fc
# ╟─2b680e02-98f6-407f-806c-c9e8233b9492
# ╟─03054abe-0973-44e0-ae08-2fee4b0c356e
# ╟─7c93c7a6-54d9-42b8-98a9-2ca4da196de5
# ╟─1adc6aeb-68b8-4ec8-a4af-24d4c2c182b8
# ╟─668155e6-939b-4e1e-aace-921fc93cc2bc
# ╟─5939e7c9-a3c0-4bf4-b706-6e5b91868094
# ╟─6bc3f7e5-af9e-48aa-9b61-3697b95dc3aa
# ╟─ebaa5fe4-3d29-4cec-a200-922e439154d7
# ╟─1c833bb8-5369-4d3b-aad9-0a384eaf40ee
# ╟─9ec41f9e-d7ab-4ea4-9cf1-cf474b34809a
# ╟─d894166f-a621-4526-ba3c-835b65935fb8
# ╟─5bc22efb-fa0f-42e0-9ede-f59eecd518f3
# ╟─3d144c31-6647-4c4e-8930-ee58f8adce2f
