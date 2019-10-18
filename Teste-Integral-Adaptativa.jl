using Test

include("Simpson-Adaptativo.jl"), 

function test()
  @testset "Testes manuais" begin
    for (f, a, b, c, d, I, nome) in [
                               ((x,y) -> exp(-x^2 - y^2), -30, 30, -30, 30, π, "exp-dupla"),
                               ((x,y) -> 1 + 2x + 3y, 0, 1, 0, 1, 3.5, "linear"),
                               ((x,y) -> exp(y -x), 0, 0.5, 0, 0.5, 0.255252, "exponencial dif"),
                               ((x,y) -> x^2 + sqrt(y), 0, 1.5, 2, 3.4, 5.01586, "quadrado raiz"),
                               ((x,y) -> (2 * y * sin(x) + (cos(x))^2), 0, π/4, 0, π/2, 1.73223, "trigonométrica"),
                               ((x,y) -> x / (sqrt(1 - y^2)), 0, 1, 0, 1, 0,785398, "com raiz"),
                               ((x,y) -> (y * sin(x) + x * cos(y)), -π, 3*π/2, 0, 2*π, -19.7392, "trigonométrica2"),
                               ((x,y) -> ln(x * y), 0, e, 1, 4, 6.91851, "ln"),
                               ((x,y) -> 
                              ]
      @testset "Função $nome" begin
        ISA = simpson_adaptivo(f, a, b, c, d, ϵ=1e-8)
        @test abs(ISA - I) < 1e-8
      end
    end
  end
end

  test()
