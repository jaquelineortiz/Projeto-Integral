function Simpson(f :: FuncaoComCache, a, b, c, d, n, m)
    h = (b - a) / n
    k = (d - c) / m
    S = 0.0
    for i = 0:n
        if i == 0 || i == n
            α = 1
        elseif mod(i,2) == 0
            α = 2
        else
            α = 4
        end
        for j = 0:m
            if j == 0 || j == m
                δ = 1
            elseif mod(j,2) == 0
                δ = 2
            else
                δ = 4
            end
            S = S + (α * δ * obj_val(f, (a + i * h), (c + j * k)))
        end
    end
    I = ((h * k) / 9) * S
    return I
end
