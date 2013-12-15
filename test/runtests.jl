require("JuMP")
using JuMP
using Base.Test

tests = ["expr.jl",
         "variable.jl",
         "operator.jl",
         "macros.jl",
         "model.jl",
         "probmod.jl"]

println("Running tests:")

for curtest in tests
  println(" Test: $(curtest)")
  include(curtest)
end

if Pkg.installed("Gurobi") != nothing
  gurobitests = ["qcqpmodel.jl", "quadmodel.jl", "callback.jl"]
  for curtest in gurobitests
    println(" Test: $(curtest)")
    include(curtest)
  end
else
  println("WARNING: Gurobi not installed, cannot execute corresponding tests")
end


callbacktests = ["callback.jl"]
if Pkg.installed("Gurobi") != nothing || Pkg.installed("CPLEX") != nothing || Pkg.installed("GLPKMathProgInterface") != nothing
  for curtest in callbacktests
    println(" Test: $(curtest)")
    include(curtest)
  end  
else
  println("WARNING: Solver supporting callbacks not installed, cannot execute corresponding tests")
end

# hygiene.jl should be run separately
