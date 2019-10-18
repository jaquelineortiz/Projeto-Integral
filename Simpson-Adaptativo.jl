include("estrutura.jl")

function simpson(f :: FuncaoComCache, a, b, c, d)
    h = (b - a) / 2
    k = (d - c) / 2
    α = (a + b) / 2
    β = (c + d) / 2
    P1 = obj_val(f, a, c) + obj_val(f, b, c) + obj_val(f, a, d) + obj_val(f, b, d)
    P2 = obj_val(f, α, c) + obj_val(f, a , β) + obj_val(f, b, β) + obj_val(f, α, d)
    P3 = obj_val(f, α, β)
    return (h * k) * (P1 + 4 * P2 + 16 * P3) / 9
end

simpson_adaptivo(f, args...; kwargs...) =
    simpson_adaptivo(FuncaoComCache(f), args...; kwargs...)

function simpson_adaptivo(f :: FuncaoComCache, a, b, c, d; ϵ = 1e-8)
    I = simpson(f, a, b, c, d)
    return simpson_adaptivo_recursivo(f, a, b, c, d, ϵ, I)
end

function simpson_adaptivo_recursivo(f :: FuncaoComCache, a, b, c, d, ϵ, I)
    i = (a + b) / 2
    j = (c + d) / 2

    V1 = simpson(f, a, i, c, j) #S([a,(a+b)/2]; [c, (b+d)/2])
    V2 = simpson(f, i, b, c, j) #S([(b+2)/2, b]; [c, (c+d)/2])
    V3 = simpson(f, a, i, j, d) #S([a, (a+b)/2]; [(c+d)/2, d])
    V4 = simpson(f, i, b, j, d) #S([(a+b)/2, b]; [(c+d)/2,d])


    if abs(I - V1 - V2 - V3 - V4) <= 15 * ϵ
        return V1 + V2 + V3 + V4
    else
        return (simpson_adaptivo_recursivo(f, a, i, c, j, ϵ/4, V1) + simpson_adaptivo_recursivo(f, i, b, c, j, ϵ/4, V2)
                + simpson_adaptivo_recursivo(f, a, i, j, d, ϵ/4, V3) + simpson_adaptivo_recursivo(f, i, b, j, d, ϵ/4, V4))
    end
end
