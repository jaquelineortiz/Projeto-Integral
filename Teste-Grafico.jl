using Plots
gr(size=(400,300))

include("Simpson-Adaptativo.jl")
include("Simpson.jl")
include("estrutura.jl")

f = f(x, y) = exp(y - x)
a = c = 0
b = d = 0.5

NF = Int[] 
Eps = Float64[]

for ϵ in 2.0 .^ (-2:-1:-30)
    F = FuncaoComCache(f) # Escolhe alguma f antes
    I = simpson_adaptivo(F, a, b, c, d, ϵ=ϵ)
    push!(Eps, ϵ)
    push!(NF, length(F))
end
scatter(NF, Eps, xaxis=:log, yaxis=:log, lab=:"Simpson-Adaptivo")
