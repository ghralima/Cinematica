### A Pluto.jl notebook ###
# v0.14.8

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

# ╔═╡ c0c2b95c-8d6d-4219-9fe8-b28c6b05f5e0
begin
 	import Pkg
 	Pkg.activate(".")
end

# ╔═╡ 6c978cdd-a550-4d0f-97c4-63741ef2010c
begin
	using CairoMakie
	using PlutoUI
	using LaTeXStrings
	using HypertextLiteral
	using LinearAlgebra, Random
end	

# ╔═╡ 39613139-84d2-4843-acab-45f02914ee90
PlutoUI.TableOfContents(title = "Índice", depth = 4, aside = true)

# ╔═╡ 81891cae-19fb-4be5-81d4-f006b38ee797
md"""
# 1. CINEMÁTICA

Cinemática é o ramo da Mecânica que tem como objetivo descrever o movimento dos objetos. Essa descrição é feita utilizando a linguagem matemática.

## 1.1. POSIÇÃO

**Posição** é uma grandeza física que indica a localização de um objeto em relação a um ponto de referência definido. Portanto, a posição depende do ponto de referência.

### 1.1.1. Posição sobre linhas ou retas (1 dimensão)

Quando queremos marcar a posição de um objeto sobre uma linha ou uma reta (apenas 1 dimensão) precisamos fornecer apenas uma medida em relação a um ponto de referência.
Para diferenciar pontos que estão à direita ou à esquerda do ponto de referência, por exemplo, podemos utilizar a seguinte convenção:

* pontos à direita do ponto de referência têm posições positivas; 
* pontos à esquerda do ponto de referência têm posições negativas.
"""

# ╔═╡ db2ee140-7191-47d2-a282-f9d13e38adab
begin
	x_positivo = rand(1:200, 2)
	x_negativo = rand(-200:-1, 2)
	xs = vcat(x_positivo, x_negativo)
	pontos = [Point2(x, 0) for x ∈ xs]
	p_nomes = ["A", "B", "C", "D"]
	
	function sentido(p) 
		if Int64(sign(p)) == 1
			return "à direita"
		elseif Int64(sign(p)) == -1
			return "à esquerda"
		else
			return ""
		end
	end
end;

# ╔═╡ a60ba8e9-9c09-4a5b-ab9f-16e65712d635
begin
	fig_00 = Figure(resolution = (800, 200))
	ax_00 = fig_00[1, 1] = Axis(fig_00, aspect = DataAspect(), backgroundcolor = :gray90, title = "Posição em 1 dimensão")
	
	lines!(ax_00, [-200, 200], [0, 0], linewidth = 3, color = :black)
	scatter!(ax_00, Point2(0), marker = :rect, markersize = 15, color = :blue)
	
	scatter!(ax_00, pontos, marker = :circle, markersize = 15, color = :red)
	
	
	text!("O", position = (0, 10), align = (:center, :center), color = :blue)
	
	for i ∈ 1:length(pontos)
		text!(string(pontos[i][1], " m"), 
			position = (pontos[i][1], -10), 
			align = (:center, :center), 
			color = :red, textsize = 15)
		text!(string(p_nomes[i]), 
			position = (pontos[i][1], 10), 
			align = (:center, :center), 
			color = :red, textsize = 15)
	end
	
	hidedecorations!(ax_00)
	limits!(ax_00, -210, 210, -20, 20)
	
	
	fig_00
end

# ╔═╡ 5a34dc36-9187-4ce6-8f9e-dad0f20b3098
md"""
Na figura acima, o ponto A está a $(abs(xs[1])) m $(sentido(xs[1])) do ponto de referência. Sendo assim iremos representar sua posição como: ``\vec{A}`` = $(xs[1]) m. Já o ponto C está a $(abs(xs[3])) m $(sentido(xs[3])) do ponto de referência, portanto sua posição será ``\vec{C}`` = $(xs[3]) m. (Utilizaremos essa notação com uma seta sobre o nome do ponto para indicar sua posição.)

Apesar de vivermos em um mundo com 3 dimensões espaciais, em algumas situações podemos considerar que estamos sobre uma região com apenas uma dimensão. Por exemplo:

 * Quando queremos saber a posição de um local em uma determinada rua, a rua pode ser considerada um objeto unidimensional, já que conseguimos localizar este objeto conhecendo apenas um valor (número da casa ou um valor de comprimento a partir de um ponto de referência). O mesmo vale para estradas, onde as posições dos locais de interesse são marcadas de acordo as placas sinalizando a quilometragem ao longo de seu comprimento.

##### Unidades de medida

Ao escrever a posição, não devemos esquecer de indicar as unidades de medida utilizadas. A localização de um ponto é medida utilizando-se de unidades de comprimento: milímetros (mm), centímetros (cm), metros (m), quilômetro (km), etc. 

> No **Sistema Internacional de Unidades (S.I.)** a unidade padrão utilizada para medir comprimentos é o *metro* (m).

A tabela abaixo mostra os fatores de conversão entre as unidades de comprimento mais comuns de serem utilizadas.

| X | mm | cm | dm | m | km|
|:--|:--:|:--:|:--:|:--:|:--:|
|1 mm | 1| 0,1| 0,01| 0,001| 0,000001|
|1 cm | 10| 1 | 0,1 | 0,01| 0,00001|
|1 dm | 100| 10 | 1 | 0,1 | 0,0001 |
|1 m | 1.000| 100 | 10 | 1 | 0,001 |
|1 km | 1.000.000| 100.000| 10.000| 1.000| 1|

"""

# ╔═╡ a0de6f53-7cdd-491e-b125-0e1cafe35fe1
md"""
#### Distância até o ponto de referência (1D)

A distância entre dois pontos é igual ao comprimento do segmento de reta que une os dois pontos. **Como medidas de comprimento são sempre positivas, distâncias também devem ser sempre positivas.** Então, na situação acima (1D), onde as posições são representadas por apenas um valor que pode ser positivo ou negativo, a distância do objeto até o ponto de referência será simplesmente o valor absoluto de sua posição. 

**Como a distância é um comprimento, utilizamos também unidades de comprimento em sua representação.**

No exemplo acima, a distância do ponto A até o ponto de referência é ``d_A = `` $(xs[1]) m. Já a distância do ponto C até o ponto de referência é ``d_C = `` $(abs(xs[3])) m. Vamos utilizar a letra ``d`` para representar distâncias.

>Note que existem dois pontos sobre uma reta que estão à mesma distância do ponto de referência, portanto, mesmo nesta situação mais simples não é possível localizar um local sabendo apenas sua distância de um ponto de referência.

"""

# ╔═╡ 18e9805b-a542-47ff-aba8-6bde222e71e6
md"""
#### Posição relativa entre dois pontos (1D)

O que acontece com a posição quando mudamos o ponto de referência?

Imagine um ponto ``P_1`` cuja posição em relação a um referencial ``O`` é dada por ``\vec{P_1} = x_1``. Agora, imagine um ponto ``P_2`` que tem posição em relação ao mesmo referencial dada por ``\vec{P_2} = x_2``. Se quisermos mudar o ponto de referencia de ``O`` para ``P_2``, o que aconteceria com a posição de ``P_1``?

O ponto ``P_1``, certamente, não mudou de lugar, mas como houve a mudança do ponto de referência, sua medida da posição de ``P_1`` muda. Encontrar a nova posição de ``P_1`` em relação a ``P_2``, representada por ``\vec{P}_{1,2}`` é bem simples. Basta apenas subtrair a posição de ``P_1`` pela posição de ``P_2``:

```math
\vec{P}_{1,2} = x_1 - x_2
```

Por exemplo, no caso visto acima, quando mudamos o ponto de referência para D, podemos ver que o ponto A está a $(xs[1]) m + $(-xs[4]) m $(sentido(xs[1] - xs[4])) do ponto D, portanto sua nova posição pode ser escrita como:

``\vec{A}_D = `` $(xs[1]-xs[4]) m.

Já a posição de C em relação a D:

``\vec{C}_D = `` $(xs[3]) m - ( $(xs[4]) m) = $(xs[3] - xs[4]) m.

O ponto C está a $(abs(xs[3] - xs[4])) m $(sentido(xs[3] - xs[4])) de D.

A distância entre os dois pontos ainda será igual ao valor absoluto de sua posição: 

```math
d_{1,2} = |\vec{P}_{1,2}| = |x_1 - x_2|.
```

"""

# ╔═╡ c07a643a-e36f-4853-bc97-079d1f4ad560
md"""
### 1.1.2. Posição sobre um plano ou superfície (2 dimensões)

Nem sempre podemos considerar que objetos encontram-se sobre retas e linhas. Em várias situações devemos localizar objetos sobre planos ou superfícies, que são objetos geométricos com 2 dimensões (2D). Nesse caso, torna-se impossível localizar um local utilizando apenas um valor ou medida, e é necessário pelo menos dois valores ou duas medidas para indicar a posição de um ponto. No caso de uma superfície plana como uma mesa, podemos sobrepor um plano cartesiano à superfície, e utilizá-lo para marcar as posições dos objetos ou locais de interesse. 

> O plano cartesiano e definido com base em dois eixos perpendiculares entre si, e as posições são medidas usando esses eixos como referência.

Para representar a posição de um ponto ``P_1`` no plano cartesiano, utilizamos a seguinte notação matemática:

```math
\vec{P_1} = (x_1, \, y_1),
```

no qual ``x_1`` é a posição de ``P_1`` em relação ao eixo de coordenadas ``y``, e ``y_1`` é a posição de ``P_1`` em relação ao eixo de coordenadas ``x``.

> Por convenção, dizemos que **pontos à esquerda do ponto do referência têm coordenada ``x`` negativa**, e pontos à direita têm coordenada ``x`` positiva. Pontos acima ou à frente do ponto de referência têm coordenada ``y`` positiva, e **pontos abaixo ou atrás do ponto de referência têm coordenada ``y`` negativa**.


Na imagem abaixo, temos 3 pontos representados num plano cartesiano com a indicação de suas respectivas posições.
"""

# ╔═╡ b948d630-845e-4828-87c8-2b9751235613
begin
	ponto_A = Point2(rand(-5:5, 2))
	ponto_B = Point2(rand(-5:5, 2))
	ponto_C = Point2(rand(-5:5, 2))
	points = [ponto_A, ponto_B, ponto_C]
end;

# ╔═╡ 2769546e-99a7-4632-a0b0-8f5be8709b5d
md"""
Mostrar eixos: $(@bind mostrar_eixos_01 CheckBox())

Mostrar posições: $(@bind mostrar_pos_01 CheckBox())
"""

# ╔═╡ 2fe6d737-1524-46fc-a978-7ab6d9814b1e
begin
	fig_01 = Figure(resolution = (800, 800))
	ax_01 = fig_01[1, 1] = Axis(fig_01, aspect = DataAspect(), 
		xlabel = "posição x (cm)", ylabel = "posição y (cm)",
		title = "Posição em 2 dimensões")
	scatter!(ax_01, points, markersize = 15, color = [:red, :green, :blue])
	scatter!(ax_01, Point2(0), markersize = 15, marker = :rect, color = :black)
	
	text!("O", position = (-0.3, -0.3), align = (:center, :center), color = :black)	
	
	if mostrar_eixos_01
		vlines!(ax_01, 0, color = :black)
		hlines!(ax_01, 0, color = :black)
		
		lines!(ax_01, [Point2(ponto_A[1], 0), ponto_A, Point2(0, ponto_A[2])],
				linewidth = 2, linestyle = :dash, color = (:red, 0.8))

		lines!(ax_01, [Point2(ponto_B[1], 0), ponto_B, Point2(0, ponto_B[2])],
			linewidth = 2, linestyle = :dash, color = (:green, 0.8))

		lines!(ax_01, [Point2(ponto_C[1], 0), ponto_C, Point2(0, ponto_C[2])],
			linewidth = 2, linestyle = :dash, color = (:blue, 0.8))
	end
	
	if mostrar_pos_01
		text!([string("A = (", ponto_A[1], " cm, ", ponto_A[2], " cm)"), 
				string("B = (", ponto_B[1], " cm, ", ponto_B[2], " cm)"), 
				string("C = (", ponto_C[1], " cm, ", ponto_C[2], " cm)")], 
			position = [(ponto_A[1], ponto_A[2] + 0.4), 
				(ponto_B[1], ponto_B[2] + 0.4), (ponto_C[1], ponto_C[2] + 0.4)],
			align = [(:center, :center), (:center, :center), (:center, :center)], 
			color = [:red, :green, :blue],
			textsize = 17)
	else
		text!(["A", "B", "C"], position = [(ponto_A[1] -0.3, ponto_A[2] + 0.3), 
			(ponto_B[1] - 0.3, ponto_B[2] + 0.3), 
			(ponto_C[1] - 0.3, ponto_C[2] + 0.3)], 	align = (:center, :center), 
			color = [:red, :green, :blue], textsize = 17)
	end
	
	limits!(ax_01, -8, 8, -8, 8)
	ax_01.xticks = -8:1:8
	ax_01.yticks = -8:1:8
	hidespines!(ax_01)
	fig_01
end

# ╔═╡ fd4842d3-e8b9-40d6-9374-7b725975d45d
md"""
#### Distância até o ponto de referência (2D)

Para medir a distância (``d_1``) entre um ponto ``\vec{P}_1 = (x_1, \, y_1)`` e o ponto de referência ``O``, iremos utilizar o *Teorema de Pitágoras*. Note que ao representar graficamente o ponto P, os eixos ``x`` e ``y`` são perpendiculares entre si, e as
coordenadas ``x_1`` e ``y_1`` formam os catetos de um triângulo retângulo. O segmento de reta que liga o ponto de referência ao ponto P é a hipotenusa desse triângulo retângulo, e seu comprimento é igual à distância entre P e o ponto de referência. Portanto, de acordo com o *Teorema de Pitágoras*:

```math
d_1^2 = x_1^2 + y_1^2 \Rightarrow d_1 = \sqrt{x_1^2 + y_1^2}
```

> Lembrando que a distância entre dois pontos é sempre positiva, então sempre escolhemos a raiz quadrada positiva.
"""

# ╔═╡ 4f6f3afa-b4df-4452-9f0b-b8fc03a94125
md"""
Mostrar triângulos: $(@bind mostrar_tri_02 CheckBox())

Mostrar distâncias: $(@bind mostrar_dist_02 CheckBox())
"""

# ╔═╡ 2eba258f-71ec-44ad-826e-069ae0eedbc7
md"""
Aplicando o *Teorema de Pitágoras*, para calcular a distância (``d_A``) de A até o ponto de referência temos:

```math
d_A^2 = x_A^2 + y_A^2 \Rightarrow \boxed{d_A = \sqrt{x_A^2 + y_A^2}}
```
"""

# ╔═╡ e2a0ab75-287d-4bd7-8dec-4db5e9ae8e6a
latexstring("d_A^2 = ( ", ponto_A[1], "\\,{\\rm cm})^2  + (", ponto_A[2], 
	"\\,{\\rm cm})^2 = ", ponto_A[1]^2, "\\,{\\rm cm^2} +", ponto_A[2]^2, 
	"\\,{\\rm cm^2} = ", ponto_A[1]^2 + ponto_A[2]^2, "\\,{\\rm cm^2}")

# ╔═╡ c5eec2f4-97d9-463e-a7fe-e7dda91d746a
latexstring("d_A = \\sqrt{", ponto_A[1]^2 + ponto_A[2]^2, "\\,{\\rm cm^2}} = ",
	replace(string(round(norm(ponto_A), digits = 2)), "." => "{,}"), "\\,{\\rm cm}")

# ╔═╡ cfd61681-6193-4e74-91f0-f2985a9fb0f1
md"""
Fazendo o mesmo para os pontos **B = ($(ponto_B[1]) cm, $(ponto_B[2]) cm)** e **C = ($(ponto_C[1]) cm, $(ponto_C[2]) cm)**, encontramos as distâncias destes até o ponto de referência:
"""

# ╔═╡ 875e1c4d-0d88-4556-b1b2-1d39bdd7870b
latexstring("d_B = \\sqrt{", ponto_B[1]^2 + ponto_B[2]^2, "\\,{\\rm cm^2}} = ",
	replace(string(round(norm(ponto_B), digits = 2)), "." => "{,}"), "\\,{\\rm cm}")

# ╔═╡ ae2d2dbf-9855-44b7-8ccf-4bf61d51510b
latexstring("d_C = \\sqrt{", ponto_C[1]^2 + ponto_C[2]^2, "\\,{\\rm cm^2}} = ",
	replace(string(round(norm(ponto_C), digits = 2)), "." => "{,}"), "\\,{\\rm cm}")

# ╔═╡ 68a541df-9218-4dfd-8dfa-5f505706aa1a
md"""
#### Posição relativa entre dois pontos (2D)

Quando estamos sobre uma superfície, e queremos mudar o ponto de referência, devemos seguir o mesmo processo que no caso unidimensional. Seja o ponto ``\vec{P_1} = (x_1, \,y_1)`` definido em relação ao ponto ``O``, e um ponto ``\vec{P_2} = (x_2, \,y_2)`` também definido em relação ao ponto ``O``. A posição de ``P_1`` em relação ao ponto ``P_2`` será:

```math
\vec{P}_{1,2} = (x_1 - x_2, \, y_1 - y_2)
```

Por exemplo, mudando o ponto de referência na imagem abaixo do ponto ``O`` para o ponto ``C``, obtemos as novas posições dos pontos ``A`` e ``B``:

"""

# ╔═╡ fd3cb35d-ac8b-4396-aebb-985ab30016dc
begin
	AC = ponto_A - ponto_C
	BC = ponto_B - ponto_C
	OC = -ponto_C
	points_C = [AC, BC, Point2(0)]
	latexstring("\\vec{A}_C = ( ", ponto_A[1], "\\, {\\rm cm} - (", ponto_C[1],
		"\\,{\\rm cm}), ", ponto_A[2], "\\, {\\rm cm} - (", ponto_C[2], 
		"\\,{\\rm cm})) = (", AC[1], "\\,{\\rm cm}, ", AC[2], "\\,{\\rm cm})")
end

# ╔═╡ 186a6ede-8dbd-4656-9cd6-155eff08350d
latexstring("\\vec{B}_C = ( ", ponto_B[1], "\\, {\\rm cm} - (", ponto_C[1],"\\,{\\rm cm}), ", 
	ponto_B[2], "\\, {\\rm cm} - (", ponto_C[2], "\\,{\\rm cm})) = (", 
	BC[1], "\\,{\\rm cm}, ", BC[2],"\\,{\\rm cm})")

# ╔═╡ 298c1975-5e9f-43be-924c-b874e8055b09
md"""
Para encontrar a distância (``d_{12}``) entre os pontos ``P_1`` e ``P_2``, então devemos utilizar o *Teorema de Pitágoras* com as novas coordenadas:

```math
d_{12}^2 = (x_1 - x_2)^2 + (y_1 - y_2)^2 \Rightarrow d_{12} = \sqrt{(x_1 -x_2)^2 + (y_1 - y_2)^2}
```

Note que a não importa a ordem dos pontos na equação acima já que:

```math
(a - b)^2 = (b - a)^2,
```

então:

```math
d_{12} = d_{21}.
``` 
"""

# ╔═╡ 18bf7a2b-d662-43de-a8b1-a0ff8848a381
md"""
Aplicando o método acima, podemos encontrar a distância entre os pontos ``A``, ``B`` e ``C``. A distância entre os pontos ``A`` e ``C`` e':

"""

# ╔═╡ d5f8b550-0e49-4d41-aee3-2fd44c0df313
latexstring("d_{AC}^2 = ( ", AC[1], "\\,{\\rm cm})^2  + (", AC[2], 
	"\\,{\\rm cm})^2 = ", AC[1]^2, "\\,{\\rm cm^2} +", AC[2]^2, 
	"\\,{\\rm cm^2} = ", AC[1]^2 + AC[2]^2, "\\,{\\rm cm^2}")

# ╔═╡ e96177c5-89db-4ffd-85bc-ef388ec6ee23
latexstring("d_{AC} = \\sqrt{", AC[1]^2 + AC[2]^2, "\\,{\\rm cm^2}} = ",
	replace(string(round(norm(AC), digits = 2)), "." => "{,}"), "\\,{\\rm cm}")

# ╔═╡ e55964e3-3724-4a70-84a9-83062f9842ea
md"""
A distância entre os pontos ``B`` e ``C`` é:
"""

# ╔═╡ 88581c7b-5728-48fb-a933-4adbf2ec619b
latexstring("d_{BC}^2 = ( ", BC[1], "\\,{\\rm cm})^2  + (", BC[2], 
	"\\,{\\rm cm})^2 = ", BC[1]^2, "\\,{\\rm cm^2} +", BC[2]^2, 
	"\\,{\\rm cm^2} = ", BC[1]^2 + BC[2]^2, "\\,{\\rm cm^2}")

# ╔═╡ a6361b9a-8d9a-4dd5-a806-7293d391dedd
latexstring("d_{BC} = \\sqrt{", BC[1]^2 + BC[2]^2, "\\,{\\rm cm^2}} = ",
	replace(string(round(norm(BC), digits = 2)), "." => "{,}"), "\\,{\\rm cm}")

# ╔═╡ 8f32c1aa-0afd-430c-a86d-905b0a772c27
md"""
Já para encontrarmos a distância entre os pontos ``A`` e ``B``, podemos usar diretamente a fórmula da distância entre dois pontos:

```math
d_{AB}^2 = (x_A - x_B)^2 + (y_A - y_B)^2
```
"""

# ╔═╡ 6cf04553-4529-4581-9163-efc03465d885
latexstring("d_{AB}^2 = [", AC[1], "\\,{\\rm cm} - (", BC[1], 
	"\\,{\\rm cm})]^2  + [", AC[2], "\\,{\\rm cm} - (", BC[2], 
	"\\,{\\rm cm})]^2 = (", AC[1] - BC[1], "\\,{\\rm cm)^2} + (", 
	AC[2] - BC[2],"\\,{\\rm cm)^2} = ", (AC[1] - BC[1])^2, "\\,{\\rm cm^2} + ", 
	(AC[2] - BC[2])^2, "\\,{\\rm cm^2}")

# ╔═╡ ad58f766-693c-48c4-8062-8351c6ff4e04
latexstring("d_{AB}^2 = ",(AC[1] - BC[1])^2 + (AC[2] - BC[2])^2,
	"\\,{\\rm cm^2} \\Rightarrow d_{A,B} = \\sqrt{", 
	(AC[1] - BC[1])^2 + (AC[2] - BC[2])^2, "\\,{\\rm cm^2}} = ", 
	replace(string(round(norm(AC - BC), digits = 2)), "." => "{,}"), "\\,{\\rm cm}")

# ╔═╡ dc1661c0-d576-4071-bade-9d42c998dc4a
md"""
Mostrar segmentos entre pontos: $(@bind mostrar_linhas PlutoUI.CheckBox())

Mostrar posição em relação a ``C``: $(@bind mostrar_pos PlutoUI.CheckBox())

Mostrar distâncias entre pontos: $(@bind mostrar_dist PlutoUI.CheckBox())

Mostrar eixos: $(@bind mostrar_eixos PlutoUI.CheckBox())
"""

# ╔═╡ fe455fdd-3a21-4e10-89d0-115c0ada3005
md"""
### 1.1.3. Posição no espaço (3 dimensões)

Na grande maioria dos casos, temos que considerar que os objetos estão no espaço tridimensional (3D). Para fazer a representação da posição de um objeto no espaço são necessários 3 valores ou medidas distintas. Utilizando a representação cartesiana para a posição, temos as posições em relação aos eixos ``x`` e ``y``, e temos que introduzir uma nova coordenada representando a posição em relação ao eixo ``z``. Os 3 eixos de coordenadas são perpendiculares entre si. A representação da posição de um ponto ``P_1`` no espaço cartesiano será:

```math
\vec{P_1} = (x_1,\, y_1,\, z_1),
```
onde ``x_1``, ``y_1`` e ``z_1`` são as respectivas coordenadas nos eixos ``x``, ``y`` e ``z``.
"""

# ╔═╡ 3cb3f748-b8cd-473e-875f-07456d5c920f
begin
	ponto_3A = Point3(rand(-10:1:10, 3))
	ponto_3B = Point3(rand(-10:1:10, 3))
	ponto_3C = Point3(rand(-10:1:10, 3))
end;

# ╔═╡ 0a67b69e-8e24-4db5-9735-85f44bd7902c
md"""
Mostrar eixos de coordenadas $(@bind mostrar_eixos3d CheckBox())

Mostrar posições $(@bind mostrar_pos3d CheckBox())

Mostrar linhas de projeção $(@bind mostrar_proj3d CheckBox())
"""


# ╔═╡ 312c3367-c3b8-4e82-99e1-df03bdf25720
begin
	fig_10 = Figure(resolution = (1000, 1000), fontsize = 18)
	ax_10 = fig_10[1,1] = Axis3(fig_10, aspect = :data, 
		limits = (-11, 11, -11, 11,	-11, 11), viewmode = :fit,
		xlabel = "x (cm)", ylabel = "y (cm)", zlabel = "z (cm)", 
		title = "Posição em 3D" )
	
	#lines!([B[1], B[1]], [0, B[2]], [B[3], B[3]], linestyle = :dash, color = :red)
	#lines!([0, B[1]], [B[2], B[2]], [B[3], B[3]], linestyle = :dash, color = :blue)
	#lines!([B[1], B[1]], [B[2], B[2]], [0, B[3]], linestyle = :dash, color = :green)
	meshscatter!(ax_10, [ponto_3A, ponto_3B, ponto_3C], markersize = 0.3, 
		color = [:darkred, :forestgreen, :dodgerblue])
		
	meshscatter!(ax_10, Point3(0), markersize = 0.2, color = (:black, 0.7))
	
	text!(ax_10, "O", position = (0, 0, -1), align = (:center, :center, :center))
	
	if mostrar_eixos3d
		lines!(ax_10, [0, 0], [0, 0], [-11,11], color = (:black, 0.5), linewidth = 2)
		lines!(ax_10, [0, 0], [-11, 11], [0, 0], color = (:black, 0.5), linewidth = 2)
		lines!(ax_10, [-11, 11], [0, 0], [0, 0], color = (:black, 0.5), linewidth = 2)
	end
	
	if mostrar_pos3d
		lines!(ax_10, [0, ponto_3A[1], ponto_3A[1], ponto_3A[1]], 
			[0, 0, ponto_3A[2], ponto_3A[2]], [0, 0, 0, ponto_3A[3]], 
			linewidth = 3, linestyle = :dash, color = :darkred)

		lines!(ax_10, [0, 0, ponto_3B[1], ponto_3B[1]], 
			[0, ponto_3B[2], ponto_3B[2], ponto_3B[2]], [0, 0, 0, ponto_3B[3]], 
			linewidth = 3, linestyle = :dash, color = :forestgreen)

		lines!(ax_10, [0, 0, 0, ponto_3C[1]], [0, 0, ponto_3C[2], ponto_3C[2]], 
			[0, ponto_3C[3], ponto_3C[3], ponto_3C[3]], 
			linewidth = 3, linestyle = :dash, color = :dodgerblue)

		text!(ax_10, 
			string("A = (", ponto_3A[1]," cm, ", ponto_3A[2]," cm,", 
				ponto_3A[3], " cm)"),
			position = (ponto_3A[1], ponto_3A[2], ponto_3A[3]-1),
			align = (:left, :center, :center), color = :darkred, textsize = 20)

		text!(ax_10, 
			string("B = (", ponto_3B[1]," cm, ", ponto_3B[2]," cm,", 
				ponto_3B[3], " cm)"),
			position = (ponto_3B[1], ponto_3B[2], ponto_3B[3]-1),
			align = (:left, :center, :center), color = :forestgreen, textsize = 20)

		text!(ax_10, 
			string("C = (", ponto_3C[1]," cm, ", ponto_3C[2]," cm,", 
				ponto_3C[3], " cm)"),
			position = (ponto_3C[1], ponto_3C[2], ponto_3C[3]+1),
			align = (:right, :center, :top), color = :dodgerblue, textsize = 20)
	else
		text!(ax_10, ["A", "B", "C"], 
			position = [(ponto_3A[1], ponto_3A[2], ponto_3A[3] - 1),
				(ponto_3B[1], ponto_3B[2], ponto_3B[3] - 1),
				(ponto_3C[1], ponto_3C[2], ponto_3C[3] - 1)],
			align = (:center, :center, :center), 
			color = [:darkred, :forestgreen, :dodgerblue],
			textsize = 20)
	end
	
	
	if mostrar_proj3d
		lines!(ax_10, [ponto_3A[1], ponto_3A[1], 11], [11, ponto_3A[2], ponto_3A[2]], 
			[ponto_3A[3], ponto_3A[3], ponto_3A[3]], color = (:darkred, 0.4),
			linewidth = 2)
		lines!(ax_10, [ponto_3A[1], ponto_3A[1]], [ponto_3A[2], ponto_3A[2]], 
			[ponto_3A[3], -11], color = (:darkred, 0.4), linewidth = 2)

		lines!(ax_10, [ponto_3B[1], ponto_3B[1], 11], [11, ponto_3B[2], ponto_3B[2]], 
			[ponto_3B[3], ponto_3B[3], ponto_3B[3]], color = (:forestgreen, 0.4),
			linewidth = 2)
		lines!(ax_10, [ponto_3B[1], ponto_3B[1]], [ponto_3B[2], ponto_3B[2]], 
			[ponto_3B[3], -11], color = (:forestgreen, 0.4), linewidth = 2)

		lines!(ax_10, [ponto_3C[1], ponto_3C[1], 11], [11, ponto_3C[2], ponto_3C[2]], 
			[ponto_3C[3], ponto_3C[3], ponto_3C[3]], color = (:dodgerblue, 0.4),
			linewidth = 2)
		lines!(ax_10, [ponto_3C[1], ponto_3C[1]], [ponto_3C[2], ponto_3C[2]], 
			[ponto_3C[3], -11], color = (:dodgerblue, 0.4), linewidth = 2)
	end

	#xlims!(ax_10, -11, 11)
	
	ax_10.xticks = -10:2:10
	ax_10.yticks = -10:2:10
	ax_10.zticks = -10:2:10
	fig_10
end

# ╔═╡ e62bb31f-3c3f-4da5-af7e-8c508a67a56e
md"""
#### Distância até o ponto de referência (3D)

Para calcularmos a distância do ponto ``P_1 = (x_1, y_1, z_1)`` até o ponto de referência ``O`` utilizamos o *Teorema de Pitágoras* como no caso de duas dimensões, mas neste caso utilizamos a versão para 3 dimensões. A distância de ``P_1`` a ``O`` será:

```math
d_1^2 = x_1^2 + y_1^2 + z_1^2 \Rightarrow d_1 = \sqrt{x_1^2 + y_1^2 + z_1^2}
```

No exemplo ilustrado na imagem acima, a posição do ponto ``A`` em relação a ``O`` é:
"""

# ╔═╡ 935bb18a-237a-4af2-993a-05dcaf8aadd9
md"""
Portanto, a distância de ``A`` até ``O`` será:
"""

# ╔═╡ 06ded766-ac1a-4e44-b3a3-9cad0129affe
latexstring("d_A^2 = ( ", ponto_3A[1], "\\,{\\rm cm})^2  + (", ponto_3A[2], 
	"\\,{\\rm cm})^2 + (", ponto_3A[3], "\\,{\\rm cm})^2 =", ponto_3A[1]^2, 
	"\\,{\\rm cm^2} + ", ponto_3A[2]^2 , "\\,{\\rm cm^2} + ", ponto_3A[3]^2,
	"\\,{\\rm cm^2}")

# ╔═╡ 9694a5f5-0cb8-430b-aac7-9fc876391652
latexstring("d_A^2 = ",ponto_3A[1]^2 + ponto_3A[2]^2 + ponto_3A[3]^2, "{\\rm \\,
	cm^2} \\Rightarrow d_A = \\sqrt{", ponto_3A[1]^2 + ponto_3A[2]^2 + ponto_3A[3]^2,
	"{\\rm \\,	cm^2}} = ", 
	replace(string(round(norm(ponto_3A), digits = 2)), "." => "{,}"),
	"{\\rm \\, cm}")

# ╔═╡ 45c1eef9-f5e3-421b-97fd-074e40726826
md"""
#### Posição relativa entre dois pontos (3D)

A posição relativa entre dois pontos é calculada de forma semelhante aos casos anteriores. Sendo os pontos ``\vec{P}_1 = (x_1, \,y_1,\, z_1)`` e ``\vec{P}_2 = (x_2,\, y_2,\, z_2)`` definidos em relação ao ponto de referência ``O``. A posição ``\vec{P}_{1,2}`` de ``P_1`` em relação a ``P_2`` será: 

```math
\vec{P}_{1,2} = (x_1 - x_2,\, y_1 - y_2,\, z_1 - z_2)
```

Já a distância entre ``P_1`` e ``P_2`` pode ser calculada aplicando o *Teorema de Pitágoras*:
```math
d_{12}^2 = (x_1 - x_2)^2 + (y_1 - y_2)^2 + (z_1 - z_2)^2
```
```math
d_{12} = \sqrt{(x_1 - x_2)^2 + (y_1 - y_2)^2 + (z_1 - z_2)^2}
```
Utilizando o exemplo ilustrado acima, vamos descobrir qual a posição de ``A`` em relação a ``B``. A posição de ``B`` em relação a ``O`` é:
"""

# ╔═╡ 3cad23f7-cc2b-4e75-8946-fd82316d3eaa
md"""
Então a posição de ``A`` em relação a ``B`` é:
"""

# ╔═╡ 02e89549-69a2-41e4-aa32-0f2cc95b6acf
latexstring("\\vec{A}_B = (", ponto_3A[1], "{\\rm \\, cm} -(", ponto_3B[1], 
	"{\\rm \\, cm),\\,}", ponto_3A[2], "{\\rm \\, cm} -(", ponto_3B[2], 
	"{\\rm \\, cm),\\,}", ponto_3A[3], "{\\rm \\, cm} -(", ponto_3B[3], 
	"{\\rm \\, cm))}")
	

# ╔═╡ 58412905-c059-4573-9161-2fc1594333e6
md"""
A distância entre os pontos ``A`` e ``B`` será:
"""

# ╔═╡ 3ee6f69e-c585-4d78-8ec7-01fbefb4923f
begin
	ponto_3AB = ponto_3A - ponto_3B
	latexstring("d_{AB}^2 = ( ", ponto_3AB[1], "\\,{\\rm cm})^2  + (", ponto_3AB[2], 
		"\\,{\\rm cm})^2 + (", ponto_3AB[3], "\\,{\\rm cm})^2 =", ponto_3AB[1]^2, 
		"\\,{\\rm cm^2} + ", ponto_3AB[2]^2 , "\\,{\\rm cm^2} + ", ponto_3AB[3]^2,
		"\\,{\\rm cm^2}")
end

# ╔═╡ 420f0bb3-93cc-47a4-9bc9-b4cff812a96b
latexstring("d_{AB}^2 = ",ponto_3AB[1]^2 + ponto_3AB[2]^2 + ponto_3AB[3]^2, 
	"{\\rm \\, cm^2} \\Rightarrow d_{AB} = \\sqrt{", 
	ponto_3AB[1]^2 + ponto_3AB[2]^2 + ponto_3AB[3]^2, "{\\rm \\,	cm^2}} = ",
	replace(string(round(norm(ponto_3AB), digits = 2)), "." => "{,}")
	,"{\\rm \\, cm}")

# ╔═╡ e540f62f-77cf-4ac5-9552-6f1aaab1f4de
md"""
### Resumo da seção

**Posição de um ponto ``P_1`` em relação à ``O`` no sistema cartesiano:**

> A posição pode ter valores positivos e negativos e deve ser representada com uma quantidade de medidas igual à quantidade de dimensões do local.

- 1 dimensão (1 medida), ``\vec{O} = 0``:

```math
\vec{P}_1 = x_1 
```

- 2 dimensões (2 medidas), ``\vec{O} = (0, 0)``:

```math
\vec{P}_1 = (x_1, \, y_1)
```

- 3 dimensões (3 medidas), ``\vec{O} = (0, 0, 0)``:

```math
\vec{P}_1 = (x_1, \, y_1,\, z_1)
```

**Distância entre ``P_1`` e ``O`` no sistema cartesiano:**

> A distância é sempre positiva e é sempre representada por um único valor.

- 1 dimensão:

```math
d_1 = |x_1|
```
- 2 dimensões:

```math
d_1 = \sqrt{x_1^2 + y_1^2}
```

- 3 dimensões:
```math
d_1 = \sqrt{x_1^2 + y_1^2 + z_1^2}
```

**Posição de ``P_1`` em relação a ``P_2`` no sistema cartesiano:**

- 1 dimensão, ``\vec{P}_1 = x_1`` e ``\vec{P}_2 = x_2``:

```math
\vec{P}_{1,2} = x_1 - x_2
```

- 2 dimensões, ``\vec{P}_1 = (x_1,\, y_1)`` e ``\vec{P}_2 = (x_2,\, y_2)``:

```math
\vec{P}_{1,2} = (x_1 - x_2, \, y_1 - y_2)
```

- 3 dimensões, ``\vec{P}_1 = (x_1,\, y_1, \, z_1)`` e ``\vec{P}_2 = (x_2,\, y_2, \, z_2)``:

```math
\vec{P}_{1,2} = (x_1 - x_2, \, y_1 - y_2, \, z_1 - z_2)
```

**Distância entre ``P_1`` e ``P_2`` no sistema cartesiano:**

- 1 dimensão:

```math
d_{12} = |x_1 - x_2|
```

- 2 dimensões:

```math
d_{12} = \sqrt{(x_1 - x_2)^2 + (y_1 - y_2)^2}
```

- 3 dimensões:

```math
d_{12} = \sqrt{(x_1 - x_2)^2 + (y_1 - y_2)^2 + (z_1 - z_2)^2}
```

"""

# ╔═╡ c9eef879-1cc0-4d46-8dcb-a3864c405c45
begin
	function rotaçao2D(p::Point2, θ)
		matriz_rotacao = [cos(θ) -sin(θ); sin(θ) cos(θ)]
		return matriz_rotacao * p
	end
	
	function escrever_posicao(p::Point3, nome, unidade)
		latexstring(nome," = (", p[1],"{\\rm \\,",unidade,"},\\,", p[2],
			"{\\rm \\,",unidade,"},\\,",p[3],"{\\rm \\,",unidade,"}).")
	end
		
end;

# ╔═╡ c9f8d8ca-24ef-4d38-acb3-21d36f6beff3
begin
	fig_02 = Figure(resolution = (800, 800))
	
	ax_02 = fig_02[1, 1] = Axis(fig_02, aspect = DataAspect(), 
		xlabel = "posição x (cm)", ylabel = "posição y (cm)",
		title = "Posição em 2 dimensões")
	
	scatter!(ax_02, points, markersize = 15, color = [:red, :green, :blue])
	scatter!(ax_02, Point2(0), markersize = 15, marker = :rect, color = :black)
	
	text!("O", position = (-0.3, -0.3), align = (:center, :center), color = :black)
	
	text!([string("A = (", ponto_A[1], " cm, ", ponto_A[2], " cm)"), 
			string("B = (", ponto_B[1], " cm, ", ponto_B[2], " cm)"), 
			string("C = (", ponto_C[1], " cm, ", ponto_C[2], " cm)")], 
		position = [(ponto_A[1], ponto_A[2] + 0.4), 
			(ponto_B[1], ponto_B[2] + 0.4), (ponto_C[1], ponto_C[2] + 0.4)],
		align = [(:center, :center), (:center, :center), (:center, :center)], 
		color = [:red, :green, :blue],
		textsize = 17)
	
	
	if mostrar_tri_02
		lines!(ax_02, [Point2(0), ponto_A],  color = :red)
		lines!(ax_02, [Point2(0), ponto_B],  color = :green)
		lines!(ax_02, [Point2(0), ponto_C],  color = :blue)
		
		lines!(ax_02, [ponto_A, Point2(ponto_A[1], 0), Point2(0)], linewidth = 2, 
			linestyle = :dash, color = (:red, 0.8))
		lines!(ax_02, [ponto_B, Point2(ponto_B[1], 0), Point2(0)], linewidth = 2, 
			linestyle = :dash, color = (:green, 0.8))
		lines!(ax_02, [ponto_C, Point2(ponto_C[1], 0), Point2(0)], linewidth = 2, 
			linestyle = :dash, color = (:blue, 0.8))
	end
	
	if mostrar_dist_02
		
		if !mostrar_tri_02
			lines!(ax_02, [Point2(0), ponto_A],  color = :red)
			lines!(ax_02, [Point2(0), ponto_B],  color = :green)
			lines!(ax_02, [Point2(0), ponto_C],  color = :blue)
		end
		
		posicao_texto_A = rotaçao2D(Point2(norm(ponto_A)/2, 0.3), 
			atan(ponto_A[2], ponto_A[1]))
		
		posicao_texto_B = rotaçao2D(Point2(norm(ponto_B)/2, 0.3), 
			atan(ponto_B[2], ponto_B[1]))
		
		posicao_texto_C = rotaçao2D(Point2(norm(ponto_C)/2, 0.3), 
			atan(ponto_C[2], ponto_C[1]))
	
		text!(replace(string(round(norm(ponto_A), digits = 2), " cm"), "." => ","),
			#position = (ponto_A[1]/2 + 0.5, ponto_A[2]/2 - 0.5), 
			position = (posicao_texto_A[1], posicao_texto_A[2]),
			align = (:center, :center),
			color = :red, rotation = atan(ponto_A[2]/ponto_A[1]), textsize = 15)

		text!(replace(string(round(norm(ponto_B), digits = 2), " cm"), "." => ","),
			position = (posicao_texto_B[1], posicao_texto_B[2]), 
			align = (:center, :center),
			color = :green, rotation = atan(ponto_B[2]/ponto_B[1]), textsize = 15)

		text!(replace(string(round(norm(ponto_C), digits = 2), " cm"), "." => ","),
			position = (posicao_texto_C[1], posicao_texto_C[2]), 
			align = (:center, :center),
			color = :blue, rotation = atan(ponto_C[2]/ponto_C[1]), textsize = 15)
	end
	
	limits!(ax_02, -8, 8, -8, 8)
	ax_02.xticks = -8:1:8
	ax_02.yticks = -8:1:8
	hidespines!(ax_02)
	fig_02
end

# ╔═╡ bc19d74e-d7b1-4115-bb69-e799d5216afc
begin
	fig_04 = Figure(resolution = (800, 800))
	
	ax_04 = fig_04[1, 1] = Axis(fig_04, aspect = DataAspect(), 
		xlabel = "posição x (cm)", ylabel = "posição y (cm)",
		title = "Posição relativa (2 dimensões)")
	
	if mostrar_pos
		scatter!(ax_04, points_C, markersize = 15, color = [:red, :green, :blue])
		scatter!(ax_04, OC, markersize = 15, marker = :rect, color = :black)
				
		text!([string("Ac = (", AC[1], " cm, ", AC[2], " cm)"), 
			string("Bc = (", BC[1], " cm, ", BC[2], " cm)")], 
			position = [(AC[1], AC[2] - 0.3), (BC[1], BC[2] - 0.3)],
			align = [(:center, :center), (:center, :center)], 
			color = [:red, :green], textsize = 15)
		if mostrar_linhas
			lines!(ax_04, [0, AC[1]], [0, AC[2]], color = :green)
			lines!(ax_04, [0, BC[1]], [0, BC[2]], color = :red)
			lines!(ax_04, [AC[1], BC[1]], [AC[2], BC[2]], color = :blue)
		end
		
		if mostrar_eixos
			vlines!(ax_04, 0, color = :black)
			hlines!(ax_04, 0, color = :black)
		end
		
		text!("O", position = (OC[1] - 0.3, OC[2] - 0.3), 
			align = (:center, :center), color = :black)
		text!(["A", "B", "C"], position = [(AC[1] - 0.3, AC[2] + 0.3), 
			(BC[1] - 0.3, BC[2] + 0.3), (-0.3 , 0.3)],
		align = (:center, :center), color = [:red, :green, :blue])
		
		if mostrar_dist
			posicao_texto_Ac = rotaçao2D(Point2(norm(AC)/2, 0.3), atan(AC[2], AC[1]))
			posicao_texto_Bc = rotaçao2D(Point2(norm(BC)/2, 0.3), atan(BC[2], BC[1]))
			posicao_texto_Ab = rotaçao2D(Point2(norm(AC - BC)/2, 0.3), 
				atan((AC[2]-BC[2]), (AC[1] - BC[1])))

			text!(replace(string(round(norm(AC), digits = 2), " cm"), "." => ","),
				#position = (ponto_A[1]/2 + 0.5, ponto_A[2]/2 - 0.5), 
				position = (posicao_texto_Ac[1], posicao_texto_Ac[2]),
				align = (:center, :center),
				color = :green, rotation = atan(AC[2]/AC[1]), textsize = 15)

			text!(replace(string(round(norm(BC), digits = 2), " cm"), "." => ","),
				position = (posicao_texto_Bc[1], posicao_texto_Bc[2]), 
				align = (:center, :center),
				color = :red, rotation = atan(BC[2],BC[1]), textsize = 15)

			text!(replace(string(round(norm(AC - BC), digits = 2), " cm"), 
					"." => ","),
				position = (posicao_texto_Ab[1] + BC[1], posicao_texto_Ab[2] + BC[2]), 
				align = (:center, :center),
				color = :blue, rotation = atan((AC[2]-BC[2]),(AC[1]-BC[1])), 
				textsize = 15)
		end
		
		limits!(ax_04, -6 - ponto_C[1], 6 - ponto_C[1], -6 - ponto_C[2], 
			6 - ponto_C[2])
		ax_04.xticks = -6 - ponto_C[1]:1:6 - ponto_C[1]
		ax_04.yticks = -6 - ponto_C[2]:1:6 - ponto_C[2]
	else
		scatter!(ax_04, points, markersize = 15, color = [:red, :green, :blue])
		scatter!(ax_04, Point2(0), markersize = 15, marker = :rect, color = :black)
		
		if mostrar_eixos
			vlines!(ax_04, 0, color = :black)
			hlines!(ax_04, 0, color = :black)
		end
		
		if mostrar_linhas
			lines!(ax_04, [ponto_A[1], ponto_C[1]], [ponto_A[2], ponto_C[2]], 
				color = :green)
			lines!(ax_04, [ponto_B[1], ponto_C[1]], [ponto_B[2], ponto_C[2]], 
				color = :red)
			lines!(ax_04, [ponto_A[1], ponto_B[1]], [ponto_A[2], ponto_B[2]], 
				color = :blue)
		end
		
		text!("O", position = (-0.3, -0.3), align = (:center, :center), 
			color = :black)
		text!(["A", "B", "C"], position = [(ponto_A[1] - 0.3, ponto_A[2] + 0.3), 
			(ponto_B[1] - 0.3, ponto_B[2] + 0.3), 
				(ponto_C[1] -0.3 , ponto_C[2] + 0.3)],
		align = (:center, :center), color = [:red, :green, :blue])
		
				
		limits!(ax_04, -8, 8, -8, 8)
		ax_04.xticks = -8:1:8
		ax_04.yticks = -8:1:8
			
	end
	
	
	#limits!(ax_04, -6 - ponto_C[1], 6 - ponto_C[1], -6 - ponto_C[2], 6 - ponto_C[2])
	#ax_04.xticks = -6:1:6
	#ax_04.yticks = -6:1:6
		
	hidespines!(ax_04)
	fig_04
end

# ╔═╡ a50a0690-7b44-4361-9a50-ea3b7a3416c3
escrever_posicao(ponto_3A, "A", "cm")

# ╔═╡ b26cc4b9-588f-446a-8c8f-9e10bc421702
escrever_posicao(ponto_3A, "A", "cm")

# ╔═╡ 2c4524fd-e9e9-4c60-8f6d-ce8debdafecb
escrever_posicao(ponto_3B, "B", "cm")

# ╔═╡ 26d7378f-e174-4bcc-96ae-9b0c1066d5a0
escrever_posicao(ponto_3A-ponto_3B, "A_{B}", "cm")

# ╔═╡ Cell order:
# ╠═c0c2b95c-8d6d-4219-9fe8-b28c6b05f5e0
# ╠═6c978cdd-a550-4d0f-97c4-63741ef2010c
# ╠═39613139-84d2-4843-acab-45f02914ee90
# ╟─81891cae-19fb-4be5-81d4-f006b38ee797
# ╟─db2ee140-7191-47d2-a282-f9d13e38adab
# ╟─a60ba8e9-9c09-4a5b-ab9f-16e65712d635
# ╟─5a34dc36-9187-4ce6-8f9e-dad0f20b3098
# ╟─a0de6f53-7cdd-491e-b125-0e1cafe35fe1
# ╟─18e9805b-a542-47ff-aba8-6bde222e71e6
# ╟─c07a643a-e36f-4853-bc97-079d1f4ad560
# ╟─b948d630-845e-4828-87c8-2b9751235613
# ╟─2769546e-99a7-4632-a0b0-8f5be8709b5d
# ╟─2fe6d737-1524-46fc-a978-7ab6d9814b1e
# ╟─fd4842d3-e8b9-40d6-9374-7b725975d45d
# ╟─4f6f3afa-b4df-4452-9f0b-b8fc03a94125
# ╟─c9f8d8ca-24ef-4d38-acb3-21d36f6beff3
# ╟─2eba258f-71ec-44ad-826e-069ae0eedbc7
# ╟─e2a0ab75-287d-4bd7-8dec-4db5e9ae8e6a
# ╟─c5eec2f4-97d9-463e-a7fe-e7dda91d746a
# ╟─cfd61681-6193-4e74-91f0-f2985a9fb0f1
# ╟─875e1c4d-0d88-4556-b1b2-1d39bdd7870b
# ╟─ae2d2dbf-9855-44b7-8ccf-4bf61d51510b
# ╟─68a541df-9218-4dfd-8dfa-5f505706aa1a
# ╟─fd3cb35d-ac8b-4396-aebb-985ab30016dc
# ╟─186a6ede-8dbd-4656-9cd6-155eff08350d
# ╟─298c1975-5e9f-43be-924c-b874e8055b09
# ╟─18bf7a2b-d662-43de-a8b1-a0ff8848a381
# ╟─d5f8b550-0e49-4d41-aee3-2fd44c0df313
# ╟─e96177c5-89db-4ffd-85bc-ef388ec6ee23
# ╟─e55964e3-3724-4a70-84a9-83062f9842ea
# ╟─88581c7b-5728-48fb-a933-4adbf2ec619b
# ╟─a6361b9a-8d9a-4dd5-a806-7293d391dedd
# ╟─8f32c1aa-0afd-430c-a86d-905b0a772c27
# ╟─6cf04553-4529-4581-9163-efc03465d885
# ╟─ad58f766-693c-48c4-8062-8351c6ff4e04
# ╟─dc1661c0-d576-4071-bade-9d42c998dc4a
# ╟─bc19d74e-d7b1-4115-bb69-e799d5216afc
# ╟─fe455fdd-3a21-4e10-89d0-115c0ada3005
# ╠═3cb3f748-b8cd-473e-875f-07456d5c920f
# ╟─0a67b69e-8e24-4db5-9735-85f44bd7902c
# ╟─312c3367-c3b8-4e82-99e1-df03bdf25720
# ╟─e62bb31f-3c3f-4da5-af7e-8c508a67a56e
# ╟─a50a0690-7b44-4361-9a50-ea3b7a3416c3
# ╟─935bb18a-237a-4af2-993a-05dcaf8aadd9
# ╟─06ded766-ac1a-4e44-b3a3-9cad0129affe
# ╟─9694a5f5-0cb8-430b-aac7-9fc876391652
# ╟─45c1eef9-f5e3-421b-97fd-074e40726826
# ╟─b26cc4b9-588f-446a-8c8f-9e10bc421702
# ╟─2c4524fd-e9e9-4c60-8f6d-ce8debdafecb
# ╟─3cad23f7-cc2b-4e75-8946-fd82316d3eaa
# ╟─02e89549-69a2-41e4-aa32-0f2cc95b6acf
# ╟─26d7378f-e174-4bcc-96ae-9b0c1066d5a0
# ╟─58412905-c059-4573-9161-2fc1594333e6
# ╟─3ee6f69e-c585-4d78-8ec7-01fbefb4923f
# ╟─420f0bb3-93cc-47a4-9bc9-b4cff812a96b
# ╟─e540f62f-77cf-4ac5-9552-6f1aaab1f4de
# ╟─c9eef879-1cc0-4d46-8dcb-a3864c405c45
