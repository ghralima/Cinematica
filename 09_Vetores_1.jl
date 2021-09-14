### A Pluto.jl notebook ###
# v0.16.0

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

# ╔═╡ 7cb2b12b-6bba-4ed8-9b78-356c8c689d7e
begin
	using Pkg
	Pkg.activate(".")
end

# ╔═╡ 38339050-f387-11eb-0542-7170a2dd8538
begin
	using CairoMakie
	using LaTeXStrings
	using Latexify
	using PlutoUI
	using HypertextLiteral
	using Unitful
	using UnitfulLatexify
	using LinearAlgebra
	TableOfContents(title = "Índice", depth = 4)
end

# ╔═╡ d0903a59-db36-4c05-a96d-ef1e74f45c09
md"""
## 1.7. Vetores na cinemática

### 1.7.1. Representação vetorial

Um pode ser representado graficamente por uma seta, como podemos ver abaixo:
"""

# ╔═╡ 33183e89-b642-40ca-809a-ae361de0e347
A = Point2f(rand(-8:8, 2));

# ╔═╡ 2997db63-6af0-4836-bd11-11f1700eafee
md"""
Mostrar as componentes de ``\vec{A}``: 
$(@bind mostrar_comp PlutoUI.CheckBox())
"""

# ╔═╡ f64e3953-d5bd-4b33-bc93-0848ef566942
latexstring("\\vec{A} = ( $(round(Int, A[1])),\\, $(round(Int, A[2])))")

# ╔═╡ 072b5789-4025-49e5-b2fa-c676c091b29f
md"""
Cada um dos valores dentro do parênteses são as componentes do vetor ``\vec{A}``. A primeira componente é sempre a componente na direção ``x``, e a segunda componente é sempre a componente na direção ``y``.

Para calcular o módulo de ``\vec{A}`` podemos utilizar suas componentes como os catetos de um triângulo retângulo, e com isso aplicar o *Teorema de Pitágoras*. A hipotenusa do triângulo é o próprio módulo do vetor:
"""

# ╔═╡ 01607855-7f55-40cc-8078-d4fdb4e546e9
latexstring("||\\vec{A}|| = \\sqrt{($(round(Int, A[1])))^2 + ($(round(Int, A[2])))^2} = \\sqrt{$(round(Int, A[1]^2 + A[2]^2))}")

# ╔═╡ 9bc4fe65-3fe2-41df-b37c-f25fde975784
md"""
A notação matemática ``||\vec{A}||`` representa o módulo de ``\vec{A}``. Para simplificar a notação, representaremos o módulo do vetor ``\vec{A}`` como simplesmente ``A`` (o nome do vetor sem a seta flutuante).

Vamos adicionar agora um outro vetor ``\vec{B}`` na figura e compará-lo com ``\vec{A}``.
"""

# ╔═╡ 9c64ceb3-4bfc-4407-b1af-075b0c5f49ec
latexstring("\\vec{B} = ( $(round(Int, A[1])),\\, $(round(Int, A[2]))).")

# ╔═╡ 7b63b617-d4f1-4d5e-b8a4-45a32ae1fccb
md"""
Como ambos os vetores têm as mesmas componentes, ele também têm o mesmo módulo. As direções de ambos os vetores (retas tracejadas) são paralelas, ou seja, têm a mesma inclinação em relação aos eixos ``x`` e ``y``, por exemplo. A inclinação da reta representa a direção do vetor, portanto, ambos têm a mesma direção. E como a seta aponta no mesmo sentido de ambos, eles também têm o mesmo sentido. Sendo assim, 

```math
\vec{A} = \vec{B}.
```

Portanto, quando dois vetores têm às mesmas componentes, esses vetores são iguais, **mesmo que não estejam começando e terminando nas mesmas posições!**

> Sendo ``\vec{A} = (a_x, a_y)`` e ``\vec{B} = (b_x, b_y)``, se ``a_x = b_x`` e ``a_y = b_y``, então ``\vec{A} = \vec{B}``.
"""

# ╔═╡ 8ab261c6-f13c-483f-ac4e-5348313fb389
md"""
### 1.7.2. Inversão de um vetor

Agora, vamos comparar ``\vec{A}`` com um outro vetor ``\vec{C}`` na imagem abaixo.
"""

# ╔═╡ 9097923f-74d3-4985-8eb2-5478d238ad52
latexstring("\\vec{C} = ( $(round(Int, -A[1])),\\, $(round(Int, -A[2]))).")

# ╔═╡ 8f9f21b2-8780-4f33-bc30-0074a2933ab5
md"""
Pode-se notar que as componentes de ``\vec{C}`` são iguais às componentes de ``\vec{A}`` multiplicadas por ``-1``. O módulo de ``\vec{C}`` é igual ao módulo de ``\vec{A}``, como podemos ver abaixo:
"""

# ╔═╡ abdeee97-81cb-4adf-b80a-7f82b335e4cd
latexstring("||\\vec{C}|| = \\sqrt{($(round(Int, -A[1])))^2 + ($(round(Int, -A[2])))^2} = \\sqrt{$(round(Int, A[1]^2 + A[2]^2))}")

# ╔═╡ f4e5e3bc-b69d-40a4-a2e9-07b603b18d02
md"""
Os vetores ``\vec{A}`` e ``\vec{C}`` estão sobre retas que são paralelas entre si, ou seja, têm a mesma direção. A única diferença está nos sentidos, que são opostos!

> Dizemos que vetores que têm a mesma direção, mas têm sentidos opostos são vetores **anti-paralelos**!

Como
"""

# ╔═╡ 19022120-dc58-4173-a497-002d7d2515f2
latexstring("\\vec{C} = ( $(round(Int, -A[1])),\\, $(round(Int, -A[2]))) =
	-1\\underbrace{($(round(Int, A[1])),\\, $(round(Int, A[2])))}_{\\vec{A}} = 
	-1 \\vec{A}")

# ╔═╡ 3da49da5-4ea6-4127-a6a1-5c7bd4af3cc9
latexstring("\\vec{C} = - \\vec{A}.")

# ╔═╡ f279bfd3-e1cc-4fc1-b38c-785b58ea68b1
md"""
Então, para inverter o sentido de um vetor, devemos simplesmente multiplicar suas componentes por ``-1``. Então, se
"""

# ╔═╡ 275a4e2f-7739-418e-8d38-93c973172289
latexstring("\\vec{A} = ( $(round(Int, A[1])),\\, $(round(Int, A[2]))),")

# ╔═╡ 5895003b-7a1d-4112-b336-4fc40621bda8
md"""
o vetor ``-\vec{A}`` que tem mesmo módulo, mesma direção, mas sentido oposto ao de ``\vec{A}`` é
"""

# ╔═╡ ed2a611d-c020-4c79-8c79-6af4ebd110f4
latexstring("-\\vec{A} = ( $(round(Int, -A[1])),\\, $(round(Int, -A[2]))).")

# ╔═╡ d7817260-aacf-491c-8fb0-87c0e402b3ef
md"""
### 1.7.3. Multiplicação de um vetor por um escalar

Acabamos de ver o que acontece quando multiplicamos um vetor por ``-1``. Também é possível multiplicar um vetor por qualquer número real. Por exemplo, se

``\vec{D} = 2\vec{A}``,

então ``\vec{D}`` é um vetor com módulo duas vezes maior que ``\vec{A}``, mas com a mesma direção e sentido de ``\vec{A}``.

``\vec{D} = 2\cdot(7, \, -2) = (14, \, -4).``

O vetor ``\vec{D}`` está representado na figura abaixo.
"""

# ╔═╡ 602923f3-e36f-4ef4-b64a-5a82db6706f3
md"""
Calculando o módulo de ``\vec{D}`` vemos que:
"""

# ╔═╡ e5ae81f9-7161-4d0f-9c7e-d580ee676056
latexstring("||\\vec{D}|| = \\sqrt{($(round(Int, 2*A[1])))^2 + ($(round(Int, 2*A[2])))^2} = \\sqrt{$(round(Int, (2*A[1])^2 + (2*A[2])^2))},")

# ╔═╡ cf8e9c0e-ac29-49d3-9316-33a612d3ded8
md"Ou seja,"

# ╔═╡ 42b5b44c-48e6-4884-b0a4-8f24a003e084
md"""
O mesmo vale quando multiplicamos ``\vec{A}`` por qualquer número real. Seja

``\vec{E} = -4{,}5 \cdot \vec{A}``.

Então

``\vec{E} = -4{,}5 \cdot (7, \, -2) = (-31{,}5,\, 9)``.

O vetor ``\vec{E}`` é o vetor que tem módulo ``4{,}5`` vezes maior que ``\vec{A}``, tem a mesma direção e sentido contrário ao de ``\vec{A}`` :

"""

# ╔═╡ bfa7dfa3-a57a-415a-9cfc-5ed687845ffd
md"""
>Lembre-se que o módulo de qualquer vetor é sempre positivo! Portanto, mesmo quando multiplicamos o vetor por um valor negativo, o módulo do vetor ainda é positivo!

Resumindo, seja ``c \in \mathbb{R}``, e ``\vec{A} = (a_x, a_y)``:

``c \vec{A} = c\cdot(a_x,\, a_y) = (c\cdot a_x,\, c\cdot a_y)``

e

``||c\vec{A}|| = |c| \cdot ||\vec{A}||.``
"""

# ╔═╡ 5fab17c5-c7bc-44c1-8970-ce47acf14085
begin
	function trocarpontovirgtexto(x::Real; digits = 1)
		x_arr = (digits == 0 ? round(Int, x) : round(x; digits = digits))
		replace(string(x_arr), "." => ",")
	end
	
	function trocarpontovirglatex(x::Real; digits = 1)
		x_arr = (digits == 0 ? round(Int, x) : round(x; digits = digits))
		replace(string(x_arr), "." => "{,}")
	end
	
	#equação de uma reta
	f_reta(a, b, x) = a*x + b
	
	#função para calcular as raízes da equação ax² + bx + c = 0
	function baskara(a, b, c)
		Δ = b*b - 4*a*c
		if Δ > 0
			x₁ = (-b - √Δ)/(2*a)
			x₂ = (-b + √Δ)/(2*a)
			return x₁, x₂
		elseif Δ == 0
			return -b/(2*a)
		else
			Δ = complex(Δ)
			x₁ = (-b - √Δ)/(2*a)
			x₂ = (-b + √Δ)/(2*a)
			return x₁, x₂
		end
	end
			
	#função para gerar a seta do vetor
	#A é o vetor, l é o tamanho da seta, 
	#α é o ângulo entre a direção do vetor e os lados da seta em graus 
	function seta_vetor(A::Point2f; l::Real = 1, α::Real = 25)
		#calculando o ângulo entre o vetor e a direção horizontal em graus
		θ = atand(A[2], A[1])
		
		#ângulo entre a direção vertical e o lado inferior da seta
		β1 = 90 - α - θ
		
		#ângulo entre a direção vertical e o lado superior da seta
		β2 = 90 + α - θ
		
		#encontrando os pontos que formam a seta
		p1 = Point2f(A[1] - l*sind(β1), A[2] - l*cosd(β1))
		p2 = Point2f(A[1] - l*sind(β2), A[2] - l*cosd(β2))
		
		return [A, p1, p2]
	end
	
	#função para desenhar vetores
	#origem é o ponto de origem do vetor
	#arrowsize é o tamanho dos lados da seta
	function desenhar_vetor!(axis::Axis, origem::Point2f, vetor::Point2f; 
			arrowsize = 0.5, color = :dodgerblue)
		
		#desenhando linha entre a origem e o final do vetor
		lines!(axis, [origem, origem + vetor], color = color,
			linewidth = 2)
		
		#encontrando os vértices da seta do vetor
		seta = [origem + ponto for ponto ∈ seta_vetor(vetor; l = arrowsize)]
		
		#desenhando a seta do vetor
		poly!(axis, seta, 
			color = color, 
			strokewidth = 1,
			strokecolor = color)
	end
	
	function orientacao_vetor(vetor::Point2f)
		if vetor[1] > 0 
			hor = "$(round(Int, abs(vetor[1]))) unidades de medida para a direita"
		elseif vetor[1] < 0
			hor = "$(round(Int, abs(vetor[1]))) unidades de medida para a esquerda"
		end
		
		if vetor[2] > 0
			ver = "$(round(Int, abs(vetor[2]))) unidades de medida para cima"
		elseif vetor[2] < 0
			ver = "$(round(Int, abs(vetor[2]))) unidades de medida para baixo"
		end
		
		vetor[1] == 0 && return ver
		vetor[2] == 0 && return hor
		
		return "$(hor), e $(ver)"
	end
		
	fmt(x) = replace(string(x), "." => "{,}")
end

# ╔═╡ 1c4e9b1c-5eb5-4809-ab99-661443cb2312
begin
	fig01 = Figure(resolution = (800, 800))
	ax101 = Axis(fig01[1, 1], 
		title = "Representação vetorial",
		xlabel = "direção x",
		ylabel = "direção y",
		xticks = -9:9,
		yticks = -9:9)
	
	limits!(ax101, -9, 9, -9, 9)
	
	hlines!(ax101, [0], linewidth = 1, color = :black)
	vlines!(ax101, [0], linewidth = 1, color = :black)
	
	lines!(ax101, [-9*A[1], 9*A[1]], [-9*A[2], 9*A[2]],
		linestyle = :dash,
		linewidth = 2,
		color = (:dodgerblue, 0.7))
	
	if mostrar_comp
		desenhar_vetor!(ax101, Point2f(0), Point2f(A[1], 0), 
			color = (:red, 0.8), arrowsize = 0.3)
		desenhar_vetor!(ax101, Point2f(A[1], 0), Point2f(0, A[2]), 
			color = (:red, 0.8), arrowsize = 0.3)
		text!(ax101, L"\vec{A} = (%$(round(Int, A[1])), \, %$(round(Int, A[2])))",
			position = (8, -8),
			align = (:right, :bottom),
			textsize = 25,
			color = :blue)
	end
	
	
	desenhar_vetor!(ax101, Point2f(0), A, color = :dodgerblue, arrowsize = 0.4)
	text!(ax101, L"\vec{A}",
		position = A/2,
		align = (:center, :bottom),
		textsize = 30,
		color = :dodgerblue,
		rotation = atan(A[2], A[1]))
		
	hidespines!(ax101)
		
	fig01
end

# ╔═╡ 5e4b54b8-fd82-42e6-8a97-16070b165e99
md"""
 Todo vetor tem três atributos que o caracterizam:

- **Módulo**: é representado graficamente pelo comprimento do vetor, ou seja, a distância entre a origem do vetor e a ponta da seta. Por ser um comprimento, o módulo do vetor é sempre positivo! O módulo é a intensidade do vetor;

- **Direção**: a reta sobre a qual o vetor se encontra (a reta tracejada na imagem acima) é a direção do vetor. A direção representa a orientação do vetor; 

- **Sentido**: sobre a reta sobre a qual o vetor se encontra existem dois sentidos possíveis, a seta na extremidade do vetor indica o sentido do vetor.

###### Como é possível representar matematicamente o vetor ``\vec{A}`` acima?

O vetor ``\vec{A}`` está sobre o plano cartesiano, ou seja, está sobre uma superfície. Dessa forma, precisamos de dois valores para representar o vetor. Para representá-lo, precisamos descrever uma maneira de se chegar na extremidade da seta a partir de sua origem ou ponto inicial. Para o vetor ``\vec{A}`` da imagem, partindo da origem devemos seguir $(orientacao_vetor(A)) para chegarmos à ponta da seta.

Como os eixos da imagem definem que os valores sobre o eixo ``x`` crescem para a direita e diminuem para a esquerda. E os valores sobre o eixo ``y`` crescem para cima e diminuem para baixo, então, o vetor ``\vec{A}`` pode ser escrito como:

"""

# ╔═╡ 0b0a1ae6-1635-4f4b-a4bd-a4a98b6ffe92
latexstring("||\\vec{A}|| = $(trocarpontovirglatex(norm(A), digits = 1))")

# ╔═╡ b25b94aa-4068-421e-a6d1-d2d5257f9a1f
begin
	fig02 = Figure(resolution = (800, 800))
	ax102 = Axis(fig02[1, 1], 
		title = "Representação vetorial",
		xlabel = "direção x",
		ylabel = "direção y",
		xticks = -9:9,
		yticks = -9:9)
	
	limits!(ax102, -9, 9, -9, 9)
	
	hlines!(ax102, [0], linewidth = 1, color = :black)
	vlines!(ax102, [0], linewidth = 1, color = :black)
	
	lines!(ax102, [-9*A[1], 9*A[1]], [-9*A[2], 9*A[2]],
		linestyle = :dash,
		linewidth = 2,
		color = (:dodgerblue, 0.7))
	
	desenhar_vetor!(ax102, Point2f(0), A, color = :dodgerblue, arrowsize = 0.4)
	text!(ax102, L"\vec{A}",
		position = A/2,
		align = (:center, :bottom),
		textsize = 30,
		color = :dodgerblue,
		rotation = atan(A[2], A[1]))
	
	origemB = Point2f(rand(-4:4, 2))
	
	a_lb = A[2]/A[1]
	b_lb = origemB[2] - a_lb*origemB[1]
	reta_b(x) = f_reta(a_lb, b_lb, x)
	
	lines!(ax102, -9:9, reta_b,
		linestyle = :dash,
		linewidth = 2,
		color = (:dodgerblue, 0.7))
	
	desenhar_vetor!(ax102,origemB, A, color = :dodgerblue, arrowsize = 0.4)
	text!(ax102, L"\vec{B}",
		position = origemB + A/2, 
		align = (:center, :bottom),
		textsize = 30,
		color = :dodgerblue,
		rotation = atan(A[2], A[1]))
	
	hidespines!(ax102)
		
	fig02
end

# ╔═╡ fc0e669c-86e7-4ea4-a0e4-d2896e75a685
md"""
Partindo da origem do vetor ``\vec{B}`` devemos seguir $(orientacao_vetor(A)) para chegar à sua outra extremidade. Ou seja, mesmo que ``\vec{B}`` não tenha a mesma origem que ``\vec{A}``, ele também pode ser representado como:
"""

# ╔═╡ a522cac9-7cdc-46ee-8360-ffc0cfc9facc
begin
	fig03 = Figure(resolution = (800, 800))
	ax103 = Axis(fig03[1, 1], 
		title = "Representação vetorial",
		xlabel = "direção x",
		ylabel = "direção y",
		xticks = -9:9,
		yticks = -9:9)
	
	limits!(ax103, -9, 9, -9, 9)
	
	hlines!(ax103, [0], linewidth = 1, color = :black)
	vlines!(ax103, [0], linewidth = 1, color = :black)
	
	lines!(ax103, [-9*A[1], 9*A[1]], [-9*A[2], 9*A[2]],
		linestyle = :dash,
		linewidth = 2,
		color = (:dodgerblue, 0.7))
	
	desenhar_vetor!(ax103, Point2f(0), A, color = :dodgerblue, arrowsize = 0.4)
	text!(ax103, L"\vec{A}",
		position = A/2,
		align = (:center, :bottom),
		textsize = 30,
		color = :dodgerblue,
		rotation = atan(A[2], A[1]))
	
	origemA1 = A + Point2f(rand(-4:4, 2))
	
	b_lb_1 = origemA1[2] - a_lb*origemA1[1]
	reta_a(x) = f_reta(a_lb, b_lb_1, x)
	
	lines!(ax103, -9:9, reta_a,
		linestyle = :dash,
		linewidth = 2,
		color = (:dodgerblue, 0.7))
	
	desenhar_vetor!(ax103,origemA1, -A, color = :dodgerblue, arrowsize = 0.4)
	text!(ax103, L"\vec{C}",
		position = origemA1 - A/2, 
		align = (:center, :bottom),
		textsize = 30,
		color = :dodgerblue,
		rotation = atan(A[2], A[1]))
	
	hidespines!(ax103)
		
	fig03
end

# ╔═╡ 7d069d71-e413-4a2e-934c-abdbae918e4d
md"""
Partindo da origem de ``\vec{C}`` devemos seguir $(orientacao_vetor(-A)) para chegar até sua outra extremidade, portanto,
"""

# ╔═╡ 6231250d-0f55-4e03-ad33-b5fda06933b0
latexstring("||\\vec{C}|| = $(trocarpontovirglatex(norm(A), digits = 1))")

# ╔═╡ d925056a-698d-498e-8a09-e31c829da571
begin
	fig04 = Figure(resolution = (800, 800))
	ax104 = Axis(fig04[1, 1], 
		title = "Representação vetorial",
		xlabel = "direção x",
		ylabel = "direção y",
		xticks = -9:9,
		yticks = -9:9)
	
	limits!(ax104, -9, 9, -9, 9)
	
	hlines!(ax104, [0], linewidth = 1, color = :black)
	vlines!(ax104, [0], linewidth = 1, color = :black)
	
	lines!(ax104, [-9*A[1], 9*A[1]], [-9*A[2], 9*A[2]],
		linestyle = :dash,
		linewidth = 2,
		color = (:dodgerblue, 0.7))
	
	desenhar_vetor!(ax104, Point2f(0), A, color = :dodgerblue, arrowsize = 0.4)
	text!(ax104, L"\vec{A}",
		position = A/2,
		align = (:center, :bottom),
		textsize = 30,
		color = :dodgerblue,
		rotation = atan(A[2], A[1]))
	
	lines!(ax104, -9:9, reta_b,
		linestyle = :dash,
		linewidth = 2,
		color = (:dodgerblue, 0.7))
	
	desenhar_vetor!(ax104,origemB-A, 2*A, color = :dodgerblue, arrowsize = 0.4)
	text!(ax104, L"\vec{D}",
		position = origemB, 
		align = (:center, :bottom),
		textsize = 30,
		color = :dodgerblue,
		rotation = atan(A[2], A[1]))
	
	hidespines!(ax104)
		
	fig04
end

# ╔═╡ b0f30584-ac17-4e53-ab07-3d24d154d627
latexstring("||\\vec{D}|| = $(trocarpontovirglatex(norm(2*A), digits = 1)).")

# ╔═╡ 745c82a5-5123-4334-b2cc-30a6d6ccfd39
latexstring("||\\vec{D}|| = 2 \\cdot ||\\vec{A}|| = 2 \\cdot $(trocarpontovirglatex(norm(A), digits = 1)) = $(trocarpontovirglatex(norm(2*A), digits = 1)).")

# ╔═╡ 1cfe5049-ca5a-4156-b378-d5c813cea486
latexstring("||\\vec{E}|| = 4{,}5 \\cdot ||\\vec{A}|| = 4{,}5 \\cdot $(trocarpontovirglatex(norm(A), digits = 1)) = $(trocarpontovirglatex(norm(4.5*A), digits = 1)).")

# ╔═╡ Cell order:
# ╟─7cb2b12b-6bba-4ed8-9b78-356c8c689d7e
# ╟─38339050-f387-11eb-0542-7170a2dd8538
# ╟─d0903a59-db36-4c05-a96d-ef1e74f45c09
# ╟─33183e89-b642-40ca-809a-ae361de0e347
# ╟─2997db63-6af0-4836-bd11-11f1700eafee
# ╟─1c4e9b1c-5eb5-4809-ab99-661443cb2312
# ╟─5e4b54b8-fd82-42e6-8a97-16070b165e99
# ╟─f64e3953-d5bd-4b33-bc93-0848ef566942
# ╟─072b5789-4025-49e5-b2fa-c676c091b29f
# ╟─01607855-7f55-40cc-8078-d4fdb4e546e9
# ╟─0b0a1ae6-1635-4f4b-a4bd-a4a98b6ffe92
# ╟─9bc4fe65-3fe2-41df-b37c-f25fde975784
# ╟─b25b94aa-4068-421e-a6d1-d2d5257f9a1f
# ╟─fc0e669c-86e7-4ea4-a0e4-d2896e75a685
# ╟─9c64ceb3-4bfc-4407-b1af-075b0c5f49ec
# ╟─7b63b617-d4f1-4d5e-b8a4-45a32ae1fccb
# ╟─8ab261c6-f13c-483f-ac4e-5348313fb389
# ╟─a522cac9-7cdc-46ee-8360-ffc0cfc9facc
# ╟─7d069d71-e413-4a2e-934c-abdbae918e4d
# ╟─9097923f-74d3-4985-8eb2-5478d238ad52
# ╟─8f9f21b2-8780-4f33-bc30-0074a2933ab5
# ╟─abdeee97-81cb-4adf-b80a-7f82b335e4cd
# ╟─6231250d-0f55-4e03-ad33-b5fda06933b0
# ╟─f4e5e3bc-b69d-40a4-a2e9-07b603b18d02
# ╟─19022120-dc58-4173-a497-002d7d2515f2
# ╟─3da49da5-4ea6-4127-a6a1-5c7bd4af3cc9
# ╟─f279bfd3-e1cc-4fc1-b38c-785b58ea68b1
# ╟─275a4e2f-7739-418e-8d38-93c973172289
# ╟─5895003b-7a1d-4112-b336-4fc40621bda8
# ╟─ed2a611d-c020-4c79-8c79-6af4ebd110f4
# ╟─d7817260-aacf-491c-8fb0-87c0e402b3ef
# ╟─d925056a-698d-498e-8a09-e31c829da571
# ╟─602923f3-e36f-4ef4-b64a-5a82db6706f3
# ╟─e5ae81f9-7161-4d0f-9c7e-d580ee676056
# ╟─b0f30584-ac17-4e53-ab07-3d24d154d627
# ╟─cf8e9c0e-ac29-49d3-9316-33a612d3ded8
# ╟─745c82a5-5123-4334-b2cc-30a6d6ccfd39
# ╟─42b5b44c-48e6-4884-b0a4-8f24a003e084
# ╟─1cfe5049-ca5a-4156-b378-d5c813cea486
# ╟─bfa7dfa3-a57a-415a-9cfc-5ed687845ffd
# ╟─5fab17c5-c7bc-44c1-8970-ce47acf14085
