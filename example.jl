function largest(factor_min::Int, factor_max::Int)
    if factor_min > factor_max
        throw(DomainError("factor_min > factor_max"))
    end

    BELOW_MIN = factor_min * factor_min - 1
    largestPP = BELOW_MIN

    higher = factor_max
    while higher ≥ factor_min
        lower = higher
        lower_lim = (largestPP ÷ higher) + 1
        lower_fnd = false
        while !lower_fnd  &&  lower ≥ lower_lim
            if isPalindrome(lower * higher)
                lower_fnd = true
                largestPP = lower * higher
            else
                lower -= 1
            end
        end
        higher -= 1
    end

    factors = []
    if largestPP > BELOW_MIN
        smaller_lim_lower = largestPP ÷ factor_max
        if smaller_lim_lower < factor_min
            smaller_lim_lower = factor_min
        end
        smaller_lim_upper = convert(Int, floor(√largestPP))
        for smaller = smaller_lim_lower : smaller_lim_upper
            if largestPP % smaller == 0
                larger = largestPP ÷ smaller
                push!(factors, [smaller, larger])
            end
        end
    else
        largestPP = nothing
    end


    largestPP, factors
end



function smallest(factor_min::Int, factor_max::Int)
    if factor_min > factor_max
        throw(DomainError("factor_min > factor_max"))
    end

    ABOVE_MAX = factor_max * factor_max + 1
    smallestPP = ABOVE_MAX

    lower = factor_min
    while lower ≤ factor_max
        higher = lower
        higher_lim = (smallestPP ÷ lower) -1
        higher_fnd = false
        while !higher_fnd  &&  higher ≤ higher_lim
            if isPalindrome(lower * higher)
                higher_fnd = true
                smallestPP = lower * higher
            else
                higher += 1
            end
        end
        lower += 1
    end

    factors = []
    if smallestPP < ABOVE_MAX
        smaller_lim_lower = smallestPP ÷ factor_max
        if smaller_lim_lower < factor_min
            smaller_lim_lower = factor_min
        end
        smaller_lim_upper = convert(Int, floor(√smallestPP))
        for smaller = smaller_lim_lower : smaller_lim_upper
            if smallestPP % smaller == 0
                larger = smallestPP ÷ smaller
                push!(factors, [smaller, larger])
            end
        end
    else
        smallestPP = nothing
    end


    smallestPP, factors
end



function isPalindrome(n)
    digits = []
    rem = n

    while rem > 0
        push!(digits, (rem % 10))
        rem ÷= 10
    end
    mismatch_fnd = false
    i = 1
    while !mismatch_fnd  &&   i ≤ length(digits) ÷ 2
        if digits[i] != digits[length(digits) - i+1]
            mismatch_fnd = true
        end

        i += 1
    end


    !mismatch_fnd
end
