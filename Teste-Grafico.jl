using Plots
pyplot()

include("Simpson-Adaptativo.jl")
include("Simpson.jl")
include("estrutura.jl")

f = f(x, y) = exp(y - x)
a = c = 0
b = d = 0.5
VI = (exp(0.5) - 1) * (1 - exp(-0.5))

NFSA, NFSR, Eps, ErroSA, ErroSR = Int[], Int[], Float64[], Float64[], Float64[]

for ϵ in 2.0 .^ (-2:-1:-30)
    F = FuncaoComCache(f) # Escolhe alguma f antes
    I = simpson_adaptivo(F, a, b, c, d, ϵ=ϵ)
    push!(Eps, ϵ)
    push!(ErroSA, abs(VI - I))
    push!(NFSA, length(F))
end

# n = m = √max(NFSA)
maxn = ceil(Int, sqrt(maximum(NFSA)))

for n = 2:2:maxn
    F = FuncaoComCache(f)
    I = Simpson(F, a, b, c, d, n, n)
    push!(ErroSR, abs(VI - I))
    push!(NFSR, length(F))
end
plot(xaxis=:log2, yaxis=:log)
scatter!(NFSA, Eps, c=:green, lab="ϵ")
plot!(NFSA, Eps, c=:green, lab="")
scatter!(NFSA, ErroSA, c=:blue, lab="Simpson-Adaptivo")
plot!(NFSA, ErroSA, c=:blue, lab="")
scatter!(NFSR, ErroSR, c=:red, lab="Simpson-Repetido")
plot!(NFSR, ErroSR, c=:red, lab="")

ticks = 2 .^ (1:ceil(Int, log2(maximum(NFSA))))
xticks!(ticks)
png("IBAGEM")
