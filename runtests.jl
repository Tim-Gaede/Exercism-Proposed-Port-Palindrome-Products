#=
Their return values of the functions smallest() and largest()
must be a tuple (value, factors) where value is the
palindrome itself, and factors is an iterable containing both factors of the
palindrome in arbitrary order.
=#




using Test

include("palindrome_products.jl")


# Tests adapted from `problem-specifications//canonical-data.json` @ v1.2.0
println("\n"^2, "-"^60, "\n"^3)

@testset "Smallest palindrome from single digit factors" begin
    value, factors = smallest(1, 9)
    @test value == 1
    @test assertFactorsEqual(factors, [[1, 1]])
end
println()

@testset "Largest palindrome from single digit factors" begin
    value, factors = largest(1, 9)
    @test value == 9
    @test assertFactorsEqual(factors, [[1, 9], [3, 3]])
end
println()

@testset "Smallest palindrome from double digit factors" begin
    value, factors = smallest(10, 99)
    @test value == 121
    @test assertFactorsEqual(factors, [[11, 11]])
end
println()

@testset "Largest palindrome from double digit factors" begin
    value, factors = largest(10, 99)
    @test value == 9009
    @test assertFactorsEqual(factors, [[91, 99]])
end
println()

@testset "Smallest palindrome from triple digit factors" begin
    value, factors = smallest(100, 999)
    @test value == 10201
    @test assertFactorsEqual(factors, [[101, 101]])
end
println()



@testset "Largest palindrome from triple digit factors" begin
    value, factors = largest(100, 999)
    @test value == 906609
    @test assertFactorsEqual(factors, [[913, 993]])
end
println()



@testset "Smallest palindrome from four digit factors" begin
    value, factors = smallest(1000, 9999)
    @test value == 1002001
    @test assertFactorsEqual(factors, [[1001, 1001]])
end
println()

@testset "Largest palindrome from four digit factors" begin
    value, factors = largest(1000, 9999)
    @test value == 99000099
    @test assertFactorsEqual(factors, [[9901, 9999]])
end
println()

@testset "Empty for smallest palindrome if none in range" begin
    value, factors = smallest(1002, 1003)
    @test value == nothing
    @test assertFactorsEqual(factors, [])
end
println()

@testset "Empty for largest palindrome if none in range" begin
    value, factors = largest(15, 15)
    @test value == nothing
    @test assertFactorsEqual(factors, [])
end
println()

@testset "Error for smallest palindrome if min is more than max" begin
    @test_throws DomainError value, factors = smallest(10000, 1)
end
println()

@testset "Error for largest palindrome if min is more than max" begin
    @test_throws DomainError value, factors = largest(2, 1)
end
println()


# Utility function
function assertFactorsEqual(actual, expected)
    actual_test = copy(actual)
    expected_text = copy(expected)

    for item in actual_test
        sort!(item)
    end

    for item in expected_text
        sort!(item)
    end


    sort(actual) == sort(expected)
end
