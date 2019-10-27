using Plots
pyplot()

include("Simpson-Adaptativo.jl")
include("Simpson.jl")
include("estrutura.jl")

f = f(x, y) = exp(y - x)
a = c = 0
b = d = 0.5
VI = (exp(0.5) - 1) * (1 - exp(-0.5))

NF, Eps, ErroSA, ErroSR = Int[], Float64[], Float64[], Float64[]

for ϵ in 2.0 .^ (-2:-1:-30)
    F = FuncaoComCache(f) # Escolhe alguma f antes
    I = simpson_adaptivo(F, a, b, c, d, ϵ=ϵ)
    push!(Eps, ϵ)
    push!(ErroSA, abs(VI - I))
    push!(NF, length(F))
end

# n = m = √max(NF)
maxn = ceil(Int, sqrt(maximum(NF)))

for n = 2:2:maxn
    F = FuncaoComCache(f)
    I = Simpson(F, a, b, c, d, n, n)
    push!(ErroSR, abs(VI - I))
end
scatter(NF, Eps, c=:green, xaxis=:log2, yaxis=:log, lab="ϵ")
plot!(NF, Eps, c=:green, xaxis=:log2, yaxis=:log, lab="")
scatter!(NF, ErroSA, c=:blue, xaxis=:log2, yaxis=:log, lab="Simpson-Adaptivo")
plot!(NF, ErroSA, c=:blue, xaxis=:log2, yaxis=:log, lab="")
scatter!(2:2:maxn, ErroSR, c=:red, xaxis=:log2, yaxis=:log, lab="Simpson-Repetido")
plot!(2:2:maxn, ErroSR, c=:red, xaxis=:log2, yaxis=:log, lab="")

ticks = 2 .^ (4:ceil(Int, log2(maximum(NF))))
xticks!(ticks)
png("IBAGEM")
