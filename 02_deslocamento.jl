### A Pluto.jl notebook ###
# v0.19.0

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

# ╔═╡ 960d6d9b-6684-4baa-8c5f-a0f5ec34b05c
begin
 	import Pkg
 	Pkg.activate(".")
end

# ╔═╡ e1aa4440-cf69-11eb-1dd2-1b847285684d
begin
	using CairoMakie
	using Unitful, Latexify, UnitfulLatexify, LaTeXStrings
	using LinearAlgebra, HypertextLiteral, PlutoUI
	TableOfContents(title = "Índice", depth = 4)
end

# ╔═╡ 7db9af1c-de19-4e79-978b-3109a48d427b
CairoMakie.activate!(type = "svg")

# ╔═╡ be391955-d06e-414b-9b33-6add82c0ded4
md"""
## 1.2. Deslocamento (``\Delta \vec{S}``)

O deslocamento é uma grandeza que representa a variação da posição de um objeto em relação à sua posição inicial, e iremos representá-la como ``\Delta \vec{S}``. Se um objeto parte de uma posição inicial ``\vec{S}_0`` e chega a uma outra posição ``\vec{S}_1``, seu deslocamento durante esse movimento foi:

```math
\Delta \vec{S} = \vec{S}_1 - \vec{S}_0
```
"""

# ╔═╡ acac2ee7-c243-43a0-bb5a-fd1ec63d0eb2
md"""

### 1.2.1. Deslocamento em 1D 

Quando o caso estudado pode ser simplificado para o movimento em apenas 1 dimensão, podemos representar a posição inicial do um objeto como ``\vec{S}_0 = x_0``. Se após um movimento a posição do objeto torna-se ``\vec{S}_1 = x_1``, então seu deslocamento foi:

```math
\Delta \vec{S} = x_1 - x_0,
```

sendo que o deslocamento pode ter valores positivos e negativos. O deslocamento também é representado utilizando-se unidades de comprimento.

**Se um objeto está parado, seu deslocamento é zero!**

> De acordo com sua definição matemática, o deslocamento pode ser entendido como a posição atual do objeto em relação à sua posição inicial.
"""

# ╔═╡ 6a1bca68-40d9-4bc3-9131-31de5bab60d5
begin
	x0 = rand(-100:100)
	x0_1D = x0 * 1u"m"
end;

# ╔═╡ 9586d30c-67d4-44dc-80ce-9348adeba0e0
md"""
Selecione a posição ``\vec{S}_1`` (em m):

$(@bind xd_1D PlutoUI.Slider(ustrip(x0_1D)-100:ustrip(x0_1D)+100; 
	default = x0_1D, show_value = true))
"""

# ╔═╡ 865bcf7e-73e2-40f8-aefe-ab393c8de748
begin
	fig_01 = Figure(resolution = (800, 200), backgroundcolor = :lightgreen)
	ax_01 = fig_01[1, 1] = Axis(fig_01, aspect = DataAspect(),
		backgroundcolor = :Gray70,
		xlabel = "Posição x (m)")
	
	x1_1D = xd_1D * 1u"m"
	
	hlines!(ax_01, 0, linestyle = :dash, color = :white, linewidth = 3)
	
	scatter!(ax_01, [x0, xd_1D], [0, 0], markersize = 20, 
		color = [(:dodgerblue, 0.3), (:red, 0.5)])
	
	arrows!(ax_01, [x0], [0], [xd_1D - x0], [0],
		color = (:dodgerblue, 0.9),
		linewidth = 4,
		arrowsize = 20)
	
	text!(ax_01, latexstring("\\vec{S}_{0} = ", x0_1D), position = (x0, 4),
		align = (:center, :bottom), color = :dodgerblue, textsize = 18)
	text!(ax_01, latexstring("\\vec{S}_{1} = ",x1_1D), position = (xd_1D, -4),
		align = (:center, :top), color = :red, textsize = 18)
	
	if (xd_1D - x0 >= 0)
		align_ΔS = :left
		offset = 8
	else
		align_ΔS = :right
		offset = -8
	end
	
	text!(ax_01, latexstring("Δ\\vec{S} = ", x1_1D - x0_1D), 
		position = (xd_1D + offset, 0),
		align = (align_ΔS, :center), color = :green, textsize = 20)
		
	ax_01.title = "Deslocamento (1D)"
	limits!(ax_01, x0 - 140, x0 + 140,  -20, 20)
	hideydecorations!(ax_01)
	hidespines!(ax_01)
	
	fig_01
end

# ╔═╡ da6e713f-43ef-4251-a78a-74847a7369a7
md"""
No exemplo ilustrado acima, temos um objeto que inicialmente está na posição ``\vec{S}_0 = `` $x0_1D, e se movimenta até a posição ``\vec{S}_1 = `` $x1_1D. O deslocamento desse objeto foi ``\Delta \vec{S} = `` $(x1_1D - x0_1D). De acordo com a convenção utilizada na imagem, um deslocamento positivo indica que o movimento foi para a direita, e um deslocamento negativo indica movimento para a esquerda.

Como no caso da posição, o sinal é importante e, para o deslocamento em 1D, indica o sentido do movimento do objeto.

A distância do objeto em relação à sua posição inicial é dada pelo módulo de seu deslocamento. 

```math
d_{1,0} = |\Delta \vec{S}| = |x_1 - x_0|.
```
**Lembrando que a distância é uma grandeza sempre positiva e, por isso, usamos o módulo do deslocamento!**
"""

# ╔═╡ dc2c63bf-8c31-4849-a1b2-ba12e1065b49
md"""
#### Distância total percorrida em 1D

A distância total percorrida ao longo de um movimento representa o comprimento de todo o caminho percorrido pelo objeto e é diferente do deslocamento. Também é diferente da distância em relação à posição inicial do objeto. Vamos representar a distância percorrida como ``D``, para diferenciar da distância entre dois pontos ``d_{1,2}``.

**A distância total percorrida também é sempre positiva!**

O caso ilustrado acima é um caso dos mais simples, temos apenas um movimento da posição inicial ``\vec{S}_0`` para a posição final ``\vec{S}_1``. Nesse caso mais simples, a distância total percorrida (``D``) é igual à distância entre ``\vec{S}_0`` e ``\vec{S}_1`` (``d_{1,0}``). Entretanto, isso não é o que acontece na maioria dos casos.

Abaixo temos a ilustração de um caso onde isso não acontece.
"""

# ╔═╡ c0cce94d-4982-4fb6-934c-48744c276133
begin
	np_1D = 6
	p_nomes_1D = ["S₀", "S₁", "S₂", "S₃", "S₄", "S₅"]
	cores = [:dodgerblue, :red, :green, :darkorange, :purple, :pink]
	alpha_x = LinRange(0.3, 0.9, np_1D)
	cor_x_1D = []
	for i ∈ 1:np_1D
		push!(cor_x_1D, (cores[i], alpha_x[i]))
	end
	#x_1D = rand(-100:100, np_1D)
	x_1D = [13, -65, -92, 29, 55, -42]
	p_1D = [Point2f(x, 0) for x ∈ x_1D]
end;

# ╔═╡ b77ab228-83d0-462e-98c4-a22bde2bd5d4
md"""
No caso ilustrado abaixo, o objeto sai de sua posição inicial ``\vec{S}_0 = `` $(x_1D[1] * 1u"m") e passa por outros $(np_1D-1) pontos sobre a mesma reta ou linha ao longo de seu movimento. 

Em seu primeiro movimento, o objeto chega à posição ``\vec{S}_1 = `` $(x_1D[2] * 1u"m"). Após o primeiro movimento, o deslocamento do em relação à sua posição inicial foi:
"""

# ╔═╡ fd9ebea6-51fd-4ad5-a684-1091382e1874
latexstring("\\overrightarrow{\\Delta S}_{0,1} = \\vec{S}_1 - \\vec{S}_2 = ",
	x_1D[2], "\\rm{\\, m} - (", x_1D[1], "\\rm{\\, m}) = ", ((x_1D[2] - x_1D[1])*1u"m"))

# ╔═╡ fa5d1fa9-9cf8-4a66-a15d-b883992d22ce
md"""
E até aqui, a distância total percorrida foi igual à distância entre ``\vec{S}_1`` e ``\vec{S}_0``: 
"""

# ╔═╡ 7458bac8-a49d-4443-b59b-4dedf8213721
latexstring("D_{0,1} = |", x_1D[2] - x_1D[1], "\\rm{\\, m}| =", 
	abs(x_1D[2] - x_1D[1]), "\\rm{\\, m}")

# ╔═╡ 3d00751d-261d-4683-bcae-486bf073ff93
md"""
Após o primeiro movimento, o objeto se move para as posições ``\vec{S}_2 = `` $(x_1D[3] * 1u"m"), ``\vec{S}_3 = `` $(x_1D[4] * 1u"m"), ``\vec{S}_4 = `` $(x_1D[5] * 1u"m") e ``\vec{S}_5 = `` $(x_1D[6] * 1u"m"). Para ver o que acontece com o ``\Delta \vec{S}`` e ``D`` ao longo do movimento, selecione o número de pontos ao longo da trajetória:

$(@bind tr_1D PlutoUI.Slider(2:np_1D; show_value = true))
"""

# ╔═╡ 7ea13518-1c1b-4a52-ac50-ff7211a927d3
begin
	fig_02 = Figure(resolution = (800, 400), backgroundcolor = :lightgreen)
	ax_02 = fig_02[1, 1] = Axis(fig_02, aspect = DataAspect(),
		backgroundcolor = :Gray70,
		xlabel = "Posição x (m)")
	
	hlines!(ax_02, 0, linestyle = :dash, color = :white, linewidth = 3)	
	scatter!(ax_02, p_1D[1:tr_1D], markersize = 15, color = cor_x_1D[1:tr_1D])
	
	text!(ax_02, p_nomes_1D[1],
			position = (x_1D[1], -3), 
			align = (:center, :top),
			color = :black,
			textsize = 16)
	text!(ax_02, string(1u"m"*x_1D[1]),
			position = (x_1D[1], -10), 
			align = (:center, :top),
			color = :black,
			textsize = 16)
	
	dist_perc_fig02 = 0u"m"
	ΔS_fig02 = 0u"m"
	
	arrows!(ax_02, [x_1D[1]], [0.0],
			[x_1D[tr_1D] - x_1D[1]], [0.0],
			color = :blue,
			linewidth = 3,
			arrowsize = 15)
	
	text!(ax_02, L"\Delta\vec{S}", position = ((x_1D[tr_1D] + x_1D[1])/2, 0.5),
		align = (:center, :bottom),
		color = :blue,
		textsize = 20)

	for i ∈ 1:tr_1D - 1
		arrows!(ax_02, [x_1D[i]], [25 - 2.5*i], 
			[x_1D[i+1] - x_1D[i]], [0.0], 
			color = cores[i],
			linewidth = 3,
			arrowsize = 15)
		
		#arrows!(ax_02, [p_1D[i][1]], [(-1)^i * (i-1) * 2], 
		#	[p_1D[i+1][1] - p_1D[i][1]], [0.0], 
		#	color = cores[i],
		#	linewidth = 3,
		#	arrowsize = 15)
		
		iseven(i) ? py_align = :bottom : py_align = :top
		
		text!(ax_02, p_nomes_1D[i+1],
			position = (x_1D[i+1], -3), 
			align = (:center, :top),
			color = :black,
			textsize = 16)
		text!(ax_02, string(1u"m"*x_1D[i+1]),
			position = (x_1D[i+1], -10), 
			align = (:center, :top),
			color = :black,
			textsize = 16)
		
		#text!(ax_02, string(p_nomes_1D[i+1]," = ", 1u"m"*x_1D[i+1]),
		#	position = (x_1D[i+1], (-1)^i * 1.5 * i), 
		#	align = (:center, py_align),
		#	color = :black,
		#	textsize = 15)
		
		global ΔS_fig02 = (x_1D[i+1] - x_1D[1])*1u"m"
		global dist_perc_fig02 += abs(x_1D[i+1] - x_1D[i])*1u"m"
	end
	
	fig_02[2, 1] = vgrid!(
		Label(fig_02, string("deslocamento: ΔS = ", ΔS_fig02), 
			textsize = 20, color = :black),
		Label(fig_02, string("distância total percorrida: D = ", dist_perc_fig02),
			textsize = 20);
		tellheight = true)
	
	fe_sublayout = GridLayout()
	fig_02[1:2, 1] = fe_sublayout
	colsize!(fe_sublayout, 1, Fixed(780))
	
	ax_02.title = "Deslocamento x distância percorrida (1D)"
	limits!(ax_02, -140, 140,  -25, 25)
	hideydecorations!(ax_02)
	hidespines!(ax_02)
	
	fig_02
end

# ╔═╡ a024ac5b-2a06-4648-a250-2e5bccea63cd
md"""
Após chegar a ``\vec{S}_1`` o objeto se movimenta para ``\vec{S}_2`` = $(x_1D[3]) m. O deslocamento de ``\vec{S}_1`` para ``\vec{S}_2`` é:
"""

# ╔═╡ aa98f8a9-e241-4f5f-a0f6-25b7df8646ac
latexstring("\\Delta \\vec{S}_{1,2} = \\vec{S}_2 - \\vec{S}_1 = ",
	x_1D[3], "\\rm{\\, m} - (", x_1D[2], "\\rm{\\, m}) = ", ((x_1D[3] - x_1D[2])*1u"m"))

# ╔═╡ 8b00b1d3-8ecb-4ea5-a6e5-67a5bf28974c
md"""
A distância percorrida entre ``\vec{S}_1`` e ``\vec{S}_2`` foi:
"""

# ╔═╡ 4409491b-ce3b-4ed5-a494-db233ea2138e
latexstring("D_{1,2} = |", x_1D[3] - x_1D[2], "\\rm{\\, m}| =", 
	abs(x_1D[3] - x_1D[2]), "\\rm{\\, m}")

# ╔═╡ 8917309e-71d2-458f-90e4-6731703ecaf0
md"""
Para encontrar o deslocamento total entre ``\vec{S}_0`` e ``\vec{S}_2`` podemos somar os deslocamentos:
"""

# ╔═╡ f34c4f86-1825-4c00-8192-1d6d38f89470
latexstring("\\Delta \\vec{S}_{0,2} = \\Delta \\vec{S}_{0,1} +
	\\Delta \\vec{S}_{1,2} = ", 
	(x_1D[2] - x_1D[1]), "\\rm{\\, m} + (", (x_1D[3] - x_1D[2]), "\\rm{\\, m}) = ", 	((x_1D[3] - x_1D[1])*1u"m"), ",")

# ╔═╡ f62a257f-0c01-4e50-92b6-d40233de5174
md"""
ou simplesmente calcular em função das posições final e inicial:
"""

# ╔═╡ 494fc3c2-97b4-465c-aab3-b4ce2af388ce
latexstring("\\Delta \\vec{S}_{0,2} = \\vec{S}_2 - \\vec{S}_0 = ",
	x_1D[3], "\\rm{\\, m} - (", x_1D[1], "\\rm{\\, m}) = ", ((x_1D[3] - x_1D[1])*1u"m"), ".")

# ╔═╡ 035cfbd0-f6ae-4418-99ba-ec3d2a2c1376
md"""
Mas para calcular a distância total percorrida entre ``\vec{S}_0`` e ``\vec{S}_2``, o único método é somando a distância percorrida de ``\vec{S}_0`` a ``\vec{S}_1`` com a distância percorrida e de ``\vec{S}_1`` a ``\vec{S}_2``:
"""

# ╔═╡ fc6b570a-e555-4a3c-b101-58a36b0c64af
latexstring("D_{0,2} = D_{0,1} + D_{1,2} = ", abs(x_1D[2] - x_1D[1]), 
	"\\rm{\\, m} +", abs(x_1D[3] - x_1D[2]), "\\rm{\\, m} = ", 
	abs(x_1D[2] - x_1D[1]) + abs(x_1D[3] - x_1D[2]), "\\rm{\\, m.}")

# ╔═╡ ee6f369e-8e06-422d-8cea-3e5b4f7aa61d
md"""
Na imagem acima, podemos ver o que acontece com o deslocamento e com a distância total percorrida à medida que o objeto vai passando por outros pontos.

Após passar sair da posição ``\vec{S}_0 = x_0``, passar por ``n`` pontos e chegar a ``\vec{S}_n = x_n``, o deslocamento será, simplesmente:

```math
\Delta \vec{S}_{0,n} = \vec{S}_n - \vec{S}_0 = x_n - x_0.
```
"""

# ╔═╡ c695a264-ead1-43a8-bf2a-ef37a29e0a8f
md"""
Já a distância total percorrida entre ``\vec{S}_0`` e ``\vec{S}_n`` dependerá de todas as distâncias percorridas:

```math
D_{0,n} = D_{0,1} + D_{1,2} + D_{2,3} + \cdots + D_{n-1, n} =
```

```math
D_{0,n}  = |x_1 - x_0| + |x_2 - x_1| + |x_3 - x_2| + \cdots + |x_{n} - x_{n-1}|,
```

Podemos simplificar a representação dessa soma, utilizando um somatório:

```math
D_{0, n} = \sum_{i = 0}^{n-1}{|x_{i+1} - x_{i}|}.
```

Enquanto o deslocamento depende apenas da posição inicial e da posição final do objeto, a distância total percorrida depende de todo o caminho percorrido!

> Note que se o objeto voltar para sua posição inicial seu deslocamento é nulo!

"""

# ╔═╡ b78cf2f3-8779-4cf2-a42a-95fdc4f5a84d
md"""
### 1.2.2. Deslocamento em 2D

Para calcularmos o deslocamento em duas dimensões, seguiremos o mesmo procedimento do que fizemos no caso unidimensional. Quando um objeto se movimenta de sua posição inicial ``\vec{S}_0 = (x_0, \, y_0)`` até a posição ``\vec{S}_1 = (x_1, \, y_1)``, seu deslocamento é:

```math
\Delta \vec{S} = \vec{S}_1 - \vec{S}_0 = (x_1 - x_0, \, y_1 - y_0).
```
"""

# ╔═╡ 446e7932-9020-4fee-9fd3-4fdee2986c45
s0_2D = rand(-100:100, Point2);

# ╔═╡ e28de55a-d025-4c50-9bed-2295ff075335
s1_2D = rand(-100:100, Point2);

# ╔═╡ 3106aae8-71df-4c4e-bf15-a1d67e909df0
md"""
Podemos ver um exemplo na imagem abaixo. A posição inicial do objeto foi: 
"""

# ╔═╡ eaf030ff-0b66-4538-ab24-0f194a2958ad
latexstring("\\vec{S}_0 = (", s0_2D[1], "\\, \\rm{m},\\,", s0_2D[2], 
	"\\, \\rm{m}),")

# ╔═╡ b58a3e20-3572-4afa-ad06-4f7595f5a481
md"""
e após se movimentar chegou até a posição:
"""

# ╔═╡ 9eebff88-82c5-4ff6-a975-feb2c5130365
latexstring("\\vec{S}_1 = (", s1_2D[1], "\\, \\rm{m},\\,", s1_2D[2], 
	"\\, \\rm{m}).")

# ╔═╡ bd73ed2a-48ee-44b9-b2aa-c75b43b7f04d
md"Mostrar deslocamento: $(@bind mostrar_ΔS_1 CheckBox())"

# ╔═╡ 0626e7dc-c344-4591-b507-89de96f9d584
md"""
O deslocamento do objeto entre esses dois pontos foi:
"""

# ╔═╡ 773f24b6-1cb0-44d9-bc9c-22b71ca69780
latexstring("\\Delta \\vec{S}_{0,1} = \\vec{S}_1 - \\vec{S}_0 = (",
	s1_2D[1], "\\rm{\\, m} -(", s0_2D[1], "\\rm{\\, m}), ",
	s1_2D[2], "\\rm{\\, m} -(", s0_2D[2], "\\rm{\\, m}))")

# ╔═╡ 1589f9c8-4fef-4ff4-a522-3299e9647ff7
latexstring("\\Delta \\vec{S}_{0,1} = (",
	s1_2D[1] - s0_2D[1], "\\rm{\\, m}, ", s1_2D[2]-s0_2D[2], "\\rm{\\, m})")

# ╔═╡ b01c8724-408a-496b-887a-0ec7bc0da3a3
md"""
Aplicando o *Teorema de Pitágoras* no deslocamento, conseguimos calcular a distância entre o posição inicial e a posição final, que também é o módulo do deslocamento:
"""

# ╔═╡ db550412-ab78-4b23-89de-eeefadc9b0dd
latexstring("d_{0,1} = |\\Delta \\vec{S}| = \\sqrt{ (",
	s1_2D[1] - s0_2D[1],"\\rm{\\, m} )^2 + (", s1_2D[2] - s0_2D[2],
	"\\rm{\\, m} )^2} = \\sqrt{", (s1_2D[1] - s0_2D[1])^2 + (s1_2D[2] - s0_2D[2])^2,
	"\\rm{\\, m^2}} = ", 
	replace(string(round(norm(s1_2D - s0_2D), digits = 2)), "." => "{,}"), 
	"\\rm{\\, m}")

# ╔═╡ 4c9eec12-440d-4bad-af5d-59b70b07e49d
md"""
#### Distância total percorrida em 2D

No caso bidimensional, podemos utilizar a mesma técnica utilizada no caso unidimensional para calcular a distância total percorrida quando o movimento for composto por trajetórias em linhas retas. No caso de trajetórias curvas, o método é um pouco mais complicado, e não será tratado aqui. 
"""

# ╔═╡ 09a487a8-2a76-4b91-bcdd-afb7fac95589
begin
	num_pontos_2D = 5
	traj2D = [rand(-100:100, Point2) for i ∈ 1:num_pontos_2D]
end;

# ╔═╡ 96ba8f64-cd0b-415a-a5f3-156ff8e61814
md"""
No caso mostrado na ilustração abaixo, o objeto sai de sua posição inicial em:
"""

# ╔═╡ 17324922-3810-4d79-8ce6-8062241d8415
latexstring("\\vec{S}_0 = ( $(traj2D[1][1])\\rm{\\, m}, \\, $(traj2D[1][2]) 
	\\rm{\\, m})")

# ╔═╡ e0a768d0-cd36-4aed-9077-30e05cb7ae38
md"""
e, em seu primeiro movimento, chega em:
"""

# ╔═╡ 764795b1-b8f0-40a6-b3c4-9c05a6b6be10
latexstring("\\vec{S}_1 = ( $(traj2D[2][1])\\rm{\\, m}, \\, $(traj2D[2][2]) 
	\\rm{\\, m}).")

# ╔═╡ 14d390e2-27ec-4acd-aeae-f101f4d593e3
md"""
O deslocamento do objeto entre ``\vec{S}_0`` e ``\vec{S}_1`` foi:

```math
\Delta \vec{S}_{0,1} = (x_1 - x_0, \, y_1 - y_0)
```
"""

# ╔═╡ e6f2bfa4-b5e2-469d-993f-71a26d907c23
latexstring("\\Delta \\vec{S}_{0,1} = ($(traj2D[2][1]) \\rm{\\, m} - 
	($(traj2D[1][1]) \\rm{\\, m}) , \\: $(traj2D[2][2]) \\rm{\\, m} - 
	($(traj2D[1][2]) \\rm{\\, m})) = ($(traj2D[2][1] - traj2D[1][1]) \\rm{\\, m},
	\\: $(traj2D[2][2] - traj2D[1][2]) \\rm{\\, m}).")

# ╔═╡ 9abe8a41-fc42-43c7-b75d-57a590fff0f2
md"""
Nesse movimento inicial, a trajetória percorrida entre ``\vec{S}_0`` e ``\vec{S}_1`` é o segmento de reta que une os dois pontos, que por sua vez pode ser representado pelo deslocamento ``\Delta \vec{S}_{0,1}``. A distância percorrida entre esses dois pontos pode ser obtida utilizando-se o *teorema de Pitágoras* com as componentes do deslocamento:

```math
D_{0,1} = \sqrt{(x_1 - x_0)^2 + (y_1 - y_0)^2}
```
"""

# ╔═╡ f4e335e1-0f0e-4c4e-921d-1ad8dd3ccc70
begin
	ΔS_traj2D = [(traj2D[i+1] - traj2D[i]) for i ∈ 1:num_pontos_2D-1]
	latexstring("D_{0,1} = \\sqrt{($(ΔS_traj2D[1][1])\\rm{\\, m})^2 + 
		($(ΔS_traj2D[1][2])\\rm{\\, m})^2} = \\sqrt{$(ΔS_traj2D[1][1]^2) 
		\\rm{\\, m^2} + $(ΔS_traj2D[1][2]^2)\\rm{\\, m^2}} = \\sqrt{
		$(ΔS_traj2D[1][1]^2 + ΔS_traj2D[1][2]^2) \\rm{\\, m^2}}")
end

# ╔═╡ b7ee61a9-fd73-4003-a21a-cfd6cc80b409
latexstring("D_{0,1} =", 
	replace(string(round(norm(ΔS_traj2D[1]), digits = 2)), "." => "{,}"), 
	"\\rm{\\, m}")

# ╔═╡ 428e5828-d9b4-49aa-a12f-1d068a49de26
md"""
Selecione a quantidade de pontos da trajetória:

$(@bind np_traj2D PlutoUI.Slider(2:num_pontos_2D; show_value = true))

Mostrar deslocamento total:
$(@bind mostrar_ΔS_fig04 PlutoUI.CheckBox())
"""

# ╔═╡ 2f793c40-9fdb-4cc3-9f66-f7bbd1ae5feb
md"""
Após passar por ``\vec{S}_1`` o objeto segue uma trajetória em linha reta até: 
"""

# ╔═╡ 212b07cc-28eb-4a6b-be47-b815fbd3ff20
latexstring("\\vec{S}_2 = ( $(traj2D[3][1])\\rm{\\, m}, \\, $(traj2D[3][2]) 
	\\rm{\\, m}).")

# ╔═╡ ab29e055-4661-4b0b-86ce-f30a04045afc
md"""
O deslocamento entre ``\vec{S}_1`` e ``\vec{S}_2`` é:

```math
\Delta \vec{S}_{1,2} = (x_2 - x_1, \, y_2 - y_1)
```
"""

# ╔═╡ 1fdb80c7-4bcc-47b3-88fc-5a3df9a34ec6
latexstring("\\Delta \\vec{S}_{1,2} = ($(traj2D[3][1]) \\rm{\\, m} - 
	($(traj2D[2][1]) \\rm{\\, m}) , \\: $(traj2D[3][2]) \\rm{\\, m} - 
	($(traj2D[2][2]) \\rm{\\, m})) = ($(traj2D[3][1] - traj2D[2][1]) \\rm{\\, m},
	\\: $(traj2D[3][2] - traj2D[2][2]) \\rm{\\, m}).")

# ╔═╡ bfa886bb-6b81-4280-96d2-b755f000c929
md"""
O deslocamento total entre ``\vec{S}_0`` e ``\vec{S}_2`` pode ser obtido como a soma dos deslocamentos que compõem o movimento:

```math
\Delta \vec{S}_{0,2} = \Delta \vec{S}_{0,1} +  \Delta \vec{S}_{1,2}
```
"""

# ╔═╡ 8000743e-adbf-4a9b-8af4-9516a4a96cce
latexstring("\\Delta \\vec{S}_{0,2} = ($(ΔS_traj2D[1][1])\\rm{\\, m},
	$(ΔS_traj2D[1][2])\\rm{\\, m}) + ($(ΔS_traj2D[2][1])\\rm{\\, m},
	$(ΔS_traj2D[2][2])\\rm{\\, m})")

# ╔═╡ f8a5aaeb-a780-4172-9241-deaa0db40e59
latexstring("\\Delta \\vec{S}_{0,2} = ($(ΔS_traj2D[1][1])\\rm{\\, m} +
	($(ΔS_traj2D[2][1])\\rm{\\, m}), $(ΔS_traj2D[1][2])\\rm{\\, m} + 
	($(ΔS_traj2D[2][2])\\rm{\\, m}))")

# ╔═╡ e6ed0332-b70e-4797-b49a-a5eb337e2f51
latexstring("\\Delta \\vec{S}_{0,2} = (
	$(ΔS_traj2D[1][1] + ΔS_traj2D[2][1])\\rm{\\, m}, 
	$(ΔS_traj2D[1][2] + ΔS_traj2D[2][2])\\rm{\\, m}).")

# ╔═╡ db9dc7a5-944b-4149-a269-e60b39a0416e
md"""
Mas a maneira mais simples de se obter o deslocamento é a partir das posições inicial e final do movimento:

```math
\Delta \vec{S}_{0,2} = (x_2 - x_0, \, y_2 - y_0)
```
"""

# ╔═╡ f8866470-9464-4ec8-8dcb-120870512775
latexstring("\\Delta \\vec{S}_{0,2} = ($(traj2D[3][1]) \\rm{\\, m} - 
	($(traj2D[1][1]) \\rm{\\, m}) , \\: $(traj2D[3][2]) \\rm{\\, m} - 
	($(traj2D[1][2]) \\rm{\\, m})) = ($(traj2D[3][1] - traj2D[1][1]) \\rm{\\, m},
	\\: $(traj2D[3][2] - traj2D[1][2]) \\rm{\\, m}).")

# ╔═╡ f13a4667-b5fb-4026-a6dd-bdd4afccd431
md"""
Entretanto, existe apenas uma maneira de se calcular a distância total percorrida, e é somando todas as distâncias percorridas durante a trajetória. Então, antes de descobrirmos a distância total percorrida de ``\vec{S}_0`` e ``\vec{S}_2`` precisamos calcular a distância percorrida entre ``\vec{S}_1`` e ``\vec{S}_2``:

```math
D_{1,2} = \sqrt{(x_2 - x_1)^2 + (y_2 - y_1)^2}
```

"""

# ╔═╡ 4bb99629-3dd2-477d-b053-65ec9806e678
latexstring("D_{1,2} = \\sqrt{($(ΔS_traj2D[2][1])\\rm{\\, m})^2 + 
		($(ΔS_traj2D[2][2])\\rm{\\, m})^2} = \\sqrt{$(ΔS_traj2D[2][1]^2) 
		\\rm{\\, m^2} + $(ΔS_traj2D[2][2]^2)\\rm{\\, m^2}} = \\sqrt{
		$(ΔS_traj2D[2][1]^2 + ΔS_traj2D[2][2]^2) \\rm{\\, m^2}}")

# ╔═╡ e62ba14d-80f6-475d-8384-6dfcc73e2fdf
latexstring("D_{1,2} =", 
	replace(string(round(norm(ΔS_traj2D[2]), digits = 2)), "." => "{,}"), 
	"\\rm{\\, m}.")

# ╔═╡ 69a65739-7ad1-4526-98be-9fdfdf454608
md"""
A distância total percorrida até ``\vec{S}_2`` é:

```math
D_{0,2} = D_{0,1} + D_{1,2}
```
"""

# ╔═╡ b3188cc4-0f89-445d-827f-dba12480cbe0
latexstring("D_{0,2} = ", 
	replace(string(round(norm(ΔS_traj2D[1]), digits = 2)), "." => "{,}"), 
	"\\rm{\\, m} +", 
	replace(string(round(norm(ΔS_traj2D[2]), digits = 2)), "." => "{,}"),
	"\\rm{\\, m}.")

# ╔═╡ 75752a80-d74a-4b89-b813-790505be143e
latexstring("D_{0,2} = ", 
	replace(string(round(norm(ΔS_traj2D[1]) + norm(ΔS_traj2D[2]), digits = 2)), "." => "{,}"), 
	"\\rm{\\, m}.")

# ╔═╡ 9a1cbaaf-315f-4b82-98eb-6d291e191ec2
md"""
A distância total percorrida ``D_{0,2}`` é diferente da distância ``d_{0,2}`` entre as posições ``\vec{S}_0`` e ``\vec{S_2}``:

```math
d_{0,2} = |\Delta \vec{S}_{0,2}| = \sqrt{(x_2 - x_0)^2 - (y_2 - y_0)^2}
```
"""

# ╔═╡ 37f26221-84f1-4907-9476-7a088e48f142
begin
	ΔS_traj2D_02 = traj2D[3] - traj2D[1]
	latexstring("d_{0,2} = |\\Delta \\vec{S}_{0,2}| = 
		\\sqrt{($(ΔS_traj2D_02[1])\\rm{\\, m})^2 + 
		($(ΔS_traj2D_02[2])\\rm{\\, m})^2} = \\sqrt{$(ΔS_traj2D_02[1]^2) 
		\\rm{\\, m^2} + $(ΔS_traj2D_02[2]^2)\\rm{\\, m^2}} = \\sqrt{
		$(ΔS_traj2D_02[1]^2 + ΔS_traj2D_02[2]^2) \\rm{\\, m^2}}")
end

# ╔═╡ 59dc48b3-5bd8-43b0-833d-db09dcfbad92
latexstring("d_{0,2} = |\\Delta \\vec{S}_{0,2}| =", 
	replace(string(round(norm(ΔS_traj2D_02), digits = 2)), "." => "{,}"), 
	"\\rm{\\, m}.")

# ╔═╡ 33eb2a62-d18c-477f-9085-73fc12dfeca3
md"""
> Podemos utilizar o ``d`` para representar a distância entre dois pontos e o ``D`` para a distância total percorrida. Mas como a distância entre dois pontos é igual ao comprimento do segmento de reta que une os dois pontos, e esse segmento de reta tem o mesmo comprimento do deslocamento entre esses dois pontos, também podemos representá-la como ``ΔS`` (sem a seta flutuante).

Podemos notar que, no caso ilustrado acima, ``D_{0,2} > d_{0,2}``. A distância total percorrida ``D`` será sempre maior ou igual à distância entre os pontos ``d`` ou ``\Delta S``:

```math
D \geq |\Delta \vec{S}|.
```

Ainda, na imagem acima, é possível ver o que acontece com a distância total percorrida e com o deslocamento à medida que o objeto segue para outras posições. Vale ressaltar, ainda, que os cálculos que fizemos para encontrar a distância percorrida só valem para trajetórias em linha reta, se a trajetória por curva, a técnica utilizada será um pouco mais complicada, e não é ensinada durante o Ensino Médio.

No caso geral, quando um objeto sai da posição ``\vec{S}_0`` passa por ``n`` posições até chegar em ``\vec{S}_n``, seu deslocamento total só dependerá de suas posições inicial e final:

```math
\Delta \vec{S}_{0,n} = (x_n - x_0, \, y_n - y_0).
```

Já a distância total percorrida, **caso a trajetória seja composta por ``n`` retas**, será a soma do comprimentos de todas as retas:

```math
D_{0,n} = D_{0,1} + D_{1,2} + D_{2, 3} + \cdots + D_{n-1, n}.
```

"""

# ╔═╡ 19e13931-3f87-45a0-ae98-8e6928cd9aaa
md"""
### 1.2.3. Deslocamento em 3D

Como vivemos num espaço tridimensional, na maioria dos casos precisamos levar em consideração a posição de um objeto no espaço (3D). Nesse caso, utilizamos três componentes para representar a posição ``\vec{S}_0 = (x_0,\, y_0,\, z_0)`` de um objeto. Se após um certo movimento, o objeto passa a estar na posição ``\vec{S}_1 = (x_1,\, y_1,\, z_1)``, seu deslocamento será:

```math
\Delta \vec{S}_{0,1} = \vec{S}_1 - \vec{S}_0 = (x_1 - x_0, \, y_1 -y_0, \, z_1 - z_0).
```

O cálculo do deslocamento em 1D, 2D e 3D são bem semelhantes, sendo que a única diferença é na quantidade de componentes necessárias para expressar as posições e os deslocamentos.

O módulo do deslocamento que representa a distância entre as posições ``\vec{S}_1`` e ``\vec{S}_0`` pode ser calculado utilizando a versão do *Teorema de Pitágoras* para três dimensões:

```math
d_{1,0} = |\Delta \vec{S}_{0,1}| = \sqrt{(x_1 - x_0)^2 + (y_1 - y_0)^2 + (z_1 - z_0)^2}.
```

Caso o objeto se desloque em linha reta de ``\vec{S}_0`` até ``\vec{S}_1``, sem mudar o sentido de seu movimento durante essa trajetória, a distância percorrida de uma posição à outra pelo objeto será igual à distância entre as posições. Em qualquer outra situação a distância total percorrida será maior que a distância entre a posição inicial e a posição final do objeto!
"""

# ╔═╡ 21e0a4f1-5a1f-4572-84c6-2f34d7d27fee
md""" 
#### Distância total percorrida em 3D

Como nos casos de movimento em 1D e 2D, a distância total percorrida em movimentos em 3D também depende da trajetória percorrida pelo objeto para ir de sua posição inicial e chegar até sua posição final. Se o movimento for composto de trajetórias em linhas retas, a distância total percorrida será simples de ser calculada, somando-se os comprimentos de todas os segmentos de reta que compõem o movimento (como já vimos nos exemplos em movimentos em 1D e 2D acima.) Já no caso de um movimento composto por trajetórias curvas, o cálculo da distância total percorrida é possível, mas a técnica utilizado para isso não faz parte do currículo do Ensino Médio e, portanto, não será mostrada aqui.

Também como nos casos vistos anteriormente, o deslocamento em 3D não depende da trajetória percorrida pelo objeto, mas apenas de sua posição inicial e de sua posição final. Por exemplo, se um objeto parte da posição inicial ``\vec{S}_0 = (x_0,\, y_0,\, z_0)``, e ao longo de sua trajetória passa por ``n`` pontos até atingir sua posição final ``\vec{S}_n = (x_n,\, y_n,\, z_n)``, seu deslocamento será simplesmente:

```math
\Delta \vec{S}_{0,n} = (x_n - x_0, \, y_n - y_0, \, z_n - z_0),
```

não dependendo de nenhum outro ponto ao longo da trajetória. Já a distância total percorrida dependerá de todos os pontos que formam a trajetória.
"""

# ╔═╡ 183aa576-721b-4dd4-a326-cb4fcedbd380
md"""
### Resumo da seção

**Deslocamento ``\Delta \vec{S}_{0,1}`` entre ``\vec{S}_0`` e ``\vec{S}_1``:**

> O deslocamento depende apenas da posição inicial e da posição final do objeto e não depende da trajetória percorrida.

* 1 dimensão, ``\vec{S}_0 = x_0`` e ``\vec{S}_1 = x_1``:
```math
\Delta \vec{S}_{0,1} = x_1 - x_0
```

* 2 dimensões, ``\vec{S}_0 = (x_0,\, y_0)`` e ``\vec{S}_1 = (x_1,\, y_1)``:
```math
\Delta \vec{S}_{0,1} = (x_1 - x_0,\, y_1 - y_0)
```

* 3 dimensões, ``\vec{S}_0 = (x_0,\, y_0, \, z_0)`` e ``\vec{S}_1 = (x_1,\, y_1,\, z_1)``:
```math
\Delta \vec{S}_{0,1} = (x_1 - x_0,\, y_1 - y_0, \, z_1 - z_0)
```

**Distância ``d_{0,1}`` entre as posições ``\vec{S}_0`` e ``\vec{S}_1`` ou módulo do deslocamento**:

* 1 dimensão, ``\vec{S}_0 = x_0`` e ``\vec{S}_1 = x_1``:
```math
d_{0,1} = |\Delta \vec{S}_{0,1}| = |x_1 - x_0|
```

* 2 dimensões, ``\vec{S}_0 = (x_0,\, y_0)`` e ``\vec{S}_1 = (x_1,\, y_1)``:
```math
d_{0,1} = |\Delta \vec{S}_{0,1}| = \sqrt{(x_1 - x_0)^2 + (y_1 - y_0)^2}
```

* 3 dimensões, ``\vec{S}_0 = (x_0,\, y_0, \, z_0)`` e ``\vec{S}_1 = (x_1,\, y_1,\, z_1)``:
```math
d_{0,1} = |\Delta \vec{S}_{0,1}| = \sqrt{(x_1 - x_0)^2 + (y_1 - y_0)^2 + (z_1 - z_0)^2}
```

**Distância total percorrida ``D_{0,1}`` entre as posições ``\vec{S}_0`` e ``\vec{S}_1``**:

>A distância total percorrida entre duas posições **sempre depende do caminho percorrido** e sempre será maior ou igual à distância entre essas posições.

```math
D_{0,1} \geq |\Delta \vec{S}_{0,1}|.
```

"""

# ╔═╡ 6e18b6b3-3b6f-47a9-b2f4-f6117db01ffc
begin
	#definindo posição em 2 dimensões
	struct pos2D
		x::Quantity{<:Any, Unitful.𝐋}
		y::Quantity{<:Any, Unitful.𝐋} 
	end
	
	#definindo posição em 3 dimensões
	struct pos3D
		x::Quantity{<:Any, Unitful.𝐋}
		y::Quantity{<:Any, Unitful.𝐋} 
		z::Quantity{<:Any, Unitful.𝐋}
	end
	
	function rotaçao2D(p::Point2, θ)
		matriz_rotacao = [cos(θ) -sin(θ); sin(θ) cos(θ)]
		return matriz_rotacao * p
	end
	
end;

# ╔═╡ aa1a67b0-ce49-4144-beb0-f83c24c892df
begin
	fig_03 = Figure(resolution = (800, 800), backgroundcolor = :gray80)
	ax_03 = fig_03[1, 1] = Axis(fig_03, 
		aspect = DataAspect(),
		xlabel = "Posição x (m)",
		ylabel = "Posição y (m)",
		title = "Deslocamento 2D")
	
	scatter!(ax_03, s0_2D, markersize = 15, color = (:dodgerblue, 0.4))
	scatter!(ax_03, s1_2D, markersize = 15, color = (:red, 0.8))
	scatter!(ax_03, Point2(0), marker = :rect, markersize = 12, color = :black)
	
	arrows!(ax_03, [s0_2D[1]], [s0_2D[2]], 
		[s1_2D[1] - s0_2D[1]], [s1_2D[2] - s0_2D[2]],
		color = (:blue, 0.5),
		linewidth = 3,
		arrowsize = 15)
	
	text!(ax_03, string("S₀ = (", s0_2D[1] * 1u"m", " , ", s0_2D[2] * 1u"m", ")"),
		position = s0_2D + Point2(0.0, 3),
		align = (:center, :bottom),
		color = :dodgerblue,
		textsize = 15)
	
	text!(ax_03, string("S₁ = (", s1_2D[1] * 1u"m", " , ", s1_2D[2] * 1u"m", ")"),
		position = s1_2D + Point2(0.0, -3),
		align = (:center, :top),
		color = :red,
		textsize = 15)
	
	ΔS_01_2D = 1u"m" .* (s1_2D - s0_2D)
	
	if mostrar_ΔS_1
		θ_ΔS = atan(s1_2D[2] - s0_2D[2], s1_2D[1] - s0_2D[1])
		pos_ΔS = rotaçao2D(Point2(norm(s1_2D - s0_2D)/2, 4.0), θ_ΔS)
		text!(ax_03, string("ΔS = (",ΔS_01_2D[1], " , ", ΔS_01_2D[2], " )"), 
			position = Point2(pos_ΔS) + s0_2D,
			align = (:center, :center),
			color = :blue,
			textsize = 15,
			rotation = θ_ΔS)
	end
	
	
	
	limits!(ax_03, -120, 120, -120, 120)
	
	fig_03
end

# ╔═╡ f79a26e7-6653-4d3d-911a-e9458691eca7
begin
	fig_04 = Figure(resolution = (800, 800), backgroundcolor = :gray80)
	ax_04 = fig_04[1, 1] = Axis(fig_04, aspect = DataAspect(),
		xlabel = "Posição (m)",
		ylabel = "Posição (m)",
		title = "Deslocamento 2D")
	
	scatter!(ax_04, Point2(0), marker = :rect, color = :black, markersize = 15)
	
	scatter!(ax_04, traj2D[1:np_traj2D], marker = :circle, 
		color = cor_x_1D[1:np_traj2D],
		markersize = 15)
	
	text!(ax_04, "S₀", position = (traj2D[1][1], traj2D[1][2] + 3),
		align = (:center, :bottom),
		color = cores[1],
		textsize = 15)
	text!(ax_04, string("(", traj2D[1][1]," m, ", traj2D[1][2]," m)"),
		position = (traj2D[1][1], traj2D[1][2] - 3),
		align = (:center, :top),
		color = :dodgerblue,
		textsize = 15)
		
	DTotal = 0
	ΔS_fig04 = traj2D[np_traj2D] - traj2D[1]
	
	for i ∈ 2:np_traj2D
		text!(ax_04, p_nomes_1D[i], position = (traj2D[i][1], traj2D[i][2] + 3),
		align = (:center, :bottom),
		color = cores[i],
		textsize = 15)
		
		text!(ax_04, string("(", traj2D[i][1]," m, ", traj2D[i][2]," m)"),
		position = (traj2D[i][1], traj2D[i][2] - 3),
		align = (:center, :top),
		color = cores[i],
		textsize = 15)
		
		arrows!(ax_04, [traj2D[i-1][1]], [traj2D[i-1][2]],
			[(traj2D[i][1] - traj2D[i-1][1])], [(traj2D[i][2] - traj2D[i-1][2])],
			color = (cores[i-1], 0.5),
			linewidth =3,
			arrowsize = 15)
			
		ΔD_fig04 = norm(ΔS_traj2D[i-1])
		DTotal += ΔD_fig04
	end
	
	if mostrar_ΔS_fig04
		arrows!(ax_04, [traj2D[1][1]], [traj2D[1][2]],
				[ΔS_fig04[1]], [ΔS_fig04[2]],
				color = :black,
				linewidth =3,
				arrowsize = 15)
		
		local θ_ΔS_04 = atan(ΔS_fig04[2], ΔS_fig04[1])
		local pos_ΔS_04 = rotaçao2D(Point2(norm(ΔS_fig04)/2, 4.0), θ_ΔS_04)
		
		text!(ax_04, string("ΔS = (",ΔS_fig04[1], " m, ", ΔS_fig04[2], " m)"), 
			position = Point2(pos_ΔS_04) + traj2D[1],
			align = (:center, :center),
			color = :black,
			textsize = 13,
			rotation = θ_ΔS_04)
	end
	
	fig_04[2, 1] = vgrid!(
		#Label(fig_04, string("deslocamento: ΔS = (", ΔS_fig04[1], " m, ", 
		#	ΔS_fig04[2], " m)"), 
		#	textsize = 16, color = :black),
		Label(fig_04, string("deslocamento: |ΔS| = ", 
			replace(string(round(norm(ΔS_fig04), digits = 2)), "." => ","), 
			" m"), 
			textsize = 16, color = :black),
		Label(fig_04, string("distância total percorrida: D = ", 
				replace(string(round(DTotal, digits = 2)), "." => ","),
				" m"),
			textsize = 16);
		tellheight = true)
	
	fe_sublayout2 = GridLayout()
	fig_04[1:2, 1] = fe_sublayout2
	colsize!(fe_sublayout2, 1, Fixed(800))
	
	limits!(ax_04, -120, 120, -120, 120)
	fig_04
end

# ╔═╡ Cell order:
# ╟─960d6d9b-6684-4baa-8c5f-a0f5ec34b05c
# ╟─e1aa4440-cf69-11eb-1dd2-1b847285684d
# ╟─7db9af1c-de19-4e79-978b-3109a48d427b
# ╟─be391955-d06e-414b-9b33-6add82c0ded4
# ╟─acac2ee7-c243-43a0-bb5a-fd1ec63d0eb2
# ╠═6a1bca68-40d9-4bc3-9131-31de5bab60d5
# ╟─9586d30c-67d4-44dc-80ce-9348adeba0e0
# ╟─865bcf7e-73e2-40f8-aefe-ab393c8de748
# ╟─da6e713f-43ef-4251-a78a-74847a7369a7
# ╟─dc2c63bf-8c31-4849-a1b2-ba12e1065b49
# ╟─c0cce94d-4982-4fb6-934c-48744c276133
# ╟─b77ab228-83d0-462e-98c4-a22bde2bd5d4
# ╟─fd9ebea6-51fd-4ad5-a684-1091382e1874
# ╟─fa5d1fa9-9cf8-4a66-a15d-b883992d22ce
# ╟─7458bac8-a49d-4443-b59b-4dedf8213721
# ╟─3d00751d-261d-4683-bcae-486bf073ff93
# ╟─7ea13518-1c1b-4a52-ac50-ff7211a927d3
# ╟─a024ac5b-2a06-4648-a250-2e5bccea63cd
# ╟─aa98f8a9-e241-4f5f-a0f6-25b7df8646ac
# ╟─8b00b1d3-8ecb-4ea5-a6e5-67a5bf28974c
# ╟─4409491b-ce3b-4ed5-a494-db233ea2138e
# ╟─8917309e-71d2-458f-90e4-6731703ecaf0
# ╟─f34c4f86-1825-4c00-8192-1d6d38f89470
# ╟─f62a257f-0c01-4e50-92b6-d40233de5174
# ╟─494fc3c2-97b4-465c-aab3-b4ce2af388ce
# ╟─035cfbd0-f6ae-4418-99ba-ec3d2a2c1376
# ╟─fc6b570a-e555-4a3c-b101-58a36b0c64af
# ╟─ee6f369e-8e06-422d-8cea-3e5b4f7aa61d
# ╟─c695a264-ead1-43a8-bf2a-ef37a29e0a8f
# ╟─b78cf2f3-8779-4cf2-a42a-95fdc4f5a84d
# ╟─446e7932-9020-4fee-9fd3-4fdee2986c45
# ╟─e28de55a-d025-4c50-9bed-2295ff075335
# ╟─3106aae8-71df-4c4e-bf15-a1d67e909df0
# ╟─eaf030ff-0b66-4538-ab24-0f194a2958ad
# ╟─b58a3e20-3572-4afa-ad06-4f7595f5a481
# ╟─9eebff88-82c5-4ff6-a975-feb2c5130365
# ╟─bd73ed2a-48ee-44b9-b2aa-c75b43b7f04d
# ╟─aa1a67b0-ce49-4144-beb0-f83c24c892df
# ╟─0626e7dc-c344-4591-b507-89de96f9d584
# ╟─773f24b6-1cb0-44d9-bc9c-22b71ca69780
# ╟─1589f9c8-4fef-4ff4-a522-3299e9647ff7
# ╟─b01c8724-408a-496b-887a-0ec7bc0da3a3
# ╟─db550412-ab78-4b23-89de-eeefadc9b0dd
# ╟─4c9eec12-440d-4bad-af5d-59b70b07e49d
# ╟─09a487a8-2a76-4b91-bcdd-afb7fac95589
# ╟─96ba8f64-cd0b-415a-a5f3-156ff8e61814
# ╟─17324922-3810-4d79-8ce6-8062241d8415
# ╟─e0a768d0-cd36-4aed-9077-30e05cb7ae38
# ╟─764795b1-b8f0-40a6-b3c4-9c05a6b6be10
# ╟─14d390e2-27ec-4acd-aeae-f101f4d593e3
# ╟─e6f2bfa4-b5e2-469d-993f-71a26d907c23
# ╟─9abe8a41-fc42-43c7-b75d-57a590fff0f2
# ╟─f4e335e1-0f0e-4c4e-921d-1ad8dd3ccc70
# ╟─b7ee61a9-fd73-4003-a21a-cfd6cc80b409
# ╟─428e5828-d9b4-49aa-a12f-1d068a49de26
# ╟─f79a26e7-6653-4d3d-911a-e9458691eca7
# ╟─2f793c40-9fdb-4cc3-9f66-f7bbd1ae5feb
# ╟─212b07cc-28eb-4a6b-be47-b815fbd3ff20
# ╟─ab29e055-4661-4b0b-86ce-f30a04045afc
# ╟─1fdb80c7-4bcc-47b3-88fc-5a3df9a34ec6
# ╟─bfa886bb-6b81-4280-96d2-b755f000c929
# ╟─8000743e-adbf-4a9b-8af4-9516a4a96cce
# ╟─f8a5aaeb-a780-4172-9241-deaa0db40e59
# ╟─e6ed0332-b70e-4797-b49a-a5eb337e2f51
# ╟─db9dc7a5-944b-4149-a269-e60b39a0416e
# ╟─f8866470-9464-4ec8-8dcb-120870512775
# ╟─f13a4667-b5fb-4026-a6dd-bdd4afccd431
# ╟─4bb99629-3dd2-477d-b053-65ec9806e678
# ╟─e62ba14d-80f6-475d-8384-6dfcc73e2fdf
# ╟─69a65739-7ad1-4526-98be-9fdfdf454608
# ╟─b3188cc4-0f89-445d-827f-dba12480cbe0
# ╟─75752a80-d74a-4b89-b813-790505be143e
# ╟─9a1cbaaf-315f-4b82-98eb-6d291e191ec2
# ╟─37f26221-84f1-4907-9476-7a088e48f142
# ╟─59dc48b3-5bd8-43b0-833d-db09dcfbad92
# ╟─33eb2a62-d18c-477f-9085-73fc12dfeca3
# ╟─19e13931-3f87-45a0-ae98-8e6928cd9aaa
# ╟─21e0a4f1-5a1f-4572-84c6-2f34d7d27fee
# ╟─183aa576-721b-4dd4-a326-cb4fcedbd380
# ╟─6e18b6b3-3b6f-47a9-b2f4-f6117db01ffc
