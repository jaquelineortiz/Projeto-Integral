function simpson(f, a, b, c, d)
    h = (b - a) / 2
    k = (d - c) / 2
    α = (a + b) / 2
    β = (c + d) / 2
    P1 = f(a, c) + f(b, c) + f(a, d) + f(b, d)
    P2 = f(α, c) + f(a , β) + f(b, β) + f(α, d)
    P3 = f(α, β)
    return (h * k) * (P1 + 4 * P2 + 16 * P3)
end

function simpson_adaptivo(f, a, b, c, d, ϵ)
    I = simpson(f, a, b, c, d)
    return simpson_adaptivo_recursivo(f, a, b, c, d, ϵ, I)
end


function simpson_adaptivo_recursivo(f, a, b, c, d, ϵ, I)
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
