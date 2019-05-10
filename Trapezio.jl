function Trapezio(f, a, b, c, d, m, n)
    h = (b - a) / n
    k = (d - c) / m
    S = 0.0
    for i = 0:n
        if i == 0 || i == n
            α = 1
        else
            α = 2
        end
        for j = 0:n
            if j == 0 || j == m
                δ = 1
            else
                δ = 2
            end
            S = S + (α * δ) * f((a + i * h), (c + j * h))
        end
    end
    I = ((h * k) / 9) * S
    return I
end
