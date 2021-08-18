using GLMakie

#definindo a posição em função do tempo, s(t)
function s(t, s0, v0, a)
    s0 + v0*t + 0.5*a*t*t
end

function v(t, v0, a)
    v0 + a*t
end

fig = Figure(resolution = (1800, 700))


ax_01 = Axis(fig[1, 1],
    title = "Posição x tempo",
    xlabel = "tempo (s)",
    xticks = 0:2:20,
    ylabel = "posição (m)",
    yticks = -500:100:500)

ax_02 = Axis(fig[1, 2],
    title = "Velocidade x tempo",
    xlabel = "tempo (s)",
    xticks = 0:2:20,
    ylabel = "velocidade (m/s)",
    yticks = -200:40:200)

ax_03 = Axis(fig[1, 3],
    title = "Aceleração x tempo",
    xlabel = "tempo (s)",
    xticks = 0:2:20,
    ylabel = "aceleração (m/s²)",
    yticks = -10:2:10)

#criando barras de seleção (sliders) para selecionar
#posição inicial
ls_s0 = labelslider!(fig, "Posição inicial:", -100:100; 
    format = x -> "$(x) m")
fig[2, 1] = ls_s0.layout
s0 = ls_s0.slider.value

#velocidade inicial
ls_v0 = labelslider!(fig, "Velocidade inicial:", -20:0.2:20; 
    format = x -> replace(string(x), "." => ",") * " m/s")
fig[2, 2] = ls_v0.layout
v0 = ls_v0.slider.value

#aceleração
ls_a = labelslider!(fig, "Aceleração:", -10:0.1:10; 
    format = x -> replace(string(x), "." => ",") * " m/s²")
fig[2, 3] = ls_a.layout
a0 = ls_a.slider.value

#desenhando gráficos
#posição x tempo
lines!(ax_01, 0:0.1:20, @lift(s.(0:0.1:20, $s0, $v0, $a0)),
    color = :red,
    linewidth = 2)
limits!(ax_01, 0, 20, -500, 500)

#velocidade x tempo
lines!(ax_02, [0, 20], @lift(v.([0, 20], $v0, $a0)),
    color = :dodgerblue,
    linewidth = 2)
limits!(ax_02, 0, 20, v(20, -20, -10), v(20, 20, 10))

#aceleração x tempo
hlines!(ax_03, @lift([$a0]), color = :green,
    linewidth = 2)
limits!(ax_03, 0, 20, -11, 11)

