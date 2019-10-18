include("Simpson-Adaptativo.jl")
include("Simpson.jl")
#include estrutura?

for ϵ = 3.0 .^ (-2:-1:-30)
    F = função com cache?
    SA = simpson_adaptivo(f, a, b, c, d, ϵ)   #usocomCache???
    nf = lenght(F)
    guarda(NF, ϵ) #função tem guardado?
end
scatter(nf, ϵ, xaxis=:log)

#Calculo Simpson Repetido
for n = 3:2:101
    for m = 3:2:101
    SR = Simpson(f, a, b, c, d, n, m)    #usocomCache???
    erro = abs(SR - I)
    guarda_erro = #mesma funçao?
    end
end
scatter
