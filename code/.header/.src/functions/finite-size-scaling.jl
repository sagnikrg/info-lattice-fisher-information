
################################
# finding the crossing indices
################################

function find_crossing_indices(curve1, curve2)
    crossing_indices = []

    for i in 2:length(curve1)
        # Check if the sign of the difference changes
        if (curve1[i] - curve2[i]) * (curve1[i-1] - curve2[i-1]) < 0
            push!(crossing_indices, i-1) # Store the first index of the pair where crossing occurs
        end
    end

    return crossing_indices
end

