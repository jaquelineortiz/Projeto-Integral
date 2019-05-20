function Simpson(f, a, b, c, d, n, m)
    h = (b - a) / n
    k(x) = (d(x) - c(x)) / m
    S = 0.0
    for i = 0:n
        if i == 0 || i == n
            α = 1 * k(a + i * h) / 3
        elseif mod(i,2) == 0
            α = 2 * k(a + i * h) / 3
        else
            α = 4 * k(a + i * h) / 3
        end
        for j = 0:m
            if j == 0 || j == m
                δ = 1
            elseif mod(j,2) == 0
                δ = 2
            else
                δ = 4
            end
        xi = a + i * h
        yj = c(xi) + j * k(xi)
        S = S + (α * δ * f(xi, yj))
        end
    end
    I = ((h / 3) * S)
    return I
end
