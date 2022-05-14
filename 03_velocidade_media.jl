### A Pluto.jl notebook ###
# v0.19.4

using Markdown
using InteractiveUtils

# ╔═╡ 912a438e-2163-4f6f-9fe5-dcac17e45e6a
begin
	using Pkg
	Pkg.activate(".")
end

# ╔═╡ 0f796ad0-d790-11eb-31ac-5fee2b23265c
begin
	using CairoMakie
	using PlutoUI
	using LaTeXStrings
	using Unitful, UnitfulLatexify, Latexify
	using LinearAlgebra
	using HypertextLiteral
end

# ╔═╡ abe7637e-24c8-405d-8ce8-d913dd52c008
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

# ╔═╡ 2f5dd3cb-ec3c-4dca-87de-43f025582f95
TableOfContents(title = "Índice", depth = 4)

# ╔═╡ 6628158d-65e1-4538-8012-ef5b7164ce2d
md"""
## 1.3. Instante de tempo (``t``) e intervalo de tempo (``\Delta t``)

Além do deslocamento (``\Delta \vec{S}``), outra grandeza que é importante na descrição do movimento de um objeto é o intervalo de tempo  (``\Delta t``) necessário para a realização desse deslocamento. Dois objetos diferentes podem realizar o mesmo deslocamento (``\Delta \vec{S}``), mas se o objeto 1 demora um tempo ``\Delta t_{1}`` para completar o deslocamento, e o objeto 2 demora um tempo ``\Delta t_{2}`` para completá-lo, e ``\Delta t_{1} \neq \Delta t_{2}``, então, um dos objetos completou o deslocamento mais rapidamente que o outro. Os movimentos dos dois objetos são diferentes.

O instante de tempo representa o momento em que um certo evento ocorreu. Para medi-lo podemos usar o horário em que o evento ocorreu, ou o tempo que estava marcado em algum dispositivo de medição de tempo. Já o intervalo de tempo ``\Delta t`` é uma grandeza que representa o tempo decorrido entre dois eventos. Por exemplo, no caso de um deslocamento, se o objeto parte de sua posição inicial no instante ``t_0`` e chega ao seu destino no instante ``t_1``, o intervalo de tempo representa o tempo decorrido entre os instantes ``t_0`` e ``t_1``:

```math
\Delta 	t = t_1 - t_0
```

Para medir instantes ou intervalos de tempo podemos utilizar várias unidades:  segundos (s), minutos (min), horas (h), dias (d), anos. 

> **A unidade de tempo padrão no Sistema Internacional de Unidades é o segundo (s).**

A tabela abaixo mostra a relação entre as unidades de tempo:

|  | s | min | h | d | ano |
|:--|:--:|:--:|:--:|:--:|:--:|
|1 s | 1| 1/60| 1/3.600| 1/86.400| 1/31.556.925|
|1 min | 60| 1 | 1/60 | 1/1.440| 1/525.948,75 |
|1 h | 3.600| 60 | 1 | 1/24 | 1/8.765,81 |
|1 d | 86.400| 1.440 | 24 | 1 | 1/365,242 |
|1 ano | 31.556.925| 525.948,75 | 8.765,81| 365,242| 1|

O ano é uma unidade definida a partir de com fenômenos astronômicos e pode ser o ano tropical ou ano sideral. Em nossas medidas de tempo utilizamos o ano tropical que representa o intervalo de tempo necessário para um ciclo completo das estações do ano: do solstício de verão (início do verão) a solstício de verão.

"""

# ╔═╡ da868d30-a988-4245-9689-bd9c71d68cb1
md"""
## 1.4. Velocidade média (``\vec{v}_{\rm med}``)

A grandeza que representa a rapidez com que um objeto se deslocou de uma certa posição inicial até uma outra posição qualquer é chamada de velocidade média (``\vec{v}_{\rm med}``). A velocidade média de um objeto, portanto, depende de seu deslocamento ``\Delta \vec{S}`` entre essas duas posições, e do tempo decorrido ``\Delta t`` durante esse movimento, e pode ser calculada como:

```math
\vec{v}_{med} = \frac{\Delta \vec{S}}{\Delta t}.
```

**Como a velocidade média depende do deslocamento, ela terá a mesma quantidade de componentes que o deslocamento**: apenas uma componente no caso unidimensional; duas componentes no caso bidimensional; e três componentes no caso tridimensional.


>A unidade de medida de velocidade padrão no Sistema Internacional de Unidades (S.I.) é o ``\rm{m/s}`` que também pode ser escrita na forma ``\rm{m\,s^{-1}}``. Outra unidade muito utilizada é o ``\rm{km/h}`` ou ``\rm{km\,h^{-1}}``. 

### 1.4.1. Conversão de unidades (``\rm{m/s} \leftrightarrow \rm{km/h}``) 

Podemos converter facilmente entre as unidades de velocidade. Por exemplo, para converter ``1\,{\rm km\,h^{-1}}`` para ``1\,{\rm m\,s^{-1}}``, devemos converter cada unidade separadamente (``1\,{\rm km} = 1000\,{\rm m}`` e ``1\,{\rm h} = 3600\,{\rm s}``):

```math
1\,\frac{\rm km}{\rm h} = 1\,\frac{1000\,\rm{m}}{3600\,{\rm s}} = \frac{1}{3{,}6} \frac{\rm m}{\rm s}
```

Ou invertendo a conversão:

```math
1\,\frac{\rm m}{\rm s} = 3{,}6\,\frac{\rm km}{\rm h}.
```

Utilizando os fatores encontrados acima, para converter a velocidade de ``100\,\rm{km\,h^{-1}}`` para ``\rm{m\,s^{-1}}``, precisamos apenas dividir o valor que indica a velocidade pelo fator ``3{,}6``:

```math
100\,\frac{\rm km}{\rm h} = \frac{100}{3{,}6} \frac{\rm m}{\rm s} = 27{,}8\,\rm{\frac{m}{s}}.
```

Fazendo o inverso, e convertendo ``20\,\rm{m\,s^{-1}}`` para ``\rm{km\,h^{-1}}``, multiplicamos o valor da velocidade pelo fator ``3{,}6``:

```math
20\,\frac{\rm m}{\rm s} = 20 \cdot 3{,}6\,\frac{\rm km}{\rm h} = 72\,\frac{\rm km}{\rm h}.
```
"""

# ╔═╡ c4427b6d-6ad8-4590-a4a7-2c96c46554f6
md"""

### 1.4.2. Velocidade média em 1D

Quando temos apenas 1 dimensão, o deslocamento do objeto pode ser descrito utilizando apenas uma medida (positiva ou negativa), portanto, a velocidade terá apenas um valor também, e, da mesma forma, este valor poderá ser positivo ou negativo:

```math
\vec{v}_{\rm med} = \frac{\Delta \vec{S}}{\Delta t} = \frac{\Delta x}{\Delta t}, \qquad \Delta x = x_1 - x_0.
```

``\Delta x`` representa o deslocamento em uma dimensão, ``x_1`` é a posição final e ``x_0`` é a posição inicial.

**A velocidade média SEMPRE tem o mesmo sentido (ou sinal) que o deslocamento!** 
"""

# ╔═╡ 745e380f-73c1-4cb7-a6cd-5584d18ac927
begin
	x0 = rand(-100:100)
	s0_1D = x0 * 1u"m"
end;

# ╔═╡ 7dc01621-b152-40a4-9fe7-03e21cd4d75f
begin
	x1 = rand(-100:100)
	s1_1D = x1 * 1u"m"
end;

# ╔═╡ fc368cb2-d469-4039-aa1b-1b4d77af55e8
Δt = rand(10:0.1:20);

# ╔═╡ efeb2879-1ce5-4852-9292-875f61970d02
md"""
O deslocamento durante o intervalo de tempo mostrado na animação foi:
"""

# ╔═╡ 97d58aec-9a61-444a-a90f-259d0e23d971
begin
	ΔS_1D = s1_1D - s0_1D
	latexify(:("Δ\\vec{S}" = $s1_1D - $s0_1D = $ΔS_1D))
end

# ╔═╡ 7312ca30-f370-40a8-be97-168d66b30bd6
md"
Usando o deslocamento calculado e o tempo decorrido durante esse deslocamento, calculamos a velocidade média:
"

# ╔═╡ 9083f07b-8584-435f-bb11-807ba7b9267b
begin
	Δt1d = Δt*1u"s"
	vmed1d = (s1_1D - s0_1D)/(Δt1d)
	latexstring("\\vec{v}_{\\rm med} = 
		\\frac{\\Delta \\vec{S}}{\\Delta t} = \\frac{",
		x1 - x0,"\\rm{\\, m}}{", 
		replace(string(Δt), "." => "{,}"), "\\rm{\\, s}} = ",
		replace(string(round(ustrip(vmed1d), sigdigits = 3)), "." => "{,}"),
		"\\rm{\\, m\\,s^{-1}}")
	#latexify(:("\\vec{v}_{med} = \\frac{\\overrightarrow{\\Delta S}}{\\Delta t}" 
	#	= $ΔS_1D/$Δt1d =  $vmed1d))
end

# ╔═╡ 04191118-0cb5-4c29-a7a4-615014a2740f
md"""
**O sinal na frente da velocidade indica o sentido do movimento.** No caso acima, se a velocidade é positiva o sentido do movimento é para a direita, e se for negativa o sentido do movimento é para a esquerda.
"""

# ╔═╡ 2eb20242-1d87-4f53-8bd8-ec24c4642ca6
md"""
### 1.4.3. Velocidade média em 2D

Quando estamos analisando o movimento em duas dimensões, sabemos que o deslocamento tem duas componentes e, portanto, a velocidade média também terá duas componentes:

```math
\vec{v}_{\rm med} = \frac{\Delta \vec{S}}{\Delta t} = \left( \frac{\Delta x}{\Delta t}, \, \frac{\Delta y}{\Delta t} \right),
```

onde ``\Delta x = x_1 - x_0`` e ``\Delta y = y_1 - y_0``. A primeira componente  da velocidade média ``\left(\Delta x / \Delta t\right)`` representa a velocidade média na direção ``x`` , e a segunda componente ``\left(\Delta y / \Delta t\right)`` representa a velocidade média na direção ``y``. 

> Como no caso unidimensional, e em todos os casos, as componentes da velocidade média podem ser positivas ou negativas, a depender do deslocamento (positivo ou negativo) nas respectivas direções. **A velocidade média sempre tem a mesma direção e mesmo sentido que o deslocamento!**
"""

# ╔═╡ a506c64d-9873-4d4d-893d-1fa6d05f264c
x02d = Point2f(rand(-100:100, 2));

# ╔═╡ 0cf36440-d6ab-44fa-b83c-6850be4b7136
x12d = Point2f(rand(-100:100, 2));

# ╔═╡ 1b24d84b-8827-4f25-bb03-67734c90ab4c
begin
	Δt2d = rand(10:25)
	framerate2d = 15
	frames2d = Δt2d * framerate2d
	traj_x_2d = range(x02d[1], x12d[1], length = frames2d)
	traj_y_2d = range(x02d[2], x12d[2], length = frames2d)
	traj2d = [Point2f(traj_x_2d[i], traj_y_2d[i]) for i ∈ 1:frames2d]
end;

# ╔═╡ 470de65e-672b-4e36-84f5-34c72f0e03d5
md"""
#### Exemplo 2
A animação abaixo mostra o movimento de um objeto sobre uma superfície plana. O objeto parte de sua posição inicial em
"""

# ╔═╡ e36e7a7f-7bf6-4b63-b0fc-f8d57ee7deac
md"""
e se movimenta em linha reta até sua posição final em
"""

# ╔═╡ c4463d6a-58ca-4c50-a008-a27b46b1a4ed
md"""
O tempo decorrido durante esse deslocamento foi:
"""

# ╔═╡ fe6ba722-0083-4114-a433-6649379382f5
begin
	Δt2du = Δt2d*1u"s"
	latexify(:("\\Delta t" = $Δt2du))
end

# ╔═╡ ea2e6558-1412-4fe8-a054-5628d8c77b05
md"""
A partir das posições final e inicial do objeto, calculamos o deslocamento do objeto, que foi:
"""

# ╔═╡ 35b9766a-6a64-4c3d-91c4-631eadae7ab2
md"""
Com os valores de ``\overrightarrow{\Delta S}`` e ``\Delta t``, podemos, finalmente, encontrar a velocidade média do objeto durante esse movimento (com duas componentes):
"""

# ╔═╡ 796b6d70-6c4d-4a4b-826f-f5a5ff86cb31
begin
	x22d = Point2(rand(-100:100, 2))
	x32d = Point2(rand(-100:100, 2))
	Δt22d = rand(1.0:0.5:10)
end;

# ╔═╡ 7951a756-248f-4879-9198-2736445dafde
md"""
Uma pessoa dirigindo um carro parte da posição 
"""

# ╔═╡ 55647acf-31f1-4670-a414-564a62ec4179
md"""
em relação ao centro de sua cidade, e após decorrido o tempo de
"""

# ╔═╡ 99b836fc-5a90-44fa-882c-3b41b9671eb1
md"""
desde sua partida, a pessoa chega em seu destino final em
"""

# ╔═╡ b48cc61a-7200-40ef-828d-869d6f6424a4
md"""
também em relação ao centro de sua cidade.

Note que **não temos nenhuma informação sobre o que aconteceu durante o tempo decorrido durante esses deslocamento**: não sabemos qual o caminho percorrido e nem a distância total percorrida pelo motorista; não sabemos se o motorista parou o carro em algum momento para comer, para abastecer o carro, ou para descansar; não sabemos em qual momento o velocímetro do carro atingiu seu valor máximo; etc. **Contudo temos todas as informações necessárias para calcular o deslocamento e a velocidade média da pessoa dirigindo o carro!**

O deslocamento foi:
"""

# ╔═╡ 1943a1d4-edbc-4e85-a39f-18ab5771e2c0
md"""
E a velocidade média foi:
"""

# ╔═╡ 693b5ea0-cd9e-4f25-aad6-0685efbcaac4
md"""
Podemos converter os valores em ``\rm{km/h}`` obtidos para cada componente da velocidade para a unidade padrão de velocidade ``\rm{m/s}``, dividindo cada valor por ``3{,}6``:
"""

# ╔═╡ 3e50edb2-52f9-4878-94fe-404139a99723
md"""
Usando as componentes da velocidade e utilizando o *teorema de Pitágoras*, conseguimos descobrir a distância que, em média, o motorista percorria a cada hora:
"""

# ╔═╡ b20aac39-9122-4113-b610-744422130582
md"""
Novamento, podemos converter o valor obtido em ``\rm{km /h}`` para ``\rm{m /s}``, como já vimos anteriormente:
"""

# ╔═╡ 20113036-db84-4040-84c4-14cb9c22710d
md"""
A velocidade média não nos dá informação alguma sobre o que ocorreu durante o movimento do objeto, mas ela nos diz como, em média, ocorreu o deslocamento em questão!

> Como no caso do deslocamento, a velocidade média também **NÃO DEPENDE** do caminho percorrido, mas apenas do deslocamento e do tempo decorrido!
"""

# ╔═╡ 72085173-ef0c-43c1-aba4-18ecce0e779f
begin
	
	function escrever_cal_desl_2d(s0::Point2, s1::Point2; digits = 0, unidade = "m")

		trocar_ponto_virgula(x) = replace(string(x), "." => "{,}")

		adicionar_unidade(x) = string(trocar_ponto_virgula(x), "\\rm{\\,", 
			unidade, "}")

		s0_arr = (digits == 0 ? round.(Int, s0) : round.(s0; digits = digits))
		s1_arr = (digits == 0 ? round.(Int, s1) : round.(s1; digits = digits))

		s01_str = s0[1] < 0 ? string("+", adicionar_unidade(abs(s0_arr[1]))) : string("-", adicionar_unidade(s0_arr[1]))
		s02_str = s0[2] < 0 ? string("+", adicionar_unidade(abs(s0_arr[2]))) : string("-", adicionar_unidade(s0_arr[2]))

		latexstring("\\Delta \\vec{S} = (", adicionar_unidade(s1_arr[1]),
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
			\\frac{\\Delta \\vec{S}}{\\Delta t} = 
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

	fmt(x) = replace(string(x), "." => "{,}")
end

# ╔═╡ 599a24c1-afb8-4173-b820-15ecd58f64c7
md"
#### Exemplo 1
A animação abaixo mostra um objeto se movendo de sua posição inicial ``\vec{S}_0`` = $s0_1D, até a posição final ``\vec{S}_1 =`` $s1_1D, em um intervalo de tempo ``\Delta t = `` $(trocarpontovirgtexto(Δt; digits = 1)) s.
"

# ╔═╡ cd56ffd5-c110-4b99-ac96-824a8ff7d787
begin
	fig_01 = Figure(resolution = (1000, 250), backgroundcolor = :lightgreen)
	ax_01 = fig_01[1, 1] = Axis(fig_01, aspect = DataAspect(),
		backgroundcolor = :Gray70,
		xlabel = "Posição x (m)")
	
	hlines!(ax_01, 0, linestyle = :dash, color = :white, linewidth = 3)
	
	#text!(ax_01, string("S₀ = ",s0_1D), position = (x0, 3),
	text!(ax_01, latexify(:("\\vec{S}_0" = $s0_1D)), position = (x0, 3),
		align = (:left, :bottom), color = :black, textsize = 17)
	
	scatter!(ax_01, Point2f(x0, 0), markersize = 15, color = (:black, 0.5))
	
	ax_01.title = "Deslocamento (1D)"
	limits!(ax_01, x0 - 140, x0 + 140,  -20, 20)
	hideydecorations!(ax_01)
	hidespines!(ax_01)

	framerate = 15
	nframes = framerate*Int64(ceil(Δt, digits = 0))
	traj_1d = range(x0,x1,length = nframes)

	xt1d = Observable(Float64(x0))
	cron1d = Observable(zero(Float64))
	scatter!(ax_01, @lift(Point2f($xt1d, 0)), markersize = 15, 
		color = :dodgerblue)

	arrows!(ax_01, [x0], [0], @lift([$xt1d - x0]), [0], arrowsize = 15,
		color = (:red, 0.5), linewidth = 3)
	text!(ax_01, 
		@lift(latexstring("\\vec{S}_1 = ", trocarpontovirglatex($xt1d, digits = 1), " \\, \\mathrm{m}")), 
		position = @lift(Point2f($xt1d, -3)),
		align = (:center, :top), color = :red, textsize = 17)

	if (x1-x0) < 0
		alinh_ΔS = :right
		offset_ΔS = -5
	else
		alinh_ΔS = :left
		offset_ΔS = 5
	end
	
	text!(ax_01, L"Δ\vec{S}", 
		position = @lift(Point2f($xt1d + offset_ΔS, 0)),
		align = (alinh_ΔS, :bottom), color = :red, textsize = 17)
	
	#text!(ax_01, @lift(string("t = ", round($cron1d, digits = 1), " s")),
	text!(ax_01, @lift(latexstring("t = ", trocarpontovirglatex($cron1d, digits = 1), " \\, \\mathrm{s}")),
		position = (x0 + 120, -18),
		align = (:right, :bottom),
		color = :black,
		textsize = 17)

	record(fig_01, "traj_1D.mp4", 1:nframes+2*framerate; framerate = framerate) do i
		xt1d[] =  (i < nframes ? traj_1d[i] : x1)
		cron1d[] = (i < nframes ? (i-1)/framerate : Δt)
		notify.((xt1d, cron1d))
		sleep(1/framerate)
	end

	LocalResource("./traj_1D.mp4")
end

# ╔═╡ fed98808-856c-450c-9535-bd7b39bb1158
latexstring("\\vec{S}_0 = (",trocarpontovirglatex(x02d[1]),"\\rm{\\, m},\\,",
	trocarpontovirglatex(x02d[2]), "\\rm{\\, m}),")

# ╔═╡ 48a72747-76df-46dd-847e-526dacd6e748
latexstring("\\vec{S}_1 = (",trocarpontovirglatex(x12d[1]),"\\rm{\\, m},\\,",
	trocarpontovirglatex(x12d[2]), "\\rm{\\, m}).")

# ╔═╡ dc8b439b-da3a-4aaf-874c-02843b4d38f8
begin
	fig_02 = Figure(resolution = (800, 800), backgroundcolor = :gray80)
	ax_02 = fig_02[1, 1] = Axis(fig_02, aspect = DataAspect(),
		backgroundcolor = :white,
		xlabel = "Posição x (m)",
		ylabel = "Posição y (m)",
		title = "Movimento 2D")
	
	scatter!(ax_02, Point2(0), marker = :rect, color = :black)
	scatter!(ax_02, x02d, marker = :circle, markersize = 20, 
		color = (:blue, 0.5))
	text!(ax_02, 
		latexstring("\\vec{S}_0 = (", trocarpontovirglatex(x02d[1], digits = 1),
			"\\, \\mathrm{m}, \\:", trocarpontovirglatex(x02d[2], digits = 1), 
			"\\, \\mathrm{m})"),
		position = (x02d[1]+5, x02d[2]-5),
		align = (:center, :center),
		color = :blue,
		textsize = 18)
	
	st2d = Observable(x02d)
	cron2d = Observable(zero(Float64))
	
	scatter!(ax_02, st2d, marker = :circle, markersize = 20,
		color = :dodgerblue)
	
	text!(ax_02, 
		@lift(latexstring("\\vec{S}_1 = (", trocarpontovirglatex($st2d[1], digits = 1), "\\, \\mathrm{m}, \\: ",
				trocarpontovirglatex($st2d[2], digits = 1), "\\, \\mathrm{m})")),
			position = @lift(Point2f($st2d[1] -5, $st2d[2] + 5)),
			align = (:center, :center),
			color = :dodgerblue,
			textsize = 18)
	
	text!(ax_02, @lift(latexstring("\\Delta t = ", trocarpontovirglatex($cron2d, digits = 1), " \\, \\mathrm{s}")),
		position = (110, 110),
		align = (:right, :top),
		color = :black,
		textsize = 18)
	
	arrows!(ax_02, [x02d[1]], [x02d[2]], @lift([$st2d[1] - x02d[1]]),
		@lift([$st2d[2] - x02d[2]]),
		linewidth = 3,
		arrowsize = 18,
		color = (:red, 0.9))
	
	limits!(ax_02, -120, 120, -120, 120)
	
	CairoMakie.Makie.record(fig_02, "traj_2D.mp4", 1:frames2d+2*framerate2d; 
		framerate = framerate2d) do i
		
		st2d[] = i < frames2d ? traj2d[i+1] : x12d
		cron2d[] = i < frames2d ? (i-1)/framerate : Δt2d
	end

	LocalResource("./traj_2D.mp4")
end

# ╔═╡ e0fb68a0-eb8d-4797-bfbc-014c5d322c56
begin
	#adicionando unidades nos valores sorteados
	s12d = x12d*1u"m"
	s02d = x02d*1u"m"
	
	Δx2d = x12d - x02d
	escrever_cal_desl_2d(x02d, x12d)
end

# ╔═╡ 78b2e836-2007-4a22-9d8d-23886cf2b708
escrever_cal_vmed_2d(Δx2d, Δt2d; digits = 2)

# ╔═╡ 91746c50-37e2-4638-b395-2899d7d7e357
begin
	vm2d = (x12d - x02d)/Δt2d
	vmed2d = 1u"m/s"*vm2d
	latexstring("v_{\\rm med} = \\sqrt{ \\left(", 
		trocarpontovirglatex(vm2d[1]; digits = 2),
		"\\rm{\\, m \\, s^{-1}}\\right)^{2} + \\left(",
		trocarpontovirglatex(vm2d[2]; digits = 2),
		"\\rm{\\, m \\, s^{-1}}\\right)^{2}}")
end

# ╔═╡ da13a9f5-ade7-4755-a4cf-2b32b760d239
md"""
Podemos notar pela figura que o objeto se movimenta sobre o segmento de reta vermelho, ou seja, durante todo o movimento mostrado na animação, sua posição ficou sobre esse segmento de reta. A velocidade média calculada para o objeto nos diz que, a cada segundo que passa, sua posição na direção ``x`` varia  $(trocarpontovirgtexto(vm2d[1]; digits = 2)) m, e, ao mesmo tempo,  varia $(trocarpontovirgtexto(vm2d[2]; digits = 2)) m na direção ``y``. 

Podemos utilizar o *teorema de Pitágoras* com esses valores de deslocamento nas direções ``x`` e ``y`` a cada segundo, para calcular a distância percorrida pela objeto durante esse segundo sobre o segmento de reta que representa sua trajetória. Esse valor é SEMPRE positivo, e é conhecido como *módulo da velocidade*. Vamos representá-lo como ``v_{\rm med}`` (**sem a seta flutuante sobre o ``v``**):
"""

# ╔═╡ 3db217bf-aa65-4505-a0ff-0e7520c36b21
latexstring("v_{\\rm med} = \\sqrt{", 
	trocarpontovirglatex(vm2d[1]^2; digits = 2),
	"\\rm{\\, m^2 \\, s^{-2}} + ",
	trocarpontovirglatex(vm2d[2]^2; digits = 2),
	"\\rm{\\, m^2 \\, s^{-2}}}")

# ╔═╡ 1dab267f-7e5e-4639-83ab-0121c7602665
latexstring("v_{\\rm med} = \\sqrt{", 
	trocarpontovirglatex((vm2d[1]^2 + vm2d[2]^2); digits = 2),
	"\\rm{\\, m^2 \\, s^{-2}}} \\Rightarrow \\boxed{v_{\\rm med} = ", 
	trocarpontovirglatex(norm(vm2d); digits = 2),
	"\\rm{\\, m \\, s^{-1}}.}")

# ╔═╡ 224a9744-40fc-430d-821d-db013559e9c5
md"""
Isso quer dizer que o objeto percorre uma distância de $(trocarpontovirgtexto(norm(vm2d); digits = 2)) m a cada segundo sobre o segmento de reta que representa sua trajetória. 

#### Exemplo 3
No caso acima, vemos a trajetória percorrida pelo objeto, mas nem sempre isso será possível. Podemos ter uma situação em que sabemos apenas a posição de partida do objeto, sua posição final e o tempo decorrido para o objeto chegar de uma posição até a outra. Por exemplo:

"""

# ╔═╡ eb5f0cf3-ba85-4bae-9b0e-2df35a63c1b0
latexstring("\\vec{S}_0 = (",trocarpontovirglatex(x22d[1]),"\\rm{\\, km},\\,",
	trocarpontovirglatex(x22d[2]), "\\rm{\\, km}),")

# ╔═╡ 02b45120-1c3c-4327-8733-b0b899b9797c
latexstring("\\Delta t = ",trocarpontovirglatex(Δt22d),"\\rm{\\, h}")

# ╔═╡ deea844a-4da2-4cc0-8016-a36a2ea47726
latexstring("\\vec{S}_1 = (",trocarpontovirglatex(x32d[1]),"\\rm{\\, km},\\,",
	trocarpontovirglatex(x32d[2]), "\\rm{\\, km}),")

# ╔═╡ d6850c4c-409c-4fc3-a807-a7f0b355129d
begin
	ΔS22d = x32d - x22d
	escrever_cal_desl_2d(x22d, x32d; unidade = "km")
end

# ╔═╡ 05094fbe-5e6a-4b6f-9a32-45766c1dc177
begin
	vmed22d = ΔS22d/Δt22d
	escrever_cal_vmed_2d(ΔS22d, Δt22d; digits = 1, ucomp = "km", utemp = "h")
end

# ╔═╡ b45e553b-3ca4-4d54-91d9-6dc532e0fb0c
latexstring("\\vec{v}_{\\rm med} = (",
	trocarpontovirglatex(vmed22d[1]/3.6; digits = 1),
	"\\rm{\\, m \\, s^{-1}},\\,", 
	trocarpontovirglatex(vmed22d[2]/3.6; digits = 1), 
	"\\rm{\\, m \\, s^{-1}}).")

# ╔═╡ cac37bb1-beca-4c3a-882c-e5acbc9f7ad5
latexstring("v_{\\rm med} = \\sqrt{ \\left(", 
	trocarpontovirglatex(vmed22d[1]; digits = 1),
	"\\rm{\\, km \\, h^{-1}}\\right)^{2} + \\left(",
	trocarpontovirglatex(vmed22d[2]; digits = 1),
	"\\rm{\\, km \\, h^{-1}}\\right)^{2}}")

# ╔═╡ 5ae63a2d-e0a4-4bfb-befe-e5583f0f0716
latexstring("v_{\\rm med} = \\sqrt{", 
	trocarpontovirglatex((vmed22d[1]^2 + vmed22d[2]^2); digits = 1),
	"\\rm{\\, km^2 \\, h^{-2}}} \\Rightarrow \\boxed{v_{\\rm med} = ", 
	trocarpontovirglatex(norm(vmed22d); digits = 1),
	"\\rm{\\, km \\, h^{-1}}.}")

# ╔═╡ 6ddd7136-f817-4215-b7b7-e910983ccf17
latexstring("v_{\\rm med} = ", 
	trocarpontovirglatex(norm(vmed22d)/3.6; digits = 1),
	"\\rm{\\, m \\, s^{-1}}.")

# ╔═╡ Cell order:
# ╠═abe7637e-24c8-405d-8ce8-d913dd52c008
# ╟─912a438e-2163-4f6f-9fe5-dcac17e45e6a
# ╟─0f796ad0-d790-11eb-31ac-5fee2b23265c
# ╟─2f5dd3cb-ec3c-4dca-87de-43f025582f95
# ╟─6628158d-65e1-4538-8012-ef5b7164ce2d
# ╟─da868d30-a988-4245-9689-bd9c71d68cb1
# ╟─c4427b6d-6ad8-4590-a4a7-2c96c46554f6
# ╟─745e380f-73c1-4cb7-a6cd-5584d18ac927
# ╟─7dc01621-b152-40a4-9fe7-03e21cd4d75f
# ╟─fc368cb2-d469-4039-aa1b-1b4d77af55e8
# ╟─599a24c1-afb8-4173-b820-15ecd58f64c7
# ╟─cd56ffd5-c110-4b99-ac96-824a8ff7d787
# ╟─efeb2879-1ce5-4852-9292-875f61970d02
# ╟─97d58aec-9a61-444a-a90f-259d0e23d971
# ╟─7312ca30-f370-40a8-be97-168d66b30bd6
# ╟─9083f07b-8584-435f-bb11-807ba7b9267b
# ╟─04191118-0cb5-4c29-a7a4-615014a2740f
# ╟─2eb20242-1d87-4f53-8bd8-ec24c4642ca6
# ╟─a506c64d-9873-4d4d-893d-1fa6d05f264c
# ╟─0cf36440-d6ab-44fa-b83c-6850be4b7136
# ╟─1b24d84b-8827-4f25-bb03-67734c90ab4c
# ╟─470de65e-672b-4e36-84f5-34c72f0e03d5
# ╟─fed98808-856c-450c-9535-bd7b39bb1158
# ╟─e36e7a7f-7bf6-4b63-b0fc-f8d57ee7deac
# ╟─48a72747-76df-46dd-847e-526dacd6e748
# ╟─c4463d6a-58ca-4c50-a008-a27b46b1a4ed
# ╟─fe6ba722-0083-4114-a433-6649379382f5
# ╟─dc8b439b-da3a-4aaf-874c-02843b4d38f8
# ╟─ea2e6558-1412-4fe8-a054-5628d8c77b05
# ╟─e0fb68a0-eb8d-4797-bfbc-014c5d322c56
# ╟─35b9766a-6a64-4c3d-91c4-631eadae7ab2
# ╟─78b2e836-2007-4a22-9d8d-23886cf2b708
# ╟─da13a9f5-ade7-4755-a4cf-2b32b760d239
# ╟─91746c50-37e2-4638-b395-2899d7d7e357
# ╟─3db217bf-aa65-4505-a0ff-0e7520c36b21
# ╟─1dab267f-7e5e-4639-83ab-0121c7602665
# ╟─224a9744-40fc-430d-821d-db013559e9c5
# ╟─796b6d70-6c4d-4a4b-826f-f5a5ff86cb31
# ╟─7951a756-248f-4879-9198-2736445dafde
# ╟─eb5f0cf3-ba85-4bae-9b0e-2df35a63c1b0
# ╟─55647acf-31f1-4670-a414-564a62ec4179
# ╟─02b45120-1c3c-4327-8733-b0b899b9797c
# ╟─99b836fc-5a90-44fa-882c-3b41b9671eb1
# ╟─deea844a-4da2-4cc0-8016-a36a2ea47726
# ╟─b48cc61a-7200-40ef-828d-869d6f6424a4
# ╟─d6850c4c-409c-4fc3-a807-a7f0b355129d
# ╟─1943a1d4-edbc-4e85-a39f-18ab5771e2c0
# ╟─05094fbe-5e6a-4b6f-9a32-45766c1dc177
# ╟─693b5ea0-cd9e-4f25-aad6-0685efbcaac4
# ╟─b45e553b-3ca4-4d54-91d9-6dc532e0fb0c
# ╟─3e50edb2-52f9-4878-94fe-404139a99723
# ╟─cac37bb1-beca-4c3a-882c-e5acbc9f7ad5
# ╟─5ae63a2d-e0a4-4bfb-befe-e5583f0f0716
# ╟─b20aac39-9122-4113-b610-744422130582
# ╟─6ddd7136-f817-4215-b7b7-e910983ccf17
# ╟─20113036-db84-4040-84c4-14cb9c22710d
# ╟─72085173-ef0c-43c1-aba4-18ecce0e779f
