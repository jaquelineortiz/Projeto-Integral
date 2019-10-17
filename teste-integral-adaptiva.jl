using Test

include("Simpson-Adaptativo.jl")

function test()
  @testset "Testes manuais" begin
    for (f, a, b, c, d, I, nome) in [
                               ((x,y) -> exp(-x^2 - y^2), -30, 30, -30, 30, π, "exp-dupla"),
                               ((x,y) -> 1 + 2x + 3y, 0, 1, 0, 1, 3.5, "linear"),
                              ]
      @testset "Função $nome" begin
        ISA = simpson_adaptivo(f, a, b, c, d, ϵ=1e-8)
        @test abs(ISA - I) < 1e-8
      end
    end
  end
end

  test()
