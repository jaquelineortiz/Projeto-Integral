struct FuncaoComCache
  f
  D :: Dict{Tuple{Real,Real},Real}
end

FuncaoComCache(f) = FuncaoComCache(f, Dict{Tuple{Real,Real},Real}())

function obj_val(f :: FuncaoComCache, x :: Real, y :: Real)
  fxy = if haskey(f.D, (x, y))
    f.D[(x, y)]
  else
    fℓ = f.f(x, y)
    f.D[(x, y)] = fℓ
    fℓ
  end
  return fxy
end

Base.length(f :: FuncaoComCache) = length(f.D)

function tem_guardado(f :: FuncaoComCache, x :: Real, y :: Real)
  return haskey(f.D, x)
end
