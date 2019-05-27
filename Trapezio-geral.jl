function Trapezio(f, a, b, c, d, m, n)
    h = (b - a) / n
    k(x) = (d(x) - c(x)) / m
    S = 0.0
    for i = 0:n
        if i == 0 || i == n
            α = 1 * k(a + i * h)
        else
            α = 2 * k(a + i * h)
        end
        for j = 0:n
            if j == 0 || j == m
                δ = 1
            else
                δ = 2
            end
        xi = a + i * h
        yj = c(xi) + j * k(xi)
        S = S + (α * δ) * f(xi, yj)
        end
    end
    I = ((h / 3) * S)
    return I
end
