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

# ╔═╡ 36c11930-041d-11ec-182c-398b86019057
begin
	using Pkg
	Pkg.activate(".")
end

# ╔═╡ 6e602140-ebb6-4e52-9599-4b32b6bdb413
begin
	using CairoMakie
	using LaTeXStrings
	using Latexify
	using Unitful
	using UnitfulLatexify
	using PlutoUI
	using HypertextLiteral
	TableOfContents(title = "Índice", depth = 4)
end

# ╔═╡ 8abb7c3d-54c7-4aaa-adba-491734efffb0
md"""
### 1.6.8. Queda-livre

O movimento de queda-livre é um típico exemplo de MRUV. A movimento de queda-livre é o movimento dos objetos quando são puxados para baixo pela gravidade do nosso planeta, quando desconsideramos a resistência do ar. Podemos considerar que todos os objetos quando caem de alturas que não são tão grandes, caem de acordo com o movimento de queda-livre.

A aceleração da gravidade na superfície da Terra varia de lugar para lugar, e depende principalmente da latitude e da altitude do local. Utilizamos a letra ``g`` para representar a aceleração da gravidade, e o seu valor médio na superfície da Terra é:

``g = 9{,}81 {\rm \, m\,s^{-2}}``,

puxando todos os objetos sempre de volta para a superfície da Terra. Na verdade, a aceleração da gravidade sempre puxa os objetos na direção e sentido do centro da Terra!

O artigo de [Hirt et al. (2013)](https://agupubs.onlinelibrary.wiley.com/doi/full/10.1002/grl.50838) mostra que o ponto na superfície da Terra com a menor aceleração da gravidade está no pico do monte Nevado Huascarán no Peru, onde ``g=9{,}76392{\rm \, m\,s^{-2}}``. Já o ponto com a maior aceleração da gravidade está no Oceano Ártico, onde ``g=9,83366{\rm \, m\,s^{-2}}``. Temos uma variação máximo de apenas ``0{,}07{\rm \, m\,s^{-2}}`` ao longo de toda a superfície da Terra.

[O artigo do Prof. Domingos Soares](http://www.lilith.fisica.ufmg.br/~dsoares/g/g.htm) cita dois pontos em Belo Horizonte com medidas bem precisas da aceleração da gravidade. Um desses pontos está no Departamento de Física da UFMG, onde ``g=9{,}7838163{\rm \, m\,s^{-2}}``; e o outro ponto está no Aeroporto da Pampulha onde a medição foi de ``g=9{,}7838550{\rm \, m\,s^{-2}}``. Como Belo Horizonte e Contagem são cidades vizinhas e têm altitudes médias bem próximas, podemos utilizar um valor aproximado de ``g=9{,}784{\rm \, m\,s^{-2}}`` para a aceleração da gravidade nas duas cidades. 

Ao aplicarmos as equações do MRUV ao movimento de queda livre, vamos escolher que **quando o objeto de movimenta para o alto, ele se movimenta no sentido positivo**, e como a **aceleração da gravidade puxa os objetos para baixo, ela terá um valor negativo**. Nesse movimento, a posição do objeto representa sua altura, vamos trocar ``s(t)`` por ``h(t)`` para representar a altura do objeto em função do tempo. Sendo assim:

- Posição e deslocamento
```math
\boxed{h(t) = h_0 + v_0 \cdot t - \frac{g\cdot t^2}{2}} \Rightarrow \boxed{\Delta h(t) = v_0 \cdot t - \frac{g\cdot t^2}{2}}
```

- Velocidade
```math
\boxed{v(t) = v_0 - g\cdot t}
```

- Equação de Torricelli
```math
\boxed{v_f^2 = v_0^2 - 2\cdot g \cdot \Delta h}
```
"""

# ╔═╡ bd6bf361-6160-495e-ae4f-a4bb9e508675
md"""
Escolha a altura inicial (``h_0``) em m:
$(@bind h₀ PlutoUI.NumberField(1:200, default = 100))

Escolha a velocidade inicial (``v_0``) em m/s:
$(@bind v₀ PlutoUI.NumberField(-30:1:30, default = 10))
"""

# ╔═╡ d7ebb465-4de4-4e66-89e9-9638d7e2a3f1
md"""
Em qualquer tipo de MRUV, o vértice da parábola no gráfico de ``s(t)`` ocorre no instante quando a velocidade do objeto é zero, ou seja, quando ocorre a mudança no sentido do movimento: 

```math
v_0 + a\cdot t = 0 \Rightarrow \boxed{t_{\rm vert.} = \frac{-v_0}{a}}
```

No caso da queda-livre, esse ponto representa o ponto mais alto da trajetória do objeto:

```math
\boxed{t_{\rm max} = \frac{-v_0}{g}}.
```
Substituindo esse valor de ``t`` na equação de ``h(t)``, conseguimos encontrar a altura máxima atingida pelo objeto.

```math
\boxed{h_{\rm max} = h_0 - \frac{v_0^2}{2g}.}
```

Para encontrar o instante em que o objeto atinge o chão ``h=0``, devemos escrever:

```math
h_0 + v_0 \cdot t - \frac{g\cdot t^2}{2} = 0,
```
para, então, encontrar as raízes dessa equação.
"""

# ╔═╡ 7ebba4f4-c827-456f-a16a-7725ca3f4161
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
			
	
	fmt(x) = replace(string(x), "." => "{,}")
end;

# ╔═╡ d090726c-9d83-4d95-b392-e9d23b0c5e46
begin
	g = -9.81
	h(t) = h₀ + Δs(t, v₀, g)
	v(t) = vel(t, v₀, g)
	hrange = LinRange(0, h₀, 5)
end;

# ╔═╡ d2594ac7-64ca-48e2-b9ef-5675c4a69433
begin
	ts = baskara(g/2, v₀, h₀)
	tqueda = Float64[]
	for t ∈ ts
		(t > 0) && push!(tqueda, t)
	end
	vrange = round.(
		LinRange(minimum([v₀, v(tqueda[1])]), maximum([v₀, v(tqueda[1])]), 4),
		digits = 1)
end;

# ╔═╡ 8b12dcf5-a1e8-407c-bd67-1704565d4550
begin
	framerate = 15
	nframes = round(Int, tqueda[1]) * framerate + 15
	δt = 1/framerate
end;

# ╔═╡ 21e1d83d-4c7c-40c5-8e54-5c60a0992c49
begin
	ht = Node(Float64[h₀])
	vt = Node(Float64[v₀])
	t_ani = Node([zero(Float64)])
	
	animation = Figure(resolution = (800, 900))
	ax01 = Axis(animation[1:2, 1],
		title = "Trajetória",
		ylabel = "Altura (m)",
		yticks = unique(vcat(hrange, [round(h(-v₀/g), digits = 0)])))
	
	limits!(ax01, -1, 1, -10, h(-v₀/g) + 10)
	hidexdecorations!(ax01)
	hidespines!(ax01, :b, :t)
	
	ax02 = Axis(animation[1, 2],
		title = "Altura x tempo",
		xlabel = "Tempo (s)",
		xticks = unique([0, -v₀/g, tqueda[1]]),
		xtickformat = xs -> [replace(
				string(
					round(x, digits = 2)
					), "." => ",")
			for x ∈ xs],
		xticklabelsize = 14,
		ylabel = "Altura (m)",
		yticks = unique(vcat(hrange, [round(h(-v₀/g), digits = 0)])),
		yticklabelsize = 14)
	
	limits!(ax02, 0, tqueda[1] + 1, 0, h(-v₀/g) + 10)
	hidespines!(ax02, :t, :r)
	
	ax03 = Axis(animation[2, 2],
		title = "Velocidade x tempo",
		xlabel = "Tempo (s)",
		xticks = unique([0, -v₀/g, tqueda[1]]),
		xtickformat = xs -> [replace(
				string(
					round(x, digits = 2)
					), "." => ",")
			for x ∈ xs],
		xticklabelsize = 14,
		ylabel = "Velocidade (m/s)",
		yticks = unique(vcat(vrange, [0])),
		ytickformat = ys -> [replace(string(y), "." => ",") for y ∈ ys],
		yticklabelsize = 14)
	
	limits!(ax03, 0, tqueda[1] + 1, minimum([v₀, v(tqueda[1]), 0]) - 5, maximum([v₀, v(tqueda[1]), 0]) + 5)
	hidespines!(ax03, :t, :r, :b)
	
	Label(animation[0, :], "Queda-livre", textsize = 25)
	
	hlines!(ax01, [0], linewidth = 5, color = :lightgreen)
	scatter!(ax01, @lift([Point2(0, h₀), Point2(0, $ht[end])]),
		color = [(:forestgreen, 0.5), (:forestgreen, 1)],
		markersize = 14)
	lines!(ax01, @lift(zeros(length($ht))), ht,
		linestyle = :dash,
		linewidth = 2,
		color = (:forestgreen, 0.7))
	
	scatter!(ax02, @lift(Point2($t_ani[end], $ht[end])),
		color = :forestgreen,
		markersize = 14)
	lines!(ax02, t_ani, ht,
		linestyle = :dashdot,
		linewidth = 3,
		color = :forestgreen)
	
	hlines!(ax03, [0], linewidth = 1, color = :black)
	scatter!(ax03, @lift(Point2($t_ani[end], $vt[end])),
		color = :dodgerblue,
		markersize = 14)
	lines!(ax03, t_ani, vt,
		linestyle = :dashdot,
		linewidth = 3,
		color = :deepskyblue)
	
	CairoMakie.Makie.Record(animation, 1:nframes; framerate = framerate) do i
		t_ani.val = push!(t_ani[], t_ani[][end] + δt)
		htemp = h(t_ani[][end])
		ht[] = (htemp > 0 ? push!(ht[], htemp) : push!(ht[], zero(Float64)))
		vt[] = (htemp > 0 ? push!(vt[], v(t_ani[][end])) : push!(vt[], zero(Float64)))
	end
	
end

# ╔═╡ Cell order:
# ╟─36c11930-041d-11ec-182c-398b86019057
# ╟─6e602140-ebb6-4e52-9599-4b32b6bdb413
# ╟─8abb7c3d-54c7-4aaa-adba-491734efffb0
# ╟─bd6bf361-6160-495e-ae4f-a4bb9e508675
# ╟─d090726c-9d83-4d95-b392-e9d23b0c5e46
# ╟─d2594ac7-64ca-48e2-b9ef-5675c4a69433
# ╟─8b12dcf5-a1e8-407c-bd67-1704565d4550
# ╟─21e1d83d-4c7c-40c5-8e54-5c60a0992c49
# ╟─d7ebb465-4de4-4e66-89e9-9638d7e2a3f1
# ╟─7ebba4f4-c827-456f-a16a-7725ca3f4161
