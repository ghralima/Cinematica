### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 4c5bb4f0-e5b2-11eb-04e9-17605f119958
begin
	using Pkg
	Pkg.activate(".")
end

# ╔═╡ cc6907d7-bdae-443d-888c-7e9bc2b28bf2
begin
	using PlutoUI
	using CairoMakie
	using LaTeXStrings
	using HypertextLiteral
	using Unitful, Latexify, UnitfulLatexify
end

# ╔═╡ 54cd73b6-6efa-4f4b-8e04-7546e27f566f
TableOfContents(title = "Índice", depth = 4)

# ╔═╡ a0effa1f-dbfe-46a9-a208-fcba21c46f32
md"""
!!! warning "Alerta!"

	Até este momento cadernos Pluto não atualizam automaticamente blocos de código contendo apenas o comando *latexify*. Ao gerar valores aleatórios, tenha em mente que é preciso reexecutar todos os blocos que contenham o comando citado acima.

"""

# ╔═╡ 682033dd-cc9f-4f3b-85a6-3cea875e4bd4
md"""
## 1.5. Movimento retilíneo uniforme (MRU)

### 1.5.5. Exemplos e aplicações
"""

# ╔═╡ dc8a676b-ae61-46e9-bb20-be2d3af19f99
begin
	v1 = rand(-20:5:20)
	v2 = rand(-20:5:20)
	s01 = rand(-100:10:100)
	s02 = rand(-100:10:100)
	
	ss1d(t, s0, v) = s0 + v*t
	t = [0, 12, 36]
	
	st1 = ss1d.(t, s01, v1)
	st2 = ss1d.(t, s02, v2)
	
	tcross = (s02 - s01)/(v1 - v2)
	scross = ss1d(tcross, s01, v1)
end;

# ╔═╡ 4a8da892-33d3-4e4e-8a53-737ff1aa5a1b
latexify(:(Δs_1 = $(st1[3]*1u"m") - $(st1[2]*1u"m") = $((st1[3] - st1[2])*1u"m")))

# ╔═╡ eec524d8-54f3-4b50-af57-36a9acf92037
md"e"

# ╔═╡ e76de3d4-cac4-4d04-8d0a-4bd5c024ebd4
md"""
A velocidade da pessoa 1 é:
"""

# ╔═╡ 664cfedf-b596-412d-a733-ac909648acf9
begin
	fig_01 = Figure(resolution = (800, 800), backgroundcolor = :Gray80)
	ax1_01 = fig_01[1, 1] = Axis(fig_01,
		title = "Posição x tempo",
		xlabel = "Tempo (s)",
		xticks = 0:12:36,
		xgridcolor = (:black, 0.36),
		ylabel = "Posição no eixo x (m)",
		yticks = [st1[2], st2[2], 0, st1[3], st2[3]],
		ygridcolor = (:black, 0.36))
	
	lines!(ax1_01, t, st1, linewidth = 2, label = "Pessoa 1")
	lines!(ax1_01, t, st2, linewidth = 2, label = "Pessoa 2")
	hlines!(ax1_01, [0], linewidth = 2, color = :black)
	
	scatter!(ax1_01, [Point2(tcross, scross)], color = (:red, 0.6), 
		markersize = 15)
	
	axislegend(ax1_01, position = :lt)
	
	limits!(ax1_01, 0, 36, minimum(vcat(st1, st2)) - 100, 
		maximum(vcat(st1, st2)) + 100)
	hidespines!(ax1_01, :b, :t, :r)
	
	fig_01
end

# ╔═╡ f41e12d4-9c9e-4816-a369-1fbf01614a4d
latexify(:(Δs_2 = $(st2[3]*1u"m") - $(st2[2]*1u"m") = $((st2[3] - st2[2])*1u"m")))

# ╔═╡ 8483b04e-6e38-4b67-b6ee-0c15fd09f5a3
md"""
e sua velocidade é:
"""

# ╔═╡ 879cd476-119d-4b74-8bb8-1675816b2275
latexify(:(s_01 + $(v1*t[2]*1u"m") = $(st1[2]*1u"m")))

# ╔═╡ b0b32b38-07b8-49a2-bdb4-e863f6804738
latexify(:(s_01 = $(st1[2]*1u"m") - $(v1*t[2]*1u"m") = $((st1[2] - v1*t[2])*1u"m")))

# ╔═╡ 92b63049-c840-46e1-b6e8-6275c9274e92
md"""
Encontramos a posição inicial da pessoa 2 utilizando o mesmo método, mas podemos usar a posição quando ``t = `` $(t[3]) s:
"""

# ╔═╡ c1616e0d-c6f3-4117-8cc9-663158536c0b
latexify(:(s_02 + $(v2*t[3]*1u"m") = $(st2[3]*1u"m")))

# ╔═╡ 4aa6ed59-5bab-4f15-9a94-056fbd05a3d0
latexify(:(s_02 = $(st2[3]*1u"m") - $(v2*t[3]*1u"m") = $((st2[3] - v2*t[3])*1u"m")))

# ╔═╡ b6401838-d8ef-4f20-a0ab-1a35cddf6e0c
md"""
##### Encontrando as equações de posição

Para encontrar as equações de posição para as pessoas 1 e 2, substituímos as posições iniciais e as velocidades de cada pessoa nas respectivas equações ``s(t) = s_0 + vt`` :

- Pessoa 1: 
"""

# ╔═╡ 3b095a69-baba-4a42-b903-54fccc48e1ce
begin
	s01u = s01*1u"m"
	v1u = v1*1u"m/s"
	latexify(:(s₁(t) = $s01u + $v1u * t))
end

# ╔═╡ 0efb6bb1-eab7-46a1-a4eb-c189f36112f6
md"""
- Pessoa 2:
"""

# ╔═╡ 0779bd76-265a-47ef-9963-b7c20b3ca057
begin
	s02u = s02*1u"m"
	v2u = v2 * 1u"m/s"
	latexify(:(s₂(t) = $s02u + $v2u * t))
end

# ╔═╡ 66195ec5-9be3-4279-8973-60ed7489bb59
md"""
##### O instante e a posição do encontro

O ponto onde as retas se cruzam no gráfico mostra o instante de tempo e a posição nas quais ambas as pessoas se encontram (o instante de tempo quando ambas as pessoas estão na mesma posição). Para encontrar esse ponto, devemos igualar as equações de ``s_1(t)``  e ``s_2(t)``:
"""

# ╔═╡ 10aae929-b4d1-4199-9f74-2f283701336c
latexify(:($s01u + $v1u * t = $s02u + $v2u * t))

# ╔═╡ c4d22cdf-f444-4e65-80b9-90a298c8fa0c
md"""
Resolvendo a equação, encontramos o instante de tempo ``t`` quando ambos estão na mesma posição:
"""

# ╔═╡ e475f3e8-5b0b-4645-86eb-7e051c690f2a
latexify(:(($v1u - $v2u) * t = $s02u - $s01u))

# ╔═╡ 51f25e9f-4f38-40fa-bf85-6e8b43759829
latexify(:($(v1u - v2u) * t = $(s02u - s01u)))

# ╔═╡ d682d579-cb68-4ce9-86da-d636bd470222
latexify(:(t = $(s02u - s01u)/$(v1u -v2u) = $((s02u-s01u)/(v1u - v2u))))

# ╔═╡ 759367f6-efcf-49bb-82a6-8846c83cd08e
begin
	tcrossu = tcross*1u"s"
	latexify(:(s₁(t) = $s01u + $v1u * $tcrossu = $(s01u + v1u*tcrossu)))
end

# ╔═╡ 91ca96f4-38bf-4e45-a928-c503fadd10d7
md"""
#### Exemplo 2

A animação abaixo mostra o movimento de um objeto ao longo de uma trajetória retilínea, e o gráfico abaixo mostra como sua posição está variando com o tempo.
"""

# ╔═╡ 9181ea12-b7b6-44d1-8703-4cfad2133809
begin
	npos = 5
	framerate = 20
	spos = rand(-200:200, npos)
	Δts = rand(5:20, npos-1)
	
	xpos = [Float64(spos[1])]
	for i ∈ 1:length(Δts)
		pp = range(spos[i], spos[i+1], length = Δts[i]*framerate+1)
		append!(xpos, pp[2:end])
	end
	append!(xpos, fill(xpos[end], 2*framerate))
	
	ts = [sum(Δts[1:i]) for i ∈ 1:length(Δts)]
	sframes = ts .* framerate
end

# ╔═╡ 4f2cd1a6-1e3f-45a1-8455-8572a97b0f77
begin
	trnode = Node([xpos[1]])
	spontos = Node([Point2f0(0, xpos[1])])
	lnpts = Node([Point2f0(0, xpos[1])])
		
	ani_01 = Figure(resolution = (800, 800))
	ax2_01 = ani_01[1, 1] = Axis(ani_01,
		xlabel = "Posição (m)",
		xticks = vcat([0], spos),
		title = "Movimento em 1D")
	
	trlength = @lift(length($trnode))
	tamanho = @lift(12:-0.5:12.5-($trlength)/2)
	cor = @lift([(:dodgerblue, (1.05 - i/20)) for i ∈ 1:$trlength])
	
	scatter!(ax2_01, trnode, 
		@lift(zeros(Float64, length($trnode))), 
		markersize = tamanho, 
		color = cor)
		
	limits!(ax2_01, minimum(xpos)-10, maximum(xpos)+10, -10, 10)
	hideydecorations!(ax2_01)
			
	ax2_02 = ani_01[2, 1] = Axis(ani_01,
		xlabel = "Tempo (s)",
		xticks = sframes ./ framerate,
		ylabel = "Posição (m)",
		yticks = vcat(spos, [0]),
		title = "Posição x tempo")
	
	scatterlines!(ax2_02, lnpts, 
		color = :dodgerblue,
		marker = :circle,
		markersize = 12,
		markercolor = :dodgerblue)
	
		
	#scatter!(ax2_02, spontos, marker = :rect, color = :red)
	
	limits!(ax2_02, 0, sum(Δts)+2, minimum(xpos)-10, maximum(xpos)+10)
	
	CairoMakie.Makie.Record(ani_01, 1:length(xpos)-1; framerate = framerate) do i
	#record(ani_01, "MRU_trajetoria_posicao_tempo.gif", 1:length(xpos)-1; framerate = framerate) do i
		
		(i ∈ sframes) && (spontos[] = 
			push!(spontos[], Point2f0(i/framerate, xpos[i+1])))
			
		lnpts[] = vcat(spontos[], [Point2f0(i/framerate, xpos[i+1])])
				
		trnode[] = (i <= 20 ? xpos[i+1:-1:1] : xpos[i+1:-1:i-19])		
	end
end

# ╔═╡ 05b24047-84df-451f-b36e-4f3d7f27d784
md"""
Para montar o gráfico de velocidade em função do tempo para o objeto da animação acima, temos que calcular a inclinação dos 4 segmentos de reta que representam a posição em função do tempo.

- No primeiro intervalo de 0 a $(ts[1]) s, o objeto parte da posição $(spos[1]) m e chega na posição $(spos[2]) m:
"""

# ╔═╡ dfa37507-d46c-4d75-a09e-8322af14e8d1
md"
-  No intervalo de $(ts[1]) s ``\leq t < `` $(ts[2]) s, o objeto parte da posição $(spos[2]) m e chega à posição $(spos[3]) m:
"

# ╔═╡ fdad3936-f35e-4237-bf9a-acc7a6665e33
md"
-  No intervalo de $(ts[2]) s ``\leq t < `` $(ts[3]) s, o objeto parte da posição $(spos[3]) m e chega à posição $(spos[4]) m:
"

# ╔═╡ bfa7f6ba-f40d-41a3-b768-e85cfe2fa913
md"
-  E, finalmente, no intervalo de $(ts[3]) s ``\leq t < `` $(ts[4]) s, o objeto parte da posição $(spos[4]) m e chega à posição $(spos[5]) m:
"

# ╔═╡ 281f43cb-8c8e-4b58-8cd2-551f47c5a58a
md"""
Após $(ts[4]) s, o objeto permanece nas mesma posição, portanto sua velocidade é zero!

>Todos os resultados acima foram arredondados de modo a possuirem apenas 2 algarismos significativos.

Usando as velocidades encontradas, conseguimos criar o gráfico de velocidade x tempo abaixo.
"""

# ╔═╡ 33407f18-dbc6-4a65-9407-25377c39c2e3
md"""
#### Exemplo 3

O gráfico a seguir mostra como a velocidade de um objeto varia com o tempo.
"""

# ╔═╡ 3f4cea99-c6aa-478f-a0df-1e2a9334c8cc
vel_rand = rand(-20:2:20, 4);

# ╔═╡ 08af2b5b-9c69-4dce-9537-a9ac6361c7c5
begin
	push!(vel_rand, 0)
	t_velxpos = [0]
	for i ∈ 1:length(vel_rand)-1
		push!(t_velxpos, t_velxpos[i] + rand(10:30))
	end
end

# ╔═╡ 45eb64d3-a7a6-417c-ac38-c25b84d64725
begin
	fig_02 = Figure(resolution = (800, 800))
	ax_02 = fig_02[1, 1] = Axis(fig_02,
		title = "Velocidade em função do tempo",
		titlesize = 20,
		xlabel = "Tempo (s)",
		xticks = t_velxpos,
		xlabelsize = 20,
		ylabel = "Velocidade (m/s)",
		yticks = unique(vel_rand),
		ylabelsize = 20)
	
	for i ∈ 1:length(t_velxpos)-1
		lines!(ax_02, [t_velxpos[i+1], t_velxpos[i+1]], vel_rand[i:i+1],
			linewidth = 2,
			color = (:red, 0.5),
			linestyle = :dash)
		scatterlines!(ax_02, t_velxpos[i:i+1], [vel_rand[i], vel_rand[i]],
			linewidth = 2,
			color = :red,
			markercolor = [(:red, 1), (:white, 1)],
			strokecolor = (:red, 1),
			strokewidth = 2)
	end
	
	hlines!(ax_02, [0], color = :black)
	
	limits!(ax_02, 0, t_velxpos[end], minimum(vel_rand)-5, maximum(vel_rand)+5)
	
	fig_02
end

# ╔═╡ 29db40ad-0b83-4235-ad47-3e4e7de68266
md"""
O gráfico mostra que a velocidade do objeto permanece constante durante um certo tempo, então ele muda sua velocidade e a mantém constante por algum tempo, antes de mudá-la novamente.

Usando o gráfico acima podemos encontrar o deslocamento total e a distância total percorrida pelo objeto. Para isso devemos lembrar que a área sob a reta que representa a velocidade e o eixo do tempo é igual ao deslocamento do objeto. Vamos calcular a área para cada um dos 4 intervalos mostrados no gráfico:

- intervalo: $(t_velxpos[1]) s ``\leq t <`` $(t_velxpos[2]) s ``\rightarrow v_1 = `` $(vel_rand[1]) m/s

"""

# ╔═╡ 2ba79d66-f5d1-478a-b559-579ad679b5f8
begin
	Δs1_3 = vel_rand[1] * (t_velxpos[2] - t_velxpos[1]) * 1u"m"
	latexify(:(Δs_1 = v_1 * Δt_1 = $(vel_rand[1] * 1u"m/s") * ($(t_velxpos[2]*1u"s") - $(t_velxpos[1]*1u"s")) = $Δs1_3))
end

# ╔═╡ b9e6facb-483d-41b4-af2d-58b55b30b9ea
md"
- intervalo: $(t_velxpos[2]) s ``\leq t <`` $(t_velxpos[3]) s ``\rightarrow v_2 = `` $(vel_rand[2]) m/s
"

# ╔═╡ 5caef9c2-8ebd-4b8f-be7d-afbfcba0f859
begin
	Δs2_3 = vel_rand[2] * (t_velxpos[3] - t_velxpos[2]) * 1u"m"
	latexify(:(Δs_2 = v_2 * Δt_2 = $(vel_rand[2] * 1u"m/s") * ($(t_velxpos[3]*1u"s") - $(t_velxpos[2]*1u"s")) = $Δs2_3))
end

# ╔═╡ bd6e252c-4624-4ed1-a8ab-f488c78897c4
md"
- intervalo: $(t_velxpos[3]) s ``\leq t <`` $(t_velxpos[4]) s ``\rightarrow v_3 = `` $(vel_rand[3]) m/s
"

# ╔═╡ 962a9f1f-ef5e-4439-a338-f927690a7670
begin
	Δs3_3 = vel_rand[3] * (t_velxpos[4] - t_velxpos[3]) * 1u"m"
	latexify(:(Δs_3 = v_3 * Δt_3 = $(vel_rand[3] * 1u"m/s") * ($(t_velxpos[4]*1u"s") - $(t_velxpos[3]*1u"s")) = $Δs3_3))
end

# ╔═╡ 54143db8-8b5d-4b34-8e99-56bd3e13d6b0
md"
- intervalo: $(t_velxpos[4]) s ``\leq t <`` $(t_velxpos[5]) s ``\rightarrow v_4 = `` $(vel_rand[4]) m/s
"

# ╔═╡ e0563344-260b-4111-b630-7597c575eee3
begin
	Δs4_3 = vel_rand[4] * (t_velxpos[5] - t_velxpos[4]) * 1u"m"
	latexify(:(Δs_4 = v_4 * Δt_4 = $(vel_rand[4] * 1u"m/s") * ($(t_velxpos[5]*1u"s") - $(t_velxpos[4]*1u"s")) = $Δs4_3))
end

# ╔═╡ fb1eb39d-7888-41bf-bfc8-ec137484f245
md"""
##### Deslocamento total (``\Delta s``)

O deslocamento total no intervalo de tempo de 0 a $(t_velxpos[5]) s é igual à soma de todos os deslocamentos ocorridos neste intervalo:
"""

# ╔═╡ 2a1e746a-8673-496f-a083-ffea9cdbff5b
begin
	Δs3 = [Δs1_3, Δs2_3, Δs3_3, Δs4_3]
	Δst3 = sum(Δs3)
	latexify(:(Δs = $Δs1_3 +  $Δs2_3 + $Δs3_3 + $Δs4_3 = $Δst3))
end	

# ╔═╡ 96cb3f5e-eff7-443e-879a-efcb3cbc8a68
md"""
##### Distância total percorrida (``D``)

Como distâncias tem sempre valores positivos, para encontrar a distância total percorrida somamos todos os valores absolutos dos deslocamentos:
"""

# ╔═╡ afd15bed-dac9-4660-8c54-0a89d1f85cba
begin
	Dt3 = sum(abs.(Δs3))
	latexify(:(D = $(abs(Δs1_3)) +  $(abs(Δs2_3)) + $(abs(Δs3_3)) + $(abs(Δs4_3)) = $Dt3))
end

# ╔═╡ 939ae661-4371-4410-adbf-68b121834fae
md"""
##### Gráfico de deslocamento em função do tempo

O deslocamento no instante ``t = 0`` é sempre zero - o objeto ainda está em sua posição inicial neste instante. No instante ``t = `` $(t_velxpos[2])s o objeto já se deslocou ``\Delta s =`` $(Δs1_3). 

No segundo intervalo o objeto se desloca ``\Delta s_{2} = `` $(Δs2_3), de modo que ao final deste intervalo o deslocamento total do objeto é
"""

# ╔═╡ da6a470a-5064-4d89-a577-22163c03a621
latexify(:(Δs_t2 = $Δs1_3 + $Δs2_3 = $(Δs1_3 + Δs2_3)))

# ╔═╡ 3b29a1a9-ac73-425b-a9fa-0741e254742c
md"""
No terceiro intervalo o objeto se desloca ``Δs_3 = `` $Δs3_3, e ao final deste intervalo o deslocamento total já é:
"""

# ╔═╡ 0e388895-47c8-4a81-8f7a-69b94aeddb8b
latexify(:(Δs_t3 = $Δs1_3 + $Δs2_3 + $Δs3_3 = $(Δs1_3 + Δs2_3 + Δs3_3)))

# ╔═╡ 710bb9ab-5f24-4190-800d-05509253e837
md"""
No último intervalo o objeto se desloca ``Δs_4 = `` $Δs4_3, e atinge sua posição final, se deslocando um total de
"""

# ╔═╡ 977366d1-67af-4784-8794-71ffd3483a2c
latexify(:(Δs = $Δs1_3 +  $Δs2_3 + $Δs3_3 + $Δs4_3 = $Δst3))

# ╔═╡ b80f272b-1239-4a4e-89f4-920b2e2b2999
md"""
O gráfico do deslocamento em função do tempo será, então:
"""

# ╔═╡ ce323bf3-0098-4ff1-9474-adfd04d1b495
begin
	Δs3_parcial = [0.0]
	for i ∈ 1:length(Δs3)
		Δsi = Δs3_parcial[i] + ustrip(Δs3[i])
		push!(Δs3_parcial, Δsi)
	end
end

# ╔═╡ 1879f3f3-b69e-4445-a944-4b285d0f0414
begin
	fig4 = Figure(resolution = (800, 800))
	ax4 = fig4[1, 1] = Axis(fig4, 
		title = "Deslocamento x tempo",
		xlabel = "tempo (s)",
		xticks = t_velxpos,
		ylabel = "deslocamento (m)",
		yticks = Δs3_parcial)
	
	hlines!(ax4, [0], color = :black)
	
	for i ∈ 1:length(Δs3_parcial)-1
		scatterlines!(ax4, [t_velxpos[i], t_velxpos[i+1]],
			[Δs3_parcial[i], Δs3_parcial[i+1]],
			linewidth = 2,	
			color = :dodgerblue,
			markercolor = :dodgerblue)
	end
	
	limits!(ax4, 0, t_velxpos[end], minimum(Δs3_parcial)-10, maximum(Δs3_parcial)+10)
	fig4
end

# ╔═╡ a4a70dab-9656-40f4-840d-45fabd3a5e76
md"""
##### Velocidade média

Podemos calcular a velocidade média do objeto durante todo o intervalo:
"""

# ╔═╡ 649af3e2-45a0-4d22-91b6-adf7171b5655
md"""
##### Rapidez média

Para calcular a rapidez média utilizamos a distância total percorrida, então durante todo o intervalo mostrado no gráfico acima:
"""

# ╔═╡ 32897342-1d53-41cc-83cc-05cdc02dc64f
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
	
	fmt(x) = replace(string(x), "." => "{,}")
end

# ╔═╡ 2a91a520-c3f8-4758-9c49-835fa9c66f41
md"""
#### Exemplo 1

O gráfico abaixo mostra como a posição de duas pessoas está mudando a medida que o tempo passa. Como encontramos as equações que descrevem a posição dessas pessoas em função do tempo?

No gráfico abaixo temos duas retas representando como a posição das duas pessoas muda com o tempo. As equações que descrevem essas retas são do tipo:

```math
s(t) = s_0 + v \cdot t.
```

##### Encontrando as velocidades
O gráfico não nos indica quais são as posições iniciais de cada pessoa. Uma das maneiras de descobrir essas posições iniciais é calculando inicialmente as velocidades de cada uma das pessoas. A velocidade é a inclinação (ou coeficiente angular) de cada uma das retas. A velocidade pode ser encontrada a partir da relação:

```math
v = \frac{\Delta s}{\Delta t}.
```

Para calcular as velocidades, precisamos da posição de cada pessoa em dois instantes diferentes. O gráfico nos mostra que a pessoa 1 está em

- ``s_1 = `` $(trocarpontovirgtexto(st1[2], digits = 0)) m em ``t=`` $(trocarpontovirgtexto(t[2], digits = 0)) s;
- ``s_1 = `` $(trocarpontovirgtexto(st1[3], digits = 0)) m em ``t=`` $(trocarpontovirgtexto(t[3], digits = 0)) s.

O deslocamento da pessoa 1 entre $(trocarpontovirgtexto(t[2], digits = 0)) s e $(trocarpontovirgtexto(t[3], digits = 0)) s foi:
"""

# ╔═╡ 61fb3db2-cfda-437e-9131-2f155b32c349
latexstring("\\Delta t =  $(trocarpontovirglatex(t[3], digits = 0)){\\rm \\, s} - $(trocarpontovirglatex(t[2], digits = 0)){\\rm \\, s} = $(trocarpontovirglatex(t[3] - t[2], digits = 0)){\\rm \\, s}.")

# ╔═╡ a6bb7032-69fb-46cf-a927-38f7dd2b3071
latexstring("v_1 = \\frac{\\Delta s_1}{\\Delta t} = \\frac{$(trocarpontovirglatex(st1[3]-st1[2], digits = 0)){\\rm \\, m}}{$(trocarpontovirglatex(t[3] - t[2], digits = 0)){\\rm \\, s}} = $(trocarpontovirglatex((st1[3]-st1[2])/(t[3]-t[2]), digits = 0)){\\rm \\, \\frac{m}{s}}.")

# ╔═╡ 95670b4d-783a-41d7-9f7b-adbe7d1a3b7f
md"""
O gráfico também nos mostra que a pessoa 2 está em:

- ``s_2 = `` $(trocarpontovirgtexto(st2[2], digits = 0)) m em ``t=`` $(trocarpontovirgtexto(t[2], digits = 0)) s;
- ``s_2 = `` $(trocarpontovirgtexto(st2[3], digits = 0)) m em ``t=`` $(trocarpontovirgtexto(t[3], digits = 0)) s.

O deslocamento da pessoa 2 entre $(trocarpontovirgtexto(t[2], digits = 0)) s e $(trocarpontovirgtexto(t[3], digits = 0)) s foi:
"""

# ╔═╡ 920eb8ae-debb-4503-a0c1-abef1dd92f15
latexstring("v_2 = \\frac{\\Delta s_2}{\\Delta t} = \\frac{$(trocarpontovirglatex(st2[3]-st2[2], digits = 0)){\\rm \\, m}}{$(trocarpontovirglatex(t[3] - t[2], digits = 0)){\\rm \\, s}} = $(trocarpontovirglatex((st2[3]-st2[2])/(t[3]-t[2]), digits = 0)){\\rm \\, \\frac{m}{s}}.")

# ╔═╡ 60334399-0b9f-491a-848e-1880447b4d99
md"""
##### Encontrando as posições iniciais
Conhecendo a velocidade e uma posição de cada pessoa, conseguimos determinar as posições iniciais. Vamos utilizar a posição da pessoa 1 no instante ``t = `` $(trocarpontovirgtexto(t[2], digits = 0)) s:
"""

# ╔═╡ 2ae064e9-4367-487e-969e-9d74daec4103
latexstring("s_1($(trocarpontovirgtexto(t[2], digits = 0)){\\rm \\, s}) = s_{01} + \\left($(trocarpontovirglatex(v1, digits = 0)){\\rm \\, \\frac{m}{s}}\\right) \\cdot $(trocarpontovirgtexto(t[2], digits = 0)){\\rm \\, s} = $(trocarpontovirglatex(st1[2], digits = 0)){\\rm \\, m}")

# ╔═╡ b9d9b798-4578-4b3d-b647-7abd376a96ca
latexstring("s_2($(trocarpontovirgtexto(t[3], digits = 0)){\\rm \\, s}) = s_{02} + \\left($(trocarpontovirglatex(v2, digits = 0)){\\rm \\, \\frac{m}{s}}\\right) \\cdot $(trocarpontovirgtexto(t[3], digits = 0)){\\rm \\, s} = $(trocarpontovirglatex(st2[3], digits = 0)){\\rm \\, m}")

# ╔═╡ 511e5eaa-ffec-4a0e-9254-00fda6d5cb81
md"""
As duas pessoas se encontram no instante ``t = `` $(trocarpontovirgtexto(tcross)) s. Se substituirmos esse ``t`` em qualquer uma das equações de posição encontramos a posição em que as pessoas se encontram:
"""

# ╔═╡ 4e97b246-af26-4c42-a0a1-63c0f95ae7fd
begin
	Δs1u_2 = (spos[2] - spos[1])*1u"m"
	Δt1u_2 = ts[1]*1u"s"
	v1u_2 = round(typeof(1u"m/s"), Δs1u_2/Δt1u_2, sigdigits = 2)
latexify(:(v_1 = Δs_1/Δt_1 = ($(spos[2]*1u"m") - $(spos[1]*1u"m"))/($(ts[1]*1u"s") - 0) = $(v1u_2)), fmt = fmt)
end

# ╔═╡ 9f4ed5c2-ddc9-4653-ab43-6409c9b5a1b7
begin
	Δs2u_2 = (spos[3] - spos[2])*1u"m"
	Δt2u_2 = Δts[2]*1u"s"
	v2u_2 = round(typeof(1u"m/s"), Δs2u_2/Δt2u_2, sigdigits = 2)
	latexify(:(v_2 = Δs_2/Δt_2 = ($(spos[3]*1u"m") - $(spos[2]*1u"m"))/($(ts[2]*1u"s") - $(ts[1]*1u"s")) = $(v2u_2)), fmt = fmt)
end

# ╔═╡ 666af31b-75cd-4186-a574-09e520e7f53a
begin
	Δs3u_2 = (spos[4] - spos[3])*1u"m"
	Δt3u_2 = Δts[3]*1u"s"
	v3u_2 = round(typeof(1.0u"m/s"), Δs3u_2/Δt3u_2, sigdigits = 2)
	latexify(:(v_3 = Δs_3/Δt_3 = ($(spos[4]*1u"m") - $(spos[3]*1u"m"))/($(ts[3]*1u"s") - $(ts[2]*1u"s")) = $(v3u_2)), fmt = fmt)
end

# ╔═╡ 23c30c10-e943-4e8b-8edb-b5bae9d8bbd5
begin
	Δs4u_2 = (spos[5] - spos[4])*1u"m"
	Δt4u_2 = Δts[4]*1u"s"
	v4u_2 = round(typeof(1u"m/s"), Δs4u_2/Δt4u_2, sigdigits = 2)
	latexify(:(v_4 = Δs_4/Δt_4 = ($(spos[5]*1u"m") - $(spos[4]*1u"m"))/($(ts[4]*1u"s") - $(ts[3]*1u"s")) = $(v4u_2)), fmt = fmt)
end

# ╔═╡ 1cb88b43-8dbb-4079-81d8-f7d80359f73d
begin
	vs_2 = ustrip.([v1u_2, v2u_2, v3u_2, v4u_2])
	
	fig3 = Figure(resolution = (800, 800))
	ax03 = fig3[1, 1] = Axis(fig3, 
		title = "Velocidade x tempo",
		xlabel = "tempo (s)",
		xticks = ts,
		ylabel = "velocidade (m/s)",
		yticks = unique(vcat(vs_2, [0])))
	
	hlines!(ax03, [0], color = :black)
	
	for i ∈ 1:length(vs_2)
		if i == 1
			scatterlines!(ax03, [0, ts[1]], [vs_2[1], vs_2[1]],
				color = :red,
				linewidth = 2,
				markercolor = [(:red, 1), (:white, 1)],
				strokecolor = (:red, 1),
				strokewidth = 2)
		else
			scatterlines!(ax03, [ts[i-1], ts[i]], [vs_2[i], vs_2[i]],
				color = :red,
				linewidth = 2,
				markercolor = [(:red, 1), (:white, 1)],
				strokecolor = (:red, 1),
				strokewidth = 2)
		end
	end
	scatterlines!(ax03, [ts[4], ts[4]+5], [0, 0],
		color = :red,
		linewidth = 2,
		markercolor = [(:red, 1), (:white, 1)],
		strokecolor = (:red, 1),
		strokewidth = 2)
	
	limits!(ax03, 0, ts[4]+2, minimum(vs_2) - 5, maximum(vs_2) + 5)
	
	fig3
end	

# ╔═╡ 6c053be0-6e2b-4611-9b4e-a04b570336a7
begin
	vmed3 = round(typeof(1.0u"m/s"), Δst3/(t_velxpos[5]*1u"s"), sigdigits = 2)
	latexify(:(v_med = Δs/Δt = $Δst3/$(t_velxpos[5]*1u"s") = $vmed3), fmt = fmt)
end

# ╔═╡ 045e8a2d-17b3-4503-8018-4803be977afd
begin
	rpmed3 = round(typeof(1.0u"m/s"), Dt3/(t_velxpos[5]*1u"s"), sigdigits = 2)
	latexify(:(rap_med = D/Δt = $Dt3/$(t_velxpos[5]*1u"s") = $rpmed3), fmt = fmt)
end

# ╔═╡ Cell order:
# ╟─4c5bb4f0-e5b2-11eb-04e9-17605f119958
# ╟─cc6907d7-bdae-443d-888c-7e9bc2b28bf2
# ╟─54cd73b6-6efa-4f4b-8e04-7546e27f566f
# ╟─a0effa1f-dbfe-46a9-a208-fcba21c46f32
# ╟─682033dd-cc9f-4f3b-85a6-3cea875e4bd4
# ╟─dc8a676b-ae61-46e9-bb20-be2d3af19f99
# ╟─2a91a520-c3f8-4758-9c49-835fa9c66f41
# ╟─4a8da892-33d3-4e4e-8a53-737ff1aa5a1b
# ╟─eec524d8-54f3-4b50-af57-36a9acf92037
# ╟─61fb3db2-cfda-437e-9131-2f155b32c349
# ╟─e76de3d4-cac4-4d04-8d0a-4bd5c024ebd4
# ╟─a6bb7032-69fb-46cf-a927-38f7dd2b3071
# ╟─664cfedf-b596-412d-a733-ac909648acf9
# ╟─95670b4d-783a-41d7-9f7b-adbe7d1a3b7f
# ╟─f41e12d4-9c9e-4816-a369-1fbf01614a4d
# ╟─8483b04e-6e38-4b67-b6ee-0c15fd09f5a3
# ╟─920eb8ae-debb-4503-a0c1-abef1dd92f15
# ╟─60334399-0b9f-491a-848e-1880447b4d99
# ╟─2ae064e9-4367-487e-969e-9d74daec4103
# ╟─879cd476-119d-4b74-8bb8-1675816b2275
# ╟─b0b32b38-07b8-49a2-bdb4-e863f6804738
# ╟─92b63049-c840-46e1-b6e8-6275c9274e92
# ╟─b9d9b798-4578-4b3d-b647-7abd376a96ca
# ╟─c1616e0d-c6f3-4117-8cc9-663158536c0b
# ╟─4aa6ed59-5bab-4f15-9a94-056fbd05a3d0
# ╟─b6401838-d8ef-4f20-a0ab-1a35cddf6e0c
# ╟─3b095a69-baba-4a42-b903-54fccc48e1ce
# ╟─0efb6bb1-eab7-46a1-a4eb-c189f36112f6
# ╟─0779bd76-265a-47ef-9963-b7c20b3ca057
# ╟─66195ec5-9be3-4279-8973-60ed7489bb59
# ╟─10aae929-b4d1-4199-9f74-2f283701336c
# ╟─c4d22cdf-f444-4e65-80b9-90a298c8fa0c
# ╟─e475f3e8-5b0b-4645-86eb-7e051c690f2a
# ╟─51f25e9f-4f38-40fa-bf85-6e8b43759829
# ╟─d682d579-cb68-4ce9-86da-d636bd470222
# ╟─511e5eaa-ffec-4a0e-9254-00fda6d5cb81
# ╟─759367f6-efcf-49bb-82a6-8846c83cd08e
# ╟─91ca96f4-38bf-4e45-a928-c503fadd10d7
# ╟─9181ea12-b7b6-44d1-8703-4cfad2133809
# ╟─4f2cd1a6-1e3f-45a1-8455-8572a97b0f77
# ╟─05b24047-84df-451f-b36e-4f3d7f27d784
# ╟─4e97b246-af26-4c42-a0a1-63c0f95ae7fd
# ╟─dfa37507-d46c-4d75-a09e-8322af14e8d1
# ╟─9f4ed5c2-ddc9-4653-ab43-6409c9b5a1b7
# ╟─fdad3936-f35e-4237-bf9a-acc7a6665e33
# ╟─666af31b-75cd-4186-a574-09e520e7f53a
# ╟─bfa7f6ba-f40d-41a3-b768-e85cfe2fa913
# ╟─23c30c10-e943-4e8b-8edb-b5bae9d8bbd5
# ╟─281f43cb-8c8e-4b58-8cd2-551f47c5a58a
# ╟─1cb88b43-8dbb-4079-81d8-f7d80359f73d
# ╟─33407f18-dbc6-4a65-9407-25377c39c2e3
# ╟─3f4cea99-c6aa-478f-a0df-1e2a9334c8cc
# ╟─08af2b5b-9c69-4dce-9537-a9ac6361c7c5
# ╟─45eb64d3-a7a6-417c-ac38-c25b84d64725
# ╟─29db40ad-0b83-4235-ad47-3e4e7de68266
# ╟─2ba79d66-f5d1-478a-b559-579ad679b5f8
# ╟─b9e6facb-483d-41b4-af2d-58b55b30b9ea
# ╟─5caef9c2-8ebd-4b8f-be7d-afbfcba0f859
# ╟─bd6e252c-4624-4ed1-a8ab-f488c78897c4
# ╟─962a9f1f-ef5e-4439-a338-f927690a7670
# ╟─54143db8-8b5d-4b34-8e99-56bd3e13d6b0
# ╟─e0563344-260b-4111-b630-7597c575eee3
# ╟─fb1eb39d-7888-41bf-bfc8-ec137484f245
# ╟─2a1e746a-8673-496f-a083-ffea9cdbff5b
# ╟─96cb3f5e-eff7-443e-879a-efcb3cbc8a68
# ╟─afd15bed-dac9-4660-8c54-0a89d1f85cba
# ╟─939ae661-4371-4410-adbf-68b121834fae
# ╟─da6a470a-5064-4d89-a577-22163c03a621
# ╟─3b29a1a9-ac73-425b-a9fa-0741e254742c
# ╟─0e388895-47c8-4a81-8f7a-69b94aeddb8b
# ╟─710bb9ab-5f24-4190-800d-05509253e837
# ╟─977366d1-67af-4784-8794-71ffd3483a2c
# ╟─b80f272b-1239-4a4e-89f4-920b2e2b2999
# ╟─ce323bf3-0098-4ff1-9474-adfd04d1b495
# ╟─1879f3f3-b69e-4445-a944-4b285d0f0414
# ╟─a4a70dab-9656-40f4-840d-45fabd3a5e76
# ╟─6c053be0-6e2b-4611-9b4e-a04b570336a7
# ╟─649af3e2-45a0-4d22-91b6-adf7171b5655
# ╟─045e8a2d-17b3-4503-8018-4803be977afd
# ╟─32897342-1d53-41cc-83cc-05cdc02dc64f
