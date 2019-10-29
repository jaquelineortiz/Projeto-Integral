using Plots
pyplot()

include("Simpson-Adaptativo.jl")
include("Simpson.jl")
include("estrutura.jl")

#=
f(x, y) = exp(-x^2 - y^2)
a = c = 20
b = d = -20
VI = π
=#

f(x, y) = exp(-3x) * sin(x) + y * exp(-y^2)
a = c = -1
b = d = 1
#VI = -(exp(2) * (sin(1) - cos(1)) + sin(1) + cos(1)) / exp(1)
VI = (2 / 5) * (cos(1) * sinh(3) - 3 * sin(1) * cosh(3))

NFSA, NFSR, Eps, ErroSA, ErroSR = Int[], Int[], Float64[], Float64[], Float64[]

for ϵ in 2.0 .^ (-2:-1:-35)
    @info("SA", ϵ)
    F = FuncaoComCache(f) # Escolhe alguma f antes
    I = simpson_adaptivo(F, a, b, c, d, ϵ=ϵ)
    push!(Eps, ϵ)
    push!(ErroSA, max(1e-16, abs(VI - I)))
    push!(NFSA, length(F))
end

# n = m = √max(NFSA)
maxn = ceil(Int, sqrt(maximum(NFSA)))

println("maxn = $maxn")

for n = 2 .^ (1:round(Int, log2(maxn)))
    @info("SR", n)
    F = FuncaoComCache(f)
    I = Simpson(F, a, b, c, d, n, n)
    push!(ErroSR, max(1e-16, abs(VI - I)))
    push!(NFSR, length(F))
end

#=
println("NFSA = $(log(NFSA))")
println("NFSR = $(log(NFSR))")
println("Eps = $(log(Eps))")
println("ErroSA = $(log(ErroSA))")
println("ErroSR = $(log(ErroSR))")
=#

plot(xaxis=:log2, yaxis=:log)
#scatter!(NFSA, Eps, c=:green, lab="ϵ")
#plot!(NFSA, Eps, c=:green, lab="")
scatter!(NFSA, ErroSA, c=:blue, lab="Simpson-Adaptivo")
plot!(NFSA, ErroSA, c=:blue, lab="")
scatter!(NFSR, ErroSR, c=:red, m=:square, lab="Simpson-Repetido")
plot!(NFSR, ErroSR, c=:red, l=:dash, lab="")

ticks = 2 .^ (1:ceil(Int, log2(maximum(NFSA))))
xticks!(ticks)
png("IMAGEM")
