using GLMakie

#definindo funções para o MRUV
#velocidade, v(t)
vel(t, v0, a) = v0 + a*t
#deslocamento, Δs(t)
Δs(t, v0, a) = v0*t + 0.5*a*t*t

#inicializando nodos para interatividade 
#velocidade inicial
v0 = Node(10.0)
#aceleração
a0 = Node(3.0)
#instante inicial
ti = Node(0.0)
#instante final
tf = Node(20.0)

#inicializando figura
fig = Figure(resolution = (1200, 800))

#inicializando o gráfico de velocidade x tempo
ax = Axis(fig[1, 1],
    title = "Velocidade x tempo",
    xlabel = "tempo (s)",
    xticks = 0:2:20,
    ylabel = "velocidade (m/s)",
    yticks = -200:40:200)

#criando grid com barras seletoras para selecionar 
#v0(velocidade inicial) e a(aceleração)
#e mudar as características da reta
lsgrid = labelslidergrid!(
    fig,
    ["v₀", "a"],
    [-20:0.2:20, -10:0.1:10];
    formats = [x -> "$(replace(string(x), "." => ",")) $s" for s ∈ ["m/s", "m/s²"]],
    width = 350,
    tellheight = false
)
fig[1, 2] = lsgrid.layout
v0, a0 = [s.value for s ∈ lsgrid.sliders]

#criando barra seletora para selecionar o intervalo de tempo
#entre instante inicial (ti) e instante final (tf),
#utilizado no cálculo da área do gráfico
t_interval = IntervalSlider(fig[2, 1], range = 0:0.1:20,
    startvalues = (0.0, 20.0))
ti = @lift($(t_interval.interval)[1])
tf = @lift($(t_interval.interval)[2])

#calculando observáveis
#velocidade no instante ti
vi = @lift(vel($ti, $v0, $a0))
#velocidade no instante tf
vf = @lift(vel($tf, $v0, $a0))
#área da reta entre ti e tf
area = @lift(($vi + $vf)*($tf - $ti)*0.5)

#desenhando as retas
#eixo x
hlines!(ax, [0], linewidth =2, color = :black)
#v(t)
lines!(ax, [0, 20], @lift(vel.([0,20], $v0, $a0)),
    linewidth = 2,
    color = :dodgerblue)

limits!(ax, 0, 20, vel(20, -20, -10), vel(20, 20, 10))

#pontos sobre a reta delimitando o intervalo selecionado
scatter!(ax, 
    @lift([Point2($ti, vel($ti, $v0, $a0)), Point2($tf, vel($tf, $v0, $a0))]),
    markersize = 12,
    color = (:red, 0.5))

#criando sequencia de pontos utilizados para preencher a área
#sob a reta no intervalo selecionado
Δt_int = @lift(LinRange($ti, $tf, 20))
v_int = @lift(vel.($Δt_int, $v0, $a0))

#preenchendo a área dentro do intervalo selecionado
band!(ax, Δt_int, 
    @lift(fill(0, length($Δt_int))),
    v_int,
    color = (:red, 0.3))

#escrevendo o valor da área no gráfico    
text!(ax, 
    @lift(string("área: Δs = ", 
        replace(string(round($area, digits = 2)), "." => ","), " m")),
    position = @lift(Point2(($ti + $tf)/2, (vel($ti, $v0, $a0))/2)),
    align = (:center, :bottom),
    color = :red,
    textsize = 20)

#texto abaixo da barra seletora de intervalo contendo os valores
#limites do intervalo selecionado
Label(fig[3, 1], 
    @lift(replace(
        string("Intervalo: (",
            round($(t_interval.interval)[1], digits = 1), " s; ", 
            round($(t_interval.interval)[2], digits = 1), " s", ")"
            ), 
        "." => ",")
        ),
    tellwidth = false)

#gravar video
#fps = 30
#record(fig, "MRUV_area_velocidade_x_tempo.mp4"; framerate = 30) do io
#    for i = 1:1800
#        sleep(1/fps)
#        recordframe!(io)
#    end
#end