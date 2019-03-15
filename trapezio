function trapezio(f, a, b, c, d)
    i = (a + b) / 2
    j = (c + d) / 2
    k = ((b - a) * (d - c)) / 16
    I = (f(a,c) + f(a,d) + f(b,c) + f(b,d) + 2 * (f(i,c) + f(i,d) + f(a,j) + f(b,j)) + 4 * f(i,j))
    return k * I
end
