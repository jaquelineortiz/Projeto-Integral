include("Simpson-Adaptativo.jl")
include("Simpson.jl")
include("estrutura.jl")

f = f(x, y) = exp(y - x)
a = c = 0
b = d = 0.5
VI = (exp(0.5) - 1) * (1 - exp(-0.5))

NF, Eps = Int[], Float64[]

for ϵ in 2.0 .^ (-2:1:30)
    F = FuncaoComCache(f) # Escolhe alguma f antes
    I = simpson_adaptivo(f, a, b, c, d, ϵ, VI)
    push!(Eps, ϵ)
    push!(NF, length(F))

    #coloco os mesmos passos pra Simpson Repetido aqui?
end
scatter(NF, Eps, xaxis=:log, yaxis=:log, lab=:"Simpson-Adaptivo")

